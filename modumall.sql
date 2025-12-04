-- 테이블 생성
CREATE OR REPLACE TABLE `modu-480005.modumall.orders` (
   order_id STRING NOT NULL,
   user_id STRING NOT NULL,
   order_timestamp TIMESTAMP
);


-- 테이블 생성
CREATE OR REPLACE TABLE `modu-480005.modumall.payments` (
   order_id STRING NOT NULL,
   value FLOAT64
);


-- 데이터 삽입
INSERT INTO modu-480005.modumall.orders (order_id, user_id, order_timestamp) VALUES
('order_1', 'user_1', TIMESTAMP('2018-01-01 10:00:00')),
('order_2', 'user_2', TIMESTAMP('2018-01-01 12:30:00')),
('order_3', 'user_3', TIMESTAMP('2018-01-02 09:20:00')),
('order_4', 'user_4', TIMESTAMP('2018-01-02 10:15:00')),
('order_5', 'user_5', TIMESTAMP('2018-01-02 14:05:00')),
('order_6', 'user_6', TIMESTAMP('2018-01-03 11:00:00')),
('order_7', 'user_7', TIMESTAMP('2018-01-03 13:45:00')),
('order_8', 'user_8', TIMESTAMP('2018-01-04 15:30:00')),
('order_9', 'user_9', TIMESTAMP('2018-01-04 18:00:00')),
('order_10', 'user_10', TIMESTAMP('2018-01-05 20:30:00')),
('order_11', 'user_11', TIMESTAMP('2018-01-06 09:00:00')),
('order_12', 'user_12', TIMESTAMP('2018-01-06 12:45:00')),
('order_13', 'user_13', TIMESTAMP('2018-01-07 16:20:00')),
('order_14', 'user_14', TIMESTAMP('2018-01-08 17:35:00')),
('order_15', 'user_15', TIMESTAMP('2018-01-09 19:50:00')),
('order_16', 'user_16', TIMESTAMP('2018-01-10 21:15:00')),
('order_17', 'user_17', TIMESTAMP('2018-01-11 22:40:00')),
('order_18', 'user_18', TIMESTAMP('2018-01-12 23:05:00')),
('order_19', 'user_19', TIMESTAMP('2018-01-13 13:15:00')),
('order_20', 'user_20', TIMESTAMP('2018-01-14 14:25:00')),
('order_21', 'user_21', TIMESTAMP('2018-01-15 15:35:00')),
('order_22', 'user_22', TIMESTAMP('2018-01-16 16:45:00')),
('order_23', 'user_23', TIMESTAMP('2018-01-17 17:55:00')),
('order_24', 'user_24', TIMESTAMP('2018-01-18 18:05:00')),
('order_25', 'user_25', TIMESTAMP('2018-01-19 19:15:00')),
('order_26', 'user_26', TIMESTAMP('2018-01-20 20:25:00')),
('order_27', 'user_27', TIMESTAMP('2018-01-21 21:35:00')),
('order_28', 'user_28', TIMESTAMP('2018-01-22 22:45:00')),
('order_29', 'user_29', TIMESTAMP('2018-01-23 23:55:00')),
('order_30', 'user_30', TIMESTAMP('2018-01-24 11:05:00'));


-- 데이터 삽입
INSERT INTO modu-480005.modumall.payments (order_id, value) VALUES
('order_1', 100.00),
('order_2', 150.00),
('order_3', 200.00),
('order_4', 110.00),
('order_5', 120.00),
('order_6', 130.00),
('order_7', 140.00),
('order_8', 210.00),
('order_9', 220.00),
('order_10', 230.00),
('order_11', 240.00),
('order_12', 250.00),
('order_13', 260.00),
('order_14', 270.00),
('order_15', 280.00),
('order_16', 290.00),
('order_17', 300.00),
('order_18', 310.00),
('order_19', 320.00),
('order_20', 330.00),
('order_21', 340.00),
('order_22', 350.00),
('order_23', 360.00),
('order_24', 370.00),
('order_25', 380.00),
('order_26', 390.00),
('order_27', 400.00),
('order_28', 410.00),
('order_29', 420.00),
('order_30', 430.00);

select
   date(o.order_timestamp) as dt,
   sum(p.value) as daily_value
from `modumall.orders` o
join `modumall.payments` p
on o.order_id = p.order_id
group by dt
order by dt;

-- 테이블 생성
CREATE OR REPLACE TABLE `modu-480005.modumall.visits` (
 `log_id` INT64,
 `user_id` INT64,
 `page_url` STRING,
 `timestamp` TIMESTAMP
);


-- 데이터 삽입
INSERT INTO `modu-480005.modumall.visits` (`log_id`, `user_id`, `page_url`, `timestamp`)
VALUES
 (1, 101, 'home', TIMESTAMP '2023-10-31 10:00:00'),
 (2, 102, 'product_detail', TIMESTAMP '2023-10-31 10:15:00'),
 (3, 101, 'cart', TIMESTAMP '2023-10-31 10:30:00'),
 (4, 103, 'home', TIMESTAMP '2023-10-31 11:00:00'),
 (5, 104, 'order', TIMESTAMP '2023-10-31 11:15:00'),
 (6, 102, 'product_detail', TIMESTAMP '2023-10-31 11:30:00'),
 (7, 105, 'product_detail', TIMESTAMP '2023-10-31 12:00:00'),
 (8, 101, 'home', TIMESTAMP '2023-10-31 12:15:00'),
 (9, 102, 'cart', TIMESTAMP '2023-10-31 12:30:00'),
 (10, 104, 'order', TIMESTAMP '2023-10-31 13:00:00');

select
   page_url,
   count(*) as PV
from
   `modumall.visits`
group by
   page_url;

select
   page_url,
   count(distinct user_id) as unique_PV
from
   `modumall.visits`
group by
   page_url;

select
   user_id,
   page_url,
   timestamp,
   lag(timestamp) over (
      partition by user_id, page_url
      order by timestamp
   ) as last_timestamp
from `modumall.visits`;

WITH LAST_SESSION AS (
  SELECT
    user_id,
    page_url,
    timestamp,
    LAG(timestamp) OVER (
      PARTITION BY user_id, page_url
      ORDER BY timestamp
    ) AS last_timestamp
  FROM `modumall.visits`
),

SESSION_DIFF AS (
  SELECT
    user_id,
    page_url,
    timestamp,
    last_timestamp,
    -- 시간 차이 계산 (NULL이면 첫 방문이므로 큰 의미 없음)
    TIMESTAMP_DIFF(timestamp, last_timestamp, MINUTE) AS diff_minute,

    -- 새로운 세션인지 여부 판단
    CASE
      WHEN last_timestamp IS NULL THEN 1  -- 해당 페이지에서 첫 방문
      WHEN TIMESTAMP_DIFF(timestamp, last_timestamp, MINUTE) > 30 THEN 1 -- 30분 초과 → 새로운 방문
      ELSE 0 -- 30분 이내 → 이전 방문과 동일한 세션
    END AS new_visit
  FROM LAST_SESSION
)

SELECT
  page_url,
  SUM(new_visit) AS Visits
FROM SESSION_DIFF
GROUP BY page_url;

select
   page_url,
   count(distinct user_id) as UV
from `modumall.visits`
group by page_url;

CREATE OR REPLACE TABLE `modumall.arpu` (
 user_id INT64,
 purchase_date DATE,
 revenue FLOAT64
);

INSERT INTO `modumall.arpu` (user_id, purchase_date, revenue) VALUES
(1, '2023-01-01', 10.00),
(2, '2023-01-01', 20.00),
(3, '2023-01-01', 0.00),
(1, '2023-01-02', 15.00),
(2, '2023-01-02', 0.00),
(3, '2023-01-02', 5.00),
(4, '2023-01-03', 20.00),
(5, '2023-01-03', 20.00),
(6, '2023-01-03', 0.00),
(1, '2023-01-04', 10.00),
(2, '2023-01-04', 25.00),
(7, '2023-01-04', 15.00),
(8, '2023-01-05', 40.00),
(5, '2023-01-05', 10.00),
(9, '2023-01-05', 0.00),
(10, '2023-01-06', 50.00),
(11, '2023-01-06', 35.00),
(6, '2023-01-06', 20.00),
(12, '2023-01-07', 15.00),
(13, '2023-01-07', 10.00),
(1, '2023-01-08', 5.00),
(14, '2023-01-08', 25.00),
(15, '2023-01-08', 30.00),
(16, '2023-01-09', 45.00),
(17, '2023-01-09', 0.00),
(18, '2023-01-10', 20.00),
(19, '2023-01-10', 35.00),
(20, '2023-01-11', 20.00),
(21, '2023-01-11', 25.00),
(22, '2023-01-12', 15.00);

select
   sum(revenue) / count(distinct user_id) as arpu,
   sum(revenue) / count(distinct if(revenue > 0, user_id, null)) as arppu
from `modumall.arpu`;

-- 테이블 생성 
CREATE TABLE IF NOT EXISTS modumall.funnel (
 user_id INT64,
 action STRING,
 action_date DATE
);
-- 데이터 삽입
INSERT INTO modumall.funnel (user_id, action, action_date) VALUES
(4, 'visit', '2023-01-02'),
(5, 'visit', '2023-01-02'),
(6, 'visit', '2023-01-03'),
(4, 'signup', '2023-01-03'),
(5, 'add_to_cart', '2023-01-04'),
(6, 'purchase', '2023-01-04'),
(7, 'visit', '2023-01-04'),
(7, 'signup', '2023-01-05'),
(7, 'add_to_cart', '2023-01-06'),
(7, 'purchase', '2023-01-07'),
(8, 'visit', '2023-01-07'),
(8, 'signup', '2023-01-08'),
(8, 'add_to_cart', '2023-01-09'),
(9, 'visit', '2023-01-09'),
(9, 'signup', '2023-01-10'),
(10, 'visit', '2023-01-10'),
(10, 'add_to_cart', '2023-01-11'),
(10, 'purchase', '2023-01-12'),
(11, 'visit', '2023-01-12'),
(11, 'signup', '2023-01-13'),
(12, 'visit', '2023-01-13'),
(12, 'add_to_cart', '2023-01-14'),
(13, 'visit', '2023-01-14'),
(13, 'signup', '2023-01-15'),
(13, 'add_to_cart', '2023-01-16'),
(13, 'purchase', '2023-01-17'),
(14, 'visit', '2023-01-17'),
(14, 'signup', '2023-01-18'),
(15, 'visit', '2023-01-18'),
(15, 'signup', '2023-01-19'),
(15, 'add_to_cart', '2023-01-20'),
(15, 'purchase', '2023-01-21'),
(16, 'visit', '2023-01-21'),
(16, 'signup', '2023-01-22'),
(17, 'visit', '2023-01-22'),
(17, 'add_to_cart', '2023-01-23'),
(18, 'visit', '2023-01-23'),
(18, 'signup', '2023-01-24'),
(18, 'add_to_cart', '2023-01-25'),
(18, 'purchase', '2023-01-26'),
(19, 'visit', '2023-01-26'),
(19, 'signup', '2023-01-27'),
(20, 'visit', '2023-01-27'),
(20, 'add_to_cart', '2023-01-28'),
(21, 'visit', '2023-01-28'),
(21, 'signup', '2023-01-29'),
(21, 'add_to_cart', '2023-01-30'),
(21, 'purchase', '2023-01-31');

with funnel_counts as (
   select
      count(distinct case when action = 'visit' then user_id end) as Visits,
      count(distinct case when action = 'signup' then user_id end) as SignUps,
      count(distinct case when action = 'add_to_cart' then user_id end) as AddToCarts,
      count(distinct case when action = 'purchase' then user_id end) as Purchases
   from `modumall.funnel`
)

select
   Visits,
   SignUps,
   AddToCarts,
   Purchases,
   ROUND(signups / visits * 100, 2) as signuprate,
   round(addtocarts / visits * 100, 2) as addtocartrate,
   round(purchases / visits * 100, 2) as purchaserate
from funnel_counts;

-- 테이블 생성
CREATE OR REPLACE TABLE `modumall.retention` (
 user_id INT64,
 invoice_date DATE,
 sales_amount FLOAT64
);
-- 데이터 삽입
INSERT INTO `modumall.retention` (user_id, invoice_date, sales_amount) VALUES
(1, '2023-01-05', 120.00),
(2, '2023-01-15', 200.00),
(1, '2023-01-20', 80.00),
(3, '2023-01-25', 150.00),
(4, '2023-02-01', 100.00),
(2, '2023-02-05', 220.00),
(1, '2023-02-15', 50.00),
(3, '2023-02-18', 130.00),
(5, '2023-02-20', 175.00),
(6, '2023-02-25', 90.00),
(4, '2023-03-01', 110.00),
(5, '2023-03-05', 160.00),
(7, '2023-03-10', 200.00),
(6, '2023-03-15', 85.00),
(8, '2023-03-20', 140.00),
(2, '2023-03-25', 210.00),
(1, '2023-04-01', 95.00),
(9, '2023-04-05', 180.00),
(5, '2023-04-10', 155.00),
(10, '2023-04-15', 200.00),
(4, '2023-04-20', 120.00),
(7, '2023-04-25', 190.00),
(3, '2023-05-01', 140.00),
(11, '2023-05-05', 220.00),
(6, '2023-05-10', 75.00),
(8, '2023-05-15', 130.00),
(12, '2023-05-20', 165.00),
(9, '2023-05-25', 180.00),
(13, '2023-06-01', 150.00),
(10, '2023-06-05', 190.00);

-- WITH first_purchase AS (
--   SELECT
--     user_id,
--     DATE_TRUNC(MIN(invoice_date), MONTH) AS cohort_group
--   FROM `modumall.retention`
--   GROUP BY user_id
-- ),
-- purchases AS (
--   SELECT
--     r.user_id,
--     DATE_TRUNC(r.invoice_date, MONTH) AS purchase_month,
--     f.cohort_group,
--     DATE_DIFF(DATE_TRUNC(r.invoice_date, MONTH), f.cohort_group, MONTH) AS cohort_index
--   FROM `modumall.retention` r
--   JOIN first_purchase f
--     ON r.user_id = f.user_id
-- ),
-- base AS (
--   SELECT
--     cohort_group,
--     cohort_index,
--     COUNT(DISTINCT user_id) AS user_count
--   FROM purchases
--   GROUP BY cohort_group, cohort_index
-- )
-- SELECT *
-- FROM base
-- PIVOT (
--   SUM(user_count) FOR cohort_index IN (0, 1, 2, 3, 4)
-- )
-- ORDER BY cohort_group;

WITH cohort AS (
  SELECT
    user_id,
    MIN(invoice_date) AS cohort_day
  FROM `modumall.retention`
  GROUP BY user_id
),

cohort_detail AS (
  SELECT
    r.user_id,
    DATE_TRUNC(c.cohort_day, MONTH) AS cohort_group,
    DATE_DIFF(DATE(r.invoice_date), c.cohort_day, MONTH) AS cohort_index
  FROM `modumall.retention` r
  JOIN cohort c
    ON r.user_id = c.user_id
)

SELECT
  cohort_group,
  cohort_index,
  COUNT(DISTINCT user_id) AS user_count
FROM cohort_detail
GROUP BY cohort_group, cohort_index
ORDER BY cohort_group, cohort_index;

-- 테이블 생성
CREATE OR REPLACE TABLE `modumall.rfm` (
 user_id STRING,
 order_date TIMESTAMP,
 order_value FLOAT64
);

-- 데이터 삽입
INSERT INTO `modumall.rfm` (user_id, order_date, order_value) VALUES
('C001', TIMESTAMP('2023-01-01 10:00:00'), 200.0),
('C002', TIMESTAMP('2023-01-02 12:30:00'), 300.0),
('C001', TIMESTAMP('2023-01-03 15:20:00'), 450.0),
('C001', TIMESTAMP('2023-01-04 11:00:00'), 230.0),
('C002', TIMESTAMP('2023-01-05 13:45:00'), 120.0),
('C002', TIMESTAMP('2023-01-06 14:30:00'), 350.0),
('C005', TIMESTAMP('2023-01-07 16:00:00'), 280.0),
('C002', TIMESTAMP('2023-01-08 17:30:00'), 500.0),
('C001', TIMESTAMP('2023-01-09 18:20:00'), 150.0),
('C005', TIMESTAMP('2023-01-10 19:00:00'), 190.0),
('C006', TIMESTAMP('2023-01-11 20:30:00'), 320.0),
('C008', TIMESTAMP('2023-01-12 21:45:00'), 310.0),
('C006', TIMESTAMP('2023-01-13 22:10:00'), 430.0),
('C007', TIMESTAMP('2023-01-14 23:00:00'), 210.0),
('C008', TIMESTAMP('2023-01-15 08:30:00'), 110.0),
('C009', TIMESTAMP('2023-02-01 09:40:00'), 250.0),
('C010', TIMESTAMP('2023-02-02 10:50:00'), 290.0),
('C008', TIMESTAMP('2023-02-03 11:55:00'), 390.0),
('C009', TIMESTAMP('2023-02-04 12:05:00'), 310.0),
('C010', TIMESTAMP('2023-02-05 13:15:00'), 130.0),
('C009', TIMESTAMP('2023-02-06 14:25:00'), 220.0),
('C007', TIMESTAMP('2023-02-07 15:35:00'), 330.0),
('C003', TIMESTAMP('2023-02-08 16:45:00'), 340.0),
('C001', TIMESTAMP('2023-02-09 17:55:00'), 360.0),
('C010', TIMESTAMP('2023-02-10 18:00:00'), 370.0),
('C009', TIMESTAMP('2023-02-11 19:05:00'), 380.0),
('C002', TIMESTAMP('2023-02-12 20:10:00'), 400.0),
('C004', TIMESTAMP('2023-02-13 21:15:00'), 410.0),
('C007', TIMESTAMP('2023-02-14 22:20:00'), 420.0),
('C010', TIMESTAMP('2023-02-15 23:25:00'), 440.0);

WITH RFM AS (
  -- 1단계: Recency, Frequency, Monetary 계산
  SELECT
    user_id,
    DATE_DIFF(CURRENT_DATE(), DATE(MAX(order_date)), DAY) AS Recency,
    COUNT(*) AS Frequency,
    SUM(order_value) AS Monetary
  FROM `modumall.rfm`
  GROUP BY user_id
),

RFMScores AS (
  -- 2단계: R, F, M 점수화
  SELECT
    user_id,
    Recency,
    Frequency,
    Monetary,

    NTILE(5) OVER (ORDER BY Recency DESC) AS RecencyScore,
    NTILE(5) OVER (ORDER BY Frequency ASC) AS FrequencyScore,
    NTILE(5) OVER (ORDER BY Monetary ASC) AS MonetaryScore
  FROM RFM
)

-- 3단계: RFMScore 컬럼 추가
SELECT
  user_id,
  Recency,
  Frequency,
  Monetary,
  RecencyScore,
  FrequencyScore,
  MonetaryScore,
  (RecencyScore + FrequencyScore + MonetaryScore) AS RFMScore
FROM RFMScores
ORDER BY user_id;

select *
from `modulabs_project.data`
limit 10;

select count(*)
from `modulabs_project.data`;

select
   count(InvoiceNo),
   count(StockCode),
   count(Description),
   count(Quantity),
   count(InvoiceDate),
   count(UnitPrice),
   count(CustomerID),
   count(Country)
from `modulabs_project.data`;

SELECT
    'InvoiceNo' AS column_name,
    ROUND(SUM(CASE WHEN InvoiceNo IS NULL THEN 1 ELSE 0 END) / COUNT(*) * 100, 2) AS missing_percentage
FROM `modulabs_project.data`

UNION ALL
SELECT
    'StockCode',
    ROUND(SUM(CASE WHEN StockCode IS NULL THEN 1 ELSE 0 END) / COUNT(*) * 100, 2)
FROM `modulabs_project.data`

UNION ALL
SELECT
    'Description',
    ROUND(SUM(CASE WHEN Description IS NULL THEN 1 ELSE 0 END) / COUNT(*) * 100, 2)
FROM `modulabs_project.data`

UNION ALL
SELECT
    'Quantity',
    ROUND(SUM(CASE WHEN Quantity IS NULL THEN 1 ELSE 0 END) / COUNT(*) * 100, 2)
FROM `modulabs_project.data`

UNION ALL
SELECT
    'InvoiceDate',
    ROUND(SUM(CASE WHEN InvoiceDate IS NULL THEN 1 ELSE 0 END) / COUNT(*) * 100, 2)
FROM `modulabs_project.data`

UNION ALL
SELECT
    'UnitPrice',
    ROUND(SUM(CASE WHEN UnitPrice IS NULL THEN 1 ELSE 0 END) / COUNT(*) * 100, 2)
FROM `modulabs_project.data`

UNION ALL
SELECT
    'CustomerID',
    ROUND(SUM(CASE WHEN CustomerID IS NULL THEN 1 ELSE 0 END) / COUNT(*) * 100, 2)
FROM `modulabs_project.data`

UNION ALL
SELECT
    'Country',
    ROUND(SUM(CASE WHEN Country IS NULL THEN 1 ELSE 0 END) / COUNT(*) * 100, 2)
FROM `modulabs_project.data`;

SELECT distinct description
FROM `modulabs_project.data`
where stockcode = '85123A';

delete from `modulabs_project.data`
where customerid is null or description is null;

SELECT 
    SUM(cnt - 1) AS duplicated_rows
FROM (
    SELECT 
        InvoiceNo,
        StockCode,
        Description,
        Quantity,
        InvoiceDate,
        UnitPrice,
        CustomerID,
        Country,
        COUNT(*) AS cnt
    FROM `modulabs_project.data`
    GROUP BY
        InvoiceNo,
        StockCode,
        Description,
        Quantity,
        InvoiceDate,
        UnitPrice,
        CustomerID,
        Country
    HAVING cnt > 1
);

SELECT 
    InvoiceNo,
    StockCode,
    Description,
    Quantity,
    InvoiceDate,
    UnitPrice,
    CustomerID,
    Country,
    COUNT(*) AS cnt
FROM `modulabs_project.data`
GROUP BY
    InvoiceNo,
    StockCode,
    Description,
    Quantity,
    InvoiceDate,
    UnitPrice,
    CustomerID,
    Country
HAVING cnt > 1
ORDER BY cnt DESC;

create or replace table `modulabs_project.data` as
select distinct *
from `modulabs_project.data`;

SELECT
  (SELECT COUNT(*) FROM `modulabs_project.data_backup`) AS before_cnt,
  (SELECT COUNT(*) FROM `modulabs_project.data`) AS after_cnt;

select
   count(distinct invoiceno)
from `modulabs_project.data`;

select distinct invoiceno
from `modulabs_project.data`
limit 100;

select *
from `modulabs_project.data`
where invoiceno like 'C%'
limit 100;

select
   round(
      sum(case when invoiceno like 'C%' then 1 else 0 end)
      / count(*)
      * 100,
   1)
from `modulabs_project.data`;

select count(distinct stockcode)
from `modulabs_project.data`;

select
   stockcode,
   count(*) as sell_cnt
from `modulabs_project.data`
group by StockCode
order by sell_cnt desc
limit 10;

with UniqueStockCodes as (
   select distinct StockCode
   from `modulabs_project.data`
)
select
   length(stockcode) - length(regexp_replace(stockcode, r'[0-9]', '')) as number_count,
   count(*) as stock_cnt
from uniquestockcodes
group by number_count
order by stock_cnt desc;

select distinct stockcode, number_count
from (
   select
      stockcode,
      length(stockcode)
         - length(regexp_replace(stockcode, r'[0-9]', '')) as number_count
   from `modulabs_project.data`
)
where number_count <= 1
order by number_count;

with StockCodeCounts as (
   select
      stockcode,
      length(stockcode)
         - length(regexp_replace(stockcode, r'[0-9]', '')) as number_count
   from `modulabs_project.data`
)
select
   round(
      (select count(*) from stockcodecounts where number_count <= 1)
      /
      (select count(*) from stockcodecounts)
      * 100,
      2
   );

delete from `modulabs_project.data`
where stockcode in (
   select distinct stockcode
   from (
      select
         stockcode,
         length(stockcode)
            - length(regexp_replace(stockcode, r'[0-9]', '')) as number_count
      from `modulabs_project.data`
   )
   where number_count <= 1
);

select
   description,
   count(*) as description_cnt
from
   `modulabs_project.data`
group by
   description
order by
   description_cnt desc
limit 30;

select distinct description
from `modulabs_project.data`
where regexp_contains(description, r'[a-z]');

delete
from `modulabs_project.data`
where description in (
   'High Resolution Image',
   'Next Day Carriage'
);

create or replace table `modulabs_project.data` as
select
   * except(description),
   upper(description) as Description
from `modulabs_project.data`;

select
   min(unitprice) as min_price,
   max(unitprice) as max_price,
   avg(unitprice) as avg_price
from `modulabs_project.data`;

select
   count(*) as cnt_quantity,
   min(quantity) as min_quantity,
   max(quantity) as max_quantity,
   avg(quantity) as avg_quantity
from `modulabs_project.data`
where unitprice = 0;

create or replace table `modulabs_project.data` as
select *
from `modulabs_project.data`
where unitprice > 0;

select
   count(*) as cnt_quantity
from `modulabs_project.data`
where unitprice = 0;

select
   date(invoicedate) as invoiceday,
   *
from `modulabs_project.data`;

SELECT
  (SELECT MAX(DATE(InvoiceDate)) FROM `modulabs_project.data`) AS most_recent_date,
  DATE(InvoiceDate) AS InvoiceDay,
  *
FROM `modulabs_project.data`;

select
   customerid,
   max(date(invoicedate)) as invoiceday
from `modulabs_project.data`
group by customerid;

SELECT
  CustomerID, 
  EXTRACT(DAY FROM MAX(InvoiceDay) OVER () - InvoiceDay) AS recency
FROM (
  SELECT 
    CustomerID,
    MAX(DATE(InvoiceDate)) AS InvoiceDay
  FROM `modulabs_project.data`
  GROUP BY CustomerID
);

create or replace table `modulabs_project.user_r` as
SELECT
  CustomerID, 
  EXTRACT(DAY FROM MAX(InvoiceDay) OVER () - InvoiceDay) AS recency
FROM (
  SELECT 
    CustomerID,
    MAX(DATE(InvoiceDate)) AS InvoiceDay
  FROM `modulabs_project.data`
  GROUP BY CustomerID
);

select
   customerid,
   count(distinct invoiceno) as purchase_cnt
from `modulabs_project.data`
group by customerid;

select
   customerid,
   sum(quantity) as item_cnt
from `modulabs_project.data`
group by customerid;

create or replace table `modulabs_project.user_rf` as
with purchase_cnt as (
   select
      customerid,
      count(distinct invoiceno) as purchase_cnt
   from `modulabs_project.data`
   group by customerid
),
item_cnt as (
   select
      customerid,
      sum(quantity) as item_cnt
   from `modulabs_project.data`
   group by customerid
)

select
   pc.customerid,
   pc.purchase_cnt,
   ic.item_cnt,
   ur.recency
from purchase_cnt as pc
join item_cnt as ic
  on pc.customerid = ic.customerid
join `modulabs_project.user_r` as ur
  on pc.customerid = ur.customerid;   

select
   customerid,
   round(sum(quantity * unitprice), 1) as user_total
from `modulabs_project.data`
group by customerid;

create or replace table `modulabs_project.user_rfm` as
select
   rf.customerid as CustomerID,
   rf.purchase_cnt,
   rf.item_cnt,
   rf.recency,
   ut.user_total,
   round(ut.user_total / rf.purchase_cnt, 0) as user_average
from `modulabs_project.user_rf` rf
left join (
   select
      customerid,
      round(sum(quantity * unitprice), 0) as user_total
   from `modulabs_project.data`
   group by customerid
) ut
on rf.customerid = ut.customerid;

select *
from `modulabs_project.user_rfm`;

create or replace table modu-480005.modulabs_project.user_data as
with unique_products as (
   select
      customerID,
      count(distinct stockcode) as unique_products
   from `modulabs_project.data`
   group by customerid
)
select ur.*, up.* except (customerid)
from `modulabs_project.user_rfm` as ur
join unique_products as up
on ur.CustomerID = up.customerid;

CREATE OR REPLACE TABLE modulabs_project.user_data AS 
WITH purchase_intervals AS (
  -- (2) 고객 별 구매와 구매 사이의 평균 소요 일수
  SELECT
    CustomerID,
    CASE WHEN ROUND(AVG(interval_), 2) IS NULL THEN 0 ELSE ROUND(AVG(interval_), 2) END AS average_interval
  FROM (
    -- (1) 구매와 구매 사이에 소요된 일수
    SELECT
      CustomerID,
      DATE_DIFF(InvoiceDate, LAG(InvoiceDate) OVER (PARTITION BY CustomerID ORDER BY InvoiceDate), DAY) AS interval_
    FROM
      modulabs_project.data
    WHERE CustomerID IS NOT NULL
  )
  GROUP BY CustomerID
);

CREATE OR REPLACE TABLE modulabs_project.user_data AS

WITH TransactionInfo AS (
  SELECT
    CustomerID,
    COUNT(*) AS total_transactions,                      -- 전체 거래 수
    SUM(CASE WHEN LEFT(InvoiceNo, 1) = 'C' THEN 1 ELSE 0 END) AS cancel_frequency  -- 취소 횟수
  FROM modulabs_project.data
  WHERE CustomerID IS NOT NULL
  GROUP BY CustomerID
)

SELECT 
  u.*,                                   -- 기존 user_data(average_interval 포함)
  t.total_transactions,
  t.cancel_frequency,
  ROUND(SAFE_DIVIDE(t.cancel_frequency, t.total_transactions), 2) AS cancel_rate
FROM modulabs_project.user_data AS u
LEFT JOIN TransactionInfo AS t
ON u.CustomerID = t.CustomerID;

CREATE OR REPLACE TABLE modulabs_project.user_data AS

WITH TransactionInfo AS (
  SELECT
    CustomerID,
    COUNT(DISTINCT InvoiceNo) AS total_transactions,  
    SUM(CASE WHEN LEFT(InvoiceNo, 1) = 'C' THEN 1 ELSE 0 END) AS cancel_frequency
  FROM modulabs_project.data
  WHERE CustomerID IS NOT NULL
  GROUP BY CustomerID
)

SELECT 
  u.*,
  t.total_transactions,
  t.cancel_frequency,
  ROUND(SAFE_DIVIDE(t.cancel_frequency, t.total_transactions), 2) AS cancel_rate
FROM modulabs_project.user_data AS u
LEFT JOIN TransactionInfo AS t
ON u.CustomerID = t.CustomerID;

SELECT *
FROM `modulabs_project.user_data`;