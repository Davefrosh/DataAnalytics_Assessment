/*
Question 1: High-Value Customers with Multiple Products


Notes:
- owner_id is a foreign key to the ID primary key in the users table
- plan_id is a foreign key to the ID primary key in the plans table
- savings_plan: is_regular_savings = 1
- investment_plan: is_a_fund = 1
- confirmed_amount is the field for value of inflow
- all amount fields are in kobo (divide by 100 to get Naira)
*/

SELECT 
    u.id AS owner_id,
    u.name,
    COUNT(DISTINCT CASE WHEN p.is_regular_savings = 1 THEN p.id END) AS savings_count,
    COUNT(DISTINCT CASE WHEN p.is_a_fund = 1 THEN p.id END) AS investment_count,
    SUM(s.confirmed_amount) / 100 AS total_deposits
FROM 
    users_customuser u
JOIN 
    plans_plan p ON u.id = p.owner_id
JOIN 
    savings_savingsaccount s ON p.id = s.plan_id
WHERE 
    s.confirmed_amount > 0
GROUP BY 
    u.id, u.name
HAVING 
    COUNT(DISTINCT CASE WHEN p.is_regular_savings = 1 THEN p.id END) >= 1
    AND COUNT(DISTINCT CASE WHEN p.is_a_fund = 1 THEN p.id END) >= 1
ORDER BY 
    total_deposits DESC;
