/*
 Question : What are the top paying analyst jobs?
 a) Identify the top 10 highest paying jobs for data analyst that are available remotely
 b) Focus on jobs that have a specified salary (remove nulls)
 c) Why? Highlight the top-paying opportunities for Data Analysts, offering insights
 */
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