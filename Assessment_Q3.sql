/*
Question 3: Account Inactivity Alert

Tables:
- plans_plan
- savings_savingsaccount

Notes:
- Active accounts are those that haven't been archived or deleted
- We need to check the last transaction date and calculate inactivity days
*/

SELECT 
    p.id AS plan_id,
    p.owner_id,
    CASE 
        WHEN p.is_regular_savings = 1 THEN 'Savings'
        WHEN p.is_a_fund = 1 THEN 'Investment'
        ELSE 'Other'
    END AS type,
    MAX(s.created_on) AS last_transaction_date,
    DATEDIFF(CURRENT_DATE, MAX(s.created_on)) AS inactivity_days
FROM 
    plans_plan p
LEFT JOIN 
    savings_savingsaccount s ON p.id = s.plan_id
WHERE 
    p.is_archived = 0 
    AND p.is_deleted = 0
    AND (p.is_regular_savings = 1 OR p.is_a_fund = 1)
GROUP BY 
    p.id, p.owner_id
HAVING 
    inactivity_days > 365
ORDER BY 
    inactivity_days DESC;
