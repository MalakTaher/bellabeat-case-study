-- ============================================================
-- Bellabeat Case Study — BigQuery Analysis Queries
-- Author: Malak Taher
-- Data: Fitbit Fitness Tracker Data (Kaggle, via Mobius), 33 users
-- Data prep note: Dailyactivity_sleepday_merged is the result of
-- joining daily activity and sleep tables on Id + ActivityDate.
-- ============================================================


-- ------------------------------------------------------------
-- 1. Sleep tracking rate
-- Chart: "Sleep is tracked on fewer than half of all activity days."
-- ------------------------------------------------------------
SELECT
  CASE
    WHEN TotalMinutesAsleep IS NULL THEN 'Not Logged'
    ELSE 'Logged'
  END AS sleep_status,
  COUNT(*) AS num_days
FROM
  `project-7ebfe586-a4c3-471f-833.bellabeat_case_study.Dailyactivity_sleepday_merged`
GROUP BY
  1
-- Result: Logged = 413, Not Logged = 530


-- ------------------------------------------------------------
-- 2. Zero-activity days
-- Chart: "Zero activity days"
-- ------------------------------------------------------------
SELECT
  CASE
    WHEN TotalSteps = 0 THEN 'No Activity'
    ELSE 'Activity Logged'
  END AS activity_status,
  COUNT(*) AS num_days
FROM
  `project-7ebfe586-a4c3-471f-833.bellabeat_case_study.Dailyactivity_sleepday_merged`
GROUP BY
  1
-- Result: Activity Logged = 866, No Activity = 77


-- ------------------------------------------------------------
-- 3. Deduplicated Steps + Sleep pull (feeds Tableau: Steps vs. Sleep)
-- ------------------------------------------------------------
-- Note: raw merged table contains 3 duplicate Id+ActivityDate rows.
-- SELECT DISTINCT removes these before the data reaches Tableau.
SELECT DISTINCT
  Id,
  ActivityDate,
  TotalSteps,
  TotalMinutesAsleep
FROM
  `project-7ebfe586-a4c3-471f-833.bellabeat_case_study.Dailyactivity_sleepday_merged`
WHERE
  TotalSteps IS NOT NULL AND TotalMinutesAsleep IS NOT NULL


-- ------------------------------------------------------------
-- 4. Deduplicated Calories + Sleep pull (feeds Tableau: Calories vs. Sleep)
-- ------------------------------------------------------------
SELECT DISTINCT
  Id,
  ActivityDate,
  Calories,
  TotalMinutesAsleep
FROM
  `project-7ebfe586-a4c3-471f-833.bellabeat_case_study.Dailyactivity_sleepday_merged`
WHERE
  Calories IS NOT NULL AND TotalMinutesAsleep IS NOT NULL


-- ------------------------------------------------------------
-- 5. Calories vs. Sleep correlation
-- Chart: "Calories show no meaningful relationship with sleep duration"
-- ------------------------------------------------------------
SELECT
  CORR(Calories, TotalMinutesAsleep) AS calories_sleep_corr,
  COUNT(
    CASE
      WHEN Calories IS NOT NULL AND TotalMinutesAsleep IS NOT NULL THEN 1
      END)
    AS observation_count
FROM (
  SELECT DISTINCT Id, ActivityDate, Calories, TotalMinutesAsleep
  FROM `project-7ebfe586-a4c3-471f-833.bellabeat_case_study.Dailyactivity_sleepday_merged`
)
-- Result: r = -0.0317, n = 410, p = 0.522 (not statistically significant)


-- ------------------------------------------------------------
-- 6. Steps vs. Sleep correlation
-- Chart: "Steps show only a weak relationship with sleep duration"
-- ------------------------------------------------------------
SELECT
  CORR(TotalSteps, TotalMinutesAsleep) AS steps_sleep_corr,
  COUNT(
    CASE
      WHEN TotalSteps IS NOT NULL AND TotalMinutesAsleep IS NOT NULL THEN 1
      END)
    AS observation_count
FROM (
  SELECT DISTINCT Id, ActivityDate, TotalSteps, TotalMinutesAsleep
  FROM `project-7ebfe586-a4c3-471f-833.bellabeat_case_study.Dailyactivity_sleepday_merged`
)
-- Result: r = -0.1903, n = 410, p = 0.0001 (statistically significant)
