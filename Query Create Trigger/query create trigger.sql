-- 1. Trigger untuk validasi status di table Campaigns

CREATE OR ALTER TRIGGER TR_ValidateCampaignStatus
ON Campaigns
AFTER INSERT, UPDATE
AS
BEGIN
    SET NOCOUNT ON;

    -- Cegah rekursi (disable trigger sementara selama eksekusi)
    IF TRIGGER_NESTLEVEL() > 1
        RETURN;

    BEGIN TRANSACTION;

    BEGIN TRY
        -- Cek apakah ada data dengan verification_status 'pending' atau 'rejected' dan status = 'active'
        IF EXISTS (
            SELECT 1
            FROM inserted
            WHERE (verification_status IN ('pending', 'rejected')) AND status = 'active'
        )
        BEGIN
            -- Rollback jika ditemukan
            ROLLBACK TRANSACTION;

            -- Berikan pesan kesalahan
            RAISERROR ('Status campaign tidak boleh "active" jika verification_status adalah "pending" atau "rejected".', 16, 1);
            RETURN;
        END;

        -- Ubah status menjadi 'inactive' jika verification_status adalah 'pending' atau 'rejected'
        UPDATE c
        SET status = 'inactive'
        FROM Campaigns c
        INNER JOIN inserted i ON c.id = i.id
        WHERE i.verification_status IN ('pending', 'rejected')
          AND i.status <> 'inactive';

        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        -- Rollback jika terjadi error
        ROLLBACK TRANSACTION;

        -- Tampilkan pesan error
        THROW;
    END CATCH;
END;



--2.  Trigger untuk memperbarui collected_amount di tabel Campaigns

CREATE OR ALTER TRIGGER TR_UpdateCollectedAmount
ON Donations
AFTER INSERT
AS
BEGIN
    UPDATE Campaigns
    SET collected_amount = (SELECT SUM(amount) FROM Donations WHERE campaign_id = inserted.campaign_id)
    FROM Campaigns
    INNER JOIN inserted ON Campaigns.id = inserted.campaign_id;
    
    PRINT 'Jumlah terkumpul berhasil diperbarui.';
END;




-- 3. Trigger untuk mencatat log perubahan status kampanye

CREATE OR ALTER TRIGGER TR_LogCampaignStatusChange
ON Campaigns
AFTER UPDATE
AS
BEGIN
    IF UPDATE(status)
    BEGIN
        -- Memastikan bahwa status yang diambil sesuai dengan constraint CHECK
        IF (SELECT status FROM inserted) IN ('approved', 'rejected')
        BEGIN
            -- Cek apakah log untuk campaign_id dan status tertentu sudah ada
            IF NOT EXISTS (
                SELECT 1
                FROM Verification_Logs
                WHERE campaign_id IN (SELECT id FROM inserted)
                AND status = (SELECT status FROM inserted)
                AND reason = 'Perubahan status kampanye'
            )
            BEGIN
                -- Jika tidak ada log yang sama, maka masukkan log perubahan status
                INSERT INTO Verification_Logs (campaign_id, user_id, admin_id, verification_date, status, reason, created_at)
                SELECT 
                    i.id AS campaign_id,
                    i.user_id,
                    a.id AS admin_id,
                    GETDATE() AS verification_date,
                    i.status,
                    'Perubahan status kampanye' AS reason,
                    GETDATE() AS created_at
                FROM inserted i
                JOIN Users a ON a.role = 'admin'; -- Mengambil admin yang ada dalam sistem

                PRINT 'Log perubahan status kampanye berhasil dicatat.';
            END
            ELSE
            BEGIN
                PRINT 'Log perubahan status kampanye sudah ada, tidak ada data yang dimasukkan.';
            END;
        END
        ELSE
        BEGIN
            PRINT 'Status yang dimasukkan tidak valid, log perubahan status tidak dicatat.';
        END;
    END;
END;




-- 4. Trigger untuk mengubah role user menjadi 'fundraiser' setelah kampanye disahkan

CREATE OR ALTER TRIGGER TR_UpdateUserRoleToFundraiser
ON Campaigns
AFTER UPDATE
AS
BEGIN
    -- Cek apakah status kampanye diubah menjadi 'approved'
    IF EXISTS (
        SELECT 1
        FROM inserted
        WHERE status = 'active'
    )
    BEGIN
        -- Update role user menjadi 'fundraiser' kecuali jika role user adalah 'admin'
        UPDATE Users
        SET role = 'fundraiser'
        FROM Users
        INNER JOIN inserted ON Users.id = inserted.user_id
        WHERE inserted.status = 'active'
          AND Users.role <> 'admin';

        PRINT 'Role user berhasil diubah menjadi fundraiser.';
    END;
END;


-- 4 Trigger untuk mengirim notifikasi setelah donasi baru diterima

CREATE OR ALTER TRIGGER TR_NewDonationNotification
ON Donations
AFTER INSERT
AS
BEGIN
    -- Deklarasi variabel
    DECLARE @campaign_id INT, 
            @donor_name NVARCHAR(100), 
            @is_anonymous BIT,
            @user_id INT;

    -- Ambil nilai dari tabel inserted
    SELECT 
        @campaign_id = campaign_id,
        @donor_name = donor_name,
        @is_anonymous = is_anonymous,
        @user_id = user_id
    FROM inserted;

    -- Notifikasi untuk pemilik campaign
    INSERT INTO Notifications (user_id, message, created_at)
    SELECT 
        user_id, 
        CONCAT('Donasi baru diterima untuk campaign Anda dengan ID: ', @campaign_id), 
        GETDATE()
    FROM Campaigns
    WHERE id = @campaign_id;

    -- Notifikasi untuk donor (jika tidak anonim)
    IF @is_anonymous = 0 AND @user_id IS NOT NULL
    BEGIN
        INSERT INTO Notifications (user_id, message, created_at)
        VALUES (
            @user_id,
            'Terima kasih atas donasi Anda!',
            GETDATE()
        );
    END
END;



-- 6. Trigger untuk mengirim notifikasi setelah status laporan diubah

CREATE OR ALTER TRIGGER TR_ReportStatusNotification
ON Reports
AFTER UPDATE
AS
BEGIN
    DECLARE @report_id INT, @campaign_id INT, @status NVARCHAR(50), @user_id INT;

    SELECT 
        @report_id = id,
        @campaign_id = campaign_id,
        @status = status,
        @user_id = user_id
    FROM inserted;

    -- Notifikasi berdasarkan status laporan
    IF @status = 'approved'
    BEGIN
        INSERT INTO Notifications (user_id, message, created_at)
        VALUES (@user_id, CONCAT('Laporan Anda untuk campaign ID: ', @campaign_id, ' telah disetujui!'), GETDATE());
    END
    ELSE IF @status = 'rejected'
    BEGIN
        INSERT INTO Notifications (user_id, message, created_at)
        VALUES (@user_id, CONCAT('Laporan Anda untuk campaign ID: ', @campaign_id, ' ditolak.'), GETDATE());
    END;
END;


-- 7. Trigger untuk mengirim notifikasi setelah kampanye baru dibuat

CREATE OR ALTER TRIGGER TR_NewCampaignNotification
ON Campaigns
AFTER INSERT
AS
BEGIN
    DECLARE @campaign_id INT;

    SELECT @campaign_id = id FROM inserted;

    -- Notifikasi kepada semua admin
    INSERT INTO Notifications (user_id, message, created_at)
    SELECT 
        id, 
        CONCAT('Campaign baru dengan ID: ', @campaign_id, ' membutuhkan verifikasi.'), 
        GETDATE()
    FROM Users
    WHERE role = 'admin';
END;
