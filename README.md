# Crowdfunding_Performance_Project
----------------------------------------- Crowd Funding SQL Analysis Performance Queries ------------------------------------------------
CREATE database croud_funding;
USE croud_funding;
DESCRIBE main_data_cf_project_1csv;
------------------------------------

```-- 1. Total Projects by State (failed / canceled / successful)
SELECT state, COUNT(*) AS croud_funding
FROM  main_data_cf_project_1csv
GROUP BY state
ORDER BY croud_funding DESC;```

-- 2. Total Amount Raised by Country
SELECT country, SUM(`Amount Raised`) AS total_amount
FROM main_data_cf_project_1csv
GROUP BY country
ORDER BY total_amount DESC;

-- 3. Top 10 Projects by Amount Raised
SELECT name, `Amount Raised`
FROM  main_data_cf_project_1csv
ORDER BY `Amount Raised` DESC
LIMIT 10;

-- 4. Average Number of Backers per Project
SELECT AVG(`Number of Backers`) AS avg_backers
FROM main_data_cf_project_1csv;

-- 5. Projects Created Per Year
SELECT Year, COUNT(*) AS total_projects
FROM  main_data_cf_project_1csv
GROUP BY Year
ORDER BY Year;

-- 6. Monthly Project Creation Trend
SELECT MonthFullName, COUNT(*) AS total_projects
FROM main_data_cf_project_1csv
GROUP BY MonthFullName
ORDER BY total_projects DESC;

-- 7. Projects with Zero Backers
# Find poor performing projects.
SELECT 
    id,
    name,
    state,
    `Number of Backers`
FROM main_data_cf_project_1csv
WHERE `Number of Backers` = 0;

-- 8. Category-wise Total Backers
# Which category attracts more supporters.
SELECT 
    `Category.name`,
    SUM(`Number of Backers`) AS total_backers
FROM main_data_cf_project_1csv
GROUP BY `Category.name`
ORDER BY total_backers DESC;


-- 9. Top 5 Countries by Total Funding
# Which country raised most money.
SELECT 
    country,
    SUM(`Amount Raised`) AS total_funding
FROM main_data_cf_project_1csv
GROUP BY country
ORDER BY total_funding DESC
LIMIT 5;

-- 10. Funding Gap (Goal vs Raised)
# How much funding is still needed.
SELECT 
    id,
    name,
    Goal_usd,
    usd_pledged,
    (Goal_usd - usd_pledged) AS funding_gap
FROM main_data_cf_project_1csv;


-- 11. Success Rate %
SELECT 
    state,
    ROUND(
         COUNT(*) * 100.0/
         (SELECT COUNT(*) FROM main_data_cf_project_1csv),
		  2
	  ) AS Percentage
FROM main_data_cf_project_1csv
GROUP BY state;

-- 12. Rank Projects by Amount Raised (Window Function)
#  Shows highest earning projects with ranking.
SELECT 
    id,
    name,
    `Amount Raised`,
    RANK() OVER (ORDER BY `Amount Raised` DESC) AS project_rank
FROM main_data_cf_project_1csv;

-- 13. Running Total of Amount Raised by Year (Window Function)
#  Shows cumulative funding trend.
SELECT 
    Year,
    SUM(`Amount Raised`) AS yearly_total,
    SUM(SUM(`Amount Raised`)) 
        OVER (ORDER BY Year) AS running_total
        FROM main_data_cf_project_1csv
GROUP BY Year;

-- 14. Project Funding Status (Advanced CASE + Join)
#  Check if project met funding goal.
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





--------------------------- thank you -------------------------------







