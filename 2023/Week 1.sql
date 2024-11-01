-- Requirements
-- Input the data (help)
-- Split the Transaction Code to extract the letters at the start of the transaction code. These identify the bank who processes the transaction (help)
-- Rename the new field with the Bank code 'Bank'. 
-- Rename the values in the Online or In-person field, Online of the 1 values and In-Person for the 2 values. 
-- Change the date to be the day of the week (help)
-- Different levels of detail are required in the outputs. You will need to sum up the values of the transactions in three ways (help):
--    1. Total Values of Transactions by each bank
--    2. Total Values by Bank, Day of the Week and Type of Transaction (Online or In-Person)
--    3. Total Values by Bank and Customer Code
-- Output each data file (help)


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
