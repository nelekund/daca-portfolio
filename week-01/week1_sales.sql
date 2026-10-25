-- sales tabeli ülevaade

-- 1. Mitu rida on? 

SELECT COUNT(*) AS ridade_arv FROM sales; 

-- 2. Millised veerud on tabelis?

SELECT * FROM sales
LIMIT 10;

-- 3. Andmete filtreerimine - ainult Tallinna kaupluse tehingud

SELECT * FROM sales
WHERE store_location = 'Tallinn'
ORDER BY sale_date desc
LIMIT 10;

-- 4. Suurimad ja väikseimad tehingud

--4.1 10 suurimat tehingut

SELECT * FROM sales
ORDER BY total_price desc
LIMIT 10;


--4.2 10 väikseimat tehingut

SELECT * FROM sales
ORDER BY total_price
LIMIT 10;

-- 5. Puuduvate väärtuste kontroll (NULL-id olulistes veergudes)
-- Mitmes reas on kliendi info puudu (customer_id)?

SELECT COUNT(*) - COUNT(customer_id) AS puuduv_klient
FROM sales;





--Lisaülesanded (A)

-- 6. DISTINCT päring (unikaalsed müügikanalid)

SELECT DISTINCT channel
FROM sales;

-- 7. COUNT päring (tehingute arv iga kaupluse kohta)

SELECT store_location, COUNT(*) AS tehingute_arv
FROM sales
GROUP BY store_location
ORDER BY tehingute_arv desc;

-- 8. Leia tehingud, kus summa on üle 100 EUR JA kauplus on Tallinnas

SELECT * FROM sales
WHERE total_price > 100 AND store_location = 'Tallinn'
ORDER by total_price desc;
