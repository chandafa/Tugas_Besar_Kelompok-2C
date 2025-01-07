INSERT INTO "Donations" ("amount", "message", "donor_name", "is_anonymous", "campaign_id", "user_id", "donation_date", "created_at", "updated_at")
VALUES
(100000, 'Semoga bermanfaat', 'Ahmad Kurniawan', 0, 1, 1, GETDATE(), GETDATE(), GETDATE()),
(150000, 'Untuk membantu sesama', 'Budi Santoso', 1, 1, 2, GETDATE(), GETDATE(), GETDATE()),
(50000, 'Dukungan untuk kampanye ini', 'Citra Lestari', 0, 2, 1, GETDATE(), GETDATE(), GETDATE()),
(250000, 'Semoga cepat tercapai', 'Diana Putri', 0, 2, 3, GETDATE(), GETDATE(), GETDATE()),
(300000, 'Saya dukung penuh', 'Eko Prasetyo', 1, 3, 4, GETDATE(), GETDATE(), GETDATE()),
(120000, 'Untuk kebaikan bersama', 'Fani Indah', 0, 3, 5, GETDATE(), GETDATE(), GETDATE()),
(200000, 'Semoga bermanfaat bagi semua', 'Gita Rizki', 1, 4, 6, GETDATE(), GETDATE(), GETDATE()),
(60000, 'Sumbangan kecil untuk perubahan besar', 'Hendra Wijaya', 0, 4, 7, GETDATE(), GETDATE(), GETDATE()),
(80000, 'Donasi untuk panti asuhan', 'Indra Nugroho', 0, 5, 8, GETDATE(), GETDATE(), GETDATE()),
(150000, 'Bantuan untuk pendidikan', 'Jasmine Putri', 1, 5, 9, GETDATE(), GETDATE(), GETDATE()),
(350000, 'Dukungan untuk kampanye lingkungan', 'Ahmad Kurniawan', 0, 6, 10, GETDATE(), GETDATE(), GETDATE()),
(50000, 'Mendukung kegiatan sosial', 'Budi Santoso', 0, 6, 11, GETDATE(), GETDATE(), GETDATE()),
(400000, 'Semoga membantu banyak orang', 'Citra Lestari', 1, 7, 12, GETDATE(), GETDATE(), GETDATE()),
(90000, 'Ayo kita berbagi', 'Diana Putri', 1, 7, 13, GETDATE(), GETDATE(), GETDATE()),
(300000, 'Bersama kita bisa', 'Eko Prasetyo', 0, 8, 14, GETDATE(), GETDATE(), GETDATE()),
(75000, 'Dukung kampanye ini', 'Fani Indah', 1, 8, 15, GETDATE(), GETDATE(), GETDATE()),
(200000, 'Sumbangan untuk orang-orang yang membutuhkan', 'Gita Rizki', 0, 9, 16, GETDATE(), GETDATE(), GETDATE()),
(45000, 'Dukungan untuk komunitas', 'Hendra Wijaya', 0, 9, 17, GETDATE(), GETDATE(), GETDATE()),
(120000, 'Semoga bermanfaat untuk yang membutuhkan', 'Indra Nugroho', 1, 10, 18, GETDATE(), GETDATE(), GETDATE()),
(60000, 'Bantuan untuk kampanye', 'Jasmine Putri', 0, 10, 19, GETDATE(), GETDATE(), GETDATE()),
(300000, 'Untuk kampanye kesehatan', 'Ahmad Kurniawan', 1, 11, 20, GETDATE(), GETDATE(), GETDATE()),
(50000, 'Bantuan untuk yayasan', 'Budi Santoso', 0, 11, 21, GETDATE(), GETDATE(), GETDATE()),
(100000, 'Semoga donasi ini diterima', 'Citra Lestari', 1, 12, 1, GETDATE(), GETDATE(), GETDATE()),
(150000, 'Untuk mendukung kegiatan sosial', 'Diana Putri', 0, 12, 2, GETDATE(), GETDATE(), GETDATE()),
(250000, 'Sumbangan untuk pendidikan anak-anak', 'Eko Prasetyo', 1, 13, 3, GETDATE(), GETDATE(), GETDATE()),
(70000, 'Dukungan untuk penyandang disabilitas', 'Fani Indah', 0, 13, 4, GETDATE(), GETDATE(), GETDATE());


select  * from Donations;




INSERT INTO "Donations" ("amount", "message", "donor_name", "is_anonymous", "campaign_id", "user_id", "donation_date", "created_at", "updated_at")
VALUES
(100000.00, 'Semoga berkah.', 'Anonim', 1, 1, NULL, '2025-01-01', DEFAULT, DEFAULT),
(500000.00, 'Untuk membantu mereka yang membutuhkan.', 'John Doe', 0, 2, NULL, '2025-01-02', DEFAULT, DEFAULT),
(750000.00, 'Semoga dana ini bermanfaat.', 'Jane Smith', 0, 3, NULL, '2025-01-03', DEFAULT, DEFAULT),
(250000.00, 'Dengan doa terbaik.', NULL, 1, 4, NULL, '2025-01-04', DEFAULT, DEFAULT),
(300000.00, 'Berikan kepada yang membutuhkan.', 'Anonim', 1, 5, NULL, '2025-01-05', DEFAULT, DEFAULT),
(150000.00, 'Semoga Allah memberkahi.', 'Rahmat', 0, 6, NULL, '2025-01-06', DEFAULT, DEFAULT),
(600000.00, 'Untuk amal kebaikan.', NULL, 1, 7, NULL, '2025-01-07', DEFAULT, DEFAULT),
(400000.00, 'Bantu yang membutuhkan.', 'Anonim', 1, 8, NULL, '2025-01-08', DEFAULT, DEFAULT),
(200000.00, 'Semoga berkah untuk semua.', 'Siti', 0, 9, NULL, '2025-01-09', DEFAULT, DEFAULT),
(50000.00, 'Bantu mereka dengan tulus.', 'Anonim', 1, 10, NULL, '2025-01-10', DEFAULT, DEFAULT);
