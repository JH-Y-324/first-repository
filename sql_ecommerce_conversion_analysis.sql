select *
from `modulabs.online_retail`
limit 5;

-- 2011년 10월 한달 동안, 취소를 제외한 영국(United Kingdom)의 유효 주문 수는 몇 건인가요? (유효 주문: InvoiceNo가 'C'로 시작하지 않는 거래)

SELECT COUNT(DISTINCT InvoiceNo)
FROM `modulabs.online_retail`
WHERE DATE(InvoiceDate) BETWEEN '2011-10-01' AND '2011-10-31'
	AND Country = 'United Kingdom'
	AND InvoiceNo NOT LIKE 'C%';

-- 전체 고객(CustomerID)은 몇 명인가요? (CustomerID가 NULL이 아닌 고객 수)

SELECT COUNT(DISTINCT CustomerID)
FROM `modulabs.online_retail`
WHERE CustomerID IS NOT NULL;

-- 데이터에 포함되어 있는 국가(Country)는 몇 개이며, 어느 나라가 유효 주문 수가 가장 많은가요?

SELECT Country, COUNT(DISTINCT InvoiceNo)
FROM `modulabs.online_retail` 
WHERE InvoiceNo NOT LIKE "C%"
GROUP BY Country 
ORDER BY COUNT(DISTINCT InvoiceNo) DESC;

-- 가장 많이 판매된 상품은 무엇인가요? (Quantity의 합계 기준)

SELECT StockCode, Description, SUM(Quantity)
FROM `modulabs.online_retail` 
GROUP BY StockCode, Description
ORDER BY SUM(Quantity) DESC;

-- 고객 당 평균 유효 주문 수는 몇 개인가요? (유효 주문 기준)

SELECT CustomerID, COUNT(DISTINCT InvoiceNo)
FROM `modulabs.online_retail` 
WHERE InvoiceNo NOT LIKE "C%"
GROUP BY CustomerID;

-- 유효 주문을 기준으로 했을 때, 가장 자주 구매한 고객은 누구인가요? (구매 건수 기준)

SELECT CustomerID, COUNT(DISTINCT InvoiceNo)
FROM `modulabs.online_retail` 
WHERE InvoiceNo NOT LIKE "C%"
   AND CustomerID IS NOT NULL
GROUP BY CustomerID
ORDER BY COUNT(DISTINCT InvoiceNo) DESC;

-- 1건의 주문에서 가장 많은 금액을 지불한 주문은 무엇인가요? (주문 당 총 결제 금액 기준)

SELECT InvoiceNo, SUM(Quantity * UnitPrice)
FROM `modulabs.online_retail`
GROUP BY InvoiceNo
ORDER BY SUM(Quantity * UnitPrice) DESC;