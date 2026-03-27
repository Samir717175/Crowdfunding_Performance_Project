----------------------------------------- Crowd Funding SQL Analysis Performance Queries ------------------------------------------------
CREATE database croud_funding;
USE croud_funding;
SHOW TABLES;
DESCRIBE main_data_cf_project_1csv;
-----------------------------------

-- 1. Total Projects by State (failed / canceled / successful)
SELECT state, COUNT(*) AS croud_funding
FROM  main_data_cf_project_1csv
GROUP BY state
ORDER BY croud_funding DESC;

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

-- 7. Success Rate %
SELECT 
    state,
    COUNT(*) * 100.0 / (SELECT COUNT(*) FROM main_data_cf_project_1csv) AS percentage
FROM main_data_cf_project_1csv 
GROUP BY state;

-- 8. Rank Projects by Amount Raised (Window Function)
#  Shows highest earning projects with ranking.
SELECT 
    id,
    name,
    `Amount Raised`,
    RANK() OVER (ORDER BY `Amount Raised` DESC) AS project_rank
FROM main_data_cf_project_1csv;

-- 9. Running Total of Amount Raised by Year (Window Function)
#  Shows cumulative funding trend.
SELECT 
    Year,
    SUM(`Amount Raised`) AS yearly_total,
    SUM(SUM(`Amount Raised`)) 
        OVER (ORDER BY Year) AS running_total
        FROM main_data_cf_project_1csv
GROUP BY Year;

-- 10. Project Funding Status (Advanced CASE + Join)
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








