
========================================VIEW AGGREGATS========================================================

-- 1. Total donasi terkumpul per campaign + AGGREGATS

CREATE VIEW VW_TotalDonationsPerCampaign AS
SELECT 
    C.id AS CampaignID,
    C.title AS CampaignTitle,
    COUNT(D.id) AS TotalDonations,
    SUM(D.amount) AS TotalAmountDonated
FROM 
    Campaigns C
LEFT JOIN Donations D ON C.id = D.campaign_id
GROUP BY 
    C.id, C.title;

SELECT * FROM VW_TotalDonationsPerCampaign



-- 2. Menampilkan ringkasan jumlah donasi dan total dana yang didonasikan oleh pengguna. + AGGREGATS


CREATE VIEW VW_UserDonationsSummary AS
SELECT 
    U.id AS UserID,
    U.name AS UserName,
    COUNT(D.id) AS TotalDonations,
    SUM(D.amount) AS TotalAmountDonated
FROM 
    Users U
LEFT JOIN Donations D ON U.id = D.user_id
GROUP BY 
    U.id, U.name;

	SELECT * FROM VW_UserDonationsSummary



--3. Menampilkan donasi tertinggi yang diterima oleh setiap kampanye. AGGREGATS


CREATE VIEW VW_HighestDonationPerCampaign AS
SELECT 
    C.id AS CampaignID,
    C.title AS CampaignTitle,
    MAX(D.amount) AS HighestDonation
FROM 
    Campaigns C
LEFT JOIN Donations D ON C.id = D.campaign_id
GROUP BY 
    C.id, C.title;

	SELECT * FROM VW_HighestDonationPerCampaign




-- 4. Menampilkan donasi terendah yang diterima oleh setiap kampanye. AGGREGATS


CREATE VIEW VW_LowestDonationPerCampaign AS
SELECT 
    C.id AS CampaignID,
    C.title AS CampaignTitle,
    MIN(D.amount) AS LowestDonation
FROM 
    Campaigns C
LEFT JOIN Donations D ON C.id = D.campaign_id
GROUP BY 
    C.id, C.title;

	SELECT * FROM VW_LowestDonationPerCampaign




--5.  Menampilkan jumlah total donasi yang diterima setiap bulan. AGGREGATS


CREATE VIEW VW_DonationTrendsByMonth AS
SELECT 
    YEAR(D.donation_date) AS DonationYear,
    MONTH(D.donation_date) AS DonationMonth,
    SUM(D.amount) AS TotalDonations
FROM 
    Donations D
GROUP BY 
    YEAR(D.donation_date), MONTH(D.donation_date);

select * from VW_DonationTrendsByMonth;



--6. Menghitung rata-rata jumlah donasi untuk setiap kampanye. AGGREGATS


CREATE VIEW VW_AvgDonationAmount AS
SELECT 
    C.id AS CampaignID,
    C.title AS CampaignTitle,
    AVG(D.amount) AS AverageDonationAmount
FROM 
    Campaigns C
LEFT JOIN Donations D ON C.id = D.campaign_id
GROUP BY 
    C.id, C.title;

	SELECT * FROM VW_AvgDonationAmount



========================================VIEW JOIN========================================================

--7.  View DonationByUser + JOIN
CREATE VIEW VW_DonationByUser AS
SELECT 
    D.id AS DonationID,
    D.amount AS Amount,
    D.message AS Message,
    D.donor_name AS DonorName,
    U.id AS UserID,
    U.name AS UserName,
    C.title AS CampaignTitle,
    D.donation_date AS DonationDate
FROM Donations D
LEFT JOIN Users U ON D.user_id = U.id
INNER JOIN Campaigns C ON D.campaign_id = C.id
WHERE D.user_id IS NOT NULL;

SELECT * FROM VW_DonationByUser


--8. View DonationByAnonim JOIN
CREATE VIEW VW_DonationByAnonim AS
SELECT 
    D.id AS DonationID,
    D.amount AS Amount,
    D.message AS Message,
    D.donor_name AS DonorName,
    D.user_id AS UserID, -- Tetap menampilkan UserID meskipun NULL
    C.title AS CampaignTitle,
    D.donation_date AS DonationDate
FROM Donations D
INNER JOIN Campaigns C ON D.campaign_id = C.id
WHERE D.user_id IS NULL;

SELECT * FROM VW_DonationByAnonim

--9. View CampaignsOwner JOIN
CREATE VIEW VW_CampaignsOwner AS
SELECT 
    C.id AS CampaignID,
    C.title AS Title,
    C.description AS Description,
    C.target_amount AS TargetAmount,
    C.collected_amount AS CollectedAmount,
    C.category AS Category,
    C.verification_status AS VerificationStatus,
    C.status AS Status,
    C.start_date AS StartDate,
    C.end_date AS EndDate,
    U.id AS UserID,
    U.name AS UserName,
    U.email AS UserEmail
FROM Campaigns C
INNER JOIN Users U ON C.user_id = U.id;

select * from VW_CampaignsOwner

--10. View CampaignsVerificationLog JOIN
CREATE VIEW VW_CampaignsVerificationLog AS
SELECT 
    VL.id AS LogID,
    VL.verification_date AS VerificationDate,
    VL.status AS VerificationStatus,
    VL.reason AS Reason,
    C.id AS CampaignID,
    C.title AS CampaignTitle,
    C.category AS Category,
    U.id AS UserID,
    U.name AS UserName
FROM Verification_Logs VL
INNER JOIN Campaigns C ON VL.campaign_id = C.id
INNER JOIN Users U ON VL.user_id = U.id

SELECT * FROM VW_CampaignsVerificationLog



--11. View TransactionDetails JOIN
CREATE VIEW VW_TransactionDetails AS
SELECT 
    T.id AS TransactionID,
    T.transaction_date AS TransactionDate,
    T.amount_transferred AS AmountTransferred,
    D.id AS DonationID,
    D.amount AS DonationAmount,
    D.donor_name AS DonorName,
    D.message AS DonationMessage,
    C.id AS CampaignID,
    C.title AS CampaignTitle
FROM Transactions T
INNER JOIN Donations D ON T.donation_id = D.id
INNER JOIN Campaigns C ON D.campaign_id = C.id;

SELECT * FROM VW_TransactionDetails


========================================VIEW BEBAS========================================================

--12. VIEW eports_With_Admin_Info BEBAS
CREATE VIEW Reports_With_Admin_Info AS
SELECT 
    r.id AS report_id,
    r.campaign_id,
    r.user_id AS reporter_user_id,
    r.report_date,
    r.description,
    r.amount_used,
    r.remaining_amount,
    r.status AS report_status,
    r.reason,
    r.admin_id
FROM 
    Reports r
WHERE 
    r.admin_id IS NOT NULL;


SELECT * FROM Reports_With_Admin_Info;


--13. VIEW Recipients_With_Transactions  BEBAS

CREATE VIEW Recipients_With_Transactions  
WITH ENCRYPTION  
AS  
SELECT 
    r.id AS recipient_id,
    r.name AS recipient_name,
    r.type AS recipient_type,
    r.contact_info,
    t.id AS transaction_id,
    t.amount_transferred,
    t.transaction_date
FROM 
    Recipients r
LEFT JOIN Transactions t ON r.id = t.recipient_id;

SELECT * FROM 	Recipients_With_Transactions;



--14. VIEW Campaigns_With_Reports BEBAS
CREATE VIEW Campaigns_With_Reports AS
SELECT 
    c.id AS campaign_id,
    c.title AS campaign_title,
    COUNT(r.id) AS total_reports,
    SUM(r.amount_used) AS total_amount_used
FROM 
    Campaigns c
LEFT JOIN Reports r ON c.id = r.campaign_id
GROUP BY 
    c.id, c.title;


SELECT * FROM 	Campaigns_With_Reports;



--15. VIEW Campaigns_With_Multiple_Recipients  BEBAS

CREATE VIEW Campaigns_With_Multiple_Recipients  
WITH SCHEMABINDING  
AS  
SELECT 
    cr.campaign_id,
    COUNT(cr.recipient_id) AS total_recipients
FROM 
    dbo.Campaign_Recipients cr
GROUP BY 
    cr.campaign_id
HAVING 
    COUNT(cr.recipient_id) > 3;
GO

CREATE UNIQUE CLUSTERED INDEX IDX_Campaigns_With_Multiple_Recipients  
ON Campaigns_With_Multiple_Recipients(campaign_id);


SELECT * FROM [dbo].[Recipients_With_Transactions];

CREATE OR ALTER VIEW Campaigns_With_Multiple_Recipients  
AS  
SELECT 
    cr.campaign_id,
    COUNT_BIG(*) AS total_recipients
FROM 
    dbo.Campaign_Recipients cr
GROUP BY 
    cr.campaign_id
HAVING 
    COUNT_BIG(*) > 3;
GO

SELECT * FROM Campaigns_With_Multiple_Recipients 



--16. VIEW Campaign_Allocation_With_Recipients BEBASss
	CREATE VIEW Campaign_Allocation_With_Recipients AS
	SELECT 
		cr.campaign_id,
		c.title AS campaign_title,
		c.category AS campaign_category,
		r.id AS recipient_id,
		r.name AS recipient_name,
		cr.allocation_percentage
	FROM 
		Campaign_Recipients cr
	INNER JOIN Campaigns c ON cr.campaign_id = c.id
	INNER JOIN Recipients r ON cr.recipient_id = r.id
	WHERE 
		cr.allocation_percentage > 0;



	SELECT * FROM Campaign_Allocation_With_Recipients;









