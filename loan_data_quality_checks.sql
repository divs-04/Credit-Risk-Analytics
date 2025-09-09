# "PAY_PATTERNS: INSIGHTS INTO LOAN REPAYMENT"
# ********************************************
# OWNER - DIVYANSHU SRIVASTAVA
# ******************************************** 

CREATE DATABASE loan_analytics;
USE loan_analytics;

# PROBLEM STATEMENT-
# *******************
# Banks and lending institutions provide loans to borrowers with the expectation 
# of repayment. However, not all borrowers repay on time—some default, 
# while others repay without issue. Lenders lose money when borrowers default or
# pay late. Most institutions already store rich loan data and borrower
# attributes, but these are rarely analyzed holistically. 
# We need a structured analysis to uncover patterns in who borrows, 
# what loans they take, and how they repay, so the business can minimize 
# default risk and improve policies. The challenge is to analyze borrower
# profiles and loan performance to understand repayment behaviors. 
# This project uses SQL for analysis and Python for visualizations, 
# with the dataset split into two tables:

# 'Borrowers table' – borrower-level demographic and financial details.
# 'Loans table' – loan-level information linked to borrowers.
# (with loan_id as PK and borrower_id as FK).
# -------------------------------------------------------------------------------- 

# PROJECT OBJECTIVE-  
# *******************

# 1. Understand borrower behavior and loan performance using two tables: 
#    Borrowers and Loans.
# 2. Explore how factors like income, employment, home ownership, loan amount, 
#    and interest rate impact repayment.
# 3. Identify high-risk borrowers and loan types by analyzing default patterns.
# 4. Compare loan purposes, grades, and terms to see which carry higher risks.
# 5. Use SQL for structured data analysis (cleaning, querying, relationships).
# 6. Use Python for visualizations (trends, distributions, comparisons).
# 7. Simulate a real-world financial case study where insights can guide better 
#    lending decisions.
# ---------------------------------------------------------------------------------- 

# DATASET DESCRIPTION-
# ********************
# The two tables are:-

# 1. "Borrowers Table"- Contains borrower-level information (each borrower 
# 					    may have multiple loans).

# 'borrower_id' → Unique ID for each borrower (Primary Key).
# 'annual_inc' → Annual income of borrower.
# 'total_acc' → Total number of credit accounts the borrower holds.
# 'emp_length' → Employment length (in years).
# 'home_ownership' → Whether they own/rent/mortgage their house.
# 'verification_status' → If income was verified or not.
# ------------------------------------------------------------------------------- 

# 2. "Loans Table"- Contains loan-level information (linked to borrowers).

# 'loan_id' → Unique ID for each loan (Primary Key).
# 'borrower_id' → Foreign key linking loan to borrower.
# 'loan_amnt' → Amount of loan requested.
# 'term' → Loan repayment term (e.g., 36 months, 60 months).
# 'int_rate' → Interest rate on the loan.
# 'grade' → Loan grade assigned by the institution (A–G, A being best).
# 'purpose' → Purpose of the loan (debt consolidation, credit card, home 
#             improvement,etc.).
# 'dti' → Debt-to-Income ratio, measuring borrower’s debt relative to income.
# 'delinq_2yrs' → Number of times borrower was delinquent in last 2 years.
# 'revol_util' → Revolving credit utilization rate (% of available credit 
#                being used).
# 'loan_status' → Target variable (whether loan is Fully Paid, Charged Off, 
# 			      or Current). 
# ------------------------------------------------------------------------------- 

# DATA UNDERSTANDING-
# *******************

-- View schema of Borrowers table
DESCRIBE borrowers;

-- View schema of Loans table
DESCRIBE loans;

-- Total row count in each table
SELECT COUNT(*) AS total_borrowers FROM borrowers;
SELECT COUNT(*) AS total_loans FROM loans;

-- Unique borrowers
SELECT COUNT(DISTINCT borrower_id) AS unique_borrowers FROM borrowers;

-- Unique loans
SELECT COUNT(DISTINCT loan_id) AS unique_loans FROM loans;

-- Sample data preview
SELECT * FROM borrowers LIMIT 10;
SELECT * FROM loans LIMIT 10;

# ------------------------------------------------------------------------------- 

# DATA QUALITY CHECKS- 
# *********************

-- Missing values count for Borrowers
SELECT 
    SUM(CASE WHEN borrower_id IS NULL THEN 1 ELSE 0 END) AS missing_borrower_id,
     SUM(CASE WHEN total_acc IS NULL THEN 1 ELSE 0 END) AS missing_total_acc,
    SUM(CASE WHEN emp_length IS NULL THEN 1 ELSE 0 END) AS missing_emp_length,
    SUM(CASE WHEN home_ownership IS NULL THEN 1 ELSE 0 END) AS missing_home_ownership,
    SUM(CASE WHEN annual_inc IS NULL THEN 1 ELSE 0 END) AS missing_annual_inc,
	SUM(CASE WHEN verification_status IS NULL THEN 1 ELSE 0 END) AS missing_verf_status
FROM borrowers;

-- Missing values count for Loans
SELECT 
    SUM(CASE WHEN loan_id IS NULL THEN 1 ELSE 0 END) AS missing_loan_id,
    SUM(CASE WHEN borrower_id IS NULL THEN 1 ELSE 0 END) AS missing_borrower_id,
    SUM(CASE WHEN loan_amnt IS NULL THEN 1 ELSE 0 END) AS missing_loan_amnt,
    SUM(CASE WHEN term IS NULL THEN 1 ELSE 0 END) AS missing_term,
    SUM(CASE WHEN int_rate IS NULL THEN 1 ELSE 0 END) AS missing_int_rate,
    SUM(CASE WHEN grade IS NULL THEN 1 ELSE 0 END) AS missing_grade,
    SUM(CASE WHEN purpose IS NULL THEN 1 ELSE 0 END) AS missing_purpose,
    SUM(CASE WHEN dti IS NULL THEN 1 ELSE 0 END) AS missing_dti,
    SUM(CASE WHEN delinq_2yrs IS NULL THEN 1 ELSE 0 END) AS missing_delinq_2yrs,
    SUM(CASE WHEN revol_util IS NULL THEN 1 ELSE 0 END) AS missing_revol_util,
    SUM(CASE WHEN loan_status IS NULL THEN 1 ELSE 0 END) AS missing_loan_status
FROM loans;

-- Duplicate rows check
SELECT borrower_id, COUNT(*) FROM borrowers 
GROUP BY borrower_id 
HAVING COUNT(*) > 1;

SELECT loan_id, COUNT(*) FROM loans
GROUP BY loan_id
HAVING COUNT(*) > 1;

# ------------------------------------------------------------------------------- 

# DATA CLEANING-
# **************

-- 1.Borrowers Table- 

-- emp_length: Remove the word "years" and trim spaces.
UPDATE borrowers
SET emp_length = TRIM(REPLACE(emp_length, 'years', '')); 
ALTER TABLE borrowers MODIFY emp_length TINYINT;

-- verification_status: labeling 'Source Verified' as 'Verified'
UPDATE borrowers
SET verification_status = 'Verified'
WHERE verification_status IN ('Verified','Source Verified');

-- 2.Loans Table-

-- term: Remove the word "months" and trim spaces.
UPDATE loans
SET term = TRIM(REPLACE(term,'months',''));
ALTER TABLE loans MODIFY term TINYINT;

-- int_rate: Remove '%' and trim spaces.
UPDATE loans
SET int_rate = TRIM(REPLACE(int_rate,'%',''));
ALTER TABLE loans MODIFY int_rate DECIMAL(5,2);

-- revol_util: Remove '%' and trim spaces.
UPDATE loans
SET revol_util = TRIM(REPLACE(revol_util,'%',''));
ALTER TABLE loans MODIFY revol_util DECIMAL(5,2);

-- loan_status: Unify Late (16-30 days),Late (31-120 days) as Late and replace 
--              Default as Charged Off.
UPDATE loans
SET loan_status = 'Late'
WHERE loan_status IN ('Late (16-30 days)', 'Late (31-120 days)');

UPDATE loans
SET loan_status = 'Charged Off'
WHERE loan_status = 'Default';

UPDATE loans
SET loan_status = LOWER(loan_status);

-- dti: Should be ≥ 0. Remove negatives.
DELETE FROM Loans WHERE dti < 0;

-- View updated schema of Borrowers table
DESCRIBE borrowers;

-- View updated schema of Loans table
DESCRIBE loans;

# ------------------------------------------------------------------------------- 

# DATA INTEGRITY- Ensure correct borrower-loan mapping.

-- Find loans with borrower_id not present in Borrowers table
SELECT loan_id, borrower_id
FROM loans
WHERE borrower_id NOT IN (SELECT borrower_id FROM borrowers);

-- Find borrowers who have no loans
SELECT b.borrower_id
FROM borrowers b
LEFT JOIN loans l ON b.borrower_id = l.borrower_id
WHERE l.borrower_id IS NULL; 

# ------------------------------------------------------------------------------
