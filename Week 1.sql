-- Start by viewing the data
SELECT *
FROM FROM PD2023_WK01;

-- Output 1: Total Values of Transaction by Bank
SELECT
SPLIT_PART(transaction_code,'-',0) as Bank,
SUM(value) as Total_Value,
FROM PD2023_WK01,
GROUP BY Bank
;


-- Output 2: Total Values of Transaction by Bank, DoW, Transaction Type
SELECT
SPLIT_PART(transaction_code,'-',0) as Bank,
dayname( DATE(transaction_date, 'DD/MM/YYYY HH:MI:SS') ) as DoW,
CASE
    WHEN online_or_in_person=1 THEN 'Online'
    WHEN online_or_in_person=2 THEN 'In-Person'
END as Transaction_Type,
SUM(value) as Total_Value,
FROM PD2023_WK01,
GROUP BY Bank, DoW, Transaction_Type
;


-- Output 3: Total Values of Transaction by Bank and Customer Code
SELECT
SPLIT_PART(transaction_code,'-',0) as Bank,
customer_code,
SUM(value) as Total_Value,
FROM PD2023_WK01,
GROUP BY Bank, customer_code
;
