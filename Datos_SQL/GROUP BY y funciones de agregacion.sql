-- COUNT básicos cuántos clientes hay
SELECT COUNT (*) AS total_clientes FROM clientes;

-- COUNT con valor en una columna específica (ignorando nulos)
SELECT COUNT (telefono) AS clientes_con_telefono FROM clientes;

-- SUM - sumar valores de una columna numérica 
SELECT SUM (total) AS total_ventas FROM pedidos; 

-- AVG - calcular el promedio de todos los valores de la columna
SELECT AVG (precio) AS precio_promedio FROM productos;

-- MIN y MAX - el valos más bajo y el más alto de rangos 
SELECT 
	MIN (precio) AS precio_minimo,
	MAX (precio) AS precio_maximo
FROM productos; 

-- GROUP BY básico 
SELECT 
	cliente_id, 
	COUNT (*) AS cantidad_pedidos
	FROM pedidos
	GROUP BY cliente_id
	ORDER BY cantidad_pedidos DESC 
	LIMIT 10;

-- GROUP BY con otra función de agregación 
SELECT 
	EXTRACT(YEAR  FROM fecha_pedido) AS anio, 
	EXTRACT(MONTH FROM fecha_pedido) AS mes, 
	COUNT (*) AS cantidad_pedidos,         
	SUM (total) AS total_ventas       
	FROM pedidos 
GROUP BY 
	EXTRACT(YEAR  FROM fecha_pedido), 
	EXTRACT(MONTH FROM fecha_pedido) 
ORDER BY anio, mes;
