-- Grupitöö nädal 5 --

-- Roll B: Marketing + koondvaade
-------------------------------------

-- 1. Tulpdiagramm --> Millised müügikanalid on kõige efektiivsemad?

SELECT 
    DATE_TRUNC('month', sale_date)::date AS kuu,
    COALESCE(store_location, 'Online') AS asukoht,
    ROUND(SUM(total_price), 0) AS kogukäive,
    COUNT(DISTINCT customer_id) AS kliente
FROM sales
GROUP BY COALESCE(store_location, 'Online'), DATE_TRUNC('month', sale_date)::date
ORDER BY kuu, kogukäive DESC;

-- 1.1 Lisa --> Kogukäibe ja klientide arv igas müügikanalis eraldi

SELECT 
    COALESCE(store_location, 'Online') AS asukoht,
    ROUND(SUM(total_price), 0) AS kogukäive,
    COUNT(DISTINCT customer_id) AS kliente
FROM sales
GROUP BY COALESCE(store_location, 'Online')
ORDER BY kogukäive DESC


-- 2. Joondiagramm --> Kuidas muutub uute klientide arv ajas?

SELECT
    DATE_TRUNC('month', registration_date)::date AS kuu,
    COUNT(DISTINCT customer_id) AS uusi_kliente
FROM customers
GROUP BY DATE_TRUNC('month', registration_date)::date
ORDER BY kuu DESC;                       


-- 3. Koondvaade --> KPI kaardid

SELECT 
    ROUND(SUM(total_price),0) AS kogukäive,
    COUNT(DISTINCT customer_id) AS kliendid,
    ROUND(AVG(total_price),0) AS keskmine_tellimus
FROM sales;

-- 3.1 Kogukäibe trend ajas --> ülevaatlikuks diagrammiks 26 kuu jaoks

SELECT
 DATE_TRUNC('month', sale_date)::date AS kuu,
 COUNT(sale_id) AS tellimuste_arv,
 ROUND(SUM(total_price),0) AS kogukäive,
 ROUND(AVG(total_price), 0) AS keskmine_hind
FROM sales
WHERE sale_date >= '2023-01-01' AND sale_date < '2025-03-01'
GROUP BY DATE_TRUNC('month', sale_date)::date
ORDER BY kuu;

-- 3.2 Kanalite efektiivsus

SELECT 
    channel AS müügikanal,
    COUNT(DISTINCT customer_id) AS kliente, 
    ROUND(SUM(total_price),0) AS kogukäive             
FROM sales
GROUP BY channel
ORDER BY kogukäive DESC;                                                           


-- 3.3 Aastase käibekasvu arvutus --> 4. KPI jaoks

WITH aastamüük AS    
(
 SELECT
  DATE_TRUNC('year', sale_date)::date AS aasta,
  ROUND(SUM(total_price),0) AS kogukäive
 FROM sales
 WHERE sale_date >= '2023-01-01' AND sale_date < '2025-01-01'
 GROUP BY DATE_TRUNC('year', sale_date)
)
SELECT
 aasta,
 kogukäive,
 LAG(kogukäive) OVER (ORDER BY aasta) AS eelmine_aasta,
 kogukäive - LAG(kogukäive) OVER (ORDER BY aasta) AS muutus,
 ROUND((kogukäive - LAG(kogukäive) OVER (ORDER BY aasta)) / LAG(kogukäive) OVER (ORDER BY aasta) * 100,0) AS kasvuprotsent
FROM aastamüük;






