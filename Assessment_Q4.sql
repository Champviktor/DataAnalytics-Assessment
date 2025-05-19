SELECT 
    u.id AS customer_id,
    u.name,
    TIMESTAMPDIFF(MONTH, u.date_joined, CURDATE()) AS tenure_months,
    COUNT(s.id) AS total_transactions,
    ROUND((
        (COUNT(s.id) / NULLIF(TIMESTAMPDIFF(MONTH, u.date_joined, CURDATE()), 0)) 
        * 12 
        * (0.001 * (SUM(s.confirmed_amount) / NULLIF(COUNT(s.id), 0)) / 100)
    ), 2) AS estimated_clv
FROM 
    users_customuser u
JOIN 
    savings_savingsaccount s ON u.id = s.owner_id
WHERE 
    s.confirmed_amount IS NOT NULL
GROUP BY 
    u.id, u.name, tenure_months
ORDER BY 
    estimated_clv DESC;
