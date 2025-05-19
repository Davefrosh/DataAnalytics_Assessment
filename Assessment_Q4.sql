/*
Question 4: Customer Lifetime Value (CLV) Estimation

Tables:
- users_customuser
- savings_savingsaccount

Notes:
- profit_per_transaction is 0.1% of the transaction value
- all amount fields are in kobo (divide by 100 to get Naira)
*/

WITH customer_metrics AS (
    SELECT 
        u.id AS customer_id,
        u.name,
        TIMESTAMPDIFF(MONTH, u.date_joined, CURRENT_DATE) AS tenure_months,
        COUNT(s.id) AS total_transactions,
        SUM(s.confirmed_amount) * 0.001 / 100 AS total_profit, -- 0.1% of transaction value in Naira
        AVG(s.confirmed_amount * 0.001) / 100 AS avg_profit_per_transaction -- 0.1% in Naira
    FROM 
        users_customuser u
    JOIN 
        savings_savingsaccount s ON u.id = s.owner_id
    WHERE 
        s.confirmed_amount > 0
    GROUP BY 
        u.id, u.name, u.date_joined
    HAVING 
        tenure_months > 0
)

SELECT 
    customer_id,
    name,
    tenure_months,
    total_transactions,
    ROUND(
        (total_transactions / tenure_months) * 12 * avg_profit_per_transaction, 
        2
    ) AS estimated_clv
FROM 
    customer_metrics
ORDER BY 
    estimated_clv DESC;
