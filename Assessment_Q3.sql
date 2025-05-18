-- Q3: Account Inactivity Alert

WITH last_transaction AS (
    SELECT 
        p.id AS plan_id,
        p.owner_id,
        CASE 
            WHEN p.is_regular_savings = 1 THEN 'Savings'
            WHEN p.is_a_fund = 1 THEN 'Investment'
            ELSE 'Other'
        END AS type,
        MAX(s.transaction_date) AS last_transaction_date
    FROM plans_plan p
    JOIN savings_savingsaccount s ON p.id = s.plan_id
    WHERE s.confirmed_amount > 0  -- Only inflow transactions
    GROUP BY p.id, p.owner_id, p.is_regular_savings, p.is_a_fund
)

SELECT 
    plan_id,
    owner_id,
    type,
    DATE(last_transaction_date) AS last_transaction_date,
    DATEDIFF(NOW(), last_transaction_date) AS inactivity_days
FROM last_transaction
WHERE last_transaction_date < NOW() - INTERVAL 365 DAY
ORDER BY inactivity_days DESC;
