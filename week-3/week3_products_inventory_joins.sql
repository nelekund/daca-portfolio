-- Grupitöö nädal 3 --

-- Roll C: (Müümata toodete ja inventuuri analüüs)
--------------------------------------------------

-- 1. Leia tooted, mida pole kunagi müüdud

SELECT
 p.product_name,
 p.category,
 p.subcategory,
 p.retail_price,
 p.created_at,
 s.sale_id
FROM products p
LEFT JOIN sales s ON p.product_id = s.product_id
WHERE s.sale_id IS NULL
ORDER BY retail_price DESC;

-- 2. Loe müümata tooted kokku

SELECT
 COUNT(*) AS müümata_tooteid
FROM products p
LEFT JOIN sales s ON p.product_id = s.product_id
WHERE s.sale_id IS NULL;    

-- 4. Leia enim müüdud tooted

SELECT
 p.product_name,
 p.category,
 p.subcategory,
COUNT(s.sale_id) AS müüke,
SUM(s.total_price) AS kogumüük
FROM products p
INNER JOIN sales s ON p.product_id = s.product_id
GROUP BY p.product_id, p.product_name, p.category, p.subcategory
ORDER BY kogumüük DESC
LIMIT 10;    

--5. Analüüsi kategooriate kaupa tooteid ja müüke

SELECT
 p.category AS kategooria,
 COUNT(DISTINCT p.product_id) AS tooteid,
 COUNT(s.sale_id) AS müüke,
 SUM(s.quantity) AS müüdud_kogus,
 SUM(s.total_price) AS kogumüük
FROM products p
LEFT JOIN sales s ON p.product_id = s.product_id
GROUP BY p.category
ORDER BY müüdud_kogus DESC;

-- 6. Ühenda inventuuriga - millised tooted on laos?

SELECT
 p.product_name,
 p.category,
 i.location,        
 i.quantity_available,        
 i.reorder_point,
CASE            
 WHEN 
 i.quantity_available <= i.reorder_point THEN 'TELLI JUURDE'
 ELSE 'OK'
END AS staatus    
FROM products p
LEFT JOIN inventory i ON p.product_id = i.product_id
ORDER BY i.quantity_available;    

-- Mitu toodet on vaja juurde tellida?

SELECT
COUNT(*) AS juurde_tellida
FROM products p
INNER JOIN inventory i ON p.product_id = i.product_id
WHERE i.quantity_available <= i.reorder_point; -- 231 toodet

-- Tooted, mis on laos, aga pole kunagi müüdud

SELECT
p.product_name,
p.category,
i.quantity_available,
p.retail_price,
(p.retail_price * i.quantity_available) AS kinni_olev_raha
FROM products p
LEFT JOIN sales s ON p.product_id = s.product_id
LEFT JOIN inventory i ON p.product_id = i.product_id
WHERE s.sale_id IS NULL AND i.quantity_available > 0
ORDER BY kinni_olev_raha DESC;

-- Kus asuvad tooted, mida pole kordagi müüdud?

SELECT
 p.product_id,
 p.product_name,
 p.category,
 p.subcategory,
 p.retail_price,
 p.created_at,
 s.sale_id,
 i.location
FROM products p
LEFT JOIN sales s ON p.product_id = s.product_id
LEFT JOIN inventory i ON p.product_id = i.product_id
WHERE s.sale_id IS NULL
ORDER BY retail_price DESC;

-- (Kontrolliks) Sama nimega tooted tootetabelis

SELECT product_id,
product_name,
category,
subcategory,
retail_price,
created_at
FROM products
WHERE product_name IN
 (
 SELECT
 product_name
 FROM products
 GROUP BY product_name
 HAVING COUNT(*) > 1)
ORDER BY product_name, product_id;


