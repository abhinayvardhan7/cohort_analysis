# Cohort Retention Analysis - SQL

A SQL-based cohort analysis project using real e-commerce transaction data to measure customer retention over time.

##  Overview

This project answers a fundamental business question:
> *After a customer makes their first purchase — do they come back?*

Using PostgreSQL, I analyzed the [Online Retail Dataset](https://www.kaggle.com/datasets/ulrikthygepedersen/online-retail-dataset) (Dec 2010 – Dec 2011) to group customers by their first purchase month and track monthly retention rates.

## Key Findings

- **Dec 2010 was the strongest cohort** — 50% retention after 11 months
- **Month 1 churn is critical** — 60–80% of customers never return after first purchase
- **Mid-2011 saw weaker retention** — smaller cohorts with lower long-term engagement
- **Loyal core exists in every cohort** — ~20–30% stick around long-term after month 3

## How It Works

| Step | Description |
|------|-------------|
| 1 | Find each customer's first purchase date |
| 2 | Group customers into monthly cohorts |
| 3 | Attach cohort month to all transactions using window functions |
| 4 | Calculate months since first purchase for each transaction |
| 5 | Count returning customers and compute retention percentages |

##  Data Source

- **Dataset:** [Online Retail Dataset on Kaggle](https://www.kaggle.com/datasets/ulrikthygepedersen/online-retail-dataset) (also known as the UCI Online Retail Dataset)
- **Period:** Dec 2010 – Dec 2011
- **Rows:** ~500,000 transactions
- **Key Columns:** `CustomerID`, `InvoiceDate`, `Quantity`, `UnitPrice`


## 💻 SQL Techniques Used

- **Window Functions** — `MIN() OVER (PARTITION BY)` for cohort assignment
- **CTEs** — Modular, readable query structure
- **Self Joins** — Cohort size normalization
- **Date Functions** — `DATE_TRUNC`, `AGE`, `EXTRACT`
- **Aggregation** — `COUNT(DISTINCT)` with `GROUP BY`

##  Why This Matters

Cohort retention is a critical metric for:
- Predicting customer lifetime value (LTV)
- Identifying when and why customers churn
- Evaluating marketing campaign effectiveness
- Informing retention strategies (onboarding, email, promotions)

This analysis mirrors work done by data teams at companies like Amazon, Flipkart, and Swiggy.



