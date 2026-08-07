# Bellabeat Case Study: Activity & Sleep Patterns

Bellabeat is a wellness technology company that designs health-tracking devices for women. This project analyzes Fitbit smart device data (33 users) to uncover activity and sleep behavior patterns that Bellabeat can apply to its own product and marketing strategy.

## Live Dashboard
[View the interactive Tableau dashboard and story](https://public.tableau.com/views/Bellabeat-ActivitySleepPatterns/BellabeatCaseStudy?:language=en-US&:sid=&:redirect=auth&:display_count=n&:origin=viz_share_link)

## Key Findings
- Sleep is tracked on only 43.8% of days (413 of 943), while activity is logged on 91.8% of days.
- Average daily steps (8,333) fall short of the CDC benchmark (10,000).
- Calories show no meaningful relationship with sleep duration (r = -0.03, not statistically significant).
- Steps show a weak but statistically significant relationship with sleep duration (r = -0.19, p = 0.0001).

## Files in This Repo
- `Malak Taher Bellabeat case study.pdf` — full written report: business task, methodology, findings, recommendations, and limitations
- `bellabeat_queries.sql` — all BigQuery SQL queries used in the analysis

## Tools Used
Google BigQuery (SQL), Tableau Public, Claude (Anthropic) for debugging guidance and drafting support.

## Data Source
Fitbit Fitness Tracker Data (Kaggle, via Mobius). Case study brief: Google Data Analytics Professional Certificate (Coursera).
