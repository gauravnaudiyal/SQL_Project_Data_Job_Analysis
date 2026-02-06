/*
 Question : What are the most in-demand skills
 Identify the top 5 in-demand skills
 Why? Retrieves the top 5 skills with the highest demand in the job market
 */
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