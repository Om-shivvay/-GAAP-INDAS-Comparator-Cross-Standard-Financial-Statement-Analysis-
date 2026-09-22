-- =====================================================================
-- US GAAP vs Ind AS: Cross-Standard Financial Statement Analysis
-- Hindustan Unilever (Ind AS, Rs Crores) vs Procter & Gamble (US GAAP, $ Millions)
-- FY2021-FY2025
-- Written for MySQL 8.0+ (CTEs and window functions)
-- =====================================================================

-- =====================================================================
-- 1. SCHEMA
-- =====================================================================

DROP TABLE IF EXISTS financial_data;
DROP TABLE IF EXISTS companies;

CREATE TABLE companies (
    company_id      INT PRIMARY KEY AUTO_INCREMENT,
    company_name    VARCHAR(100) NOT NULL,
    ticker          VARCHAR(20)  NOT NULL,
    country         VARCHAR(50)  NOT NULL,
    accounting_standard VARCHAR(20) NOT NULL,   -- 'US GAAP' or 'Ind AS'
    reporting_currency   VARCHAR(10) NOT NULL,  -- 'INR Crores' or 'USD Millions'
    fiscal_year_end VARCHAR(20)  NOT NULL
);

CREATE TABLE financial_data (
    record_id       INT PRIMARY KEY AUTO_INCREMENT,
    company_id      INT NOT NULL,
    fiscal_year     INT NOT NULL,               -- 2021-2025
    statement_type  VARCHAR(30) NOT NULL,        -- 'Income Statement', 'Balance Sheet', 'Cash Flow'
    metric          VARCHAR(60) NOT NULL,
    value           DECIMAL(18,2) NOT NULL,
    FOREIGN KEY (company_id) REFERENCES companies(company_id)
);

-- =====================================================================
-- 2. REFERENCE DATA — companies
-- =====================================================================

INSERT INTO companies (company_name, ticker, country, accounting_standard, reporting_currency, fiscal_year_end) VALUES
('Hindustan Unilever Ltd', 'HINDUNILVR', 'India', 'Ind AS', 'INR Crores', '31 March'),
('Procter & Gamble Co',   'PG',         'USA',   'US GAAP', 'USD Millions', '30 June');

-- =====================================================================
-- 3. RAW DATA LOAD — Hindustan Unilever (company_id = 1)
-- =====================================================================

INSERT INTO financial_data (company_id, fiscal_year, statement_type, metric, value) VALUES
-- Income Statement
(1, 2021, 'Income Statement', 'Revenue', 47028), (1, 2022, 'Income Statement', 'Revenue', 52446),
(1, 2023, 'Income Statement', 'Revenue', 60580), (1, 2024, 'Income Statement', 'Revenue', 61896),
(1, 2025, 'Income Statement', 'Revenue', 61328),

(1, 2021, 'Income Statement', 'Operating Profit', 11626), (1, 2022, 'Income Statement', 'Operating Profit', 12857),
(1, 2023, 'Income Statement', 'Operating Profit', 14147), (1, 2024, 'Income Statement', 'Operating Profit', 14659),
(1, 2025, 'Income Statement', 'Operating Profit', 14698),

(1, 2021, 'Income Statement', 'Net Profit', 7999),  (1, 2022, 'Income Statement', 'Net Profit', 8892),
(1, 2023, 'Income Statement', 'Net Profit', 10143), (1, 2024, 'Income Statement', 'Net Profit', 10282),
(1, 2025, 'Income Statement', 'Net Profit', 10671),

-- Balance Sheet
(1, 2021, 'Balance Sheet', 'Inventory', 3579), (1, 2022, 'Balance Sheet', 'Inventory', 4096),
(1, 2023, 'Balance Sheet', 'Inventory', 4251), (1, 2024, 'Balance Sheet', 'Inventory', 4022),
(1, 2025, 'Balance Sheet', 'Inventory', 4415),

(1, 2021, 'Balance Sheet', 'Total Current Assets', 14217), (1, 2022, 'Balance Sheet', 'Total Current Assets', 15522),
(1, 2023, 'Balance Sheet', 'Total Current Assets', 16998), (1, 2024, 'Balance Sheet', 'Total Current Assets', 21324),
(1, 2025, 'Balance Sheet', 'Total Current Assets', 22051),

(1, 2021, 'Balance Sheet', 'Total Assets', 68740), (1, 2022, 'Balance Sheet', 'Total Assets', 70506),
(1, 2023, 'Balance Sheet', 'Total Assets', 73077), (1, 2024, 'Balance Sheet', 'Total Assets', 78489),
(1, 2025, 'Balance Sheet', 'Total Assets', 79863),

(1, 2021, 'Balance Sheet', 'Total Current Liabilities', 11103), (1, 2022, 'Balance Sheet', 'Total Current Liabilities', 11280),
(1, 2023, 'Balance Sheet', 'Total Current Liabilities', 12028), (1, 2024, 'Balance Sheet', 'Total Current Liabilities', 12879),
(1, 2025, 'Balance Sheet', 'Total Current Liabilities', 16537),

(1, 2021, 'Balance Sheet', 'Total Liabilities', 21066), (1, 2022, 'Balance Sheet', 'Total Liabilities', 21445),
(1, 2023, 'Balance Sheet', 'Total Liabilities', 22773), (1, 2024, 'Balance Sheet', 'Total Liabilities', 27271),
(1, 2025, 'Balance Sheet', 'Total Liabilities', 30461),

(1, 2021, 'Balance Sheet', 'Total Equity', 47674), (1, 2022, 'Balance Sheet', 'Total Equity', 49061),
(1, 2023, 'Balance Sheet', 'Total Equity', 50304), (1, 2024, 'Balance Sheet', 'Total Equity', 51218),
(1, 2025, 'Balance Sheet', 'Total Equity', 49402),

-- Cash Flow
(1, 2021, 'Cash Flow', 'Operating Cash Flow', 9163),  (1, 2022, 'Cash Flow', 'Operating Cash Flow', 9048),
(1, 2023, 'Cash Flow', 'Operating Cash Flow', 9991),  (1, 2024, 'Cash Flow', 'Operating Cash Flow', 15469),
(1, 2025, 'Cash Flow', 'Operating Cash Flow', 11886),

(1, 2021, 'Cash Flow', 'Free Cash Flow', 5097),  (1, 2022, 'Cash Flow', 'Free Cash Flow', 7995),
(1, 2023, 'Cash Flow', 'Free Cash Flow', 8980),  (1, 2024, 'Cash Flow', 'Free Cash Flow', 14012),
(1, 2025, 'Cash Flow', 'Free Cash Flow', 10624);

-- =====================================================================
-- 4. RAW DATA LOAD — Procter & Gamble (company_id = 2)
-- =====================================================================

INSERT INTO financial_data (company_id, fiscal_year, statement_type, metric, value) VALUES
-- Income Statement
(2, 2021, 'Income Statement', 'Revenue', 76118), (2, 2022, 'Income Statement', 'Revenue', 80187),
(2, 2023, 'Income Statement', 'Revenue', 82006), (2, 2024, 'Income Statement', 'Revenue', 84039),
(2, 2025, 'Income Statement', 'Revenue', 84284),

(2, 2021, 'Income Statement', 'Gross Profit', 39010), (2, 2022, 'Income Statement', 'Gross Profit', 38030),
(2, 2023, 'Income Statement', 'Gross Profit', 39246), (2, 2024, 'Income Statement', 'Gross Profit', 43191),
(2, 2025, 'Income Statement', 'Gross Profit', 43120),

(2, 2021, 'Income Statement', 'Operating Income', 18000), (2, 2022, 'Income Statement', 'Operating Income', 17800),
(2, 2023, 'Income Statement', 'Operating Income', 18100), (2, 2024, 'Income Statement', 'Operating Income', 18500),
(2, 2025, 'Income Statement', 'Operating Income', 20500),

(2, 2021, 'Income Statement', 'Net Profit', 14306), (2, 2022, 'Income Statement', 'Net Profit', 14742),
(2, 2023, 'Income Statement', 'Net Profit', 14653), (2, 2024, 'Income Statement', 'Net Profit', 14879),
(2, 2025, 'Income Statement', 'Net Profit', 15974),

-- Balance Sheet
(2, 2021, 'Balance Sheet', 'Inventory', 5983), (2, 2022, 'Balance Sheet', 'Inventory', 6924),
(2, 2023, 'Balance Sheet', 'Inventory', 7073), (2, 2024, 'Balance Sheet', 'Inventory', 7016),
(2, 2025, 'Balance Sheet', 'Inventory', 7551),

(2, 2021, 'Balance Sheet', 'Total Current Assets', 23091), (2, 2022, 'Balance Sheet', 'Total Current Assets', 21653),
(2, 2023, 'Balance Sheet', 'Total Current Assets', 22648), (2, 2024, 'Balance Sheet', 'Total Current Assets', 24709),
(2, 2025, 'Balance Sheet', 'Total Current Assets', 25392),

(2, 2021, 'Balance Sheet', 'Total Assets', 119307), (2, 2022, 'Balance Sheet', 'Total Assets', 117208),
(2, 2023, 'Balance Sheet', 'Total Assets', 120829), (2, 2024, 'Balance Sheet', 'Total Assets', 122370),
(2, 2025, 'Balance Sheet', 'Total Assets', 125231),

(2, 2021, 'Balance Sheet', 'Total Current Liabilities', 33132), (2, 2022, 'Balance Sheet', 'Total Current Liabilities', 33081),
(2, 2023, 'Balance Sheet', 'Total Current Liabilities', 35756), (2, 2024, 'Balance Sheet', 'Total Current Liabilities', 33627),
(2, 2025, 'Balance Sheet', 'Total Current Liabilities', 36058),

(2, 2021, 'Balance Sheet', 'Total Liabilities', 72653), (2, 2022, 'Balance Sheet', 'Total Liabilities', 70354),
(2, 2023, 'Balance Sheet', 'Total Liabilities', 73764), (2, 2024, 'Balance Sheet', 'Total Liabilities', 71811),
(2, 2025, 'Balance Sheet', 'Total Liabilities', 72946),

(2, 2021, 'Balance Sheet', 'Total Equity', 46654), (2, 2022, 'Balance Sheet', 'Total Equity', 46854),
(2, 2023, 'Balance Sheet', 'Total Equity', 47065), (2, 2024, 'Balance Sheet', 'Total Equity', 50559),
(2, 2025, 'Balance Sheet', 'Total Equity', 52284),

-- Cash Flow
(2, 2021, 'Cash Flow', 'Operating Cash Flow', 18371), (2, 2022, 'Cash Flow', 'Operating Cash Flow', 16723),
(2, 2023, 'Cash Flow', 'Operating Cash Flow', 16848), (2, 2024, 'Cash Flow', 'Operating Cash Flow', 19846),
(2, 2025, 'Cash Flow', 'Operating Cash Flow', 17817),

(2, 2021, 'Cash Flow', 'Free Cash Flow', 15584), (2, 2022, 'Cash Flow', 'Free Cash Flow', 13567),
(2, 2023, 'Cash Flow', 'Free Cash Flow', 13786), (2, 2024, 'Cash Flow', 'Free Cash Flow', 16524),
(2, 2025, 'Cash Flow', 'Free Cash Flow', 14044);

-- =====================================================================
-- 5. STANDARDS DIFFERENCES REFERENCE TABLE
-- =====================================================================

DROP TABLE IF EXISTS standards_differences;

CREATE TABLE standards_differences (
    topic               VARCHAR(60)  PRIMARY KEY,
    us_gaap_treatment   VARCHAR(500) NOT NULL,
    ind_as_treatment    VARCHAR(500) NOT NULL,
    practical_impact    VARCHAR(500) NOT NULL
);

INSERT INTO standards_differences VALUES
('Revenue Recognition',
 'ASC 606: revenue recognized at a single point in time when control transfers; trade/volume discounts and returns recorded as reduction of sales.',
 'Ind AS 115: substantially converged with ASC 606 - revenue recognized when control transfers; discounts/rebates also net against revenue.',
 'Largely converged post-2018 (both IFRS-15-based) - minimal practical divergence for FMCG revenue timing.'),
('Inventory Valuation',
 'ASC 330: lower of cost or market (or NRV); FIFO, LIFO, or average cost all permitted. P&G 10-K confirms primarily FIFO, minor LIFO for select items.',
 'Ind AS 2: lower of cost and net realizable value; FIFO or weighted-average permitted. LIFO is explicitly prohibited.',
 'P&G''s own disclosed practice (mostly FIFO) means real-world divergence from HUL is smaller than the standards permit in theory.'),
('Lease Accounting',
 'ASC 842: lessee recognizes right-of-use asset and lease liability for most leases (operating and finance) on balance sheet.',
 'Ind AS 116: same core model as ASC 842 - right-of-use asset and lease liability recognized for nearly all leases.',
 'Both standards converged around 2019; minor differences in short-term/low-value exemption thresholds and discount rate guidance.'),
('Property, Plant & Equipment',
 'ASC 360: PP&E carried at historical cost less accumulated depreciation; revaluation to fair value is NOT permitted.',
 'Ind AS 16: allows a choice between the cost model and the revaluation model (fair value with periodic revaluation).',
 'If HUL elected revaluation for any asset class, PP&E carrying values would not be directly comparable to P&G''s cost-only figures.'),
('Goodwill Treatment',
 'ASC 350: goodwill is not amortized; tested for impairment at least annually.',
 'Ind AS 103 / Ind AS 36: goodwill also not amortized under current Ind AS (aligned with IFRS 3); tested for impairment annually.',
 'Converged since Ind AS adoption - both companies expense goodwill only through impairment charges, not systematic amortization.');

-- =====================================================================
-- 6. ANALYSIS QUERIES
-- =====================================================================

-- 6.1 Side-by-side Revenue & Net Profit, both companies, all years
SELECT
    c.company_name,
    fd.fiscal_year,
    MAX(CASE WHEN fd.metric = 'Revenue'    THEN fd.value END) AS revenue,
    MAX(CASE WHEN fd.metric = 'Net Profit' THEN fd.value END) AS net_profit
FROM financial_data fd
JOIN companies c ON c.company_id = fd.company_id
WHERE fd.statement_type = 'Income Statement'
GROUP BY c.company_name, fd.fiscal_year
ORDER BY c.company_name, fd.fiscal_year;

-- 6.2 YoY Revenue Growth % using window function LAG()
WITH revenue_by_year AS (
    SELECT c.company_name, fd.fiscal_year, fd.value AS revenue
    FROM financial_data fd
    JOIN companies c ON c.company_id = fd.company_id
    WHERE fd.metric = 'Revenue'
)
SELECT
    company_name,
    fiscal_year,
    revenue,
    LAG(revenue) OVER (PARTITION BY company_name ORDER BY fiscal_year) AS prior_year_revenue,
    ROUND(
        (revenue - LAG(revenue) OVER (PARTITION BY company_name ORDER BY fiscal_year))
        / LAG(revenue) OVER (PARTITION BY company_name ORDER BY fiscal_year) * 100, 2
    ) AS yoy_growth_pct
FROM revenue_by_year
ORDER BY company_name, fiscal_year;

-- 6.3 Full ratio panel per company per year (CTEs pivoting the long table into columns)
WITH pivoted AS (
    SELECT
        c.company_name,
        fd.fiscal_year,
        MAX(CASE WHEN fd.metric = 'Revenue'                   THEN fd.value END) AS revenue,
        MAX(CASE WHEN fd.metric = 'Net Profit'                THEN fd.value END) AS net_profit,
        MAX(CASE WHEN fd.metric = 'Total Current Assets'      THEN fd.value END) AS current_assets,
        MAX(CASE WHEN fd.metric = 'Total Current Liabilities' THEN fd.value END) AS current_liabilities,
        MAX(CASE WHEN fd.metric = 'Total Assets'              THEN fd.value END) AS total_assets,
        MAX(CASE WHEN fd.metric = 'Total Liabilities'         THEN fd.value END) AS total_liabilities,
        MAX(CASE WHEN fd.metric = 'Total Equity'              THEN fd.value END) AS total_equity,
        MAX(CASE WHEN fd.metric = 'Free Cash Flow'            THEN fd.value END) AS free_cash_flow
    FROM financial_data fd
    JOIN companies c ON c.company_id = fd.company_id
    GROUP BY c.company_name, fd.fiscal_year
)
SELECT
    company_name,
    fiscal_year,
    ROUND(current_assets / current_liabilities, 2)      AS current_ratio,
    ROUND(net_profit / revenue * 100, 2)                 AS net_margin_pct,
    ROUND(net_profit / total_assets * 100, 2)            AS roa_pct,
    ROUND(net_profit / total_equity * 100, 2)            AS roe_pct,
    ROUND(total_liabilities / total_equity, 2)           AS debt_to_equity,
    ROUND(free_cash_flow / revenue * 100, 2)             AS fcf_margin_pct
FROM pivoted
ORDER BY company_name, fiscal_year;

-- 6.4 5-year CAGR comparison (Revenue), both companies
WITH endpoints AS (
    SELECT
        c.company_name,
        MAX(CASE WHEN fd.fiscal_year = 2021 THEN fd.value END) AS revenue_fy21,
        MAX(CASE WHEN fd.fiscal_year = 2025 THEN fd.value END) AS revenue_fy25
    FROM financial_data fd
    JOIN companies c ON c.company_id = fd.company_id
    WHERE fd.metric = 'Revenue'
    GROUP BY c.company_name
)
SELECT
    company_name,
    revenue_fy21,
    revenue_fy25,
    ROUND((POWER(revenue_fy25 / revenue_fy21, 1.0/4) - 1) * 100, 2) AS revenue_cagr_pct
FROM endpoints;

-- 6.5 Standards differences reference lookup
SELECT topic, us_gaap_treatment, ind_as_treatment, practical_impact
FROM standards_differences
ORDER BY topic;
