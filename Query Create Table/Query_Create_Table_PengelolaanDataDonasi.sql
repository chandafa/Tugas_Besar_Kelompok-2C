CREATE TABLE "Users" (
    "id" INT NOT NULL IDENTITY(1,1),
    "name" NVARCHAR(100) NOT NULL,
    "email" NVARCHAR(100) NOT NULL,
    "password" NVARCHAR(255) NOT NULL,
    "role" NVARCHAR(10) CHECK (
        "role" IN (N'admin', N'fundraiser', N'donatur')
    ) NOT NULL DEFAULT 'donatur',
    "created_at" DATETIME NULL DEFAULT GETDATE(),
    "updated_at" DATETIME NULL DEFAULT GETDATE()
);
ALTER TABLE "Users" ADD CONSTRAINT "users_id_primary" PRIMARY KEY ("id");
CREATE UNIQUE INDEX "users_email_unique" ON "Users" ("email");

CREATE TABLE "Campaigns" (
    "id" INT NOT NULL IDENTITY(1,1),
    "title" NVARCHAR(150) NOT NULL,
    "description" VARCHAR(255) NOT NULL,
    "target_amount" DECIMAL(15, 2) NOT NULL,
    "collected_amount" DECIMAL(15, 2) NULL DEFAULT 0.00,
    "category" NVARCHAR(30) NOT NULL,
    "verification_status" NVARCHAR(10) CHECK (
        "verification_status" IN (N'pending', N'approved', N'rejected')
    ) NULL DEFAULT 'pending',
    "status" NVARCHAR(10) CHECK (
        "status" IN (N'active', N'inactive', N'completed')
    ) NULL DEFAULT 'inactive',
    "user_id" INT NOT NULL,
    "start_date" DATE NOT NULL,
    "end_date" DATE NOT NULL,
    "created_at" DATETIME NULL DEFAULT GETDATE(),
    "updated_at" DATETIME NULL DEFAULT GETDATE()
);
ALTER TABLE "Campaigns" ADD CONSTRAINT "campaigns_id_primary" PRIMARY KEY ("id");

CREATE TABLE "Recipients" (
    "id" INT NOT NULL IDENTITY(1,1),
    "name" NVARCHAR(100) NOT NULL,
    "type" NVARCHAR(15) CHECK (
        "type" IN (N'individual', N'organization')
    ) NOT NULL,
    "contact_info" NVARCHAR(255) NULL,
    "address" VARCHAR(255) NULL,
    "created_at" DATETIME NULL DEFAULT GETDATE(),
    "updated_at" DATETIME NULL DEFAULT GETDATE()
);
ALTER TABLE "Recipients" ADD CONSTRAINT "recipients_id_primary" PRIMARY KEY ("id");

CREATE TABLE "Campaign_Recipients" (
    "id" INT NOT NULL IDENTITY(1,1),
    "campaign_id" INT NOT NULL,
    "recipient_id" INT NOT NULL,
    "allocation_percentage" DECIMAL(5, 2) NULL DEFAULT 100,
    "created_at" DATETIME NULL DEFAULT GETDATE(),
    "updated_at" DATETIME NULL DEFAULT GETDATE()
);
ALTER TABLE "Campaign_Recipients" ADD CONSTRAINT "campaign_recipients_id_primary" PRIMARY KEY ("id");

CREATE TABLE "Donations" (
    "id" INT NOT NULL IDENTITY(1,1),
    "amount" DECIMAL(15, 2) NOT NULL,
    "message" VARCHAR(150) NULL,
    "donor_name" NVARCHAR(100) NULL,
    "is_anonymous" BIT NULL DEFAULT 0,
    "campaign_id" INT NOT NULL,
    "user_id" INT NULL,
    "donation_date" DATETIME NOT NULL,
    "created_at" DATETIME NULL DEFAULT GETDATE(),
    "updated_at" DATETIME NULL DEFAULT GETDATE()
);
ALTER TABLE "Donations" ADD CONSTRAINT "donations_id_primary" PRIMARY KEY ("id");

CREATE TABLE "Transactions" (
    "id" INT NOT NULL IDENTITY(1,1),
    "donation_id" INT NOT NULL,
    "recipient_id" INT NOT NULL,
    "amount_transferred" DECIMAL(15, 2) NOT NULL,
    "transaction_date" DATETIME NOT NULL,
    "created_at" DATETIME NULL DEFAULT GETDATE(),
    "updated_at" DATETIME NULL DEFAULT GETDATE()
);
ALTER TABLE "Transactions" ADD CONSTRAINT "transactions_id_primary" PRIMARY KEY ("id");

CREATE TABLE "Verification_Logs" (
    "id" INT NOT NULL IDENTITY(1,1),
    "campaign_id" INT NULL,
    "user_id" INT NOT NULL,
    "admin_id" INT NOT NULL,
    "verification_date" DATETIME NOT NULL,
    "status" NVARCHAR(50) CHECK (
        "status" IN (N'approved', N'rejected')
    ) NOT NULL,
    "reason" VARCHAR(100) NULL,
    "created_at" DATETIME NULL DEFAULT GETDATE()
);
ALTER TABLE "Verification_Logs" ADD CONSTRAINT "verification_logs_id_primary" PRIMARY KEY ("id");

CREATE TABLE "Notifications" (
    "id" INT NOT NULL IDENTITY(1,1),
    "user_id" INT NOT NULL,
    "message" VARCHAR(100) NOT NULL,
    "created_at" DATETIME NULL DEFAULT GETDATE()
);
ALTER TABLE "Notifications" ADD CONSTRAINT "notifications_id_primary" PRIMARY KEY ("id");

CREATE TABLE "Reports" (
    "id" INT NOT NULL IDENTITY(1,1),
    "campaign_id" INT NOT NULL,
    "user_id" INT NOT NULL,
    "report_date" DATE NOT NULL,
    "description" VARCHAR(255) NOT NULL,
    "amount_used" DECIMAL(15, 2) NOT NULL,
    "remaining_amount" DECIMAL(15, 2) NOT NULL,
    "status" NVARCHAR(50) CHECK (
        "status" IN (N'pending', N'approved', N'rejected')
    ) NULL DEFAULT 'pending',
    "admin_id" INT NULL,
    "reason" VARCHAR(100) NULL,
    "created_at" DATETIME NULL DEFAULT GETDATE(),
    "updated_at" DATETIME NULL DEFAULT GETDATE()
);
ALTER TABLE "Reports" ADD CONSTRAINT "reports_id_primary" PRIMARY KEY ("id");

-- Foreign Keys
ALTER TABLE "Reports" ADD CONSTRAINT "reports_campaign_id_foreign" FOREIGN KEY ("campaign_id") REFERENCES "Campaigns" ("id");
ALTER TABLE "Donations" ADD CONSTRAINT "donations_campaign_id_foreign" FOREIGN KEY ("campaign_id") REFERENCES "Campaigns" ("id");
ALTER TABLE "Notifications" ADD CONSTRAINT "notifications_user_id_foreign" FOREIGN KEY ("user_id") REFERENCES "Users" ("id");
ALTER TABLE "Reports" ADD CONSTRAINT "reports_admin_id_foreign" FOREIGN KEY ("admin_id") REFERENCES "Users" ("id");
ALTER TABLE "Verification_Logs" ADD CONSTRAINT "verification_logs_user_id_foreign" FOREIGN KEY ("user_id") REFERENCES "Users" ("id");
ALTER TABLE "Verification_Logs" ADD CONSTRAINT "verification_logs_campaign_id_foreign" FOREIGN KEY ("campaign_id") REFERENCES "Campaigns" ("id");
ALTER TABLE "Campaigns" ADD CONSTRAINT "campaigns_user_id_foreign" FOREIGN KEY ("user_id") REFERENCES "Users" ("id");
ALTER TABLE "Campaign_Recipients" ADD CONSTRAINT "campaign_recipients_recipient_id_foreign" FOREIGN KEY ("recipient_id") REFERENCES "Recipients" ("id");
ALTER TABLE "Campaign_Recipients" ADD CONSTRAINT "campaign_recipients_campaign_id_foreign" FOREIGN KEY ("campaign_id") REFERENCES "Campaigns" ("id");
ALTER TABLE "Transactions" ADD CONSTRAINT "transactions_donation_id_foreign" FOREIGN KEY ("donation_id") REFERENCES "Donations" ("id");
ALTER TABLE "Verification_Logs" ADD CONSTRAINT "verification_logs_admin_id_foreign" FOREIGN KEY ("admin_id") REFERENCES "Users" ("id");
ALTER TABLE "Reports" ADD CONSTRAINT "reports_user_id_foreign" FOREIGN KEY ("user_id") REFERENCES "Users" ("id");
ALTER TABLE "Donations" ADD CONSTRAINT "donations_user_id_foreign" FOREIGN KEY ("user_id") REFERENCES "Users" ("id");
ALTER TABLE "Transactions" ADD CONSTRAINT "transactions_recipient_id_foreign" FOREIGN KEY ("recipient_id") REFERENCES "Recipients" ("id");
