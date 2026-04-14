
-- PROJECT: COHORT ANALYSIS USING SQL
--  STEP 1 — Find First Purchase (User Start Date)
 
SELECT 
  CustomerID,
  MIN(InvoiceDate) AS first_purchase
FROM online_retail
GROUP BY CustomerID;

--  STEP 2 — Convert to Cohort Month
SELECT 
  CustomerID,
  DATE_TRUNC('month', MIN(InvoiceDate)) AS cohort_month
FROM online_retail
GROUP BY CustomerID;

--  STEP 3 — Attach Cohort to All Transactions
SELECT 
  CustomerID,
  InvoiceDate,
  DATE_TRUNC('month', MIN(InvoiceDate) OVER (PARTITION BY CustomerID)) AS cohort_month
FROM online_retail;

--  STEP 4 — Get Activity Month
SELECT 
  CustomerID,
  DATE_TRUNC('month', InvoiceDate) AS activity_month
FROM online_retail;


--  STEP 5 — Calculate Month Difference
SELECT
  CustomerID,
  DATE_TRUNC('month', MIN(InvoiceDate) OVER (PARTITION BY CustomerID)) AS cohort_month,
  DATE_TRUNC('month', InvoiceDate) AS activity_month,
  EXTRACT(MONTH FROM AGE(
    DATE_TRUNC('month', InvoiceDate),
    DATE_TRUNC('month', MIN(InvoiceDate) OVER (PARTITION BY CustomerID))
  )) AS month_diff
FROM online_retail;

--  STEP 6 — Count Users per Cohort
SELECT 
  cohort_month,
  month_diff,
  COUNT(DISTINCT CustomerID) AS users
FROM (
  SELECT
    CustomerID,
    DATE_TRUNC('month', MIN(InvoiceDate) OVER (PARTITION BY CustomerID)) AS cohort_month,
    EXTRACT(MONTH FROM AGE(
      DATE_TRUNC('month', InvoiceDate),
      DATE_TRUNC('month', MIN(InvoiceDate) OVER (PARTITION BY CustomerID))
    )) AS month_diff
  FROM online_retail
) t
GROUP BY cohort_month, month_diff
ORDER BY cohort_month, month_diff;

-- STEP 7 — Calculate Retention Percentage (FINAL)
WITH cohort_data AS (
  SELECT
    CustomerID,
    DATE_TRUNC('month', MIN(InvoiceDate) OVER (PARTITION BY CustomerID)) AS cohort_month,
    EXTRACT(MONTH FROM AGE(
      DATE_TRUNC('month', InvoiceDate),
      DATE_TRUNC('month', MIN(InvoiceDate) OVER (PARTITION BY CustomerID))
    )) AS month_diff
  FROM online_retail
),

cohort_counts AS (
  SELECT
    cohort_month,
    month_diff,
    COUNT(DISTINCT CustomerID) AS users
  FROM cohort_data
  GROUP BY cohort_month, month_diff
)

SELECT
  c.cohort_month,
  c.month_diff,
  c.users,
  c.users * 100.0 / cs.users AS retention
FROM cohort_counts c
JOIN cohort_counts cs
  ON c.cohort_month = cs.cohort_month
  AND cs.month_diff = 0
ORDER BY c.cohort_month, c.month_diff;