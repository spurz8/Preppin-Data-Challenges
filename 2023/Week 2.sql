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
