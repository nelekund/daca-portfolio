-- Grupitöö nädal 4 --

-- Roll A: Müügi koondandmed (Sales Aggregation)
-------------------------------------------------

-- 1. Müügid 2024. aasta kuude kaupa: tellimuste arv, kogukäive, keskmine tellimusväärtus

SELECT
 DATE_TRUNC('month', sale_date) AS kuu,
 COUNT(sale_id) AS tellimuste_arv,
 SUM(total_price) AS kogukäive,
 ROUND(AVG(total_price), 2) AS keskmine_hind
FROM sales
WHERE sale_date >= '2024-01-01' AND sale_date < '2025-01-01'
GROUP BY DATE_TRUNC('month', sale_date)
ORDER BY kuu;

-- 2. Müügid nende tootekategooriate kaupa, kus kogukäive on üle 500 000 €

SELECT
p.category AS kategooria,
COUNT(DISTINCT p.product_id) AS toodete_arv,
SUM(s.total_price) AS kogukäive,
ROUND(AVG(s.total_price)) AS keskmine_hind
FROM sales s
JOIN products p ON s.product_id = p.product_id
GROUP BY p.category
HAVING SUM(s.total_price) > 500000
ORDER BY kogukäive DESC;

-- 3. Kuised trendid CTE-ga

WITH kuumüük AS
 (      
  SELECT        
   DATE_TRUNC('month', sale_date) AS kuu,
   SUM(total_price) AS kogukäive
  FROM sales
  WHERE sale_date >= '2023-01-01' AND sale_date < '2025-01-01'
  GROUP BY DATE_TRUNC('month', sale_date)
 )    
SELECT
  kuu, 
  kogukäive,
  LAG(kogukäive) OVER (ORDER BY kuu) AS eelmine_kuu,
  kogukäive - LAG(kogukäive) OVER (ORDER BY kuu) AS muutus
FROM kuumüük
ORDER BY kuu;

-- 4. CTE + window function, arvuta kuust-kuusse kasvu protsent

WITH kuumüük AS
 (      
  SELECT        
   DATE_TRUNC('month', sale_date) AS kuu,
   SUM(total_price) AS kogukäive
  FROM sales
  WHERE sale_date >= '2023-01-01' AND sale_date < '2025-01-01'
  GROUP BY DATE_TRUNC('month', sale_date)
 )    
SELECT
  kuu, 
  kogukäive,
  LAG(kogukäive) OVER (ORDER BY kuu) AS eelmine_kuu,
  kogukäive - LAG(kogukäive) OVER (ORDER BY kuu) AS muutus,
  ROUND((kogukäive - LAG(kogukäive) OVER (ORDER BY kuu))/ LAG(kogukäive) OVER (ORDER BY kuu) * 100, 1) AS kasvu_protsent    
FROM kuumüük
ORDER BY kuu;



-- 5. Lisaarvutus --> 2023. aasta kogukäive VS 2024. aasta kogukäive ning kasvuprotsent

WITH aastamüük AS    
(
 SELECT
  DATE_TRUNC('year', sale_date) AS aasta,
  SUM(total_price) AS kogukäive
 FROM sales
 WHERE sale_date >= '2023-01-01' AND sale_date < '2025-01-01'
 GROUP BY DATE_TRUNC('year', sale_date)
)
SELECT
 aasta,
 kogukäive,
 LAG(kogukäive) OVER (ORDER BY aasta) AS eelmine_aasta,
 kogukäive - LAG(kogukäive) OVER (ORDER BY aasta) AS muutus,
 ROUND((kogukäive - LAG(kogukäive) OVER (ORDER BY aasta)) / LAG(kogukäive) OVER (ORDER BY aasta) * 100,2) AS kasvuprotsent
FROM aastamüük;






