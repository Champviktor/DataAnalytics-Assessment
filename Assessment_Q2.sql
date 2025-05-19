-- Calculate transaction frequency per customer per month
-- Categorize as High (>=10), Medium (3-9), or Low (<=2)

-- STEP 1: Count number of transactions per customer per month
WITH transaction_monthly_counts AS (
    SELECT 
        sa.owner_id,
        DATE_FORMAT(sa.transaction_date, '%Y-%m-01') AS transaction_month, -- Truncate to month
        COUNT(*) AS monthly_tx_count
    FROM 
        savings_savingsaccount sa
    GROUP BY 
        sa.owner_id, transaction_month
),

-- STEP 2: Compute average monthly transaction count per customer
average_tx_per_customer AS (
    SELECT 
        owner_id,
        AVG(monthly_tx_count) AS avg_transactions_per_month
    FROM 
        transaction_monthly_counts
    GROUP BY 
        owner_id
),

-- STEP 3: Categorize each customer based on average transactions per month
categorized_customers AS (
    SELECT
        CASE 
            WHEN avg_transactions_per_month >= 10 THEN 'High Frequency'
            WHEN avg_transactions_per_month BETWEEN 3 AND 9 THEN 'Medium Frequency'
            ELSE 'Low Frequency'
        END AS frequency_category,
        avg_transactions_per_month
    FROM 
        average_tx_per_customer
)

-- STEP 4: Aggregate by category
SELECT 
    frequency_category,
    COUNT(*) AS customer_count,
    ROUND(AVG(avg_transactions_per_month), 1) AS avg_transactions_per_month
FROM 
    categorized_customers
GROUP BY 
    frequency_category
ORDER BY 
    customer_count DESC;
