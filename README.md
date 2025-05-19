# Data Analytics Assessment

This repository contains SQL solutions for the Data Analytics Assessment.

Approach and Solutions

Question 1: High-Value Customers with Multiple Products

Approach:
I approached this by first identifying the key tables and relationships needed to solve the problem. The solution required joining the users table with plans and savings accounts, then filtering for customers who have both types of plans with actual deposits.

The implementation uses:
- JOIN operations to connect user data with their plans and savings transactions
- CASE statements to categorize plans as either savings or investments
- GROUP BY with HAVING clauses to filter for customers with both plan types
- Aggregation functions to count plans and sum deposits
- Division by 100 to convert kobo to Naira for better readability

The query efficiently identifies high-value customers who already demonstrate interest in multiple product types, making them prime candidates for additional cross-selling.

Question 2: Transaction Frequency Analysis

Approach:
For this analysis, I created a Common Table Expression (CTE) to first calculate each customer's transaction metrics, including:
- Total active months (from first to last transaction)
- Total number of transactions
- Average transactions per month

The main query then categorizes customers based on their transaction frequency and calculates the average transactions per month for each category.

This segmentation provides valuable insights for the finance team to tailor different strategies for each customer segment:
- High-frequency users might benefit from loyalty programs
- Medium-frequency users could be targeted for increased engagement
- Low-frequency users might need re-engagement campaigns

Question 3: Account Inactivity Alert

Approach:
This query focuses on identifying potentially dormant accounts that require attention from the operations team. The implementation:
- Joins plans with savings transactions
- Filters for active accounts (not archived or deleted)
- Calculates the last transaction date and inactivity period in days
- Filters for accounts inactive for more than 365 days

The results are ordered by inactivity duration to prioritize the most dormant accounts. This helps the ops team proactively reach out to customers before they completely disengage, potentially improving retention rates.

Question 4: Customer Lifetime Value (CLV) Estimation

Approach:
For this analysis, I implemented a simplified CLV model using:
- A CTE to calculate base metrics for each customer (tenure, transactions, profit)
- The CLV formula provided in the requirements
- Proper conversion from kobo to Naira for monetary values

The query calculates:
- Account tenure in months
- Total transaction count
- Average profit per transaction (0.1% of transaction value)
- Estimated CLV using the formula: (transactions/tenure) * 12 * avg_profit

This provides the marketing team with actionable insights on customer value, helping them prioritize retention efforts for high-CLV customers and identify opportunities to increase value from others.

Challenges and Solutions

Challenge 1: Understanding the Database Schema

The database schema was complex with multiple related tables and specific field meanings. I needed to carefully analyze the relationships between tables and understand the business context of each field.

Solution: I methodically examined the table structures, focusing on primary and foreign keys to map relationships. I paid special attention to boolean flags like `is_regular_savings` and `is_a_fund` that were crucial for categorizing plan types.

Challenge 2: Handling Date Calculations

Several queries required date-based calculations, such as determining account tenure and inactivity periods. These calculations needed to be accurate while accounting for edge cases.

Solution: I used MySQL's `TIMESTAMPDIFF` and `DATEDIFF` functions for precise date calculations. For tenure calculations, I added 1 to the month difference to include partial months, and used `IFNULL` with `CURRENT_DATE` to handle cases where there might not be a last transaction date.

Challenge 3: Converting Currency Units

The database stored monetary values in kobo (1/100 of Naira), which needed conversion for human-readable output.

Solution: I applied appropriate division operations (dividing by 100) to convert kobo to Naira in the final output, making the results more intuitive for business users while maintaining precision in calculations.

Challenge 4: Ensuring Query Efficiency

Some queries required multiple joins and aggregations, which could potentially impact performance with large datasets.

Solution: I optimized the queries by:
- Using appropriate indexes (implied by the schema)
- Filtering data early in the query execution
- Using CTEs to organize complex logic and improve readability
- Applying aggregations efficiently to minimize data processing
