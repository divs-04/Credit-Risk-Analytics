# PAY_PATTERNS: Insights Into Loan Repayment

## Overview

This project analyzes loan and borrower data to uncover patterns in repayment behavior, default risk, and portfolio health. Using SQL for data cleaning, validation, and analysis, and Python for visualization, 
it provides actionable insights for financial institutions to optimize lending strategies and minimize risk.

---

## Objectives

- **Understand Borrower Profiles:** Analyze demographics, income, employment, and credit history.
- **Assess Loan Performance:** Explore loan amounts, terms, interest rates, grades, and purposes.
- **Identify Risk Factors:** Detect high-risk borrowers and loan types using default and delinquency patterns.
- **Guide Lending Decisions:** Reveal trends that inform pricing, approval, and portfolio diversification.

---

## Data Structure

- **Borrowers Table:**  
  - `borrower_id` (PK)  
  - `annual_inc`  
  - `total_acc`  
  - `emp_length`  
  - `home_ownership`  
  - `verification_status`  

- **Loans Table:**  
  - `loan_id` (PK)  
  - `borrower_id` (FK)  
  - `loan_amnt`  
  - `term`  
  - `int_rate`  
  - `grade`  
  - `purpose`  
  - `dti`  
  - `delinq_2yrs`  
  - `revol_util`  
  - `loan_status`  

---

## Key Features

- **Data Quality Checks:**  
  - Missing values, duplicates, schema validation.
- **Data Cleaning:**  
  - Standardize formats, remove inconsistencies, enforce integrity.
- **Integrity Validation:**  
  - Ensure correct borrower-loan mapping.
- **Advanced Analysis:**  
  - Segment risk by grade, purpose, employment, and utilization.
- **Business Insights:**  
  - Recommendations for risk mitigation and portfolio optimization.

---

## How to Use

1. **Setup Database:**  
   - Run the SQL script to create and clean the database.
2. **Run Analysis:**  
   - Use the Jupyter notebook to connect to MySQL and execute queries.
3. **Visualize Results:**  
   - Generate plots and dashboards using Python (Matplotlib, Seaborn).

---

## Requirements

- MySQL Server
- Python 3.x
- Libraries: `mysql-connector-python`, `sqlalchemy`, `ipython-sql`, `pandas`, `matplotlib`, `seaborn`

---

## Author

**Divyanshu Srivastava**

---

## License

This project is for educational and analytical purposes. Please cite appropriately if used in publications.

---

## File List

- [`loan_data_quality_checks.sql`](loan_data_quality_checks.sql) – SQL scripts for database setup, cleaning, and analysis.
- `Loan_Borrower_Analysis_Notebook.ipynb` – Jupyter notebook for running queries and visualizations.

---

## Contact

For questions or collaboration, please reach out
