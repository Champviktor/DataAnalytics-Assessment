-- Identify customers with at least one funded savings and one funded investment plan
-- Sum confirmed_amount for total deposits and filter on plan types

SELECT 
    cu.id AS owner_id,
    cu.name,
    COUNT(DISTINCT CASE WHEN p.is_regular_savings = 1 THEN p.id END) AS savings_count,
    COUNT(DISTINCT CASE WHEN p.is_a_fund = 1 THEN p.id END) AS investment_count,
    ROUND(SUM(sa.confirmed_amount) / 100, 2) AS total_deposits -- convert from kobo to Naira
FROM 
    users_customuser cu
JOIN 
    savings_savingsaccount sa ON cu.id = sa.owner_id
JOIN 
    plans_plan p ON p.id = sa.plan_id
WHERE 
    sa.confirmed_amount > 0
GROUP BY 
    cu.id, cu.name
HAVING 
    savings_count > 0 AND investment_count > 0
ORDER BY 
    total_deposits DESC;
