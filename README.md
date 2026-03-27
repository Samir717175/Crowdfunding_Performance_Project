# 📊 Crowd Funding SQL Analysis
-- Group Project
## 🔍 Overview

This project focuses on analyzing a crowdfunding dataset using SQL to extract meaningful insights about project performance. 
The dataset includes details such as project state (successful/failed), funding amount, backers, country, and time trends.
By applying SQL concepts like aggregation, grouping, window functions, and CASE statements, the project evaluates how different factors impact crowdfunding success.

## 🎯 Objective

- The main objectives of this analysis are:

To analyze the distribution of projects by state (successful, failed, canceled)
To identify top-performing countries based on total funding raised
To find the highest-funded projects
To calculate average backers per project
To study yearly and monthly project trends
To evaluate the success rate of projects
To apply window functions for ranking and cumulative analysis
To determine whether projects achieved their funding goals

## 📈 Key Findings

-- Project Distribution:
Most projects fall into specific states (e.g., failed or successful), highlighting competition and risk in crowdfunding.
- Top Countries by Funding:
Certain countries contribute significantly more to total funding, indicating stronger crowdfunding ecosystems.
- Top Projects:
A small number of projects generate extremely high funding, showing a power-law distribution (few winners dominate).
- Backer Analysis:
The average number of backers gives insight into audience engagement and campaign reach.
- Yearly Trends:
The number of projects has changed over time, showing growth or decline in crowdfunding popularity.
- Monthly Trends:
Some months have higher project launches, suggesting seasonal patterns.
- Success Rate:
Percentage analysis shows how many projects succeed vs fail—important for business decision-making.
- Ranking Analysis:
Using window functions, projects are ranked by funding, helping identify top performers quickly.
- Cumulative Funding Trend:
Running total shows how funding has grown over the years.
- Funding Goal Achievement:
Using CASE logic, projects are categorized into:
- Goal Achieved
- Not Achieved


## Crowd Funding SQL Analysis Performance Queries 

```sql
CREATE database croud_funding;
USE croud_funding;
DESCRIBE main_data_cf_project_1csv;
```

### 1. Total Projects by State (failed / canceled / successful)

```sql
SELECT state, COUNT(*) AS croud_funding
FROM  main_data_cf_project_1csv
GROUP BY state
ORDER BY croud_funding DESC;
```

### 2. Total Amount Raised by Country

```sql
SELECT country, SUM(`Amount Raised`) AS total_amount
FROM main_data_cf_project_1csv
GROUP BY country
ORDER BY total_amount DESC;
```

### 3. Top 10 Projects by Amount Raised

```sql
SELECT name, `Amount Raised`
FROM  main_data_cf_project_1csv
ORDER BY `Amount Raised` DESC
LIMIT 10;
```

### 4. Average Number of Backers per Project

```sql
SELECT AVG(`Number of Backers`) AS avg_backers
FROM main_data_cf_project_1csv;
```

### 5. Projects Created Per Year

```sql
SELECT Year, COUNT(*) AS total_projects
FROM  main_data_cf_project_1csv
GROUP BY Year
ORDER BY Year;
```

### 6. Monthly Project Creation Trend

```sql
SELECT MonthFullName, COUNT(*) AS total_projects
FROM main_data_cf_project_1csv
GROUP BY MonthFullName
ORDER BY total_projects DESC;
```

### 7. Projects with Zero Backers
## Find poor performing projects.

```sql
SELECT 
    id,
    name,
    state,
    `Number of Backers`
FROM main_data_cf_project_1csv
WHERE `Number of Backers` = 0;
```

### 8. Category-wise Total Backers
## Which category attracts more supporters.

```sql
SELECT 
    `Category.name`,
    SUM(`Number of Backers`) AS total_backers
FROM main_data_cf_project_1csv
GROUP BY `Category.name`
ORDER BY total_backers DESC;
```

### 9. Top 5 Countries by Total Funding
## Which country raised most money.

```sql
SELECT 
    country,
    SUM(`Amount Raised`) AS total_funding
FROM main_data_cf_project_1csv
GROUP BY country
ORDER BY total_funding DESC
LIMIT 5;
```

### 10. Funding Gap (Goal vs Raised)
## How much funding is still needed.

```sql
SELECT 
    id,
    name,
    Goal_usd,
    usd_pledged,
    (Goal_usd - usd_pledged) AS funding_gap
FROM main_data_cf_project_1csv;
```

### 11. Success Rate %

```sql
SELECT 
    state,
    ROUND(
         COUNT(*) * 100.0/
         (SELECT COUNT(*) FROM main_data_cf_project_1csv),
		  2
	  ) AS Percentage
FROM main_data_cf_project_1csv
GROUP BY state;
```

### 12. Rank Projects by Amount Raised (Window Function)
##  Shows highest earning projects with ranking.

```sql
SELECT 
    id,
    name,
    `Amount Raised`,
    RANK() OVER (ORDER BY `Amount Raised` DESC) AS project_rank
FROM main_data_cf_project_1csv;
```

### 13. Running Total of Amount Raised by Year (Window Function)
##  Shows cumulative funding trend.

```sql
SELECT 
    Year,
    SUM(`Amount Raised`) AS yearly_total,
    SUM(SUM(`Amount Raised`)) 
        OVER (ORDER BY Year) AS running_total
        FROM main_data_cf_project_1csv
GROUP BY Year;
```

### 14. Project Funding Status (Advanced CASE + Join)
##  Check if project met funding goal.

```sql
SELECT 
    id,
    name,
    Goal_usd,
    usd_pledged,
    CASE
        WHEN usd_pledged >= Goal_usd THEN 'Goal Achieved'
        ELSE 'Not Achieved'
    END AS funding_status
FROM main_data_cf_project_1csv;
```
## ✅ Conclusion

- This SQL-based analysis provides valuable insights into the crowdfunding ecosystem. The findings show that:

Success in crowdfunding is highly competitive
Only a small percentage of projects achieve their funding goals
Country and timing play a significant role in project success
Advanced SQL techniques like window functions and CASE statements are powerful for real-world data analysis

- Overall, this project demonstrates how SQL can be effectively used to analyze large datasets, uncover trends, and support data-driven decision-making.




--------------------------- thank you -------------------------------







