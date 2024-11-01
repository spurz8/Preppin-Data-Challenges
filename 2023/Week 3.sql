--View the data

SELECT * 
FROM PD2023_WK03_TARGETS;

SELECT * 
FROM PD2023_WK01;

-- Clean the Transaction file as CTE to join later
WITH CTE_T AS (
SELECT 
CASE
    WHEN ONLINE_OR_IN_PERSON=1 THEN 'Online'
    WHEN ONLINE_OR_IN_PERSON=2 THEN 'In-Person'
    END as Type,
QUARTER(TO_DATE(TRANSACTION_DATE, 'DD/MM/YYYY HH:MI:SS')) as Quarter,
SUM(VALUE) AS Total_Value
FROM PD2023_WK01
WHERE TRANSACTION_CODE LIKE 'DSB%'
GROUP BY Type, Quarter)

-- Pivot Targets file, join to Transactions and calculate Variance
SELECT 
    ONLINE_OR_IN_PERSON,
    Targets as Quarterly_Targets,
    CAST(REPLACE(Q,'Q','') AS int) AS Q,
    V.Total_Value,
    V.Total_Value - Quarterly_Targets as Variance, 
FROM PD2023_WK03_TARGETS as P
UNPIVOT (Targets FOR Q in (Q1, Q2, Q3 ,Q4))
INNER JOIN CTE_T AS V ON CAST(REPLACE(Q,'Q','') AS int) = V.Quarter AND ONLINE_OR_IN_PERSON = V.Type
;
