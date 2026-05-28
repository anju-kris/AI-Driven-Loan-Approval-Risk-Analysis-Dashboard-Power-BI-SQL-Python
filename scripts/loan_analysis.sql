--1.What is the total number of applicants?

select count(*) as total_applicants from loan_risk_data_cleaned

--2. How many loans were approved and rejected?

with approved as 
(
select count(*) as loan_approved from loan_risk_data_cleaned
where loan_approved = 1
), rejected as 
(
select count(*) as loan_rejected from loan_risk_data_cleaned
where loan_approved = 0
)
select loan_approved,loan_rejected from approved,rejected


--3. What is the overall loan approval rate?

select
	round(count(*)*100.0/(select count(*) from loan_risk_data_cleaned),2) as loan_approval_rate 
from loan_risk_data_cleaned
where loan_approved = 1

--4. What is the average loan amount requested by applicants?

select round(avg(loan_amount),2) as average_loan_amount from loan_risk_data_cleaned

--5. What is the average income of applicants?

select round(avg(income),2) as average_income from loan_risk_data_cleaned

--6. What is the average credit score of applicants?

select round(avg(credit_score),2) as avg_credit_score from loan_risk_data_cleaned

--7. Which education category has the highest loan approval rate?

select 
	education,
	round(sum(case when loan_approved = 1 then 1 else 0 end) * 100.0/count(*) ,2) as loan_approval_rate
from loan_risk_data_cleaned
group by education
order by loan_approval_rate desc
limit 1

--8. Which employment type has the highest number of approved loans?

select 
	employment_type,
	sum(case when loan_approved = 1 then 1 else 0 end) as loan_approved 
from loan_risk_data_cleaned
group by employment_type 
limit 1

--9. Which city has the highest number of loan applicants?

select city , count(*) as loan_applicants from loan_risk_data_cleaned
group by city
order by loan_applicants desc
limit 1 

--10.Which city has the highest loan approval rate?

select 
	city,
	round(sum(case when loan_approved = 1 then 1 else 0 end) * 100.0/count(*) ,2) as loan_approval_rate
from loan_risk_data_cleaned
group by city
order by loan_approval_rate desc
limit 1 

--11.What is the approval rate based on gender?

select 
	gender,
	round(sum(case when loan_approved = 1 then 1 else 0 end) * 100.0/count(*) ,2) as loan_approval_rate
from loan_risk_data_cleaned
group by gender
order by loan_approval_rate desc

--12.How does credit score impact loan approval?

select case 
		when credit_score < 500 then 'Below 500'
		when credit_score between 500 and 599 then '500-599'
		when credit_score between 600 and 699 then '600-699'
		when credit_score between 700 and 799 then '700-799'
		else '800+'
		end as credit_score_range,
		count(*) as total_applicants,
		sum(case when loan_approved = 1 then 1 else 0 end) as loan_approved,
		round(sum(case when loan_approved = 1 then 1 else 0 end) * 100.0/count(*),2) as  approval_rate 
from loan_risk_data_cleaned
group by credit_score_range
order by approval_rate desc;

--13.What is the average credit score of approved vs rejected applicants?

with approved as 
(
select 
		round(avg(credit_score)) as avg_credit_score_approved
from loan_risk_data_cleaned
where loan_approved = 1
),
rejected as 
(
select 
		round(avg(credit_score)) as avg_credit_score_rejected 
from loan_risk_data_cleaned
where loan_approved = 0
)
select 
		avg_credit_score_approved,
		avg_credit_score_rejected 
from approved,rejected

--14.Which income group receives the highest number of approvals?

select case 
		when income < 30000 then 'Low Income' 
		when income between 30000 and 60000 then 'Middle Income'
		else 'High Income'
		end as income_range,
		sum(case when loan_approved = 1 then 1 else 0 end) as approved_loans
from loan_risk_data_cleaned
group by income_range
order by approved_loans desc

--15.What is the relationship between income and loan amount?

select case 
		when income < 30000 then 'Low Income' 
		when income between 30000 and 60000 then 'Middle Income'
		else 'High Income'
		end as income_range,
		round(avg(loan_amount),2) as avg_loan_amount
from loan_risk_data_cleaned
group by income_range

--16.Which applicants have a high loan-to-income ratio?

select 
		row_number() over() as applicant_id,
		income,
		loan_amount,
		round(loan_amount*1.0/income ,2) as loan_to_income_ratio,
		loan_approved
from loan_risk_data_cleaned
where loan_amount*1.0/income > 0.5
order by loan_to_income_ratio desc

--17.How does work experience affect loan approval?

select 
		yearsexperience,
		count(*) as total_applicants,
		sum(case when loan_approved = 1 then 1 else 0 end) as approved_loan ,
		round(sum(case when loan_approved = 1 then 1 else 0 end)*100.0/count(*),2) as approval_rate 
from loan_risk_data_cleaned
group by yearsexperience 
order by approval_rate desc

--18.Which age group applies for the highest number of loans?

select case 
		when age between 18 and 29 then '18-29'
		when age between 30 and 39 then '30-39'
		when age between 40 and 49 then '40-49'
		when age between 50 and 59 then '50-59'
		when age between 60 and 69 then '60-69'
		else '70+'
		end as age_range,
		count(*) as total_applicants
from loan_risk_data_cleaned
group by age_range
order by count(*) desc

--19.Which age group has the highest approval rate?

select case 
		when age between 18 and 29 then '18-29'
		when age between 30 and 39 then '30-39'
		when age between 40 and 49 then '40-49'
		when age between 50 and 59 then '50-59'
		when age between 60 and 69 then '60-69'
		else '70+'
		end as age_range,
		count(*) as total_applicants,
		sum(case when loan_approved = 1 then 1 else 0 end) as approved_loan,
		round(sum(case when loan_approved = 1 then 1 else 0 end) *100.0/ count(*),2) as approval_rate
from loan_risk_data_cleaned
group by age_range
order by approval_rate desc

--20.Identify high-risk applicants based on low credit score and high loan amount.

select * from loan_risk_data_cleaned
where credit_score < 600 and  loan_amount > (select avg(loan_amount) from loan_risk_data_cleaned)
order by credit_score asc , loan_amount desc


--21.Segment customers into Low Risk, Medium Risk, and High Risk categories.

SELECT
    *,
    CASE
        WHEN credit_score >= 750 
             AND income >= 50000
             AND loan_amount < income * 0.5
        THEN 'Low Risk'
        
        WHEN credit_score BETWEEN 600 AND 749
        THEN 'Medium Risk'
        
        ELSE 'High Risk'
    END AS risk_category
FROM loan_risk_data_cleaned;

--22.What percentage of applicants belong to each risk category?

WITH risk_segments AS (
    SELECT
        CASE
            WHEN credit_score >= 750 
                 AND income >= 50000
                 AND loan_amount < income * 0.5
            THEN 'Low Risk'

            WHEN credit_score BETWEEN 600 AND 749
            THEN 'Medium Risk'

            ELSE 'High Risk'
        END AS risk_category
    FROM loan_risk_data_cleaned
)

SELECT
    risk_category,
    COUNT(*) AS total_applicants,
    ROUND(
        COUNT(*) * 100.0 / SUM(COUNT(*)) OVER (), 
        2
    ) AS percentage_of_applicants
FROM risk_segments
GROUP BY risk_category
ORDER BY percentage_of_applicants DESC;

--23.Which education level has the highest average income?

select education,round(avg(income),2) as avg_income from  loan_risk_data_cleaned
group by education 
order by avg_income desc

--24.Which employment type requests the highest average loan amount?

select employment_type, round(avg(loan_amount),2) as avg_loan_amount from loan_risk_data_cleaned
group by employment_type
limit 1

--25.Which city has the highest average credit score?

select city ,round(avg(credit_score),2) as avg_credit_score from loan_risk_data_cleaned
group by city
order by avg_credit_score desc
limit 1 

--26.Find the top 10 applicants with the highest loan amounts.

select * from loan_risk_data_cleaned
order by loan_amount desc
limit 10

--27.Rank applicants based on income.

select 
		dense_rank() over(order by income desc) as rank,
		* 
from  loan_risk_data_cleaned

--28.Rank cities based on loan approval rate.

with city_approval as 
(
select 
		city,
		round(sum(case when loan_approved = 1 then 1 else 0 end)*100.0/count(*),2) as approval_rate
from loan_risk_data_cleaned
group by city
) 
select city,approval_rate ,dense_rank() over(order by approval_rate desc) as rank from city_approval

--29.Find applicants whose loan amount is higher than the overall average loan amount.

select * from loan_risk_data_cleaned
where loan_amount  > (select avg(loan_amount) from loan_risk_data_cleaned)

--30.Which factors appear to influence loan approval the most?

SELECT
    CASE
        WHEN credit_score < 600 THEN 'Low'
        WHEN credit_score BETWEEN 600 AND 749 THEN 'Medium'
        ELSE 'High'
    END AS credit_segment,

    ROUND(
    SUM(CASE WHEN loan_approved=1 THEN 1 ELSE 0 END)
    *100.0/COUNT(*),2
    ) AS approval_rate

FROM loan_risk_data_cleaned
GROUP BY credit_segment
ORDER BY approval_rate DESC;

--31.Compare approval rates between salaried and self-employed applicants.

select 
		employment_type,
		count(*) as total_applicants,
		sum(case when loan_approved = 1 then 1 else 0 end) as approved_loan,
		round(sum(case when loan_approved = 1 then 1 else 0 end)*100.0/count(*),2) as approval_rate 
from loan_risk_data_cleaned
where employment_type in ('Salaried','Self-Employed')
group by employment_type
order by approval_rate desc

--insights 
Salaried applicants show a higher loan approval rate than self-employed applicants, suggesting that lenders may favor applicants with more stable and predictable income sources. Employment stability appears to influence loan decisions and may reduce perceived repayment risk.


--32.Find the percentage contribution of each city to total loan approvals.

select 
		city,
		sum(case when loan_approved = 1 then 1 else 0 end) as approved_loan ,
		round(sum(case when loan_approved = 1 then 1 else 0 end) * 100.0/(select sum(case when loan_approved = 1 then 1 else 0 end) from loan_risk_data_cleaned),2) as perc_contribution
from loan_risk_data_cleaned
group by city 
order by perc_contribution desc

--33.What is the distribution of applicants across education categories?

select 
		education ,
		count(*) as total_applicants 
from loan_risk_data_cleaned
group by education
order by total_applicants desc

34.Which risk category has the highest rejection rate?

WITH risk_segments AS
(
SELECT
    CASE
        WHEN credit_score >= 750
        AND income>=50000
        AND loan_amount<income*0.5
        THEN 'Low Risk'

        WHEN credit_score BETWEEN 600 AND 749
        THEN 'Medium Risk'

        ELSE 'High Risk'
    END AS risk_category,
    loan_approved

FROM loan_risk_data_cleaned
)

SELECT
    risk_category,
    ROUND(
    SUM(CASE WHEN loan_approved=0 THEN 1 ELSE 0 END)
    *100.0/COUNT(*),2
    ) AS rejection_rate
FROM risk_segments
GROUP BY risk_category
ORDER BY rejection_rate DESC;

--35.Find customers with high income but rejected loans.

select * from loan_risk_data_cleaned
where loan_approved = 0 and income > (select avg(income) from loan_risk_data_cleaned)

--36.Find customers with low income but approved loans.

select * from loan_risk_data_cleaned 
where loan_approved = 1 and income < (select avg(income) from loan_risk_data_cleaned)

select * from loan_risk_data_cleaned

--38.Find the cumulative approval count by city.

with city_approvals as (
    select 
        city,
        count(*) as approval_count
    from  loan_risk_data_cleaned
    where loan_approved = 1
	group by city
    order by city
)

select 
    city,
    approval_count,
    sum(approval_count) over (
        order by city
    ) as cumulative_approval_count
from city_approvals;

--39.Identify outliers in income or loan amount.

WITH stats AS (
    SELECT
        percentile_cont(0.25) WITHIN GROUP (ORDER BY income) AS income_q1,
        percentile_cont(0.75) WITHIN GROUP (ORDER BY income) AS income_q3,
        percentile_cont(0.25) WITHIN GROUP (ORDER BY loan_amount) AS loan_q1,
        percentile_cont(0.75) WITHIN GROUP (ORDER BY loan_amount) AS loan_q3
    FROM loan_risk_data_cleaned
)

SELECT *
FROM loan_risk_data_cleaned, stats
WHERE income < (income_q1 - 1.5 * (income_q3 - income_q1))
   OR income > (income_q3 + 1.5 * (income_q3 - income_q1))
   OR loan_amount < (loan_q1 - 1.5 * (loan_q3 - loan_q1))
   OR loan_amount > (loan_q3 + 1.5 * (loan_q3 - loan_q1));

--40.Which customer segments should banks target for low-risk lending?

SELECT
    education,
    city,
    CASE
        WHEN credit_score >= 750 THEN 'Excellent'
        WHEN credit_score >= 650 THEN 'Good'
        ELSE 'Risky'
    END AS credit_segment,
    round(AVG(income),2) AS avg_income,
    round(AVG(loan_amount),2) AS avg_loan_amount,
    ROUND(
        100.0 * SUM(CASE WHEN loan_approved = 1 THEN 1 ELSE 0 END)
        / COUNT(*),2
    ) AS approval_rate,
    COUNT(*) AS total_customers
FROM loan_risk_data_cleaned
GROUP BY education, city, credit_segment
ORDER BY approval_rate DESC, avg_income DESC;

