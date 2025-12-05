select count(distinct id)
from `automobile.train`;

select
  gender,
  round(count(distinct id) / (select count(distinct id) from `automobile.train`) * 100, 2)
from `automobile.train`
group by gender;

SELECT AVG(Age)
FROM `automobile.train`;

-- select avg(age)
-- from (
--   select distinct id, age
--   from `automobile.train`
-- );

-- WITH RawData AS (
--   SELECT ID, 
--          Gender, 
--          Ever_Married, 
--          CASE WHEN Ever_Married IS true THEN 1 ELSE 0 END AS Indicator
--   FROM `automobile.train`
-- )
-- SELECT SUM(Indicator) AS MarriedNumber, 
--        SUM(Indicator)/COUNT(Indicator) AS MarriedPercentage
-- FROM RawData;

select
  count(distinct case when ever_married = true then id end),
  count(distinct case when ever_married = true then id end) / count(distinct id)
from `automobile.train`;

select
  concat(round(count(distinct case when graduated = true then id end) / count(distinct id) * 100, 2), '%')
from `automobile.train`;

WITH RawData AS (
  SELECT ID, 
         Graduated, 
         CASE WHEN Graduated IS true THEN 1 ELSE 0 END AS Indicator
  FROM `automobile.train`
)
SELECT SUM(Indicator) AS GraduatedNumber, 
       SUM(Indicator)/COUNT(Indicator) AS GraduatedPercentage
FROM RawData;

SELECT 
  id,
  COUNT(*)
FROM `automobile.train`
GROUP BY id
HAVING COUNT(*) > 1;

-- select
--   profession,
--   count(*)
-- from `automobile.train`
-- group by Profession
-- order by count(*) desc;

select
  profession,
  count(distinct id)
from `automobile.train`
group by Profession
order by count(distinct id) desc;

select avg(age)
from `automobile.train`
where segmentation = 'A';

SELECT DISTINCT Spending_Score
FROM `automobile.train`
ORDER BY Spending_Score;

select
  profession,
  count(case when spending_score = 'High' then 1 end) / count(*)
from `automobile.train`
group by Profession
order by count(case when spending_score = 'High' then 1 end) / count(*) desc;

with processeddata as (
  select id, profession, spending_score,
    case when spending_score = 'Low' then 1 else 0 end isLow,
    case when spending_score = 'Average' then 1 else 0 end isAvg,
    case when spending_score = 'High' then 1 else 0 end ishigh
  from `automobile.train`
)
select profession,
       round(sum(islow)/count(id), 2) as lowNum,
       round(sum(isavg)/count(id), 2) as avgNum,
       round(sum(ishigh)/count(id), 2) as highNum
from processeddata
group by profession
order by highnum desc;

select profession,
       round(count(case when spending_score = 'Low' then 1 end)/count(id), 2) as lowNum,
       round(count(case when spending_score = 'Average' then 1 end)/count(id), 2) as avgNum,
       round(count(case when spending_score = 'High' then 1 end)/count(id), 2) as highNum
from `automobile.train`
group by profession
order by highnum desc;

select
  segmentation,
  count(id)
from `automobile.train`
group by segmentation
order by segmentation;

select
  segmentation,
  concat(round(count(case when ever_married = true then 1 end) / count(*) * 100, 2), '%')
from `automobile.train`
group by segmentation
order by concat(round(count(case when ever_married = true then 1 end) / count(*) * 100, 2), '%') desc;

WITH ProcessedData AS (
  SELECT ID, 
         Ever_Married, 
         Segmentation, 
         CASE WHEN Ever_Married IS true THEN 1 ELSE 0 END IsMarried
  FROM `automobile.train`
) 
SELECT Segmentation, SUM(IsMarried)/COUNT(ID)
FROM ProcessedData
GROUP BY Segmentation
order by SUM(IsMarried)/COUNT(ID) desc;

SELECT
  Segmentation,
  COUNT(CASE WHEN Spending_Score = 'High' THEN 1 END) AS High_Count,
  COUNT(CASE WHEN Spending_Score = 'Average' THEN 1 END) AS Avg_Count,
  COUNT(CASE WHEN Spending_Score = 'Low' THEN 1 END) AS Low_Count
FROM `automobile.train`
GROUP BY Segmentation
ORDER BY Segmentation;

SELECT 
  Segmentation,
  COUNT(CASE WHEN Spending_Score = 'High' THEN 1 END)/count(*)
FROM `automobile.train`
GROUP BY Segmentation
ORDER BY COUNT(CASE WHEN Spending_Score = 'High' THEN 1 END)/count(*) DESC;

SELECT 
  Segmentation,
  COUNT(CASE WHEN Spending_Score = 'Average' THEN 1 END)/count(*)
FROM `automobile.train`
GROUP BY Segmentation
ORDER BY COUNT(CASE WHEN Spending_Score = 'Average' THEN 1 END)/count(*) DESC;

SELECT 
  Segmentation,
  COUNT(CASE WHEN Spending_Score = 'Low' THEN 1 END)/count(*)
FROM `automobile.train`
GROUP BY Segmentation
ORDER BY COUNT(CASE WHEN Spending_Score = 'Low' THEN 1 END)/count(*) DESC;

WITH ProcessedData AS (
  SELECT Segmentation, ID,
         CASE WHEN Spending_Score = "Low" THEN 1 ELSE 0 END isLow,
         CASE WHEN Spending_Score = "Average" THEN 1 ELSE 0 END isAvg,
         CASE WHEN Spending_Score = "High" THEN 1 ELSE 0 END isHigh
  FROM `automobile.train`
)
SELECT Segmentation, 
       ROUND(SUM(isLow)/COUNT(ID)*100, 2) AS LowPercentage,
       ROUND(SUM(isAvg)/COUNT(ID)*100, 2) AS AvgPercentage,
       ROUND(SUM(isHigh)/COUNT(ID)*100, 2) AS HighPercentage
FROM ProcessedData
GROUP BY Segmentation;

select
  segmentation,
  avg(Age)
from `automobile.train`
group by segmentation
order by segmentation;

WITH tmp AS (
  SELECT
    Segmentation,
    Profession,
    COUNT(*) AS cnt
  FROM `automobile.train`
  GROUP BY Segmentation, Profession
),
ranked AS (
  SELECT
    Segmentation,
    Profession,
    cnt,
    ROW_NUMBER() OVER (
      PARTITION BY Segmentation
      ORDER BY cnt DESC
    ) AS rn
  FROM tmp
)
SELECT
  Segmentation,
  STRING_AGG(Profession ORDER BY cnt DESC LIMIT 3) AS Top3_Professions
FROM ranked
WHERE rn <= 3
GROUP BY Segmentation
ORDER BY Segmentation;

SELECT
  Segmentation,
  CONCAT(
    ROUND(COUNT(CASE WHEN Spending_Score = 'Low' THEN 1 END) * 100.0 / COUNT(*)), ':',
    ROUND(COUNT(CASE WHEN Spending_Score = 'Average' THEN 1 END) * 100.0 / COUNT(*)), ':',
    ROUND(COUNT(CASE WHEN Spending_Score = 'High' THEN 1 END) * 100.0 / COUNT(*))
  ) AS SpendingScoreRatio
FROM `automobile.train`
GROUP BY Segmentation
ORDER BY Segmentation;

SELECT
  Segmentation,
  ROUND(AVG(Family_Size), 1) AS AvgFamilySize
FROM `automobile.train`
GROUP BY Segmentation
ORDER BY Segmentation;















WITH AvgAge AS (
  SELECT
    Segmentation,
    ROUND(AVG(Age), 2) AS AvgAge
  FROM `automobile.train`
  GROUP BY Segmentation
),

MarriedRatio AS (
  SELECT
    Segmentation,
    CONCAT(ROUND(COUNT(CASE WHEN Ever_Married = TRUE THEN 1 END) 
      * 100.0 / COUNT(*)), '%') AS MarriedRatio
  FROM `automobile.train`
  GROUP BY Segmentation
),

ProfTmp AS (
  SELECT
    Segmentation,
    Profession,
    COUNT(*) AS cnt
  FROM `automobile.train`
  GROUP BY Segmentation, Profession
),

ProfRanked AS (
  SELECT
    Segmentation,
    Profession,
    cnt,
    ROW_NUMBER() OVER (
      PARTITION BY Segmentation
      ORDER BY cnt DESC
    ) AS rn
  FROM ProfTmp
),

Top3Profession AS (
  SELECT
    Segmentation,
    STRING_AGG(Profession ORDER BY cnt DESC LIMIT 3) AS Top3Profession
  FROM ProfRanked
  WHERE rn <= 3
  GROUP BY Segmentation
),

SpendRatio AS (
  SELECT
    Segmentation,
    CONCAT(
      ROUND(COUNT(CASE WHEN Spending_Score = 'Low' THEN 1 END) 
        * 100.0 / COUNT(*)), ':',
      ROUND(COUNT(CASE WHEN Spending_Score = 'Average' THEN 1 END) 
        * 100.0 / COUNT(*)), ':',
      ROUND(COUNT(CASE WHEN Spending_Score = 'High' THEN 1 END) 
        * 100.0 / COUNT(*))
    ) AS SpendingScoreRatio
  FROM `automobile.train`
  GROUP BY Segmentation
),

FamilySize AS (
  SELECT
    Segmentation,
    ROUND(AVG(Family_Size), 2) AS AvgFamilySize
  FROM `automobile.train`
  GROUP BY Segmentation
)

SELECT 
  A.Segmentation,
  A.AvgAge,
  M.MarriedRatio,
  T.Top3Profession,
  S.SpendingScoreRatio,
  F.AvgFamilySize
FROM AvgAge A
JOIN MarriedRatio M USING (Segmentation)
JOIN Top3Profession T USING (Segmentation)
JOIN SpendRatio S USING (Segmentation)
JOIN FamilySize F USING (Segmentation)
ORDER BY Segmentation;
















WITH base AS (
  SELECT 
    Segmentation,
    Age,
    CASE WHEN Ever_Married = true THEN 1 ELSE 0 END AS IsMarried,
    Spending_Score,
    Profession,
    Family_Size
  FROM `automobile.train`
),

-- 평균 나이
avg_age AS (
  SELECT 
    Segmentation,
    ROUND(AVG(Age), 0) AS AvgAge
  FROM base
  GROUP BY Segmentation
),

-- 결혼 비율 %
married_ratio AS (
  SELECT
    Segmentation,
    ROUND(COUNT(CASE WHEN IsMarried = 1 THEN 1 END) * 100.0 / COUNT(*), 1) AS MarriedPct
  FROM base
  GROUP BY Segmentation
),

-- 소비점수 비율 Low:Avg:High
spend_ratio AS (
  SELECT
    Segmentation,
    CONCAT(
      ROUND(COUNT(CASE WHEN Spending_Score = 'Low' THEN 1 END) * 100.0 / COUNT(*)), ':',
      ROUND(COUNT(CASE WHEN Spending_Score = 'Average' THEN 1 END) * 100.0 / COUNT(*)), ':',
      ROUND(COUNT(CASE WHEN Spending_Score = 'High' THEN 1 END) * 100.0 / COUNT(*))
    ) AS ScoreRatio
  FROM base
  GROUP BY Segmentation
),

-- 직업 Top3
prof_cnt AS (
  SELECT 
    Segmentation,
    Profession,
    COUNT(*) AS cnt
  FROM base
  GROUP BY Segmentation, Profession
),
prof_rank AS (
  SELECT
    Segmentation,
    Profession,
    cnt,
    ROW_NUMBER() OVER (PARTITION BY Segmentation ORDER BY cnt DESC) AS rn
  FROM prof_cnt
),
top3_prof AS (
  SELECT
    Segmentation,
    STRING_AGG(Profession ORDER BY cnt DESC LIMIT 3) AS Top3Prof
  FROM prof_rank
  WHERE rn <= 3
  GROUP BY Segmentation
),

-- 평균 가족 크기
fam_size AS (
  SELECT 
    Segmentation,
    ROUND(AVG(Family_Size), 1) AS AvgFamily
  FROM base
  GROUP BY Segmentation
)

-- ⭐ 피벗 출력 (숫자 → STRING 변환)
SELECT
  '결혼 비율' AS Metric,
  CONCAT(m_a.MarriedPct, '%') AS Group_A,
  CONCAT(m_b.MarriedPct, '%') AS Group_B,
  CONCAT(m_c.MarriedPct, '%') AS Group_C,
  CONCAT(m_d.MarriedPct, '%') AS Group_D
FROM married_ratio m_a
JOIN married_ratio m_b ON m_b.Segmentation = 'B'
JOIN married_ratio m_c ON m_c.Segmentation = 'C'
JOIN married_ratio m_d ON m_d.Segmentation = 'D'
WHERE m_a.Segmentation = 'A'

UNION ALL
SELECT
  '평균 나이',
  CAST(a_a.AvgAge AS STRING), 
  CAST(a_b.AvgAge AS STRING), 
  CAST(a_c.AvgAge AS STRING), 
  CAST(a_d.AvgAge AS STRING)
FROM avg_age a_a
JOIN avg_age a_b ON a_b.Segmentation = 'B'
JOIN avg_age a_c ON a_c.Segmentation = 'C'
JOIN avg_age a_d ON a_d.Segmentation = 'D'
WHERE a_a.Segmentation = 'A'

UNION ALL
SELECT
  '소비 점수 비율',
  s_a.ScoreRatio, s_b.ScoreRatio, s_c.ScoreRatio, s_d.ScoreRatio
FROM spend_ratio s_a
JOIN spend_ratio s_b ON s_b.Segmentation = 'B'
JOIN spend_ratio s_c ON s_c.Segmentation = 'C'
JOIN spend_ratio s_d ON s_d.Segmentation = 'D'
WHERE s_a.Segmentation = 'A'

UNION ALL
SELECT
  '직업 Top 3',
  t_a.Top3Prof, t_b.Top3Prof, t_c.Top3Prof, t_d.Top3Prof
FROM top3_prof t_a
JOIN top3_prof t_b ON t_b.Segmentation = 'B'
JOIN top3_prof t_c ON t_c.Segmentation = 'C'
JOIN top3_prof t_d ON t_d.Segmentation = 'D'
WHERE t_a.Segmentation = 'A'

UNION ALL
SELECT
  '평균 가족 크기',
  CAST(f_a.AvgFamily AS STRING), 
  CAST(f_b.AvgFamily AS STRING), 
  CAST(f_c.AvgFamily AS STRING), 
  CAST(f_d.AvgFamily AS STRING)
FROM fam_size f_a
JOIN fam_size f_b ON f_b.Segmentation = 'B'
JOIN fam_size f_c ON f_c.Segmentation = 'C'
JOIN fam_size f_d ON f_d.Segmentation = 'D'
WHERE f_a.Segmentation = 'A';
