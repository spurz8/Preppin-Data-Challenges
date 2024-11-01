-- Requirements
-- Input the data
-- For the transactions file:
-- Filter the transactions to just look at DSB (help)
--    These will be transactions that contain DSB in the Transaction Code field
-- Rename the values in the Online or In-person field, Online of the 1 values and In-Person for the 2 values
-- Change the date to be the quarter (help)
-- Sum the transaction values for each quarter and for each Type of Transaction (Online or In-Person) (help)

-- For the targets file:
-- Pivot the quarterly targets so we have a row for each Type of Transaction and each Quarter (help)
-- Rename the fields
-- Remove the 'Q' from the quarter field and make the data type numeric (help)

-- Join the two datasets together (help)
--   You may need more than one join clause!
-- Remove unnecessary fields
-- Calculate the Variance to Target for each row (help)
-- Output the data


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
