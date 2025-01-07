	INSERT INTO "Campaigns" ("title", "description", "target_amount", "collected_amount", "category", "verification_status", "status", "user_id", "start_date", "end_date", "created_at", "updated_at")
	VALUES
	('Bantuan Banjir', 'Penggalangan dana untuk korban banjir di Jakarta.', 50000000.00, 15000000.00, 'bencana', 'approved', 'active', 1, '2025-01-01', '2025-03-01', GETDATE(), GETDATE()),
	('Pendidikan Anak', 'Menyediakan beasiswa untuk anak-anak yang kurang mampu.', 30000000.00, 8000000.00, 'pendidikan', 'pending', 'active', 2, '2025-01-10', '2025-06-10', GETDATE(), GETDATE()),
	('Kesehatan Masyarakat', 'Mendukung program kesehatan di desa terpencil.', 70000000.00, 25000000.00, 'kesehatan', 'approved', 'active', 1, '2025-01-15', '2025-05-15', GETDATE(), GETDATE()),
	('Bantuan Pangan', 'Distribusi sembako untuk keluarga kurang mampu.', 20000000.00, 5000000.00, 'kemanusiaan', 'pending', 'active', 3, '2025-02-01', '2025-04-01', GETDATE(), GETDATE()),
	('Pelestarian Lingkungan', 'Kegiatan penghijauan di kota.', 10000000.00, 3000000.00, 'lingkungan', 'pending', 'inactive', 2, '2025-03-01', '2025-08-01', GETDATE(), GETDATE()),
	('Bantuan Medis', 'Penggalangan dana untuk obat-obatan di puskesmas.', 15000000.00, 5000000.00, 'kesehatan', 'approved', 'active', 1, '2025-01-20', '2025-05-20', GETDATE(), GETDATE()),
	('Bantuan Pendidikan', 'Penyediaan alat tulis untuk anak-anak sekolah.', 10000000.00, 2000000.00, 'pendidikan', 'pending', 'active', 3, '2025-02-10', '2025-04-10', GETDATE(), GETDATE()),
	('Dukungan Seni', 'Mendukung kegiatan seni dan budaya lokal.', 5000000.00, 1500000.00, 'seni', 'approved', 'inactive', 2, '2025-02-15', '2025-06-15', GETDATE(), GETDATE()),
	('Rehabilitasi Rumah', 'Membangun rumah untuk keluarga yang membutuhkan.', 80000000.00, 30000000.00, 'perumahan', 'approved', 'active', 1, '2025-01-05', '2025-09-05', GETDATE(), GETDATE()),
	('Bantuan Bencana Alam', 'Menyalurkan bantuan untuk korban gempa.', 60000000.00, 20000000.00, 'bencana', 'pending', 'active', 3, '2025-02-20', '2025-07-20', GETDATE(), GETDATE()),
	('Program Imunisasi', 'Menyediakan imunisasi gratis untuk anak-anak.', 25000000.00, 12000000.00, 'kesehatan', 'approved', 'active', 2, '2025-01-25', '2025-06-25', GETDATE(), GETDATE()),
	('Kampanye Kebersihan', 'Menggalakkan kebersihan lingkungan di kota.', 3000000.00, 1000000.00, 'lingkungan', 'pending', 'inactive', 3, '2025-03-10', '2025-06-10', GETDATE(), GETDATE()),
	('Pengembangan Desa', 'Mendukung program pengembangan desa terpencil.', 40000000.00, 15000000.00, 'pengembangan', 'approved', 'active', 1, '2025-01-30', '2025-12-30', GETDATE(), GETDATE()),
	('Pelatihan Keterampilan', 'Memberikan pelatihan keterampilan untuk pemuda.', 20000000.00, 6000000.00, 'pendidikan', 'pending', 'active', 2, '2025-02-05', '2025-05-05', GETDATE(), GETDATE()),
	('Program Penghijauan', 'Menanam pohon di area kritis.', 15000000.00, 4000000.00, 'lingkungan', 'approved', 'active', 3, '2025-03-15', '2025-07-15', GETDATE(), GETDATE()),
	('Bantuan Hukum', 'Menyediakan bantuan hukum untuk yang membutuhkan.', 30000000.00, 5000000.00, 'hukum', 'pending', 'inactive', 1, '2025-01-15', '2025-08-15', GETDATE(), GETDATE()),
	('Festival Budaya', 'Mendukung penyelenggaraan festival budaya lokal.', 50000000.00, 15000000.00, 'seni', 'approved', 'active', 2, '2025-02-01', '2025-06-01', GETDATE(), GETDATE()),
	('Bantuan Transportasi', 'Menyediakan transportasi bagi masyarakat terpencil.', 20000000.00, 5000000.00, 'kemanusiaan', 'pending', 'active', 3, '2025-02-15', '2025-07-15', GETDATE(), GETDATE()),
	('Kegiatan Olahraga', 'Menggalakkan kegiatan olahraga bagi anak-anak.', 15000000.00, 7000000.00, 'olahraga', 'approved', 'active', 1, '2025-03-20', '2025-06-20', GETDATE(), GETDATE()),
	('Pelayanan Kesehatan', 'Menyediakan layanan kesehatan gratis untuk masyarakat.', 40000000.00, 20000000.00, 'kesehatan', 'pending', 'active', 2, '2025-01-20', '2025-10-20', GETDATE(), GETDATE()),
	('Kegiatan Relawan', 'Mendukung kegiatan relawan di komunitas.', 3000000.00, 1200000.00, 'kemanusiaan', 'approved', 'inactive', 3, '2025-02-20', '2025-06-20', GETDATE(), GETDATE()),
	('Pengadaan Alat Olahraga', 'Menyediakan alat olahraga untuk sekolah.', 10000000.00, 3000000.00, 'olahraga', 'pending', 'inactive', 1, '2025-03-05', '2025-07-05', GETDATE(), GETDATE()),
	('Bantuan Kemanusiaan', 'Mendukung program bantuan kemanusiaan di daerah konflik.', 60000000.00, 20000000.00, 'kemanusiaan', 'approved', 'active', 2, '2025-01-10', '2025-12-10', GETDATE(), GETDATE()),
	('Kegiatan Ramah Lingkungan', 'Mendukung kegiatan ramah lingkungan di masyarakat.', 20000000.00, 8000000.00, 'lingkungan', 'pending', 'active', 3, '2025-02-25', '2025-08-25', GETDATE(), GETDATE());
			
			select * from Campaigns