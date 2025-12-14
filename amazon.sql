SELECT
    ROUND(SAFE_CAST(rating AS FLOAT64), 1) AS rating_bin,
    COUNT(*) AS cnt
FROM `amazon.amazon`
WHERE SAFE_CAST(rating AS FLOAT64) IS NOT NULL
GROUP BY rating_bin
ORDER BY rating_bin DESC;

select *
from `amazon.amazon`
limit 5;

SELECT product_id, product_name, rating, rating_count
FROM `modu-480005`.`amazon`.`amazon`
WHERE
  SAFE_CAST(REGEXP_REPLACE(rating, r'[^0-9.]', '') AS FLOAT64) > 4.5
  AND SAFE_CAST(REGEXP_REPLACE(rating, r'[^0-9.]', '') AS FLOAT64) IS NOT NULL
ORDER BY rating_count DESC
LIMIT 100;

SELECT *
FROM `amazon.amazon`,
     UNNEST(SPLIT(category, '|')) AS category_value;

SELECT category, COUNT(*) AS product_count
FROM `amazon.amazon`
GROUP BY category
ORDER BY product_count DESC;

SELECT product_id, product_name, rating_count
FROM `amazon.amazon`
ORDER BY rating_count DESC
LIMIT 20;

WITH cleaned AS (
  SELECT
    product_id,
    product_name,
    SAFE_CAST(REGEXP_REPLACE(CAST(discount_percentage AS STRING), r'[^0-9]', '') AS INT64) AS discount_pct,
    SAFE_CAST(REGEXP_REPLACE(CAST(rating AS STRING), r'[^0-9.]', '') AS FLOAT64) AS rating_num,
    SAFE_CAST(REGEXP_REPLACE(CAST(rating_count AS STRING), r'[^0-9]', '') AS INT64) AS rating_cnt
  FROM `amazon.amazon`
)
SELECT *
FROM cleaned
WHERE rating_num >= 4.0
  AND rating_cnt >= 100
ORDER BY 
    discount_pct DESC,      -- 1순위: 할인율
    rating_num DESC,        -- 2순위: 평점
    rating_cnt DESC        -- 3순위: 리뷰 수
limit 25;

-- 1. 특정 상품 리뷰한 사용자 찾기
WITH target_users AS (
  SELECT
    SAFE_CAST(user_id AS STRING) AS user_id  -- user_id가 문자열이라면 안전하게 변환
  FROM `modu-480005.amazon.amazon`
  WHERE product_id = 'B07JW9H4J1'  -- 추천 기준 상품
),

-- 2. 해당 유저들이 리뷰한 다른 상품 찾기
user_other_products AS (
  SELECT
    p.product_id,
    p.product_name,
    COUNT(*) AS count
  FROM `modu-480005.amazon.amazon` p
  JOIN target_users t
    ON SAFE_CAST(p.user_id AS STRING) = t.user_id
  WHERE p.product_id != 'B07JW9H4J1'  -- 자기 자신 제외
  GROUP BY p.product_id, p.product_name
)

-- 3. 추천 순위로 정렬
SELECT *
FROM user_other_products
ORDER BY count DESC
LIMIT 20;










WITH cleaned AS (
  SELECT
    product_id,
    product_name,

    -- 할인율: 숫자만 추출
    discount_percentage AS discount_pct,

    -- 평점: 소수점 포함 숫자만 추출
    SAFE_CAST(REGEXP_REPLACE(CAST(rating AS STRING), r'[^0-9.]', '') AS FLOAT64) AS rating_num,

    -- 리뷰 수: 숫자만 추출
    rating_count AS rating_cnt
  FROM `amazon.amazon`
)

SELECT 
  product_id,
  product_name,
  discount_pct,
  rating_num,
  rating_cnt
FROM cleaned
WHERE 
  rating_num >= 4.0          -- 품질 기준
  AND rating_cnt >= 100      -- 신뢰도 기준
ORDER BY 
  discount_pct DESC,         -- 1순위: 가장 큰 할인율
  rating_num DESC,           -- 2순위: 가장 높은 평점
  rating_cnt DESC            -- 3순위: 검증된 리뷰 수
LIMIT 20;





WITH cleaned AS (
  SELECT
    product_id,
    product_name,

    -- 리뷰 길이 계산
    LENGTH(CAST(review_content AS STRING)) AS review_length,

    -- 평점 정규화
    SAFE_CAST(REGEXP_REPLACE(CAST(rating AS STRING), r'[^0-9.]', '') AS FLOAT64) AS rating_num,

    -- 리뷰 수 정규화
    rating_count AS rating_cnt
  FROM `amazon.amazon`
)

SELECT
  product_id,
  product_name,
  review_length,
  rating_num,
  rating_cnt
FROM cleaned
WHERE
  rating_num >= 4.0         -- 품질 필터 (4.5보다 낮춰도 OK)
  AND rating_cnt >= 50      -- 최소 신뢰도 필터
  AND review_length >= 200  -- 정성 리뷰 기준
ORDER BY
  review_length DESC,       -- 1순위: 리뷰 길이 가장 긴 순
  rating_num DESC,          -- 2순위: 평점
  rating_cnt DESC           -- 3순위: 리뷰 수
LIMIT 20;






WITH cleaned AS (
  SELECT
    product_id,
    product_name,
    category,

    -- 할인율 정규화
    discount_percentage AS discount_pct,

    -- 평점 정규화
    SAFE_CAST(REGEXP_REPLACE(CAST(rating AS STRING), r'[^0-9.]', '') AS FLOAT64) AS rating_num,

    -- 리뷰 수 정규화
    rating_count AS rating_cnt
  FROM `amazon.amazon`
),

ranked AS (
  SELECT
    *,
    ROW_NUMBER() OVER (
      PARTITION BY category
      ORDER BY 
        rating_num DESC,      -- 1순위: 평점 높은 순
        rating_cnt DESC,      -- 2순위: 리뷰 수 많은 순
        discount_pct DESC     -- 3순위: 할인율 높은 순
    ) AS rn
  FROM cleaned
)

SELECT
  product_id,
  product_name,
  category,
  rating_num,
  rating_cnt,
  discount_pct
FROM ranked
WHERE rn <= 5                 -- 카테고리별 TOP 5만 출력
ORDER BY category, rn;

SELECT DISTINCT 
  SPLIT(category, '|')[SAFE_ORDINAL(1)] AS top_category
FROM `amazon.amazon`
ORDER BY top_category;





WITH product_level AS (
  SELECT
    product_id,
    ANY_VALUE(product_name) AS product_name,
    ANY_VALUE(category) AS category,

    -- 할인율
    ANY_VALUE(discount_percentage) AS discount_pct,

    -- 평점 정규화
    SAFE_CAST(REGEXP_REPLACE(ANY_VALUE(CAST(rating AS STRING)), r'[^0-9.]', '') AS FLOAT64) AS rating_num,

    -- 리뷰 수 (이미 INT일 가능성 높음)
    ANY_VALUE(rating_count) AS rating_cnt
  FROM `amazon.amazon`
  GROUP BY product_id
),

cleaned AS (
  SELECT
    *,
    SPLIT(category, '|')[SAFE_ORDINAL(ARRAY_LENGTH(SPLIT(category, '|')))] AS simple_category
  FROM product_level
),

ranked AS (
  SELECT
    *,
    ROW_NUMBER() OVER (
      PARTITION BY simple_category
      ORDER BY rating_num DESC
    ) AS rn
  FROM cleaned
  WHERE rating_num >= 4.0         -- 평점 조건
    AND rating_cnt >= 100         -- 리뷰 수 조건
    AND discount_pct >= 0.10      -- 할인율 최소 조건 (원하면 조절 가능)
)

SELECT
  simple_category,
  rn,
  product_id,
  product_name,
  rating_num,
  rating_cnt,
  discount_pct
FROM ranked
WHERE rn <= 5
ORDER BY simple_category, rn;
