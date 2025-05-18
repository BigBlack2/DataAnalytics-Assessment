-- Q2: Transaction Frequency Analysis

WITH customer_transactions AS (
    SELECT 
        u.id AS customer_id,
        u.name,
        COUNT(s.id) AS total_transactions,
        -- Calculate number of active months from first to last transaction
        PERIOD_DIFF(
            DATE_FORMAT(MAX(s.transaction_date), '%Y%m'),
            DATE_FORMAT(MIN(s.transaction_date), '%Y%m')
        ) + 1 AS active_months
    FROM users_customuser u
    LEFT JOIN savings_savingsaccount s ON u.id = s.owner_id
    GROUP BY u.id, u.name
),
customer_frequency AS (
    SELECT
        customer_id,
        name,
        total_transactions,
        active_months,
        total_transactions / GREATEST(active_months, 1) AS avg_transactions_per_month,
        CASE
            WHEN total_transactions / GREATEST(active_months, 1) >= 10 THEN 'High Frequency'
            WHEN total_transactions / GREATEST(active_months, 1) BETWEEN 3 AND 9 THEN 'Medium Frequency'
            ELSE 'Low Frequency'
        END AS frequency_category
    FROM customer_transactions
)

SELECT
    frequency_category,
    COUNT(customer_id) AS customer_count,
    ROUND(AVG(avg_transactions_per_month), 2) AS avg_transactions_per_month
FROM customer_frequency
GROUP BY frequency_category
ORDER BY 
    CASE frequency_category
        WHEN 'High Frequency' THEN 1
        WHEN 'Medium Frequency' THEN 2
        WHEN 'Low Frequency' THEN 3
    END;
