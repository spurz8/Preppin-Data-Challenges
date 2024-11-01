-- Requirements
-- Input the data
-- In the Transactions table, there is a Sort Code field which contains dashes. We need to remove these so just have a 6 digit string (hint)
-- Use the SWIFT Bank Code lookup table to bring in additional information about the SWIFT code and Check Digits of the receiving bank account (hint)
-- Add a field for the Country Code (hint)
--     Hint: all these transactions take place in the UK so the Country Code should be GB
-- Create the IBAN as above (hint)
--     Hint: watch out for trying to combine sting fields with numeric fields - check data types
-- Remove unnecessary fields (hint)
-- Output the data

-- View datasets

SELECT *
FROM PD2023_WK02_SWIFT_CODES;

SELECT *
FROM PD2023_WK02_TRANSACTIONS;

-- We need to create an IBAN field from the following fields:
-- IBAN: Country code - check digits - bank code - sort code - account number

SELECT 
     TRANSACTION_ID,
    concat('GB', CHECK_DIGITS, SWIFT_CODE, REPLACE(SORT_CODE,'-',''), ACCOUNT_NUMBER) as  IBAN,
FROM PD2023_WK02_TRANSACTIONS as T
INNER JOIN PD2023_WK02_SWIFT_CODES as S on T.BANK = S.BANK
;
