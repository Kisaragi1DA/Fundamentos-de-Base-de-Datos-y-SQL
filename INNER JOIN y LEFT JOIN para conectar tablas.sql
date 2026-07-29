-- Inner join, devuelve solo filas que tienen coincidencia en las dos tablas

SELECT p.cliente_id,
	   c.nombre AS nombres_clientes, 
	   c.apellido AS apellidos_clientes,
	COUNT (*) AS pedidos_2024
	FROM pedidos AS p
INNER JOIN clientes AS c ON p.cliente_id = c.cliente_id
GROUP BY p.cliente_id, c.nombre, c.apellido
HAVING COUNT (*) >= 3
ORDER BY pedidos_2024 DESC;

-- Left Join, devuelve todas las filas de la tabla izquierda, tenga o no coincidencia con la tabla derecha

SELECT 
	c.nombre,
	c.email,
	p.pedido_id
FROM clientes AS c
LEFT JOIN pedidos AS p ON c.cliente_id = p.cliente_id
WHERE p.pedido_id IS NULL 
ORDER BY c.nombre DESC;