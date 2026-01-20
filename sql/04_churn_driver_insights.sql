-- 04_churn_driver_insights.sql
-- Churn driver analysis: marketing engagement vs churn

-- Churn rate by number of marketing channels touched
SELECT
  channels_touched,
  AVG(churn_flag) AS churn_rate,
  COUNT(*) AS customers
FROM (
  SELECT
    c.customer_id,
    cl.churn_flag,
    COUNT(DISTINCT mt.channel) AS channels_touched
  FROM customers c
  JOIN churn_labels cl
    ON c.customer_id = cl.customer_id
  LEFT JOIN marketing_touchpoints mt
    ON c.customer_id = mt.customer_id
  GROUP BY c.customer_id, cl.churn_flag
) x
GROUP BY channels_touched
ORDER BY channels_touched;
