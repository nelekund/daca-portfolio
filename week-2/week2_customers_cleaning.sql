-- Grupitöö nädal 2 --

-- Roll: B (Customer Data Cleaner)
----------------------------------

-- 1. Loo test koopia customers tabelist

CREATE TABLE customers_test AS 
SELECT * FROM customers;

SELECT COUNT(*) AS ridade_arv FROM customers_test;
-- 3150 rida

-- 2. Leia duplikaatsed emailid

SELECT email, COUNT(*) AS koopiate_arv
FROM customers_test
WHERE email IS NOT NULL
AND email <> ''
GROUP BY email
HAVING COUNT(*) > 1
ORDER BY koopiate_arv DESC;

-- 2.1 Loe duplikaatsed e-mailid kokku

SELECT COUNT(*) AS duplikaatsed_emailid
FROM (
  SELECT email, COUNT(*) AS koopiate_arv
  FROM customers_test
  WHERE email IS NOT NULL
  AND email <> ''
  GROUP BY email
  HAVING COUNT(*) > 1
  ) AS duplikaadid;
-- 128 duplikaatset e-maili.

-- 3. Leia puuduvad nimed

SELECT
    COUNT(*) FILTER (WHERE first_name IS NULL OR first_name = '') AS null_eesnimi,
    COUNT(*) FILTER (WHERE last_name IS NULL OR last_name = '') AS null_perenimi
FROM customers_test;
-- 0 puuduvat eesnime, 0 puuduvat perenime.

-- 4. Kontrolli linnade nimekujusid

SELECT city, COUNT(*) AS arv
FROM customers_test
GROUP BY city
HAVING COUNT(*) > 1
ORDER BY arv DESC;

-- 4.1 Erinevad nimekujud samal linnal

SELECT INITCAP(TRIM(city)) AS linn,
COUNT(DISTINCT city) AS nimekujusid
FROM customers_test
GROUP BY INITCAP(TRIM(city))
HAVING COUNT(DISTINCT city) > 1
ORDER BY nimekujusid DESC;

/* 
8 linnal (Kuressaare, Paide, Pärnu, Rakvere, Tallinn, Tartu, Viljandi, Võru) 
on 5 erinevat nimekuju, 
3 linnal (Haapsalu, Jõhvi, Narva)
on 4 erinevat nimekuju
1 linnal (Valga)
on 2 erinevat nimekuju.
*/

-- 4.2 Loe ebajärjekindlate nimedega linnad kokku

SELECT COUNT(*) AS ebajärjekindlate_nimedega_linnad
FROM (
  SELECT INITCAP(TRIM(city)) AS linn,
  COUNT(DISTINCT city) AS nimekujusid
  FROM customers_test
  GROUP BY INITCAP(TRIM(city))
  HAVING COUNT(DISTINCT city) > 1
  ) AS ebajärjekindlaid;
--12 ebajärjekindlate nimedega linna.

-- 5. Kontrolli kontaktandmeid - puuduvad telefoninumbrid ja e-mailid

SELECT
    COUNT(*) FILTER (WHERE phone IS NULL OR phone = '') AS null_telefon,
    COUNT(*) FILTER (WHERE email IS NULL OR email = '') AS null_email
FROM customers_test;
-- 0 puuduvat telefoninumbrit, 380 puuduvat e-maili.
