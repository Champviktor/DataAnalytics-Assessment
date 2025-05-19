# DataAnalytics-Assessment

# DataAnalytics-Assessment

This repository contains SQL solutions to the Data Analyst Proficiency Assessment. Each question tests core SQL skills including data retrieval, joins, aggregation, subqueries, and data manipulation.

## ✅ Per-Question Explanations


### 🔹 Question 1: High-Value Customers with Multiple Products

**Objective:**  
Identify customers who have **at least one funded savings plan** and **one funded investment plan**, sorted by total deposits.

**Approach:**
- Join `users_customuser`, `savings_savingsaccount`, and `plans_plan`.
- Filter for:
  - **Funded savings plans** (`is_regular_savings = 1`)
  - **Funded investment plans** (`is_a_fund = 1`)
- Use subqueries or CTEs to:
  - Count the number of each plan type per customer
  - Sum the deposit amounts
- Return customers meeting both criteria, ordered by `total_deposits`.

**Challenges:**
- Ensuring only customers with **both** types of plans were selected.
- Filtering only **funded** plans (using correct boolean columns).
- Aggregating the data correctly with `GROUP BY`.

---

### 🔹 Question 2: Transaction Frequency Analysis

**Objective:**  
Categorize customers based on how often they transact monthly:
- High Frequency (≥10)
- Medium Frequency (3–9)
- Low Frequency (≤2)

**Approach:**
- Count transactions for each customer using `savings_savingsaccount`.
- Divide total transactions by the number of active months using `TIMESTAMPDIFF(MONTH, MIN(transaction_date), MAX(transaction_date))`.
- Use a `CASE` statement to assign frequency categories.
- Group by category and compute:
  - Number of customers in each category
  - Average monthly transaction rate

**Challenges:**
- Ensuring accurate month calculation per user.
- Handling users with short or inconsistent transaction history.
- Averaging transaction frequency over variable durations.

---

### 🔹 Question 3: Account Inactivity Alert

**Objective:**  
Identify accounts (savings or investment) with **no inflow** in the last **365 days**, but are still **active**.

**Approach:**
- Join `plans_plan` and `savings_savingsaccount`.
- Filter for `confirmed_amount` inflows.
- Get the **last transaction date** per account using `MAX(transaction_date)`.
- Use `DATEDIFF(CURDATE(), last_transaction_date)` to calculate inactivity duration.
- Return accounts with `inactivity_days > 365`.

**Challenges:**
- Filtering for accounts with confirmed transactions.
- Correctly interpreting the last transaction date for inactivity check.
- Handling plans that may be inactive or archived.

---

### 🔹 Question 4: Customer Lifetime Value (CLV) Estimation

**Objective:**  
Estimate each customer's CLV using:
- Tenure in months
- Total transactions
- 0.1% profit per transaction

**Approach:**
- Use `TIMESTAMPDIFF(MONTH, date_joined, CURDATE())` to calculate tenure.
- Count deposit transactions per customer.
- Calculate `avg_profit_per_transaction` as `0.1%` of average transaction value.
- Apply the formula:


