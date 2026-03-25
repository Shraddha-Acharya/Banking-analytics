-- ================================================
-- BANKING ANALYTICS SQL QUERIES
-- Author: Shraddha Acharya
-- Database: banking.db
-- ================================================

-- QUERY 1: Total customers and churn count
SELECT 
    COUNT(*) AS total_customers,
    SUM(Exited) AS total_churned,
    ROUND(SUM(Exited) * 100.0 / COUNT(*), 2) AS churn_rate_percent
FROM customers;

-- QUERY 2: Churn rate by Geography
SELECT 
    Geography,
    COUNT(*) AS total_customers,
    SUM(Exited) AS churned,
    ROUND(SUM(Exited) * 100.0 / COUNT(*), 2) AS churn_rate_percent
FROM customers
GROUP BY Geography
ORDER BY churn_rate_percent DESC;

-- QUERY 3: Churn rate by Gender
SELECT 
    Gender,
    COUNT(*) AS total_customers,
    SUM(Exited) AS churned,
    ROUND(SUM(Exited) * 100.0 / COUNT(*), 2) AS churn_rate_percent
FROM customers
GROUP BY Gender
ORDER BY churn_rate_percent DESC;

-- QUERY 4: Average balance and credit score by Geography
SELECT 
    Geography,
    ROUND(AVG(Balance), 2) AS avg_balance,
    ROUND(AVG(CreditScore), 2) AS avg_credit_score,
    ROUND(AVG(EstimatedSalary), 2) AS avg_salary
FROM customers
GROUP BY Geography
ORDER BY avg_balance DESC;

-- QUERY 5: Churn by number of products
SELECT 
    NumOfProducts,
    COUNT(*) AS total_customers,
    SUM(Exited) AS churned,
    ROUND(SUM(Exited) * 100.0 / COUNT(*), 2) AS churn_rate_percent
FROM customers
GROUP BY NumOfProducts
ORDER BY NumOfProducts;

-- QUERY 6: Active vs Inactive member churn comparison
SELECT 
    CASE WHEN IsActiveMember = 1 THEN 'Active' ELSE 'Inactive' END AS member_status,
    COUNT(*) AS total_customers,
    SUM(Exited) AS churned,
    ROUND(SUM(Exited) * 100.0 / COUNT(*), 2) AS churn_rate_percent,
    ROUND(AVG(Balance), 2) AS avg_balance
FROM customers
GROUP BY IsActiveMember
ORDER BY churn_rate_percent DESC;

-- QUERY 7: Age group analysis
SELECT 
    CASE 
        WHEN Age BETWEEN 18 AND 27 THEN '18-27'
        WHEN Age BETWEEN 28 AND 37 THEN '28-37'
        WHEN Age BETWEEN 38 AND 47 THEN '38-47'
        WHEN Age BETWEEN 48 AND 57 THEN '48-57'
        WHEN Age BETWEEN 58 AND 67 THEN '58-67'
        ELSE '68+'
    END AS age_group,
    COUNT(*) AS total_customers,
    SUM(Exited) AS churned,
    ROUND(SUM(Exited) * 100.0 / COUNT(*), 2) AS churn_rate_percent,
    ROUND(AVG(Balance), 2) AS avg_balance
FROM customers
GROUP BY age_group
ORDER BY churn_rate_percent DESC;

-- QUERY 8: High value customers at risk
SELECT 
    CustomerId,
    Surname,
    Geography,
    Age,
    Balance,
    CreditScore,
    NumOfProducts,
    Exited
FROM customers
WHERE Balance > 100000 
AND Exited = 1
ORDER BY Balance DESC
LIMIT 10;

-- QUERY 9: Transaction analysis by channel
SELECT 
    Channel,
    COUNT(*) AS total_transactions,
    ROUND(AVG(TransactionAmount), 2) AS avg_amount,
    ROUND(SUM(TransactionAmount), 2) AS total_amount,
    ROUND(MAX(TransactionAmount), 2) AS max_amount
FROM transactions
GROUP BY Channel
ORDER BY total_transactions DESC;

-- QUERY 10: Transaction analysis by customer occupation
SELECT 
    CustomerOccupation,
    COUNT(*) AS total_transactions,
    ROUND(AVG(TransactionAmount), 2) AS avg_transaction,
    ROUND(AVG(AccountBalance), 2) AS avg_balance
FROM transactions
GROUP BY CustomerOccupation
ORDER BY avg_transaction DESC;

-- QUERY 11: Monthly transaction trends
SELECT 
    SUBSTR(TransactionDate, 4, 7) AS month_year,
    COUNT(*) AS total_transactions,
    ROUND(SUM(TransactionAmount), 2) AS total_amount,
    ROUND(AVG(TransactionAmount), 2) AS avg_amount
FROM transactions
GROUP BY month_year
ORDER BY total_transactions DESC
LIMIT 10;

-- QUERY 12: Credit score segments and churn
SELECT 
    CASE 
        WHEN CreditScore >= 800 THEN 'Excellent (800+)'
        WHEN CreditScore >= 700 THEN 'Good (700-799)'
        WHEN CreditScore >= 600 THEN 'Fair (600-699)'
        ELSE 'Poor (Below 600)'
    END AS credit_segment,
    COUNT(*) AS total_customers,
    SUM(Exited) AS churned,
    ROUND(SUM(Exited) * 100.0 / COUNT(*), 2) AS churn_rate_percent,
    ROUND(AVG(Balance), 2) AS avg_balance
FROM customers
GROUP BY credit_segment
ORDER BY churn_rate_percent DESC;