INSERT INTO "Recipients" ("name", "type", "contact_info", "address", "created_at", "updated_at")
VALUES
('Ahmad Kurniawan', 'individual', '081234567890', 'Jl. Raya No. 1, Jakarta', GETDATE(), GETDATE()),
('Budi Santoso', 'individual', '082345678901', 'Jl. Merdeka No. 2, Bandung', GETDATE(), GETDATE()),
('Citra Lestari', 'individual', '083456789012', 'Jl. Sejahtera No. 3, Surabaya', GETDATE(), GETDATE()),
('Diana Putri', 'individual', '084567890123', 'Jl. Pahlawan No. 4, Yogyakarta', GETDATE(), GETDATE()),
('Eko Prasetyo', 'individual', '085678901234', 'Jl. Cinta No. 5, Semarang', GETDATE(), GETDATE()),
('Fani Indah', 'individual', '086789012345', 'Jl. Harmoni No. 6, Medan', GETDATE(), GETDATE()),
('Gita Rizki', 'individual', '087890123456', 'Jl. Kebangkitan No. 7, Makassar', GETDATE(), GETDATE()),
('Hendra Wijaya', 'individual', '088901234567', 'Jl. Bahagia No. 8, Palembang', GETDATE(), GETDATE()),
('Indra Nugroho', 'individual', '089012345678', 'Jl. Sukses No. 9, Bali', GETDATE(), GETDATE()),
('Jasmine Putri', 'individual', '081123456789', 'Jl. Rakyat No. 10, Medan', GETDATE(), GETDATE()),
('Keluarga Bahagia', 'organization', '02123456789', 'Jl. Keluarga No. 1, Jakarta', GETDATE(), GETDATE()),
('Lembaga Pendidikan Cerdas', 'organization', '02123456790', 'Jl. Edukasi No. 2, Bandung', GETDATE(), GETDATE()),
('Komunitas Pecinta Alam', 'organization', '02123456791', 'Jl. Alam No. 3, Surabaya', GETDATE(), GETDATE()),
('Yayasan Sosial Harapan', 'organization', '02123456792', 'Jl. Harapan No. 4, Yogyakarta', GETDATE(), GETDATE()),
('Organisasi Kesehatan Masyarakat', 'organization', '02123456793', 'Jl. Kesehatan No. 5, Semarang', GETDATE(), GETDATE()),
('Lembaga Swadaya Masyarakat', 'organization', '02123456794', 'Jl. Masyarakat No. 6, Medan', GETDATE(), GETDATE()),
('Yayasan Anak Cinta', 'organization', '02123456795', 'Jl. Anak No. 7, Makassar', GETDATE(), GETDATE()),
('Komunitas Seni Budaya', 'organization', '02123456796', 'Jl. Budaya No. 8, Palembang', GETDATE(), GETDATE()),
('Panti Asuhan Bahagia', 'organization', '02123456797', 'Jl. Panti No. 9, Bali', GETDATE(), GETDATE()),
('Badan Amil Zakat', 'organization', '02123456798', 'Jl. Zakat No. 10, Jakarta', GETDATE(), GETDATE()),
('Rumah Singgah Anak', 'organization', '02123456799', 'Jl. Singgah No. 11, Bandung', GETDATE(), GETDATE()),
('Yayasan Kemanusiaan', 'organization', '02123456800', 'Jl. Kemanusiaan No. 12, Surabaya', GETDATE(), GETDATE()),
('Koperasi Usaha Bersama', 'organization', '02123456801', 'Jl. Usaha No. 13, Yogyakarta', GETDATE(), GETDATE()),
('Forum Komunitas Muda', 'organization', '02123456802', 'Jl. Muda No. 14, Semarang', GETDATE(), GETDATE()),
('Lembaga Lingkungan Hidup', 'organization', '02123456803', 'Jl. Lingkungan No. 15, Medan', GETDATE(), GETDATE()),
('Organisasi Perempuan Sejahtera', 'organization', '02123456804', 'Jl. Perempuan No. 16, Makassar', GETDATE(), GETDATE()),
('Sekolah Dasar Harapan', 'organization', '02123456805', 'Jl. Pendidikan No. 17, Palembang', GETDATE(), GETDATE()),
('Badan Pemuda dan Olahraga', 'organization', '02123456806', 'Jl. Olahraga No. 18, Bali', GETDATE(), GETDATE()),
('Organisasi Perempuan Sejahtera', 'organization', '02123456804', 'Jl. Perempuan No. 16, Makassar', GETDATE(), GETDATE()),
('Sekolah Dasar Harapan', 'organization', '02123456805', 'Jl. Pendidikan No. 17, Palembang', GETDATE(), GETDATE());


select * from Recipients

DELETE FROM "Recipients"
WHERE "name" IN ('Organisasi Perempuan Sejahtera', 'Sekolah Dasar Harapan');