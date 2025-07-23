/*
Question: What are the most optimal skills to learn (aka it’s in high demand and a high-paying skill)?
– Identify skills in high demand and associated with high average salaries for Data Analyst roles
– Concentrates on job positions based in India with specified salaries
– Why? Targets skills that offer job security (high demand) and financial benefits (high salaries),
   offering strategic insights for career development in data analysis
*/

WITH skills_demand AS (
SELECT
    skills_dim.skill_id,
    skills_dim.skills,
    COUNT(skills_job_dim.job_id)
FROM job_postings_fact
INNER JOIN skills_job_dim ON skills_job_dim.job_id = job_postings_fact.job_id
INNER JOIN skills_dim ON skills_dim.skill_id = skills_job_dim.skill_id
WHERE
    job_title_short = 'Data Analyst' AND 
    salary_year_avg IS NOT NULL AND
    job_location = 'India'
GROUP BY
    skills_dim.skill_id), average_salary AS (
SELECT
    skills_job_dim.skill_id,
    ROUND(AVG(salary_year_avg),0) AS salary_avg
FROM job_postings_fact
INNER JOIN skills_job_dim ON skills_job_dim.job_id = job_postings_fact.job_id
INNER JOIN skills_dim ON skills_dim.skill_id = skills_job_dim.skill_id
WHERE
    job_title_short = 'Data Analyst' AND 
    salary_year_avg IS NOT NULL AND
    job_location = 'India'
GROUP BY
    skills_job_dim.skill_id)

SELECT 
    skills_demand.skill_id,
    skills_demand.skills,
    COUNT,
    salary_avg
FROM
    skills_demand
INNER JOIN average_salary ON average_salary.skill_id=skills_demand.skill_id
ORDER BY
    salary_avg,
    count DESC 
LIMIT 25