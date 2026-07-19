-- ============================================================================
-- GODREJ RIVERINE, NOIDA — CRM / MARKETING / SALES / INVENTORY DATABASE
-- Schema Design | MySQL 8.0+
-- Built directly from: 01_Data_Dictionary.md
-- ============================================================================
-- Design notes (straight from the data dictionary):
-- - All primary keys are VARCHAR business codes (e.g. CUST00001, LEAD00001),
--   matching how the CSVs are generated — not auto-increment surrogate keys.
-- - Inventory, Marketing_Spend, Channel_Partners, and Competitor_Analysis are
--   intentionally STANDALONE tables (no FK) — this mirrors the real dataset:
--   Inventory (Towers I-L) is a different phase than Bookings (Towers A-H),
--   Marketing_Spend is a monthly aggregate, Channel_Partners is a
--   pre-aggregated summary, and Competitor_Analysis is external research.
-- ============================================================================

DROP DATABASE IF EXISTS godrej_riverine;
CREATE DATABASE godrej_riverine
    CHARACTER SET utf8mb4
    COLLATE utf8mb4_unicode_ci;

USE godrej_riverine;

-- ----------------------------------------------------------------------------
-- 1. SALES_EXECUTIVES
-- ----------------------------------------------------------------------------
CREATE TABLE Sales_Executives (
    Executive_ID    VARCHAR(6)   PRIMARY KEY,
    Executive_Name  VARCHAR(60)  NOT NULL,
    Experience      INT,
    Manager         VARCHAR(60),
    Monthly_Target  BIGINT,
    Joining_Date    DATE
) ENGINE=InnoDB;

-- ----------------------------------------------------------------------------
-- 2. MARKETING_CAMPAIGNS
-- ----------------------------------------------------------------------------
CREATE TABLE Marketing_Campaigns (
    Campaign_ID    VARCHAR(7)   PRIMARY KEY,
    Campaign_Name  VARCHAR(80)  NOT NULL,
    Channel        VARCHAR(30),
    Start_Date     DATE,
    End_Date       DATE,
    Objective      VARCHAR(30),
    CHECK (End_Date IS NULL OR End_Date >= Start_Date)
) ENGINE=InnoDB;

-- ----------------------------------------------------------------------------
-- 3. CUSTOMERS
-- ----------------------------------------------------------------------------
CREATE TABLE Customers (
    Customer_ID         VARCHAR(10)  PRIMARY KEY,
    First_Name          VARCHAR(50)  NOT NULL,
    Last_Name           VARCHAR(50)  NOT NULL,
    Gender              VARCHAR(10),
    Age                 INT,
    Marital_Status      VARCHAR(15),
    Occupation          VARCHAR(50),
    Company             VARCHAR(100),
    Annual_Income       BIGINT,
    Net_Worth           BIGINT,
    City                VARCHAR(50),
    Current_Residence   VARCHAR(100),
    Family_Size         INT,
    Existing_Home       VARCHAR(5),
    Investment_Purpose  VARCHAR(30),
    Preferred_BHK       VARCHAR(10),
    Budget              BIGINT,
    Preferred_Payment   VARCHAR(40),
    Created_Date        DATE,
    CHECK (Age BETWEEN 18 AND 100)
) ENGINE=InnoDB;

-- ----------------------------------------------------------------------------
-- 4. CHANNEL_PARTNERS  (standalone — no FK, per data dictionary)
-- ----------------------------------------------------------------------------
CREATE TABLE Channel_Partners (
    Partner_ID       VARCHAR(6)   PRIMARY KEY,
    Partner_Name     VARCHAR(60)  NOT NULL,
    Location         VARCHAR(60),
    Experience       INT,
    Leads_Generated  INT DEFAULT 0,
    Bookings         INT DEFAULT 0
) ENGINE=InnoDB;

-- ----------------------------------------------------------------------------
-- 5. MARKETING_SPEND  (standalone — one row per month, wide format)
-- ----------------------------------------------------------------------------
CREATE TABLE Marketing_Spend (
    Month            VARCHAR(7)  PRIMARY KEY,   -- YYYY-MM
    Google           BIGINT DEFAULT 0,
    Meta             BIGINT DEFAULT 0,
    LinkedIn         BIGINT DEFAULT 0,
    OOH              BIGINT DEFAULT 0,
    Metro            BIGINT DEFAULT 0,
    Print            BIGINT DEFAULT 0,
    Events           BIGINT DEFAULT 0,
    ChannelPartners  BIGINT DEFAULT 0
) ENGINE=InnoDB;

-- ----------------------------------------------------------------------------
-- 6. INVENTORY  (standalone — currently open phase, Towers I-L)
-- ----------------------------------------------------------------------------
CREATE TABLE Inventory (
    Tower          VARCHAR(2),
    Floor          INT,
    Unit_No        VARCHAR(10)  PRIMARY KEY,
    Configuration  VARCHAR(10),
    Facing         VARCHAR(30),
    Status         VARCHAR(15)   -- Available / Reserved / Booked
) ENGINE=InnoDB;

-- ----------------------------------------------------------------------------
-- 7. COMPETITOR_ANALYSIS  (standalone — external market research)
-- ----------------------------------------------------------------------------
CREATE TABLE Competitor_Analysis (
    Visit_ID         VARCHAR(12)  PRIMARY KEY,
    Competitor       VARCHAR(30)  NOT NULL,
    Visit_Date       DATE,
    Price_Score      DECIMAL(3,1),
    Sales_Score      DECIMAL(3,1),
    Amenities_Score  DECIMAL(3,1),
    Trust_Score      DECIMAL(3,1),
    Overall_Rating   DECIMAL(3,1)
) ENGINE=InnoDB;

-- ----------------------------------------------------------------------------
-- 8. LEADS  (core fact table — one row per inquiry)
-- ----------------------------------------------------------------------------
CREATE TABLE Leads (
    Lead_ID             VARCHAR(10)  PRIMARY KEY,
    Customer_ID         VARCHAR(10)  NOT NULL,
    Lead_Date           DATE         NOT NULL,
    Lead_Source         VARCHAR(30),
    Campaign_ID         VARCHAR(10),                 -- nullable: only paid channels have one
    Project             VARCHAR(30),
    Lead_Status         VARCHAR(30),
        -- New / Contacted / Qualified / Site Visit Scheduled / Negotiation /
        -- Converted / Not Interested / Lost
    Interest_Score      INT,
    Budget_Fit          VARCHAR(10),
    Sales_Executive_ID  VARCHAR(10),
    CONSTRAINT fk_leads_customer FOREIGN KEY (Customer_ID) REFERENCES Customers(Customer_ID)
        ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_leads_campaign FOREIGN KEY (Campaign_ID) REFERENCES Marketing_Campaigns(Campaign_ID)
        ON DELETE SET NULL ON UPDATE CASCADE,
    CONSTRAINT fk_leads_exec FOREIGN KEY (Sales_Executive_ID) REFERENCES Sales_Executives(Executive_ID)
        ON DELETE SET NULL ON UPDATE CASCADE,
    CHECK (Interest_Score BETWEEN 1 AND 10)
) ENGINE=InnoDB;

-- ----------------------------------------------------------------------------
-- 9. SITE_VISITS
-- ----------------------------------------------------------------------------
CREATE TABLE Site_Visits (
    Visit_ID             VARCHAR(11)  PRIMARY KEY,
    Lead_ID              VARCHAR(10)  NOT NULL,
    Visit_Date           DATE,
    Sales_Executive_ID   VARCHAR(10),
    Visit_Rating         INT,
    Family_Attended      VARCHAR(5),
    Sample_Flat          VARCHAR(10),
    Visit_Duration       INT,
    Booking_Probability  DECIMAL(4,2),
    CONSTRAINT fk_visits_lead FOREIGN KEY (Lead_ID) REFERENCES Leads(Lead_ID)
        ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_visits_exec FOREIGN KEY (Sales_Executive_ID) REFERENCES Sales_Executives(Executive_ID)
        ON DELETE SET NULL ON UPDATE CASCADE,
    CHECK (Visit_Rating BETWEEN 1 AND 5),
    CHECK (Booking_Probability BETWEEN 0 AND 1)
) ENGINE=InnoDB;

-- ----------------------------------------------------------------------------
-- 10. FOLLOW_UPS
-- ----------------------------------------------------------------------------
CREATE TABLE Follow_Ups (
    FollowUp_ID    VARCHAR(9)  PRIMARY KEY,
    Lead_ID        VARCHAR(10) NOT NULL,
    FollowUp_Date  DATE,
    Mode           VARCHAR(30),
    Purpose        VARCHAR(40),
    Outcome        VARCHAR(30),
    CONSTRAINT fk_followup_lead FOREIGN KEY (Lead_ID) REFERENCES Leads(Lead_ID)
        ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB;

-- ----------------------------------------------------------------------------
-- 11. BOOKINGS  (1:1 with Leads — only Converted leads appear here)
-- ----------------------------------------------------------------------------
CREATE TABLE Bookings (
    Booking_ID      VARCHAR(9)   PRIMARY KEY,
    Lead_ID         VARCHAR(10)  NOT NULL UNIQUE,
    Booking_Date    DATE,
    Tower           VARCHAR(2),
    Floor           INT,
    Unit_No         VARCHAR(10),
    Configuration   VARCHAR(10),
    Sale_Value      BIGINT,
    Discount        DECIMAL(4,2),
    Payment_Plan    VARCHAR(40),
    Booking_Status  VARCHAR(30),
    CONSTRAINT fk_booking_lead FOREIGN KEY (Lead_ID) REFERENCES Leads(Lead_ID)
        ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB;

-- ----------------------------------------------------------------------------
-- 12. PSYCHOLOGICAL_SURVEY  (1:1 with Site_Visits, linked via Lead_ID)
-- ----------------------------------------------------------------------------
CREATE TABLE Psychological_Survey (
    Survey_ID            VARCHAR(9)  PRIMARY KEY,
    Lead_ID              VARCHAR(10) NOT NULL,
    Trust_Score          INT,
    FOMO_Score           INT,
    Luxury_Score         INT,
    Investment_Score     INT,
    Price_Sensitivity    INT,
    Transparency_Rating  INT,
    Booking_Decision     VARCHAR(5),
    CONSTRAINT fk_survey_lead FOREIGN KEY (Lead_ID) REFERENCES Leads(Lead_ID)
        ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB;

-- ============================================================================
-- INDEXES — on the columns used most often for filtering/joining in analysis
-- ============================================================================
CREATE INDEX idx_leads_status   ON Leads(Lead_Status);
CREATE INDEX idx_leads_date     ON Leads(Lead_Date);
CREATE INDEX idx_leads_source   ON Leads(Lead_Source);
CREATE INDEX idx_bookings_date  ON Bookings(Booking_Date);
CREATE INDEX idx_visits_date    ON Site_Visits(Visit_Date);
CREATE INDEX idx_followup_date  ON Follow_Ups(FollowUp_Date);

-- ============================================================================
-- END OF SCHEMA — 12 tables, matching the data dictionary exactly
-- ============================================================================
