# SQL Data Job Market Analysis

I built this while learning PostgreSQL. The idea was to use real job posting data from 2024 to answer questions I actually cared about as someone thinking about the job market, specifically what skills pay well and what is actually in demand.

All the SQL queries are in: [/project_sql](/project_sql/)

## Questions I tried to answer

1. What are the top-paying data jobs?
2. What skills do those high-paying roles actually ask for?
3. Which skills come up most often across all data job postings?
4. Which skills are linked to higher salaries?
5. What is the most useful thing to learn if you want high demand and high pay?

## What I found

Python, SQL, and cloud platforms like AWS and Azure kept coming up as the best combination to have. Senior data engineering and ML engineering roles paid the most, but even mid-level analyst roles paid well when cloud skills were on the CV.

## Built with

- PostgreSQL
- SQL
- VS Code and DBeaver

## Running it yourself

```bash
git clone https://github.com/gauravnaudiyal/SQL_Project_Data_Job_Analysis.git
```

Set up a PostgreSQL database, import the dataset from `/data`, then open the query files in `/project_sql` and run them in order.

Developed by Gaurav Naudiyal.
