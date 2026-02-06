# Introduction
This is the 2024 Data of Job Market! Focusing on mainly data analyst roles. This project explores top-paying jobs, in-demand skills and where high demand meets high salary in data analysis.
All the SQL queries are in this folder: [project_sql](/project_sql/)

# Background
Wanted to navigate the data analysis market more effectively as I was learning PostgreSQL, this project was born from a desire to pinpoint top-paid and in-demand skills whilst learning SQL at the same time!

### The questions I wanted to answer through my SQL queries were:
- What are the top-paying data analyst jobs?
- What skills are required to be a top data analyst?
- What skill are most in-demand?
- Which skills are associated with higher salaries?
- What are the most optimal skills to learn
  
# Tools I Used

- SQL : Backbone of my analysis
- PostgreSQL : I chose this as my database management as it is one of the most used tool in big companies and proven to be ideal for handling big job posting data
- Antigravy : The new googles' IDE (pretty good)
  
# The Analysis
Each query for this project aimed at investigating specific aspects of the job market. Here is how I approached each question

### 1. Top Paying Data Analyst jobs

```sql
SELECT job_id,
    job_title,
    job_location,
    job_schedule_type,
    salary_year_avg,
    job_posted_date,
    company_dim.name
FROM job_postings_fact
    LEFT JOIN company_dim ON job_postings_fact.company_id = company_dim.company_id
WHERE job_title = 'Data Analyst'
    AND job_work_from_home IS TRUE
    AND salary_year_avg IS NOT NULL
ORDER BY salary_year_avg DESC
LIMIT 10;
```

Here is the breakdown of the top paying jobs for data analysis:
![top paying jobs](assets\image.png)

### 2. Top Paying Skills

```sql
WITH top_10_jobs AS (
    SELECT job_id,
        job_title,
        job_location,
        job_schedule_type,
        salary_year_avg,
        job_posted_date,
        company_dim.name
    FROM job_postings_fact
        LEFT JOIN company_dim ON job_postings_fact.company_id = company_dim.company_id
    WHERE job_title = 'Data Analyst'
        AND job_work_from_home IS TRUE
        AND salary_year_avg IS NOT NULL
    ORDER BY salary_year_avg DESC
    LIMIT 10
)
SELECT top_10_jobs.*,
    skills_dim.skills
FROM top_10_jobs
    INNER JOIN skills_job_dim ON top_10_jobs.job_id = skills_job_dim.job_id
    INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
ORDER BY salary_year_avg DESC;
```

here is the breakdown of the top paying skills for Data Analyst roles:
![top_paying_skills](assets\image1.png)

### 3. In-demand Skills

``` sql
WITH top_5_skills_table AS(
    SELECT COUNT(job_id) as number_of_jobs,
        skill_id
    FROM skills_job_dim
    GROUP BY skill_id
    ORDER BY number_of_jobs DESC
    LIMIT 5
)
SELECT top_5_skills_table.number_of_jobs,
    skills_dim.skills
FROM top_5_skills_table
    LEFT JOIN skills_dim ON top_5_skills_table.skill_id = skills_dim.skill_id
```
Here is the breakdown of the most indemand skills right now (regardless of the job, great insight for someone who hasn't picked up a clear path yet)

![in_demand_skils](assets\image2.png)

### 4. Skills based on salary

``` sql
WITH top_5_skills_table AS (
    SELECT skills_job_dim.job_id,
        skill_id,
        job_postings_fact.salary_year_avg
    FROM skills_job_dim
        LEFT JOIN job_postings_fact ON skills_job_dim.job_id = job_postings_fact.job_id
)
SELECT top_5_skills_table.salary_year_avg,
    skills
FROM skills_dim
    LEFT JOIN top_5_skills_table ON skills_dim.skill_id = top_5_skills_table.skill_id
WHERE top_5_skills_table.salary_year_avg IS NOT NULL
ORDER BY top_5_skills_table.salary_year_avg DESC
LIMIT 5;
```
Here is the breakdown of the top 5 skills which are based on salary:
![top_5_salary_skills](assets\image3.png)

### 5. Optimal skill to learn
Finally; from the demand skill and salary, this query aimed to identify what skills are in high demand at the same time high salary. This will highlight what skills need to be improved.

``` sql

SELECT skills_dim.skill_id,
    skills_dim.skills,
    COUNT(skills_job_dim.job_id) AS demand_count,
    ROUND(AVG(job_postings_fact.salary_year_avg), 0) AS avg_salary
FROM job_postings_fact
    INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
    INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE job_title_short = 'Data Analyst'
    AND salary_year_avg IS NOT NULL
    AND job_work_from_home = True
GROUP BY skills_dim.skill_id
HAVING COUNT(skills_job_dim.job_id) > 10
ORDER BY avg_salary DESC,
    demand_count DESC
LIMIT 25;

```
Here is the breakdown image for the most optimal skills to learn:

![most_optimal_skills](assets\image4.png)

# The Result:

- Sql, python and R seem to be the most in demand skills with high paying jobs, making them optimal to learn for someone who is new and hasn't chosen a career path yet (like an undergrad)
  
# My learnings

This project helped me strengthen my skills in SQL data analysis and gave me hands-on experience working with real-world job market data. Some key learnings include:

- Using CTEs (Common Table Expressions) to organize complex queries, especially for filtering and ranking the top-paying jobs.

- JOIN operations (e.g., INNER JOIN, LEFT JOIN) were essential to combine job data with skills and company information across multiple tables.

- Aggregation functions like COUNT() and AVG() were crucial for measuring skill demand and calculating average salaries.

- Filtering and sorting with WHERE, ORDER BY, and LIMIT helped isolate the most relevant jobs 

- GROUP BY and subqueries enabled skill-level analysis by demand and salary.


