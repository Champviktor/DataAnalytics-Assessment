-- Find plans (Savings or Investments) with no transactions in last 365 days

SELECT 
    p.id AS plan_id,
    p.owner_id,
    CASE 
        WHEN p.is_regular_savings = 1 THEN 'Savings'
        WHEN p.is_a_fund = 1 THEN 'Investment'
        ELSE 'Other'
    END AS type,
    MAX(sa.transaction_date) AS last_transaction_date,
    DATEDIFF(CURDATE(), MAX(sa.transaction_date)) AS inactivity_days
FROM 
    plans_plan p
LEFT JOIN 
    savings_savingsaccount sa ON p.id = sa.plan_id
GROUP BY 
    p.id, p.owner_id, type
HAVING 
    (MAX(sa.transaction_date) IS NULL OR MAX(sa.transaction_date) < DATE_SUB(CURDATE(), INTERVAL 365 DAY))
ORDER BY 
    inactivity_days DESC;
