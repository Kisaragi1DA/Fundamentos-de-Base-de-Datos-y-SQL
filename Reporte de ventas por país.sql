-- Explorar datos disponibles -- 
SELECT COUNT (*) AS total_clientes FROM clientes;
SELECT COUNT (*) AS total_pedidos FROM pedidos;
SELECT COUNT (*) AS total_detalle_de_pedidos FROM detalles_pedidos;
SELECT COUNT (*) AS total_productos FROM productos;

-- Construcción de reporte de ventas por pais --
SELECT 
	pa.nombre_pais AS pais,
COUNT (DISTINCT p.pedido_id) AS total_pedidos,
COUNT (DISTINCT p.cliente_id) AS clientes_unicos,
SUM(dp.cantidad::numeric * dp.precio_unitario) AS monto_total,
AVG(dp.cantidad::numeric * dp.precio_unitario) AS ticket_promedio
FROM pedidos p
INNER JOIN sucursales s ON p.sucursal_id = s.sucursal_id
INNER JOIN paises pa ON s.pais_id = pa.pais_id
INNER JOIN detalles_pedidos dp ON p.pedido_id = dp.pedido_id
GROUP BY pa.pais_id, pa.nombre_pais
ORDER BY monto_total DESC

-- Agregar formato a los numeros --

SELECT 
	pa.nombre_pais AS pais,
COUNT (DISTINCT p.pedido_id) AS total_pedidos,
COUNT (DISTINCT p.cliente_id) AS clientes_unicos,
TO_CHAR(SUM(dp.cantidad::numeric * dp.precio_unitario), 'FM$999,999,999.00' ) AS monto_total,
TO_CHAR(AVG(dp.cantidad::numeric * dp.precio_unitario), 'FM$999,999,999.00') AS ticket_promedio
FROM pedidos p
INNER JOIN sucursales s ON p.sucursal_id = s.sucursal_id
INNER JOIN paises pa ON s.pais_id = pa.pais_id
INNER JOIN detalles_pedidos dp ON p.pedido_id = dp.pedido_id
GROUP BY pa.pais_id, pa.nombre_pais
ORDER BY SUM(dp.cantidad::numeric * dp.precio_unitario) DESC

-- Variante 1: Reporte por MES -- 

SELECT 
	TO_CHAR(p.fecha_pedido, 'YYYY-MM') AS periodo,
COUNT (DISTINCT p.pedido_id) AS pedido,
SUM(dp.cantidad::numeric * dp.precio_unitario) AS monto_totaL
FROM pedidos p
INNER JOIN detalles_pedidos dp ON p.pedido_id = dp.pedido_id
GROUP BY TO_CHAR(p.fecha_pedido, 'YYYY-MM')
ORDER BY periodo DESC
LIMIT 12;

-- Variante 2: Top 10 productos más vendidos --

SELECT 
	pr.nombre_producto AS producto,
	ca.nombre_categoria AS categora,
SUM(dp.cantidad:: numeric) AS unidades_vendidas,
SUM(dp.cantidad::numeric * dp.precio_unitario) AS ingreso_total
FROM detalles_pedidos dp
INNER JOIN productos pr ON dp.producto_id = pr.producto_id
INNER JOIN categorias ca ON pr.categoria_id = ca.categoria_id
GROUP BY pr.producto_id, pr.nombre_producto, ca.nombre_categoria
ORDER BY ingreso_total DESC
LIMIT 10;
	