/*
 Question: What are the top 5 skills based on salary? (regardless of number of job postings)
 Why? Find out which skills are the highest paying
 */
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