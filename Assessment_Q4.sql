-- Q4: Customer Lifetime Value (CLV) Estimation

WITH customer_transactions AS (
    SELECT 
        u.id AS customer_id,
        u.name,
        TIMESTAMPDIFF(MONTH, u.date_joined, NOW()) AS tenure_months,
        COUNT(s.id) AS total_transactions,
        SUM(s.confirmed_amount) / 100 AS total_value_naira
    FROM users_customuser u
    LEFT JOIN savings_savingsaccount s ON u.id = s.owner_id AND s.confirmed_amount > 0
    GROUP BY u.id, u.name, u.date_joined
), clv_calc AS (
    SELECT 
        customer_id,
        name,
        GREATEST(tenure_months, 1) AS tenure_months,
        total_transactions,
        total_value_naira,
        ROUND((12 / GREATEST(tenure_months, 1)) * (0.001 * total_value_naira), 2) AS estimated_clv
    FROM customer_transactions
)

SELECT 
    customer_id,
    name,
    tenure_months,
    total_transactions,
    estimated_clv
FROM clv_calc
ORDER BY estimated_clv DESC;
