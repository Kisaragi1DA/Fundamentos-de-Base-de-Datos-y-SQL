-- HAVING filtra resultados para quedarte solo con las categorias que cumplen una condición

SELECT cliente_id,
	COUNT (*) AS cantidad_de_pedidos
	FROM pedidos
GROUP BY cliente_id
HAVING COUNT (*) >= 5;

-- Filtrar primero con WHERE y despues con HAVING 

SELECT cliente_id,
	COUNT (*) AS pedidos_2024
	FROM pedidos 
WHERE EXTRACT(YEAR FROM fecha_pedido) = 2024
GROUP BY cliente_id
HAVING COUNT (*) > 3
ORDER BY pedidos_2024 DESC;

-- Categorias con más de 5 productos 

SELECT categoria_id,
	COUNT (*) AS cantidad_de_productos
	FROM productos 
GROUP BY categoria_id
HAVING COUNT (*) >= 5;

-- Paises con más de 10 clientes

SELECT pais_id,
	COUNT (*) AS cantidad_de_clientes
	FROM clientes 
GROUP BY pais_id
HAVING COUNT (*) >= 10
ORDER BY pais_id DESC;	

