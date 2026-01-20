-- 03_customer_kpis.sql
-- Customer KPI table (Recency, Frequency, Monetary)

-- This query creates customer-level KPIs
-- used for churn and retention analysis

SELECT
  c.customer_id,

  -- Recency: most recent purchase date
  MAX(t.transaction_date) AS last_purchase_date,

  -- Frequency: number of transactions
  COUNT(t.transaction_id) AS purchase_frequency,

  -- Monetary: total customer spend
  COALESCE(SUM(t.amount), 0) AS total_spend

FROM customers c
LEFT JOIN transactions t
  ON c.customer_id = t.customer_id

GROUP BY c.customer_id
ORDER BY total_spend DESC;

