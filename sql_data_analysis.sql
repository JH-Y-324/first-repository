-- 2. 회사의 일별 매출액 구하기
-- 문제 상황
-- 모두몰은 이제 막 성장하는 인터넷 쇼핑몰이므로 매일 쇼핑몰 사이트에 유입자가 얼마나 들어오는지, 매일 매출액이 얼마나 되는지 등을 파악하는 것이 중요합니다.

-- 테이블 생성
CREATE OR REPLACE TABLE `project-a0c0a4c1-844b-45a2-beb.modulabs.orders` (
   order_id STRING NOT NULL,
   user_id STRING NOT NULL,
   order_timestamp TIMESTAMP
);

-- 테이블 생성
CREATE OR REPLACE TABLE `project-a0c0a4c1-844b-45a2-beb.modulabs.payments` (
   order_id STRING NOT NULL,
   value FLOAT64
);

-- 데이터 삽입
INSERT INTO `project-a0c0a4c1-844b-45a2-beb.modulabs.orders` (order_id, user_id, order_timestamp) VALUES
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
INSERT INTO `project-a0c0a4c1-844b-45a2-beb.modulabs.payments` (order_id, value) VALUES
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



-- 문제 해결
-- 주문이 일어난 시점에 대한 정보를 기록한 orders와 주문별 결제 금액을 기록한 payments 테이블을 활용하여, 모두몰의 일별 매출액 총합을 구해주세요.



SELECT
  DATE(o.order_timestamp) AS dt,  -- timestamp → 날짜만 추출
  SUM(p.value) AS total_revenue   -- 매출 합계
FROM `project-a0c0a4c1-844b-45a2-beb.modulabs.orders` o
JOIN `project-a0c0a4c1-844b-45a2-beb.modulabs.payments` p
  ON o.order_id = p.order_id
GROUP BY dt
ORDER BY dt;



-- 문제 상황
-- 여러분은 유저가 방문한 모두몰 페이지의 정보를 바탕으로 PV, UV를 계산해야 합니다.

-- 유저가 조회한 페이지 정보를 기록한 visits 테이블을 활용하여 PV, Unique PV, Visits, UV를 계산해 주세요.



-- 테이블 생성
CREATE OR REPLACE TABLE `project-a0c0a4c1-844b-45a2-beb.modulabs.visits` (
 `log_id` INT64,
 `user_id` INT64,
 `page_url` STRING,
 `timestamp` TIMESTAMP
);

-- 데이터 삽입
INSERT INTO `project-a0c0a4c1-844b-45a2-beb.modulabs.visits` (`log_id`, `user_id`, `page_url`, `timestamp`)
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



-- 1. 페이지별 PV를 구해주세요.



SELECT
  page_url,
  COUNT(*) AS PV
FROM `project-a0c0a4c1-844b-45a2-beb.modulabs.visits`
GROUP BY page_url;



-- 2. 페이지 별 Unique PV를 구해주세요.



SELECT
  page_url,
  COUNT(DISTINCT user_id) AS unique_pv
FROM `project-a0c0a4c1-844b-45a2-beb.modulabs.visits`
GROUP BY page_url
ORDER BY unique_pv DESC;



-- 3. 페이지별 Visits를 구해주세요.
-- 모두몰에서 정한 세션 단위는 30분입니다.


-- 1. Visits는 특정 '세션'을 기준으로 동일 세션 내 방문인지 판단합니다. 그러므로 각 로그 행마다 '직전 세션'이 언제 일어났는지에 대한 값과 현재 시간을 비교해주어야 합니다. LAG 함수를 활용하여 last_timestamp라는 이름의 컬럼에 "각 유저가 특정 페이지에 대하여 남긴 로그"의 직전 timestamp를 구해주세요.


SELECT
  *,
  -- 같은 유저 내에서 시간 순으로 정렬 후
  -- 바로 이전 방문 시간 가져오기
  LAG(timestamp) OVER (
    PARTITION BY user_id 
    ORDER BY timestamp
  ) AS last_timestamp
FROM `project-a0c0a4c1-844b-45a2-beb.modulabs.visits`;



-- 2. 위에서 구한 결과를 LAST_SESSION이라는 이름의 임시 테이블로 명시해주세요.



WITH LAST_SESSION AS (
  SELECT
    *,
    -- 각 유저별 이전 방문 시간
    LAG(timestamp) OVER (
      PARTITION BY user_id
      ORDER BY timestamp
    ) AS last_timestamp
  FROM `project-a0c0a4c1-844b-45a2-beb.modulabs.visits`
)

SELECT *
FROM LAST_SESSION;



-- 3. SESSION_DIFF라는 이름의 임시 테이블을 생성하여 timestamp 값과 last_timestamp 사이의 시간 차이를 계산해주세요. 시간차가 30분을 초과한 경우는 별도의 방문으로 집계하고, 시간차가 30분 이내인 경우는 동일 방문으로 집계하도록 쿼리문을 작성해주세요.

-- SQL에서 TIMESTAMP_DIFF 함수는 두 컬럼의 시간차를 계산해주는 함수입니다. 예를 들어 TIMESTAMP_DIFF(timestamp, last_timestamp, MINUTE)를 작성한다면, timestamp와 last_timestamp의 시간차를 분 단위(MINUTE)으로 계산한 것입니다.



WITH LAST_SESSION AS (
  SELECT
    *,
    -- 이전 timestamp
    LAG(timestamp) OVER (
      PARTITION BY user_id
      ORDER BY timestamp
    ) AS last_timestamp
  FROM `project-a0c0a4c1-844b-45a2-beb.modulabs.visits`
),

SESSION_DIFF AS (
  SELECT
    *,
    -- 시간 차이 (분 단위)
    TIMESTAMP_DIFF(timestamp, last_timestamp, MINUTE) AS diff_min,

    -- 30분 기준으로 세션 구분
    CASE
      WHEN last_timestamp IS NULL THEN 1
      WHEN TIMESTAMP_DIFF(timestamp, last_timestamp, MINUTE) > 30 THEN 1
      ELSE 0
    END AS new_session_flag
  FROM LAST_SESSION
)

SELECT *
FROM SESSION_DIFF;


-- 3. 페이지별 Visits를 구해주세요.
-- 모두몰에서 정한 세션 단위는 30분입니다.

-- 아래와 같이 결과가 나와야 합니다.


WITH LAST_SESSION AS (
  SELECT
    *,
    LAG(timestamp) OVER (
      PARTITION BY user_id
      ORDER BY timestamp
    ) AS last_timestamp
  FROM `project-a0c0a4c1-844b-45a2-beb.modulabs.visits`
),

SESSION_DIFF AS (
  SELECT
    *,
    CASE
      WHEN last_timestamp IS NULL THEN 1
      WHEN TIMESTAMP_DIFF(timestamp, last_timestamp, MINUTE) > 30 THEN 1
      ELSE 0
    END AS new_session_flag
  FROM LAST_SESSION
),

SESSIONIZED AS (
  SELECT
    *,
    SUM(new_session_flag) OVER (
      PARTITION BY user_id
      ORDER BY timestamp
    ) AS session_id
  FROM SESSION_DIFF
)

SELECT
  page_url,
  COUNT(DISTINCT CONCAT(CAST(user_id AS STRING), '-', CAST(session_id AS STRING))) AS visits
FROM SESSIONIZED
GROUP BY page_url;


-- 4. 페이지별 Unique Visitors를 구해주세요.


SELECT
  page_url,
  COUNT(DISTINCT user_id) AS UV
FROM `project-a0c0a4c1-844b-45a2-beb.modulabs.visits`
GROUP BY page_url;



-- 4. ARPU와 ARPPU 구하기
-- 문제 상황
-- 유저들의 구매 정보를 기록한 arpu 테이블을 활용하여 ARPU, ARPPU를 계산해 봅시다. 각 지표의 개념에 유의하여 쿼리문을 작성해주세요.



CREATE OR REPLACE TABLE `project-a0c0a4c1-844b-45a2-beb.modulabs.arpu` (
 user_id INT64,
 purchase_date DATE,
 revenue FLOAT64
);

INSERT INTO `project-a0c0a4c1-844b-45a2-beb.modulabs.arpu` (user_id, purchase_date, revenue) VALUES
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



-- 문제 해결
-- 사용자당 평균 수익인 ARPU와 유료 결제 사용자당 평균 수익인 ARPPU를 각각 구해주세요.



SELECT
  SUM(revenue) / COUNT(DISTINCT user_id) AS ARPU,
  SUM(revenue) / COUNT(DISTINCT CASE WHEN revenue > 0 THEN user_id END) AS ARPPU
FROM `project-a0c0a4c1-844b-45a2-beb.modulabs.arpu`;



-- 5. 퍼널 분석: 사람들은 어디에서 이탈하고 있을까?
-- 문제 상황
-- 유저들의 액션 로그 정보를 기록한 funnel 테이블을 활용하여  퍼널 분석을 해봅시다.

-- 각 페이지 단위의 방문 수와 visits 수를 모수로 한 페이지 단위의 전환율을 계산해 주세요.



-- 테이블 생성 
CREATE TABLE IF NOT EXISTS `project-a0c0a4c1-844b-45a2-beb.modulabs.funnel` (
 user_id INT64,
 action STRING,
 action_date DATE
);

-- 데이터 삽입
INSERT INTO `project-a0c0a4c1-844b-45a2-beb.modulabs.funnel` (user_id, action, action_date) VALUES
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



WITH base AS (
  SELECT DISTINCT user_id, action
  FROM `project-a0c0a4c1-844b-45a2-beb.modulabs.funnel`
),

agg AS (
  SELECT
    COUNT(DISTINCT IF(action = 'visit', user_id, NULL)) AS visits,
    COUNT(DISTINCT IF(action = 'signup', user_id, NULL)) AS signups,
    COUNT(DISTINCT IF(action = 'add_to_cart', user_id, NULL)) AS add_to_carts,
    COUNT(DISTINCT IF(action = 'purchase', user_id, NULL)) AS purchases
  FROM base
)

SELECT
  visits,
  signups,
  add_to_carts AS add_to_carts,
  purchases,
  ROUND(signups / visits * 100, 2) AS sign_up_rate,
  ROUND(add_to_carts / visits * 100, 2) AS add_to_cart_rate,
  ROUND(purchases / visits * 100, 2) AS purchase_rate
FROM agg;



-- 6. 리텐션 분석: 내가 VIP가 될 상인가?
-- 문제 상황
-- 유저들의 구매 정보를 기록한 retention 테이블을 활용하여 리텐션 분석을 해 봅시다.

-- 모두몰은 제품의 사용 주기가 긴 영양제를 주력 상품으로 밀고 있기 때문에 월별 리텐션을 구해야 합니다.



-- 테이블 생성
CREATE OR REPLACE TABLE `project-a0c0a4c1-844b-45a2-beb.modulabs.retention` (
 user_id INT64,
 invoice_date DATE,
 sales_amount FLOAT64
);

-- 데이터 삽입
INSERT INTO `project-a0c0a4c1-844b-45a2-beb.modulabs.retention` (user_id, invoice_date, sales_amount) VALUES
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



-- 문제 해결
-- 여러분은 모두몰의 월별 리텐션을 구해야 합니다.

-- 리텐션은 쿼리문으로 cohort_group, cohort_index, user_count을 구한 후, 구글 시트를 통해 피봇 테이블을 만들어 계산할 수 있습니다.

-- cohort(코호트)는 동일한 특성을 공유하는 사람들의 집단을 의미합니다. 따라서 cohort_group는 같은 시기에 웹 사이트에 가입 또는 제품을 사용한 사용자들의 집단이고, cohort_index는 기간을 의미할 것입니다.



WITH base AS (
  SELECT
    user_id,
    DATE_TRUNC(invoice_date, MONTH) AS order_month
  FROM `project-a0c0a4c1-844b-45a2-beb.modulabs.retention`
),

first_purchase AS (
  SELECT
    user_id,
    MIN(order_month) AS cohort_group
  FROM base
  GROUP BY user_id
),

cohort_data AS (
  SELECT
    b.user_id,
    f.cohort_group,
    b.order_month,
    DATE_DIFF(b.order_month, f.cohort_group, MONTH) AS cohort_index
  FROM base b
  JOIN first_purchase f
  ON b.user_id = f.user_id
)

SELECT
  cohort_group,
  cohort_index,
  COUNT(DISTINCT user_id) AS user_count
FROM cohort_data
GROUP BY cohort_group, cohort_index
ORDER BY cohort_group, cohort_index;






WITH base AS (
  SELECT
    user_id,
    invoice_date,
    sales_amount,
    MIN(invoice_date) OVER (PARTITION BY user_id) AS cohort_day
  FROM `project-a0c0a4c1-844b-45a2-beb.modulabs.retention`
),

cohort_calc AS (
  SELECT
    user_id,
    DATE_TRUNC(cohort_day, MONTH) AS cohort_group,
    DATE_DIFF(
      DATE(invoice_date),
      cohort_day,
      MONTH
    ) AS cohort_index
  FROM base
)

SELECT
  cohort_group,
  cohort_index,
  COUNT(DISTINCT user_id) AS user_count
FROM cohort_calc
GROUP BY cohort_group, cohort_index
ORDER BY cohort_group, cohort_index;



-- 7. RFM 분석
-- 문제 상황
-- 유저들의 구매 정보를 기록한 rfm 테이블을 활용하여 RFM 세그먼테이션을 분석해 봅시다.

-- Recency, Frequency, Monetary를 계산하고, 1점에서 5점까지의 척도로 각각 점수를 매긴 후 RFMScore를 구해 주세요.



-- 테이블 생성
CREATE OR REPLACE TABLE `project-a0c0a4c1-844b-45a2-beb.modulabs.rfm` (
 user_id STRING,
 order_date TIMESTAMP,
 order_value FLOAT64
);

-- 데이터 삽입
INSERT INTO `project-a0c0a4c1-844b-45a2-beb.modulabs.rfm` (user_id, order_date, order_value) VALUES
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
  SELECT
    user_id,

    -- Recency
    DATE_DIFF(
      CURRENT_DATE(),
      DATE(MAX(order_date)),
      DAY
    ) AS Recency,

    -- Frequency
    COUNT(*) AS Frequency,

    -- Monetary
    SUM(order_value) AS Monetary

  FROM `project-a0c0a4c1-844b-45a2-beb.modulabs.rfm`
  GROUP BY user_id
),

RFMScores AS (
  SELECT
    *,
    
    -- Recency: 작을수록 좋음 → DESC
    NTILE(5) OVER (ORDER BY Recency DESC) AS RecencyScore,
    
    -- Frequency: 클수록 좋음 → ASC
    NTILE(5) OVER (ORDER BY Frequency ASC) AS FrequencyScore,
    
    -- Monetary: 클수록 좋음 → ASC
    NTILE(5) OVER (ORDER BY Monetary ASC) AS MonetaryScore

  FROM RFM
)

SELECT
  *,
  RecencyScore + FrequencyScore + MonetaryScore AS RFMScore
FROM RFMScores
ORDER BY user_id;