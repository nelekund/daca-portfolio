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
ORDER BY kuu, kogukäive DESC
LIMIT 200;

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




