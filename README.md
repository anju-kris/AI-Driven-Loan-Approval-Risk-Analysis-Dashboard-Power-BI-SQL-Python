# Loan Risk & Approval Analysis

## Project Overview
This project delivers an end-to-end data analysis solution evaluating a dataset of loan applications. Using **Python** for initial data preparation, **PostgreSQL** for deep-dive analytical querying, and **Power BI** for interactive reporting, this project identifies key factors influencing loan approval rates, segments customer risk profiles, and provides data-driven recommendations for financial institutions to optimize their lending strategies.

## Tech Stack & Tools
* **Data Cleaning & Preprocessing:** Python (Google Colab / Pandas)
* **Database & Analytical Queries:** PostgreSQL
* **Data Visualization & Dashboarding:** Power BI

## Repository Structure
* `/data`: Contains the raw and cleaned loan application datasets.
* `/notebooks`: Python Jupyter notebook used for data cleaning and preprocessing.
* `/scripts`: `loan_analysis.sql` containing 40 comprehensive analytical business queries.
* `/dashboard`: The Power BI `.pbix` file and dashboard screenshots.

---

## Executive Dashboard
* Add a high-quality screenshot of your Power BI dashboard here using markdown:*
![Loan Risk Dashboard Preview](dashboard/insights_screenshot.png) 
*(Tip: Replace this path with wherever you save your dashboard screenshot image in your repo!)*

---

## Key Insights Discovered
* **Employment Impact:** Salaried applicants demonstrate higher loan approval rates compared to self-employed individuals, highlighting a corporate preference for steady, predictable income streams.
* **Risk Segmentation:** Developed a programmatic risk matrix classifying applicants into Low, Medium, and High-Risk profiles based on credit scores, income levels, and loan-to-income (LTI) ratios.
* **Geographic & Demographic Trends:** Isolated the top-performing regions by loan volume, education levels yielding the highest average incomes, and specific age groups driving peak application velocity.

---

## SQL Analysis Breakdown (`scripts/loan_analysis.sql`)
The PostgreSQL script features 40 comprehensive business queries divided into three major stages:
1. **Basic Descriptive Metrics:** Aggregations for total applicants, baseline credit scores, and average income benchmarks.
2. **Advanced Business Performance:** Complex conditional logic calculations evaluating approval vs. rejection rates by demographic and risk tiers.
3. **Statistical Outlier Detection:** Implementation of Interquartile Range (IQR) calculations using SQL window functions and percentiles to isolate anomalies in loan amounts and applicant incomes.

## Strategic Recommendations
*Based on the insights from your data, add 2-3 high-level action points here. For example:*
* **Refine Self-Employed Risk Models:** Introduce stricter secondary financial checks or alternative documentation requirements for self-employed applicants to bridge the approval rate gap safely.
* **Automate Low-Risk Approvals:** Establish an automated fast-track approval pipeline for applicants falling into the programmatically defined "Low-Risk" category to improve operational efficiency.
