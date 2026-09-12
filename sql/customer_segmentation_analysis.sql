SELECT * FROM rfm_customer_segments;
USE customer_segmentation_db;


-- 1. Customer count by segment
SELECT
    Segment,
    COUNT(*) AS Customer_Count
FROM rfm_customer_segments
GROUP BY Segment
ORDER BY Customer_Count DESC;


-- 2. Total revenue by segment
SELECT
    Segment,
    SUM(Monetary) AS Total_Revenue
FROM rfm_customer_segments
GROUP BY Segment
ORDER BY Total_Revenue DESC;


-- 3. Average customer value by segment
SELECT
    Segment,
    ROUND(AVG(Monetary), 2) AS Avg_Customer_Value
FROM rfm_customer_segments
GROUP BY Segment
ORDER BY Avg_Customer_Value DESC;


-- 4. Top 10 customers by monetary value
SELECT
    `Customer ID`,
    Recency,
    Frequency,
    Monetary,
    Segment
FROM rfm_customer_segments
ORDER BY Monetary DESC
LIMIT 10;


-- 5. Top 10 At-Risk customers by monetary value
SELECT
    `Customer ID`,
    Recency,
    Frequency,
    Monetary,
    Segment
FROM rfm_customer_segments
WHERE Segment = 'At-Risk Customers'
ORDER BY Monetary DESC
LIMIT 10;


-- 6. Top 10 customers by purchase frequency
SELECT
    `Customer ID`,
    Recency,
    Frequency,
    Monetary,
    Segment
FROM rfm_customer_segments
ORDER BY Frequency DESC
LIMIT 10;


-- 7. RFM metrics by segment
SELECT
    Segment,
    ROUND(AVG(Recency), 2) AS Avg_Recency,
    ROUND(AVG(Frequency), 2) AS Avg_Frequency,
    ROUND(AVG(Monetary), 2) AS Avg_Monetary
FROM rfm_customer_segments
GROUP BY Segment
ORDER BY Avg_Monetary DESC;


-- 8. Champions vs other customers
SELECT
    CASE
        WHEN Segment = 'Champions' THEN 'Champions'
        ELSE 'Other Customers'
    END AS Customer_Group,
    COUNT(*) AS Customer_Count,
    ROUND(SUM(Monetary), 2) AS Total_Revenue
FROM rfm_customer_segments
GROUP BY Customer_Group
ORDER BY Total_Revenue DESC;


-- 9. Revenue at risk from At-Risk and Dormant customers
SELECT
    Segment,
    COUNT(*) AS Customer_Count,
    ROUND(SUM(Monetary), 2) AS Revenue_at_Risk
FROM rfm_customer_segments
WHERE Segment IN ('At-Risk Customers', 'Dormant Customers')
GROUP BY Segment
ORDER BY Revenue_at_Risk DESC;
