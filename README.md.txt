Data Analytics Assessment
This repository contains solutions to the SQL Proficiency Assessment.

Questions & Approaches
Q1: High-Value Customers with Multiple Products
-	Objective: Identify customers who have at least one savings and one investment plan, with deposits.
-	Approach: Used conditional aggregation to count each product type and summed deposits, converted from kobo to Naira.
Q2: Transaction Frequency Analysis
-	Objective: Classify customers based on transaction frequency per month.
-	Approach: Calculated active months using `PERIOD_DIFF()` between first and last transaction, and grouped frequency using CASE.
Q3: Account Inactivity Alert
-	Objective: Flag active plans with no inflows in the last 365 days.
-	Approach: Compared last transaction date with current date using `DATEDIFF()`. Used `MAX(transaction_date)` per plan.
Q4: Customer Lifetime Value (CLV) Estimation
-	Objective: Estimate customer CLV using tenure and profit-per-transaction.
-	Approach: Calculated tenure in months from `date_joined`, summed confirmed amounts, and applied CLV formula.

Challenges Faced
-	Adjusting date logic due to field name inconsistencies.
-	Handling possible division-by-zero using `GREATEST()` for safe calculations.
-	Missing date columns (e.g., `confirmed_date`) required fallback to `transaction_date`.
