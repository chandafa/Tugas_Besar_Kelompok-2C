--1. Prosedur untuk menambahkan data pengguna baru ke dalam tabel Users.

CREATE OR ALTER PROC SP_InsertUser
    @name NVARCHAR(100),
    @email NVARCHAR(100),
    @password NVARCHAR(255),
    @role NVARCHAR(10)
AS
BEGIN
    IF NOT EXISTS (SELECT 1 FROM Users WHERE email = @email)
    BEGIN
        INSERT INTO Users (name, email, password, role)
        VALUES (@name, @email, @password, @role);
        PRINT 'Pengguna berhasil ditambahkan.';
    END
    ELSE
    BEGIN
        PRINT 'Email sudah digunakan.';
    END
END;


EXEC SP_InsertUser 
    @name = 'John Doe', 
    @email = 'john@gmail.com', 
    @password = 'securepassword123', 
    @role = 'donatur';


SELECT * FROM Users


	
--2. Prosedur untuk memperbarui data pengguna yang ada di tabel Users.


CREATE OR ALTER PROC SP_UpdateUser
    @id INT,
    @name NVARCHAR(100),
    @email NVARCHAR(100),
    @password NVARCHAR(255),
    @role NVARCHAR(10)
AS
BEGIN
    IF EXISTS (SELECT 1 FROM Users WHERE id = @id)
    BEGIN
        UPDATE Users
        SET name = @name, email = @email, password = @password, role = @role, updated_at = GETDATE()
        WHERE id = @id;
        PRINT 'Data pengguna berhasil diperbarui.';
    END
    ELSE
    BEGIN
        PRINT 'Pengguna tidak ditemukan.';
    END
END;


EXEC SP_UpdateUser 
    @id = 31, 
    @name = 'John lennon', 
    @email = 'john@gmail.com', 
    @password = 'newsecurepassword123', 
    @role = 'donatur';


SELECT * FROM Users



--3. Prosedur untuk menambahkan kampanye baru ke dalam tabel Campaigns.	

CREATE OR ALTER PROC SP_InsertCampaign
    @title NVARCHAR(150),
    @description VARCHAR(255),
    @target_amount DECIMAL(15, 2),
    @category NVARCHAR(30),
    @user_id INT,
    @start_date DATE,
    @end_date DATE
AS
BEGIN
    IF EXISTS (SELECT 1 FROM Users WHERE id = @user_id)
    BEGIN
        INSERT INTO Campaigns (title, description, target_amount, category, user_id, start_date, end_date)
        VALUES (@title, @description, @target_amount, @category, @user_id, @start_date, @end_date);
        PRINT 'Kampanye berhasil ditambahkan.';
    END
    ELSE
    BEGIN
        PRINT 'Pengguna tidak ditemukan.';
    END
END;


EXEC SP_InsertCampaign 
    @title = 'Bangun Rumah', 
    @description = 'Membangun perpustakaan untuk meningkatkan minat baca anak-anak desa.',
    @target_amount = 25000000.00, 
    @category = 'pendidikan', 
    @user_id = 1, 
    @start_date = '2025-01-01', 
    @end_date = '2025-06-09';


SELECT * FROM Campaigns



--4. Prosedur untuk memperbarui data kampanye yang ada di tabel Campaigns.	

CREATE OR ALTER PROC SP_UpdateCampaign
    @id INT,
    @title NVARCHAR(150),
    @description VARCHAR(255),
    @target_amount DECIMAL(15, 2),
    @status NVARCHAR(10)
AS
BEGIN
    IF EXISTS (SELECT 1 FROM Campaigns WHERE id = @id)
    BEGIN
        UPDATE Campaigns
        SET title = @title, description = @description, target_amount = @target_amount, status = @status, updated_at = GETDATE()
        WHERE id = @id;
        PRINT 'Data kampanye berhasil diperbarui.';
    END
    ELSE
    BEGIN
        PRINT 'Kampanye tidak ditemukan.';
    END
END;


EXEC SP_UpdateCampaign 
    @id = 33, 
    @title = 'Desa Cikadut', 
    @description = 'Bantuannya sahabat surga', 
    @target_amount = 260000000.00, 
    @status = 'active';


SELECT * FROM Campaigns



--5. Prosedur untuk menambahkan data penerima baru ke dalam tabel Recipients.	

CREATE OR ALTER PROC SP_InsertRecipient
    @name NVARCHAR(100),
    @type NVARCHAR(15),
    @contact_info NVARCHAR(255),
    @address VARCHAR(255)
AS
BEGIN
    INSERT INTO Recipients (name, type, contact_info, address)
    VALUES (@name, @type, @contact_info, @address);
    PRINT 'Penerima berhasil ditambahkan.';
END;


EXEC SP_InsertRecipient 
    @name = 'Charity Organization', 
    @type = 'Organization', 
    @contact_info = 'contact@charity.org', 
    @address = '123 Charity Street';


SELECT * FROM Recipients



--6. Prosedur untuk memperbarui data penerima yang ada di tabel Recipients.

CREATE OR ALTER PROC SP_UpdateRecipient
    @id INT,
    @name NVARCHAR(100),
    @type NVARCHAR(15),
    @contact_info NVARCHAR(255),
    @address VARCHAR(255)
AS
BEGIN
    IF EXISTS (SELECT 1 FROM Recipients WHERE id = @id)
    BEGIN
        UPDATE Recipients
        SET name = @name, type = @type, contact_info = @contact_info, address = @address, updated_at = GETDATE()
        WHERE id = @id;
        PRINT 'Data penerima berhasil diperbarui.';
    END
    ELSE
    BEGIN
        PRINT 'Penerima tidak ditemukan.';
    END
END;	


EXEC SP_UpdateRecipient 
    @id = 30, 
    @name = 'Yayasan Panti', 
    @type = 'Organization', 
    @contact_info = '02123456867', 
    @address = 'Jl. sederhana No. 17, Bandung';


SELECT * FROM Campaign_Recipients



--7. Prosedur untuk menambahkan donasi baru ke dalam tabel Donations.	

CREATE OR ALTER PROC SP_InsertDonation
    @amount DECIMAL(15, 2),
    @message VARCHAR(150),
    @donor_name NVARCHAR(100),
    @is_anonymous BIT,
    @campaign_id INT,
    @user_id INT
AS
BEGIN
    IF EXISTS (SELECT 1 FROM Campaigns WHERE id = @campaign_id)
    BEGIN
        INSERT INTO Donations (amount, message, donor_name, is_anonymous, campaign_id, user_id, donation_date)
        VALUES (@amount, @message, @donor_name, @is_anonymous, @campaign_id, @user_id, GETDATE());
        PRINT 'Donasi berhasil ditambahkan.';
    END
    ELSE
    BEGIN
        PRINT 'Kampanye tidak ditemukan.';
    END
END;


EXEC SP_InsertDonation 
    @amount = 750000, 
    @message = 'Semoga Allah memberkahi.', 
	
    @donor_name = 'Ramayana', 
    @is_anonymous = 0,
    @campaign_id = 2,
    @user_id = NULL;
    

SELECT * FROM Donations




--8. Prosedur untuk menampilkan semua campaigns berdasarkan user	

CREATE OR ALTER PROC SP_GetCampaignsByUser
    @user_id INT
AS
BEGIN
    SELECT * FROM Campaigns WHERE user_id = @user_id;
END;


EXEC SP_GetCampaignsByUser 
    @user_id = 1;

SELECT * FROM Campaigns


--9. Prosedur untuk menampilkan donasi berdasarkan campaign	

CREATE OR ALTER PROC SP_GetDonationsByCampaign
    @campaign_id INT
AS
BEGIN
    SELECT * FROM Donations WHERE campaign_id = @campaign_id;
END;


EXEC SP_GetDonationsByCampaign 
    @campaign_id = 1;


SELECT * FROM Donations



--10. Prosedur untuk menambahkan laporan	

CREATE OR ALTER PROC SP_InsertReport
    @campaign_id INT,
    @user_id INT,
    @description VARCHAR(255),
    @amount_used DECIMAL(15, 2),
    @remaining_amount DECIMAL(15, 2)
AS
BEGIN
    -- Cek apakah user dengan ID yang diberikan bukan "donatur"
    IF EXISTS (
        SELECT 1 
        FROM Users 
        WHERE id = @user_id AND role != 'donatur'
    )
    BEGIN
        -- Cek apakah kampanye dengan ID yang diberikan ada
        IF EXISTS (SELECT 1 FROM Campaigns WHERE id = @campaign_id)
        BEGIN
            INSERT INTO Reports (campaign_id, user_id, report_date, description, amount_used, remaining_amount, created_at)
            VALUES (@campaign_id, @user_id, GETDATE(), @description, @amount_used, @remaining_amount, GETDATE());
            PRINT 'Laporan berhasil ditambahkan.';
        END
        ELSE
        BEGIN
            PRINT 'Kampanye tidak ditemukan.';
        END
    END
    ELSE
    BEGIN
        PRINT 'Pengguna dengan peran donatur tidak dapat membuat laporan.';
    END
END;


EXEC SP_InsertReport 
    @campaign_id = 33, 
    @user_id = 1, 
    @description = 'Laporan penggunaan dana untuk Desa.', 
    @amount_used = 250000.00, 
    @remaining_amount = 250000.00;


SELECT * FROM Reports



--11. Prosedur untuk melihat laporan berdasarkan campaign	

CREATE OR ALTER PROC SP_GetReportsByCampaign
    @campaign_id INT
AS
BEGIN
    SELECT * FROM Reports WHERE campaign_id = @campaign_id;
END;


EXEC SP_GetReportsByCampaign 
    @campaign_id = 1;


SELECT * FROM Reports


--12. Prosedur untuk melakukan pengesahan laporan oleh admin	

CREATE OR ALTER PROC SP_ApproveReport
    @report_id INT,
    @admin_id INT,
    @status NVARCHAR(50),
    @reason VARCHAR(100) NULL
AS
BEGIN
    -- Cek apakah admin yang mengesahkan
    IF EXISTS (SELECT 1 FROM Users WHERE id = @admin_id AND role = 'admin')
    BEGIN
        IF EXISTS (SELECT 1 FROM Reports WHERE id = @report_id)
        BEGIN
            UPDATE Reports
            SET status = @status, admin_id = @admin_id, reason = @reason, updated_at = GETDATE()
            WHERE id = @report_id;
            PRINT 'Laporan berhasil disahkan.';
        END
        ELSE
        BEGIN
            PRINT 'Laporan tidak ditemukan.';
        END
    END
    ELSE
    BEGIN
        PRINT 'Hanya admin yang bisa melakukan pengesahan laporan.';
    END
END;


EXEC SP_ApproveReport 
    @report_id = 26, 
    @admin_id = 3, 
    @status = 'approved', 
    @reason = 'All ';


select * from reports
select * from Notifications

select * from donations
select * from campaigns



--13. Prosedur untuk melakukan pengesahan campaigns oleh admin	

CREATE OR ALTER PROC SP_ApproveCampaign
    @campaign_id INT,
    @admin_id INT,
    @status NVARCHAR(50),
    @verification_status NVARCHAR(10),
    @reason VARCHAR(100) NULL
AS
BEGIN
    -- Cek apakah admin yang mengesahkan
    IF EXISTS (SELECT 1 FROM Users WHERE id = @admin_id AND role = 'admin')
    BEGIN
        IF EXISTS (SELECT 1 FROM Campaigns WHERE id = @campaign_id)
        BEGIN
            UPDATE Campaigns
            SET status = @status, verification_status = @verification_status, updated_at = GETDATE()
            WHERE id = @campaign_id;
            
            INSERT INTO Verification_Logs (campaign_id, user_id, admin_id, verification_date, status, reason, created_at)
            SELECT id, user_id, @admin_id, GETDATE(), @verification_status, @reason, GETDATE()
            FROM Campaigns WHERE id = @campaign_id;
            
            PRINT 'Kampanye berhasil disahkan.';
        END
        ELSE
        BEGIN
            PRINT 'Kampanye tidak ditemukan.';
        END
    END
    ELSE
    BEGIN
        PRINT 'Hanya admin yang bisa melakukan pengesahan kampanye.';
    END
END;


EXEC SP_ApproveCampaign 
    @campaign_id = 33, 
    @admin_id = 3, 
    @status = 'active', 
    @verification_status = 'approved', 
    @reason = 'Campaign validated';


	select * from campaign_recipients
	select * from users






--14. prosedur untuk melakukan penghapusan laporan	

CREATE OR ALTER PROC SP_DeleteReport
    @report_id INT
AS
BEGIN
    IF EXISTS (SELECT 1 FROM Reports WHERE id = @report_id)
    BEGIN
        -- Hapus data di Verification_Logs yang terkait dengan laporan ini
        DELETE FROM Verification_Logs WHERE campaign_id IN (SELECT campaign_id FROM Reports WHERE id = @report_id);

        -- Hapus laporan dari tabel Reports
        DELETE FROM Reports WHERE id = @report_id;
        PRINT 'Laporan berhasil dihapus beserta data terkaitnya.';
    END
    ELSE
    BEGIN
        PRINT 'Laporan tidak ditemukan.';
    END
END;


EXEC SP_DeleteReport 
    @report_id = 24;


select * from notifications
select * from reports




--15. prosedur untuk pembaruan status campaign dan pengiriman notifikasi dalam satu proses.

CREATE OR ALTER PROCEDURE UpdateCampaignsToCompletedAndNotify
AS
BEGIN
    -- Mulai transaksi untuk menjaga integritas data
    BEGIN TRANSACTION;

    BEGIN TRY
        -- Variabel untuk menyimpan tanggal hari ini
        DECLARE @current_date DATE = GETDATE();

        -- Langkah 1: Update status menjadi 'completed' untuk campaign yang:
        -- 1. Sudah melewati end_date
        -- 2. Belum memiliki status 'completed'
        UPDATE Campaigns
        SET status = 'completed',
            updated_at = GETDATE() -- Perbarui timestamp
        WHERE end_date < @current_date -- Sudah melewati end_date
          AND status != 'completed'; -- Pastikan tidak mengubah yang sudah completed

        -- Langkah 2: Kirim notifikasi untuk campaign yang telah berakhir
        INSERT INTO Notifications (user_id, message, created_at)
        SELECT user_id, 
               CONCAT('Campaign dengan ID: ', id, ' telah berakhir.'), 
               GETDATE()
        FROM Campaigns
        WHERE end_date = @current_date;

        -- Commit transaksi jika semuanya sukses
        COMMIT TRANSACTION;

        PRINT 'Proses update campaign dan notifikasi selesai. Campaign yang memenuhi kriteria telah diperbarui ke status "completed" dan notifikasi telah dikirim.';
    END TRY
    BEGIN CATCH
        -- Rollback transaksi jika terjadi kesalahan
        ROLLBACK TRANSACTION;

        -- Tampilkan pesan error
        PRINT 'Terjadi kesalahan:';
        PRINT ERROR_MESSAGE();
    END CATCH;
END;


EXEC UpdateCampaignsToCompletedAndNotify;
select * from campaigns
select * from notifications


select * from users
select * from donations



--16. prosedur untuk menambahkan data campaign recipient

CREATE OR ALTER PROCEDURE SP_InsertCampaignRecipient
    @campaign_id INT,
    @recipient_id INT,
    @allocation_percentage DECIMAL(5, 2) = 100
AS
BEGIN
    BEGIN TRY
        BEGIN TRANSACTION;

        -- Validasi keberadaan campaign_id dan recipient_id
        IF NOT EXISTS (SELECT 1 FROM Campaigns WHERE id = @campaign_id)
        BEGIN
            THROW 50001, 'Campaign ID tidak ditemukan.', 1;
        END

        IF NOT EXISTS (SELECT 1 FROM Recipients WHERE id = @recipient_id)
        BEGIN
            THROW 50002, 'Recipient ID tidak ditemukan.', 1;
        END

        -- Tambahkan data ke tabel Campaign_Recipients
        INSERT INTO Campaign_Recipients (campaign_id, recipient_id, allocation_percentage, created_at, updated_at)
        VALUES (@campaign_id, @recipient_id, @allocation_percentage, GETDATE(), GETDATE());

        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;

        -- Tampilkan pesan error
        THROW;
    END CATCH
END;


EXEC InsertCampaignRecipient
    @campaign_id = 2,          
    @recipient_id = 31,         
    @allocation_percentage = 70.00; 


	select  * from Campaign_Recipients





-- 17. prosedur untuk memperbarui data campaign recipient

CREATE OR ALTER PROCEDURE SP_UpdateCampaignRecipient
    @id INT,
    @campaign_id INT,
    @recipient_id INT,
    @allocation_percentage DECIMAL(5, 2)
AS
BEGIN
    BEGIN TRY
        BEGIN TRANSACTION;

        -- Validasi keberadaan record Campaign_Recipients
        IF NOT EXISTS (SELECT 1 FROM Campaign_Recipients WHERE id = @id)
        BEGIN
            THROW 50003, 'Campaign Recipient ID tidak ditemukan.', 1;
        END

        -- Validasi keberadaan campaign_id dan recipient_id
        IF NOT EXISTS (SELECT 1 FROM Campaigns WHERE id = @campaign_id)
        BEGIN
            THROW 50001, 'Campaign ID tidak ditemukan.', 1;
        END

        IF NOT EXISTS (SELECT 1 FROM Recipients WHERE id = @recipient_id)
        BEGIN
            THROW 50002, 'Recipient ID tidak ditemukan.', 1;
        END

        -- Update data pada tabel Campaign_Recipients
        UPDATE Campaign_Recipients
        SET 
            campaign_id = @campaign_id,
            recipient_id = @recipient_id,
            allocation_percentage = @allocation_percentage,
            updated_at = GETDATE()
        WHERE id = @id;

        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;

        -- Tampilkan pesan error
        THROW;
    END CATCH
END;


EXEC UpdateCampaignRecipient
    @id = 14, 
    @campaign_id = 5,
    @recipient_id = 14, 
    @allocation_percentage = 15; 



SELECT * FROM Campaign_Recipients
	select * from Campaign_Recipients;



