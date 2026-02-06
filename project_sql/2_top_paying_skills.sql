/*
 Question : What skills are required for the top 10 highest paying jobs?
 Why? It provides a detailed look at which high paying jobs demand certain skills
 */
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