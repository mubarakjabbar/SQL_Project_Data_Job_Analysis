# Introduction

📊 Dive into the data job market! Focusing on data analyst roles, this project explores 💰 top-paying jobs, 🔥 in-demand skills, and 📈 where high demand meets high salary in data analytics across India.

🔍 SQL queries? Check them out here: [project_sql folder](/project_sql/)



# Background
Driven by a quest to navigate the data analyst job market more effectively, this project was born from a desire to pinpoint top-paid and in-demand skills, streamlining others' work to find optimal jobs in India.

### The questions I wanted to answer through my SQL queries were:
1. What are the top-paying data analyst jobs in India?  
2. What skills are required for these top-paying jobs in India?  
3. What skills are most in demand for data analysts in India?  
4. Which skills are associated with higher salaries in India?  
5. What are the most optimal skills to learn for aspiring data analysts in India?




# Tools I Used

For my deep dive into the data analyst job market, I harnessed the power of several key tools:

- **SQL:** The backbone of my analysis, allowing me to query the database and unearth critical insights.  
- **PostgreSQL:** The chosen database management system, ideal for handling the job posting data.  
- **Visual Studio Code:** My go-to for database management and executing SQL queries.  
- **Git & GitHub:** Essential for version control and sharing my SQL scripts and analysis, ensuring collaboration and project tracking.



# The Analysis

Each query for this project aimed at investigating specific aspects of the data analyst job market.  
Here’s how I approached each question:

### 1. Top Paying Data Analyst Jobs

To identify the highest-paying roles, I filtered data analyst positions by average yearly salary and location, focusing on jobs within India.  
This query highlights the high-paying opportunities in the Indian job market.

```sql
SELECT
    job_id,
    job_title,
    job_location,
    job_schedule_type,
    salary_year_avg,
    job_posted_date,
    name AS company_name
FROM 
    job_postings_fact
LEFT JOIN company_dim ON job_postings_fact.company_id = company_dim.company_id
WHERE
    job_title_short = 'Data Analyst' AND
    job_location = 'India' AND
    salary_year_avg IS NOT NULL
ORDER BY
    salary_year_avg DESC
LIMIT 10;
```

Insights from High-Paying Data Analyst Jobs in India (2023):
- **Senior roles dominate the top spots:** Jobs titled “Senior Business & Data Analyst” and “Sr. Enterprise Data Analyst” offer the highest average annual salaries, exceeding ₹11.8 lakh per year, highlighting the premium placed on experience and advanced expertise.
- **Finance and consulting firms lead in pay:** Companies like Deutsche Bank and ACA Group are among the top payers, indicating that financial institutions and consulting sectors highly value data analysts.
- **Full-time roles prevail:** All top-paying positions are full-time, suggesting that high compensation in India’s data analytics field is tightly linked with permanent employment rather than contractual or part-time roles.

![Top paying roles](assets\top_paying_jobs.JPG)
*Bar graph visualizing the salary for the top 10 data analyst roles in India (2023).*

### 2. Skills Associated with Top-Paying Data Analyst Roles

To identify which technical and professional skills are most common among the highest-paying data analyst jobs in India (2023), I used a Common Table Expression (CTE) to first filter the top 10 highest-paying jobs based on average yearly salary.  
I then joined this subset with the associated skills to highlight the tools and technologies in demand for premium roles.
```sql
WITH top_paying_jobs AS(
SELECT
    job_id,
    job_title,
    salary_year_avg,
    name AS company_name
FROM 
    job_postings_fact
LEFT JOIN company_dim ON job_postings_fact.company_id = company_dim.company_id
WHERE
    job_title_short = 'Data Analyst' AND
    job_location = 'India' AND
    salary_year_avg IS NOT NULL
ORDER BY
    salary_year_avg DESC
LIMIT 10)

SELECT
    top_paying_jobs.*,
    skills_dim.skills,
    top_paying_jobs.job_id
FROM top_paying_jobs
INNER JOIN skills_job_dim ON skills_job_dim.job_id = top_paying_jobs.job_id
INNER JOIN skills_dim ON skills_dim.skill_id = skills_job_dim.skill_id 
ORDER BY
    salary_year_avg DESC;
```

Insights from Top-Paying Data Analyst Job Skills (2023):
- SQL and Excel are must-haves — appear in 70% of the top-paying jobs.
- Python is the leading programming language.
- Visualization tools like Tableau and Power BI appear but are less common.
- Cloud, ML, and soft tools (e.g., Jira, Confluence) are also present but scattered.
![Top paying job skills](assets\top_paying_job_skills_visualized.png)
*Bar graph showing the most in-demand skills among the top 10 highest-paying data analyst roles in India (2023).*

### 3. Most In-Demand Skills for Data Analyst Roles
To identify the top 5 most in-demand skills for data analyst positions in India, I analyzed all job postings with the title “Data Analyst.”  
By joining job data with associated skills using an inner join, I counted how frequently each skill appeared across all postings.  
This gives a direct view into the tools and technologies most sought after in the broader market, beyond just the top-paying roles.
```SQL
SELECT
    skills,
    COUNT(skills_job_dim.job_id)
FROM job_postings_fact
INNER JOIN skills_job_dim ON skills_job_dim.job_id = job_postings_fact.job_id
INNER JOIN skills_dim ON skills_dim.skill_id = skills_job_dim.skill_id
WHERE
    job_title_short = 'Data Analyst' AND 
    job_location = 'India'
GROUP BY
    skills
ORDER BY
    COUNT DESC
LIMIT 5;
```
Insights from Most In-Demand Data Analyst Skills (2023):
- SQL is the top skill, reinforcing its essential role in data extraction and manipulation.
- Excel continues to be heavily used for reporting and ad-hoc analysis.
- Python remains the most preferred programming language due to its flexibility and ecosystem.
- Tableau and Power BI show consistent demand, highlighting the need for strong data visualization capabilities.

**Top 5 Most In-Demand Skills for Data Analysts in India (2023)**:
| Rank | Skill    | Job Postings Count |
| ---- | -------- | ------------------ |
| 1️⃣  | SQL      | 1016               |
| 2️⃣  | Excel    | 717                |
| 3️⃣  | Python   | 687                |
| 4️⃣  | Tableau  | 545                |
| 5️⃣  | Power BI | 402                |

### 4. Top-Paying Skills for Data Analyst Roles in India

To understand which skills are associated with higher average salaries for data analyst positions in India, I analyzed job postings that explicitly mentioned salary details.  
By joining job data with associated skills, I calculated the **average annual salary** for each skill.  
This analysis helps identify **financially rewarding skills** for data analysts to acquire or improve.

```sql
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
```
Insights from Top-Paying Data Analyst Skills (2023):
- Enterprise tools like Visio, Jira, and Confluence are surprisingly associated with the highest-paying roles.
- Power BI and Azure suggest strong demand for Microsoft ecosystem skills in top-paying jobs.
- Traditional tools like SQL, Excel, and PowerPoint remain relevant and well-paid.
- Machine learning frameworks (PyTorch, TensorFlow) and programming languages (Python, R) also feature among high-paying skillsets.


**Top 20 Highest Paying Skills for Data Analyst Roles (India, 2023)**

| Rank | Skill        | Average Salary (USD/year) |
|------|--------------|----------------------------|
|  1   | Visio        | $119,250                   |
| 2️   | Jira         | $119,250                   |
| 3️   | Confluence   | $119,250                   |
| 4️   | Power BI     | $118,140                   |
| 5️   | Azure        | $118,140                   |
| 6️   | PowerPoint   | $104,550                   |
| 7️   | Flow         | $96,604                    |
| 8️   | Sheets       | $93,600                    |
| 9️   | Word         | $89,579                    |
| 10   | SQL          | $85,397                    |
| 11   | Excel        | $84,366                    |
| 12   | PyTorch      | $79,200                    |
| 13   | Unix         | $79,200                    |
| 14   | TensorFlow   | $79,200                    |
| 15   | Windows      | $79,200                    |
| 16   | Python       | $77,186                    |
| 17   | R            | $76,667                    |
| 18   | Outlook      | $75,068                    |
| 19   | Oracle       | $75,068                    |
| 20   | Tableau      | $74,435                    |

### 5. Optimal Skills to Learn: High Demand + High Salary

To pinpoint the most strategic skills for aspiring data analysts in India, I combined two key metrics:
- 💼 **Demand** — how often each skill appears in job postings
- 💰 **Salary** — the average annual salary linked to each skill

By joining these two perspectives, we highlight skills that are both *frequently requested* and *financially rewarding*.  
This analysis is restricted to **Data Analyst** roles in **India** with specified annual salaries.

```sql
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
    salary_avg DESC,
    count DESC 
LIMIT 25
```
Insights on Optimal Skills (2023):
- Skills like SQL, Excel, and Python are not just popular but also command above-average salaries.
- Power BI, Azure, and Confluence appear in high-paying roles even if less frequently — suggesting niche but lucrative expertise.
- Strategic learners should aim to combine broadly used tools with premium skill sets for the best outcomes.

**Optimal Skills for Data Analyst Roles in India (Job Demand & Avg Salary)**


| Skill         | Job Count | Avg Salary  |
|---------------|-----------|------------------|
| Visio         | 1         | $119,250         |
| Confluence    | 1         | $119,250         |
| Jira          | 1         | $119,250         |
| Power BI      | 1         | $118,140         |
| Azure         | 1         | $118,140         |
| PowerPoint    | 1         | $104,550         |
| Flow          | 2         | $96,604          |
| Sheets        | 1         | $93,600          |
| Word          | 3         | $89,579          |
| SQL           | 9         | $85,397          |
| Excel         | 8         | $84,366          |
| TensorFlow    | 1         | $79,200          |
| Windows       | 1         | $79,200          |
| Unix          | 1         | $79,200          |
| PyTorch       | 1         | $79,200          |
| Python        | 6         | $77,186          |
| R             | 3         | $76,667          |
| Outlook       | 1         | $75,068          |
| Oracle        | 1         | $75,068          |
| Tableau       | 3         | $74,435          |
| T-SQL         | 1         | $64,600          |
| VBA           | 1         | $64,600          |
| SQL Server    | 1         | $64,600          |
| MS Access     | 1         | $64,600          |
| Looker        | 1         | $64,600          |


# What I Learned

- **🧠 Advanced SQL Querying:** Developed strong proficiency in writing complex SQL queries, including multi-table joins, subqueries, and Common Table Expressions (CTEs) using `WITH` clauses for efficient data transformation.

- **📊 Data Aggregation Techniques:** Gained hands-on experience with `GROUP BY`, `COUNT()`, `AVG()`, and other aggregate functions to effectively summarize and extract key insights from large datasets.

- **🧩 Analytical Problem Solving:** Strengthened my ability to translate real-world business problems into data-driven solutions by formulating clear, actionable SQL queries to support decision-making. 


# Conclusions
### 📌 Insights

From the analysis of data analyst job postings in India (2023), five key insights emerged:

1. **Top-Paying Data Analyst Jobs in India**:  
   Senior-level roles such as “Senior Business & Data Analyst” and “Sr. Enterprise Data Analyst” offer the highest average salaries. Finance and consulting firms like Deutsche Bank and ACA Group lead in compensation, with full-time roles dominating the top-paying segment.

2. **Skills for Top-Paying Jobs**:  
   **SQL and Excel** appear in **70%** of the highest-paying job listings, making them foundational. **Python** is the most in-demand programming language, while tools like **Tableau**, **Power BI**, **Jira**, and **Confluence** show up but less consistently.

3. **Most In-Demand Skills**:  
   **SQL** is the most frequently required skill, emphasizing its importance in data extraction and manipulation. **Excel** and **Python** follow closely, while **Tableau** and **Power BI** remain strong in demand for data visualization.

4. **Skills Linked to Higher Salaries**:  
   Enterprise tools like **Visio**, **Jira**, and **Confluence** are frequently associated with higher salaries. Skills in the **Microsoft ecosystem** (e.g., **Power BI**, **Azure**) and in **machine learning** (e.g., **PyTorch**, **TensorFlow**) also correlate with high compensation.

5. **Optimal Skills for Career Growth**:  
   A mix of widely used tools like **SQL**, **Excel**, and **Python**, along with niche but high-value skills such as **Azure**, **Power BI**, and **Confluence**, offer the best return. Strategic upskilling in both foundational and specialized areas is key to maximizing market value.

   ### Closing Thoughts

   This project significantly enhanced my SQL skills and provided valuable insights into the Indian data analyst job market. The findings served as a guide to prioritizing skill development and job search strategies. By identifying in-demand and high-paying skills in India, it highlighted how aspiring data analysts can better position themselves in a competitive landscape. Overall, the experience reinforced the importance of continuous learning and staying adaptable to evolving trends in the field of data analytics.
