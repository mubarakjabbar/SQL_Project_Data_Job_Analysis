/*
Question: What are the top skills based on salary (India)?
- Look at the average salary associated with each skill for Data Analyst positions
- Focuses only on roles with specified salaries in India
- Why? It reveals how different skills impact salary levels for Data Analysts in the Indian job market
  and helps identify the most financially rewarding skills to acquire or improve in the local context
*/

SELECT
    skills,
    ROUND(AVG(salary_year_avg),0) AS salary_avg
FROM job_postings_fact
INNER JOIN skills_job_dim ON skills_job_dim.job_id = job_postings_fact.job_id
INNER JOIN skills_dim ON skills_dim.skill_id = skills_job_dim.skill_id
WHERE
    job_title_short = 'Data Analyst' AND 
    salary_year_avg IS NOT NULL AND
    job_location = 'India'
GROUP BY
    skills
ORDER BY
    salary_avg DESC
LIMIT 20;

/*
-Project Management & Collaboration Tools Dominate: Skills like Visio, Jira, and Confluence are among the highest-paying, suggesting that data analysts who support Agile workflows and cross-functional teams are highly valued in India.
-Microsoft Ecosystem Brings High Returns: Tools such as Power BI, PowerPoint, Excel, and Word feature prominently in top-paying roles, reflecting the importance of business reporting, communication, and dashboarding in Indian enterprises.
-Cloud Skills Boost Salary Potential: Azure ranks in the top 5, indicating that familiarity with cloud-based analytics environments significantly enhances earning potential for data analysts.
-Core Analytics Tools Stay Relevant: Although not the highest-paying, essential tools like SQL, Python, R, and Tableau continue to offer strong salary value and remain fundamental to the role.
-ML & Technical Tools Hold Moderate Pay: Skills like TensorFlow, PyTorch, Unix, and Windows appear with mid-range salaries, highlighting their niche use in hybrid analyst-engineer or ML-driven roles.

[
  {
    "skills": "visio",
    "salary_avg": "119250"
  },
  {
    "skills": "jira",
    "salary_avg": "119250"
  },
  {
    "skills": "confluence",
    "salary_avg": "119250"
  },
  {
    "skills": "power bi",
    "salary_avg": "118140"
  },
  {
    "skills": "azure",
    "salary_avg": "118140"
  },
  {
    "skills": "powerpoint",
    "salary_avg": "104550"
  },
  {
    "skills": "flow",
    "salary_avg": "96604"
  },
  {
    "skills": "sheets",
    "salary_avg": "93600"
  },
  {
    "skills": "word",
    "salary_avg": "89579"
  },
  {
    "skills": "sql",
    "salary_avg": "85397"
  },
  {
    "skills": "excel",
    "salary_avg": "84366"
  },
  {
    "skills": "pytorch",
    "salary_avg": "79200"
  },
  {
    "skills": "unix",
    "salary_avg": "79200"
  },
  {
    "skills": "tensorflow",
    "salary_avg": "79200"
  },
  {
    "skills": "windows",
    "salary_avg": "79200"
  },
  {
    "skills": "python",
    "salary_avg": "77186"
  },
  {
    "skills": "r",
    "salary_avg": "76667"
  },
  {
    "skills": "outlook",
    "salary_avg": "75068"
  },
  {
    "skills": "oracle",
    "salary_avg": "75068"
  },
  {
    "skills": "tableau",
    "salary_avg": "74435"
  }
]
*/