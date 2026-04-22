-- 임시 테이블 생성
CREATE OR REPLACE TABLE `project-a0c0a4c1-844b-45a2-beb.modulabs.item` (
 `item_id` INT64,
 `category` INT64,
 `item_name` STRING,
 `price` INT64
);

-- 데이터 삽입
INSERT INTO `project-a0c0a4c1-844b-45a2-beb.modulabs.item` (`item_id`, `category`, `item_name`, `price`)
VALUES
 (1003, 1, 'Mango', 10000),
 (1000, 1, 'Apple', 8000),
 (1002, 1, 'Orange', 4000),
 (1004, 1, 'Tomato', 1500),
 (1005, 2, 'Kiwi', 6000),
 (1001, 2, 'Banana', 6000);



-- 순위함수 ORDER BY price DESC
SELECT *
 , RANK() OVER (ORDER BY price DESC) AS RANK
 , DENSE_RANK() OVER (ORDER BY price DESC) AS DENSE_RANK
 , ROW_NUMBER() OVER (ORDER BY price DESC) AS ROW_NUMBER
FROM `project-a0c0a4c1-844b-45a2-beb.modulabs.item`
ORDER BY price DESC;



-- 순위함수 PARTITION BY category, ORDER BY price DESC
SELECT *
 , RANK() OVER (PARTITION BY category ORDER BY price DESC) AS RANK
 , DENSE_RANK() OVER (PARTITION BY category ORDER BY price DESC) AS DENSE_RANK
 , ROW_NUMBER() OVER (PARTITION BY category ORDER BY price DESC) AS ROW_NUMBER
FROM `project-a0c0a4c1-844b-45a2-beb.modulabs.item`
ORDER BY category ASC, price DESC;



-- 순위함수 PARTITION BY item_id, ORDER BY price DESC
SELECT *
 , RANK() OVER (PARTITION BY item_id ORDER BY price DESC) AS RANK
 , DENSE_RANK() OVER (PARTITION BY item_id ORDER BY price DESC) AS DENSE_RANK
 , ROW_NUMBER() OVER (PARTITION BY item_id ORDER BY price DESC) AS ROW_NUMBER
FROM `project-a0c0a4c1-844b-45a2-beb.modulabs.item`
ORDER BY category ASC, price DESC;



-- FIRST_VALUE, LAST_VALUE with ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
SELECT *,
 FIRST_VALUE(price) OVER (PARTITION BY category ORDER BY item_name DESC ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS FIRST_VALUE,
 LAST_VALUE(price) OVER (PARTITION BY category ORDER BY item_name DESC ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS LAST_VALUE
FROM `project-a0c0a4c1-844b-45a2-beb.modulabs.item`;

-- FIRST_VALUE, LAST_VALUE with ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING
SELECT *,
 FIRST_VALUE(price) OVER (PARTITION BY category ORDER BY item_name DESC ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING) AS FIRST_VALUE,
 LAST_VALUE(price) OVER (PARTITION BY category ORDER BY item_name DESC ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING) AS LAST_VALUE
FROM `project-a0c0a4c1-844b-45a2-beb.modulabs.item`
ORDER BY category, item_name DESC;

-- LAG(col, 1), LEAD(col, 1)
SELECT *,
 LAG(price, 1) OVER (ORDER BY price DESC) AS LAG,
 LEAD(price, 1) OVER (ORDER BY price DESC) AS LEAD
FROM `project-a0c0a4c1-844b-45a2-beb.modulabs.item`
ORDER BY price DESC;

-- LAG(col, 2), LEAD(col, 2)
SELECT *,
 LAG(price, 2) OVER (ORDER BY price DESC) AS LAG,
 LEAD(price, 2) OVER (ORDER BY price DESC) AS LEAD
FROM `project-a0c0a4c1-844b-45a2-beb.modulabs.item`
ORDER BY price DESC;



-- 임시 테이블 생성
CREATE OR REPLACE TABLE `project-a0c0a4c1-844b-45a2-beb.modulabs.employees` (
   name STRING,
   department STRING,
   job STRING,
   salary INT64
);

-- 임시 테이블에 데이터 삽입
INSERT INTO `project-a0c0a4c1-844b-45a2-beb.modulabs.employees` (name, department, job, salary)
VALUES
 ('Amy', 'Sales', 'Manager', 80000),
 ('Bob', 'Sales', 'Sales Rep', 50000),
 ('Charlie', 'Sales', 'Sales Rep', 55000),
 ('David', 'HR', 'Manager', 75000),
 ('Eve', 'HR', 'Recruiter', 60000),
 ('Frank', 'HR', 'Recruiter', 65000),
 ('Grace', 'IT', 'Manager', 90000),
 ('Hank', 'IT', 'Developer', 70000),
 ('Ivy', 'IT', 'Developer', 75000);



SELECT department, job, SUM(salary)
FROM `project-a0c0a4c1-844b-45a2-beb.modulabs.employees`
GROUP BY department, job;

-- 부서(department), 직무(job)별 salary 소계: ROLLUP
SELECT department, job, SUM(salary)
FROM `project-a0c0a4c1-844b-45a2-beb.modulabs.employees`
GROUP BY ROLLUP(department, job);

-- 부서(department), 직무(job)별 salary 소계: CUBE
SELECT department, job, SUM(salary)
FROM `project-a0c0a4c1-844b-45a2-beb.modulabs.employees`
GROUP BY CUBE(department, job);

-- 부서(department), 직무(job)별 다양한 소계: GROUPING SETS
SELECT department, job, SUM(salary)
FROM `project-a0c0a4c1-844b-45a2-beb.modulabs.employees`
GROUP BY GROUPING SETS((department, job), (department), ());



-- 임시 테이블 생성
CREATE OR REPLACE TABLE `project-a0c0a4c1-844b-45a2-beb.modulabs.user_logs` (
 log STRING,
 user_id STRING,
 action_detail STRING
);

-- 임시 테이블에 데이터 삽입
INSERT INTO `project-a0c0a4c1-844b-45a2-beb.modulabs.user_logs` (log, user_id, action_detail)
VALUES
 ('{"user": "user1", "action": "login", "timestamp": "2023-11-01T08:00:00"}', '1001', 'button_click'),
 ('{"user": "user2", "action": "logout", "timestamp": "2023-11-01T09:30:00"}', '1002', 'button_click'),
 ('{"user": "user1", "action": "purchase", "timestamp": "2023-11-01T10:15:00"}', '1001', 'button_click');



 -- JSON_EXTRACT로 dictionary형 데이터 쪼개기
SELECT *,
 JSON_EXTRACT(log, '$.user') AS user,
 JSON_EXTRACT(log, '$.action') AS action,
 JSON_EXTRACT(log, '$.timestamp') AS timestamp
FROM `project-a0c0a4c1-844b-45a2-beb.modulabs.user_logs`;