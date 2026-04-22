-- 테이블 생성   
CREATE OR REPLACE TABLE `project-a0c0a4c1-844b-45a2-beb.modulabs.ex1`(
   order_id STRING,
   user_id STRING,
   item_id STRING,
   price FLOAT64
);


-- 데이터 삽입
INSERT INTO `project-a0c0a4c1-844b-45a2-beb.modulabs.ex1` (order_id, user_id, item_id, price)
VALUES
   ('order_001', 'customer_01', 'product_001', 100.0),
   ('order_001', 'customer_01', 'product_002', 150.0),
   ('order_002', 'customer_02', 'product_003', 200.0),
   ('order_003', 'customer_03', 'product_004', 80.0),
   ('order_004', 'customer_04', 'product_005', 220.0),
   ('order_004', 'customer_04', 'product_006', 90.0),
   ('order_005', 'customer_05', 'product_007', 140.0),
   ('order_006', 'customer_01', 'product_008', 110.0),
   ('order_007', 'customer_06', 'product_009', 300.0),
   ('order_008', 'customer_07', 'product_010', 130.0),
   ('order_009', 'customer_03', 'product_011', 250.0),
   ('order_010', 'customer_08', 'product_012', 90.0);

-- 문제 상황
-- "ex1"라는 이름의 테이블에는 각 주문에 포함된 상품들에 대한 데이터가 들어있습니다. 총 주문 금액이 높은 상위 3명의 손님 리스트를 출력하는 쿼리문을 작성해주세요.

-- 이 경우, 각 주문의 총 금액을 계산해야 합니다. 쿼리 결과에는 아래 컬럼이 있어야 합니다.

-- user_id: 손님 ID
-- total_spent: 손님이 소비한 총 금액

SELECT
  user_id,
  SUM(price) AS total_spent
FROM `project-a0c0a4c1-844b-45a2-beb.modulabs.ex1`
GROUP BY user_id
ORDER BY total_spent DESC
LIMIT 3;



-- 테이블 생성   
CREATE OR REPLACE TABLE `project-a0c0a4c1-844b-45a2-beb.modulabs.ex2` (
   table_id STRING,
   total_bill FLOAT64,
   tip FLOAT64,
   gender STRING,
   party_size INT64,
   day STRING,
   time STRING
);


-- 데이터 삽입
INSERT INTO `project-a0c0a4c1-844b-45a2-beb.modulabs.ex2` (table_id, total_bill, tip, gender, party_size, day, time)
VALUES
   ('T01', 24.59, 3.61, 'Female', 2, 'Sun', 'Dinner'),
   ('T02', 21.01, 3.50, 'Male', 3, 'Sun', 'Dinner'),
   ('T03', 23.68, 3.31, 'Male', 2, 'Sun', 'Dinner'),
   ('T04', 24.59, 3.61, 'Female', 4, 'Sun', 'Dinner'),
   ('T05', 25.29, 4.71, 'Male', 4, 'Sun', 'Dinner'),
   ('T06', 8.77, 2.00, 'Male', 2, 'Sun', 'Dinner'),
   ('T07', 26.88, 3.12, 'Male', 2, 'Sun', 'Dinner'),
   ('T08', 15.04, 1.96, 'Male', 2, 'Sun', 'Dinner'),
   ('T09', 14.78, 3.23, 'Male', 2, 'Sun', 'Dinner'),
   ('T10', 10.27, 1.71, 'Male', 2, 'Sun', 'Dinner'),
   ('T11', 35.26, 5.00, 'Female', 4, 'Sun', 'Dinner'),
   ('T12', 15.42, 1.57, 'Male', 2, 'Sun', 'Dinner');

-- 문제 상황
-- "ex2"라는 이름의 테이블에는 각 테이블의 식사 금액, 팁, 손님 수, 결제자 성별, 요일, 시간대 등에 대한 데이터가 들어있습니다.

-- 각 테이블의 식사 금액이 전체 평균 식사 금액보다 많은 경우를 찾아내어, 특히 많은 양의 음식을 주문한 큰손 손님들을 식별하는 쿼리문을 작성해주세요. 결과에는 ex2 테이블의 모든 컬럼이 포함되어야 합니다.

SELECT *
FROM `project-a0c0a4c1-844b-45a2-beb.modulabs.ex2`
WHERE total_bill > (
  SELECT AVG(total_bill)
  FROM `project-a0c0a4c1-844b-45a2-beb.modulabs.ex2`
)
order by table_id asc;

-- 힌트
-- 쿼리문을 길게 작성해도 되지만 가독성을 높이기 위해 WITH 문을 사용하는 것도 좋습니다.

-- WITH 문은 쿼리문을 임시 테이블처럼 활용할 수 있는 기능으로, 아래와 같은 구조를 가지고 있습니다.

WITH AverageBill AS (
   SELECT AVG(total_bill) AS avg_bill
   FROM `project-a0c0a4c1-844b-45a2-beb.modulabs.ex2`
)
SELECT *
FROM `project-a0c0a4c1-844b-45a2-beb.modulabs.ex2` ex2
CROSS JOIN AverageBill
WHERE ex2.total_bill > AverageBill.avg_bill
ORDER BY table_id ASC;

-- 문제 상황
-- "ex3" 라는 이름의 테이블에는 제품별 판매 정보가 담겨 있습니다. 즉 제품번호(PRODUCT_ID)와 제품라인(PRODUCT_LINE), 그리고 각 PRODUCT 별로 판매된 판매량 정보가 들어있죠.

-- ex3 테이블을 사용하여 판매량 합계가 가장 많은 ‘제품 라인(Product Line) 을 찾아주세요.

-- 테이블 생성   
CREATE OR REPLACE TABLE `project-a0c0a4c1-844b-45a2-beb.modulabs.ex3` (
   PRODUCT_ID INT64 NOT NULL,
   PRODUCT_LINE STRING NOT NULL,
   TOTAL_ORDER INT64 NOT NULL
);

-- 데이터 삽입
INSERT INTO `project-a0c0a4c1-844b-45a2-beb.modulabs.ex3` (PRODUCT_ID, PRODUCT_LINE, TOTAL_ORDER)
VALUES
(101, 'Sneakers', 3200),
(102, 'Boots', 2500),
(103, 'Sandals', 1800),
(104, 'Running Shoes', 2100),
(105, 'Sneakers', 3000),
(106, 'Boots', 2700),
(107, 'Sandals', 1600),
(108, 'Running Shoes', 2200),
(109, 'Sneakers', 3100),
(110, 'Boots', 2600),
(111, 'Sandals', 1500),
(112, 'Running Shoes', 2000),
(113, 'Sneakers', 3300),
(114, 'Boots', 2400),
(115, 'Sandals', 1700),
(116, 'Running Shoes', 2300),
(117, 'Sneakers', 3400),
(118, 'Boots', 2800),
(119, 'Sandals', 1900),
(120, 'Running Shoes', 2500);

SELECT
  PRODUCT_LINE,
  SUM(TOTAL_ORDER) AS total_sales
FROM `project-a0c0a4c1-844b-45a2-beb.modulabs.ex3`
GROUP BY PRODUCT_LINE
ORDER BY total_sales DESC
LIMIT 1;



-- 5. 베스트 리뷰어에게 경품을 주자!
-- 모두몰에서는 베스트 리뷰어에게 경품을 주는 프로모션을 진행하려고 합니다.

-- 모두몰의 VIP 고객이 리뷰를 가장 많이 남겼을까요?

-- 모두몰에서 상품 리뷰를 가장 많이 남긴 고객을 찾아 어떤 리뷰를 남겼는지 살펴 봅시다.



-- 문제 상황
-- "ex4_member", "ex4_review" 라는 이름의 테이블에는 각각 회원에 대한 정보와, 회원이 남긴 리뷰에 대한 정보가 담겨 있습니다.

-- ex4_member 테이블과 ex4_review 테이블을 사용하여 리뷰를 가장 많이 남긴 회원의 리뷰를 조회해 주세요.

-- 최종 출력은 회원 이름, 리뷰 텍스트, 리뷰 작성일이 포함되어야 합니다. 정렬은 아래와 같이 해주세요.

-- 리뷰 작성일: 오름차순
-- 동일 날짜에 적힌 리뷰의 경우에는 리뷰 텍스트를 기준으로 오름차순 정렬



-- 테이블 생성   
CREATE OR REPLACE TABLE `project-a0c0a4c1-844b-45a2-beb.modulabs.ex4_member` (
   MEMBER_ID STRING NOT NULL,
   MEMBER_NAME STRING NOT NULL,
   TLNO STRING,
   GENDER STRING,
   DATE_OF_BIRTH DATE
);

CREATE OR REPLACE TABLE `project-a0c0a4c1-844b-45a2-beb.modulabs.ex4_review` (
   REVIEW_ID STRING NOT NULL,
   REST_ID STRING,
   MEMBER_ID STRING,
   REVIEW_SCORE INT64,
   REVIEW_TEXT STRING,
   REVIEW_DATE DATE
);

-- 데이터 삽입
INSERT INTO `project-a0c0a4c1-844b-45a2-beb.modulabs.ex4_member` 
(MEMBER_ID, MEMBER_NAME, TLNO, GENDER, DATE_OF_BIRTH)
VALUES
('kevin@gmail.com', 'Kevin', '01076432111', 'M', '1992-02-12'),
('james@gmail.com', 'James', '01032324117', 'M', '1992-02-22'),
('alice@gmail.com', 'Alice', '01023258688', 'W', '1993-02-23'),
('maria@gmail.com', 'Maria', '01076482209', 'W', '1993-03-16'),
('duke@gmail.com', 'Duke', '01017626711', 'M', '1990-11-30');

INSERT INTO `project-a0c0a4c1-844b-45a2-beb.modulabs.ex4_review` 
(REVIEW_ID, REST_ID, MEMBER_ID, REVIEW_SCORE, REVIEW_TEXT, REVIEW_DATE)
VALUES
('R000000065', '00028', 'alice@gmail.com', 5, 'The broth for the shabu-shabu was clean and tasty', '2022-04-12'),
('R000000066', '00039', 'duke@gmail.com', 5, 'The kimchi stew was the best', '2022-02-12'),
('R000000067', '00028', 'duke@gmail.com', 5, 'Loved the generous amount of ham', '2022-02-22'),
('R000000068', '00035', 'kevin@gmail.com', 5, 'The aged sashimi was fantastic', '2022-02-15'),
('R000000069', '00035', 'maria@gmail.com', 4, 'No fishy smell at all', '2022-04-16'),
('R000000070', '00040', 'kevin@gmail.com', 4, 'Cozy atmosphere and great experience', '2022-05-10'),
('R000000071', '00041', 'kevin@gmail.com', 5, 'Top-notch service and taste', '2022-05-12'),
('R000000072', '00042', 'kevin@gmail.com', 3, 'Average taste but friendly staff', '2022-05-14'),
('R000000073', '00043', 'james@gmail.com', 5, 'Both the taste and service were satisfying', '2022-05-15'),
('R000000074', '00044', 'alice@gmail.com', 4, 'The ingredients were fresh', '2022-05-16');



WITH review_count AS (
  SELECT
    MEMBER_ID,
    COUNT(*) AS cnt
  FROM `project-a0c0a4c1-844b-45a2-beb.modulabs.ex4_review`
  GROUP BY MEMBER_ID
),
top_member AS (
  SELECT MEMBER_ID
  FROM review_count
  ORDER BY cnt DESC
  LIMIT 1
)

SELECT
  m.MEMBER_NAME,
  r.REVIEW_TEXT,
  r.REVIEW_DATE
FROM `project-a0c0a4c1-844b-45a2-beb.modulabs.ex4_review` r
JOIN top_member t
  ON r.MEMBER_ID = t.MEMBER_ID
JOIN `project-a0c0a4c1-844b-45a2-beb.modulabs.ex4_member` m
  ON r.MEMBER_ID = m.MEMBER_ID
ORDER BY
  r.REVIEW_DATE ASC,
  r.REVIEW_TEXT ASC;



-- 가장 많은 리뷰를 남긴 유저의 정보 찾기
WITH ReviewCounts AS (
    SELECT
        MEMBER_ID,
        COUNT(*) AS NumberOfReviews
    FROM `project-a0c0a4c1-844b-45a2-beb.modulabs.ex4_review`
    GROUP BY MEMBER_ID
    ORDER BY NumberOfReviews DESC
    LIMIT 1
)

-- 가장 많은 리뷰를 남긴 유저의 리뷰 조회
SELECT
    MEMBER.MEMBER_NAME,
    REVIEW.REVIEW_TEXT,
    REVIEW.REVIEW_DATE
FROM `project-a0c0a4c1-844b-45a2-beb.modulabs.ex4_member` MEMBER
JOIN `project-a0c0a4c1-844b-45a2-beb.modulabs.ex4_review` REVIEW 
  ON MEMBER.MEMBER_ID = REVIEW.MEMBER_ID
JOIN ReviewCounts 
  ON REVIEW.MEMBER_ID = ReviewCounts.MEMBER_ID
ORDER BY REVIEW.REVIEW_DATE ASC, REVIEW.REVIEW_TEXT ASC;



-- 6. 다음 환자분, 진료실로 들어오세요!
-- 모두 병원에는 매일 수많은 환자들이 방문합니다.

-- 모두 병원의 간호사들은 다음에 진료를 받을 환자가 누구인지 매번 알아보고 호출해야 하는데요, 이전에는 눈으로 확인했었던 작업을 SQL을 사용하여 빠르게 찾으려고 합니다.

-- 예약된 환자 중 아직 진료를 받지 않은 환자는 누구일까요?

-- 다음에 진료받을 환자를 찾아 주세요.



-- 문제 상황
-- "ex5_patient" 라는 이름의 테이블에는 환자들에 대한 정보가, "ex5_apnt" 테이블에는 진료 예약 정보가 담겨 있습니다.

-- 테이블들을 활용하여 아직 진료 완료(TREATMENT_STATUS = 'Completed')가 되지 않은 예약 건들에 대하여 '취소 되지 않은 다음 진료 예약' 의 예약자명을 찾아주세요.



-- 테이블 생성  
CREATE OR REPLACE TABLE `project-a0c0a4c1-844b-45a2-beb.modulabs.ex5_patient` (
   PATIENT_NO STRING,
   PATIENT_NAME STRING,
   GENDER STRING,
   AGE INT64
);

CREATE OR REPLACE TABLE `project-a0c0a4c1-844b-45a2-beb.modulabs.ex5_apnt` (
   APNT_YMD TIMESTAMP,
   APNT_NO INT64,
   PATIENT_NO STRING,
   APNT_CANCEL_YN STRING,
   TREATMENT_STATUS STRING
);

-- 데이터 삽입
INSERT INTO `project-a0c0a4c1-844b-45a2-beb.modulabs.ex5_patient` (PATIENT_NO, PATIENT_NAME, GENDER, AGE) VALUES
('PT22000024', '영희', 'W', 30),
('PT22000035', '철수', 'M', 45),
('PT22000046', '은지', 'W', 20),
('PT22000057', '준호', 'M', 35),
('PT22000068', '수민', 'W', 28),
('PT22000079', '현준', 'M', 52),
('PT22000080', '서연', 'W', 22),
('PT22000091', '지후', 'M', 40),
('PT22000102', '민서', 'W', 33),
('PT22000113', '예준', 'M', 47);


INSERT INTO `project-a0c0a4c1-844b-45a2-beb.modulabs.ex5_apnt` (APNT_YMD, APNT_NO, PATIENT_NO, APNT_CANCEL_YN, TREATMENT_STATUS) VALUES
(TIMESTAMP '2024-01-01 09:00:00', 49, 'PT22000068', 'Y', 'Completed'),
(TIMESTAMP '2024-01-01 09:30:00', 44, 'PT22000024', 'N', 'Completed'),
(TIMESTAMP '2024-01-01 10:00:00', 50, 'PT22000079', 'N', 'Completed'),
(TIMESTAMP '2024-01-01 10:30:00', 45, 'PT22000035', 'N', ''),
(TIMESTAMP '2024-01-01 11:00:00', 51, 'PT22000080', 'N', ''),
(TIMESTAMP '2024-01-01 11:30:00', 47, 'PT22000046', 'N', ''),
(TIMESTAMP '2024-01-01 13:00:00', 52, 'PT22000091', 'N', ''),
(TIMESTAMP '2024-01-01 14:30:00', 48, 'PT22000057', 'N', ''),
(TIMESTAMP '2024-01-01 15:00:00', 53, 'PT22000102', 'N', ''),
(TIMESTAMP '2024-01-01 16:00:00', 54, 'PT22000113', 'Y', '');



SELECT
    p.PATIENT_NAME
FROM `project-a0c0a4c1-844b-45a2-beb.modulabs.ex5_apnt` a
JOIN `project-a0c0a4c1-844b-45a2-beb.modulabs.ex5_patient` p
  ON a.PATIENT_NO = p.PATIENT_NO
WHERE a.APNT_CANCEL_YN = 'N'
  AND a.TREATMENT_STATUS != 'Completed'
limit 1;



SELECT p.PATIENT_NAME
FROM `project-a0c0a4c1-844b-45a2-beb.modulabs.ex5_apnt` a
JOIN `project-a0c0a4c1-844b-45a2-beb.modulabs.ex5_patient` p 
  ON a.PATIENT_NO = p.PATIENT_NO
WHERE 1=1
    AND a.APNT_CANCEL_YN = 'N'
    AND a.TREATMENT_STATUS != 'Completed'
ORDER BY a.APNT_YMD
LIMIT 1;