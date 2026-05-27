# Loan Risk Data Analysis (SQL)

## Project Overview
This project contains a comprehensive set of 40 SQL queries analyzing a cleaned loan risk dataset (`loan_risk_data_cleaned`). The goal of this analysis is to identify key factors influencing loan approval rates, segment customers by risk levels, evaluate demographic trends, and provide data-driven insights for financial institutions.

## Key Insights Discovered
* **Employment Impact:** Salaried applicants demonstrate higher loan approval rates compared to self-employed individuals, highlighting a preference for steady income streams.
* **Risk Segmentation:** Customers are programmatically grouped into Low, Medium, and High-Risk profiles using credit scores, income levels, and loan-to-income ratios.
* **Geographic & Demographic Trends:** Identified top-performing cities, education levels with the highest average incomes, and age groups driving the highest application volumes.

## Queries Included
The `loan_analysis.sql` script includes queries covering:
1. Basic descriptive metrics (Total applicants, average credit scores, average incomes).
2. Advanced business metrics (Approval/rejection rates by demographic, risk segmentation, cumulative metrics).
3. Outlier detection using Interquartile Range (IQR) calculations via percentiles.
