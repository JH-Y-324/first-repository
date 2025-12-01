-- 테이블 생성   
CREATE OR REPLACE TABLE `firstproject-479902.firstdataset.ex1`(
  order_id STRING,
  user_id STRING,
  item_id STRING,
  price FLOAT64
);


-- 데이터 삽입
INSERT INTO `firstproject-479902.firstdataset.ex1` (order_id, user_id, item_id, price)
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
   ('order_009', 'customer_03', 'product_0011', 250.0), 
   ('order_0010', 'customer_08', 'product_012', 90.0);

SELECT user_id, SUM(price) AS total_spent
FROM `firstproject-479902.firstdataset.ex1`
GROUP BY user_id
ORDER BY total_spent DESC
LIMIT 3;

-- 테이블 생성   
CREATE OR REPLACE TABLE `firstproject-479902.firstdataset.ex2` (
   table_id STRING,
   total_bill FLOAT64,
   tip FLOAT64,
   gender STRING,
   party_size INT64,
   day STRING,
   time STRING
);


-- 데이터 삽입
INSERT INTO firstproject-479902.firstdataset.ex2 (table_id, total_bill, tip, gender, party_size, day, time)
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

   select *
   from `firstproject-479902.firstdataset.ex2`
   where total_bill > (
      select avg(total_bill)
      from `firstproject-479902.firstdataset.ex2`
   )
   order by table_id;

   -- 테이블 생성   
CREATE OR REPLACE TABLE `firstproject-479902.firstdataset.ex3` (
   PRODUCT_ID INT64 NOT NULL,
   PRODUCT_LINE STRING NOT NULL,
   TOTAL_ORDER INT64 NOT NULL
);
-- 데이터 삽입
INSERT INTO `firstproject-479902.firstdataset.ex3` (PRODUCT_ID, PRODUCT_LINE, TOTAL_ORDER)
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

select product_line, sum(total_order) as total_sales
from `firstproject-479902.firstdataset.ex3`
group by PRODUCT_LINE
order by total_sales desc
limit 1;

-- 테이블 생성   
CREATE OR REPLACE TABLE `firstproject-479902.firstdataset.ex4_member` (
   MEMBER_ID STRING NOT NULL,
   MEMBER_NAME STRING NOT NULL,
   TLNO STRING,
   GENDER STRING,
   DATE_OF_BIRTH DATE
);
CREATE OR REPLACE TABLE `firstproject-479902.firstdataset.ex4_review` (
   REVIEW_ID STRING NOT NULL,
   REST_ID STRING,
   MEMBER_ID STRING,
   REVIEW_SCORE INT64,
   REVIEW_TEXT STRING,
   REVIEW_DATE DATE
);
-- 데이터 삽입
INSERT INTO `firstproject-479902.firstdataset.ex4_member` (MEMBER_ID, MEMBER_NAME, TLNO, GENDER, DATE_OF_BIRTH)
VALUES
('kevin@gmail.com', 'Kevin', '01076432111', 'M', '1992-02-12'),
('james@gmail.com', 'James', '01032324117', 'M', '1992-02-22'),
('alice@gmail.com', 'Alice', '01023258688', 'W', '1993-02-23'),
('maria@gmail.com', 'Maria', '01076482209', 'W', '1993-03-16'),
('duke@gmail.com', 'Duke', '01017626711', 'M', '1990-11-30');


INSERT INTO `firstproject-479902.firstdataset.ex4_review` (REVIEW_ID, REST_ID, MEMBER_ID, REVIEW_SCORE, REVIEW_TEXT, REVIEW_DATE)
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

select m.member_name, r.review_text, r.review_date
from `firstdataset.ex4_review` r
join `firstdataset.ex4_member` m
  on r.MEMBER_ID = m.MEMBER_ID
where r.member_id = (
  select member_id
  from `firstdataset.ex4_review`
  group by MEMBER_ID
  order by count(*) desc
  limit 1
)
order by r.REVIEW_DATE, r.REVIEW_TEXT;

-- 테이블 생성  
CREATE OR REPLACE TABLE `firstproject-479902.firstdataset.ex5_patient` (
   PATIENT_NO STRING,
   PATIENT_NAME STRING,
   GENDER STRING,
   AGE INT64
);
CREATE OR REPLACE TABLE `firstproject-479902.firstdataset.ex5_apnt` (
   APNT_YMD TIMESTAMP,
   APNT_NO INT64,
   PATIENT_NO STRING,
   APNT_CANCEL_YN STRING,
   TREATMENT_STATUS STRING
);
-- 데이터 삽입
INSERT INTO `firstproject-479902.firstdataset.ex5_patient` (PATIENT_NO, PATIENT_NAME, GENDER, AGE) VALUES
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


INSERT INTO `firstproject-479902.firstdataset.ex5_apnt` (APNT_YMD, APNT_NO, PATIENT_NO, APNT_CANCEL_YN, TREATMENT_STATUS) VALUES
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

select p.PATIENT_NAME
from `firstdataset.ex5_apnt` a
join `firstdataset.ex5_patient` p
  on a.PATIENT_NO = p.PATIENT_NO
where a.TREATMENT_STATUS != 'Completed'
  and a.APNT_CANCEL_YN != 'Y'
  -- and a.APNT_YMD = (
  --   select min(APNT_YMD)
  --   from `firstdataset.ex5_apnt`
  --   where TREATMENT_STATUS != 'Completed'
  --     and APNT_CANCEL_YN != 'Y'
  -- );
order by a.APNT_YMD
limit 1;

-- SELECT p.PATIENT_NAME
-- FROM project_name.dataset_name.ex5_apnt a
-- JOIN project_name.dataset_name.ex5_patient p ON a.PATIENT_NO = p.PATIENT_NO
-- WHERE 1=1
--     AND a.APNT_CANCEL_YN = 'N'
--     AND a.TREATMENT_STATUS != 'Completed'
-- ORDER BY a.APNT_YMD
-- LIMIT 1;

-- 임시 테이블 생성
CREATE OR REPLACE TABLE `firstdataset.item` (
 `item_id` INT64,
 `category` INT64,
 `item_name` STRING,
 `price` INT64
);

-- 데이터 삽입
INSERT INTO `firstdataset.item` (`item_id`, `category`, `item_name`, `price`)
VALUES
 (1003, 1, 'Mango', 10000),
 (1000, 1, 'Apple', 8000),
 (1002, 1, 'Orange', 4000),
 (1004, 1, 'Tomato', 1500),
 (1005, 2, 'Kiwi', 6000),
 (1001, 2, 'Banana', 6000);

select *
  , rank() over (order by price desc) as rank
  , dense_rank() over (order by price desc) as dense_rank
  , row_number() over (order by price desc) as row_number
from `firstdataset.item`
order by price desc;

select *
  , rank() over (partition by category order by price desc) as rank
  , dense_rank() over (partition by category order by price desc) as dense_rank
  , row_number() over (partition by category order by price desc) as row_number
from `firstdataset.item`
order by category asc, price desc;

-- 임시 테이블 생성
CREATE OR REPLACE TABLE firstdataset.web (
 YYMM STRING,
 YYMMDD DATE,
 Visits INT64
);

-- 임시 테이블에 데이터 삽입
INSERT INTO firstdataset.web (YYMM, YYMMDD, Visits)
VALUES
 ('2024-01', '2024-01-01', 100),
 ('2024-01', '2024-01-02', 120),
 ('2024-01', '2024-01-03', 140),
 ('2024-01', '2024-01-04', 120),
 ('2024-01', '2024-01-05', 130),
 ('2024-01', '2024-01-06', 140);

select *,
  sum(Visits) over (partition by yymm) as sum,
  avg(Visits) over (partition by yymm) as avg,
  max(visits) over (partition by yymm) as max,
  min(visits) over (partition by yymm) as min
from `firstdataset.web`;

-- 임시 테이블 생성
CREATE OR REPLACE TABLE `firstdataset.item` (
 `item_id` INT64,
 `category` INT64,
 `item_name` STRING,
 `price` INT64
);

-- 임시 테이블에 데이터 삽입
INSERT INTO `firstdataset.item` (`item_id`, `category`, `item_name`, `price`)
VALUES
 (1003, 1, 'Mango', 10000),
 (1000, 1, 'Apple', 8000),
 (1002, 1, 'Orange', 4000),
 (1004, 1, 'Tomato', 1500),
 (1005, 2, 'Kiwi', 6000),
 (1001, 2, 'Banana', 6000);

 select *,
  first_value(price) over (
    partition by category
    order by item_name desc
    rows between unbounded preceding and unbounded following
  ) as first_value,
  last_value(price) over (
    partition by category
    order by item_name desc
    rows between unbounded preceding and unbounded following
  ) as last_value
  from `firstproject-479902.firstdataset.item`;

select *,
  first_value(price) over (
    partition by category
    order by item_name desc
    rows between current row and unbounded following
  ) as first_value,
  last_value(price) over (
    partition by category
    order by item_name desc
    rows between current row and unbounded following
  ) as last_value
from `firstproject-479902.firstdataset.item`
order by category, item_name desc;

select *,
  lag(price, 1) over (order by price desc) as lag,
  lead(price, 1) over (order by price desc) as lead
from `firstproject-479902.firstdataset.item`
order by price desc;

select *,
  lag(price, 2) over (order by price desc) as lag,
  lead(price, 2) over (order by price desc) as lead
from `firstproject-479902.firstdataset.item`
order by price desc;