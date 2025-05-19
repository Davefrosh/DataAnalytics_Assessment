/*
Question 2: Transaction Frequency Analysis

Tables:
- users_customuser
- savings_savingsaccount
*/

WITH customer_transactions AS (
    SELECT 
        u.id AS customer_id,
        -- Calculate months between first and last transaction
        TIMESTAMPDIFF(MONTH, 
            MIN(s.created_on), 
            IFNULL(MAX(s.created_on), CURRENT_DATE)
        ) + 1 AS active_months,
        COUNT(s.id) AS total_transactions,
        COUNT(s.id) / (TIMESTAMPDIFF(MONTH, 
            MIN(s.created_on), 
            IFNULL(MAX(s.created_on), CURRENT_DATE)
        ) + 1) AS transactions_per_month
    FROM 
        users_customuser u
    JOIN 
        savings_savingsaccount s ON u.id = s.owner_id
    GROUP BY 
        u.id
    HAVING 
        active_months > 0
)

SELECT 
    CASE 
        WHEN transactions_per_month >= 10 THEN 'High Frequency'
        WHEN transactions_per_month BETWEEN 3 AND 9 THEN 'Medium Frequency'
        ELSE 'Low Frequency'
    END AS frequency_category,
    COUNT(*) AS customer_count,
    ROUND(AVG(transactions_per_month), 1) AS avg_transactions_per_month
FROM 
    customer_transactions
GROUP BY 
    frequency_category
ORDER BY 
    CASE 
        WHEN frequency_category = 'High Frequency' THEN 1
        WHEN frequency_category = 'Medium Frequency' THEN 2
        WHEN frequency_category = 'Low Frequency' THEN 3
    END;
