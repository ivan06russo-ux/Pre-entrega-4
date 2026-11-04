USE Ventas_Tech_DB

SELECT * FROM dbo.Ventas

SELECT * FROM dbo.Productos

SELECT * FROM dbo.Clientes

SELECT * FROM dbo.Categoria

--CONSULTA 1

SELECT
	MONTH(fecha_venta) AS mes,
	SUM(cantidad * precio_unitario) AS total_facturado,
	COUNT(id_venta) AS cantidad_pedidos,
	AVG(cantidad * precio_unitario) AS promedio_de_venta
FROM dbo.Ventas
GROUP BY MONTH(fecha_venta);

--CONSULTA 2

SELECT TOP 5 id_producto,
	SUM(cantidad * precio_unitario) AS total_facturado,
	SUM(cantidad) AS cantidad_total
FROM dbo.Ventas
GROUP BY id_producto
ORDER BY total_facturado DESC;


--CONSULTA 3

SELECT
	id_cliente,
	count(*) AS pedidos,
	SUM(cantidad * precio_unitario) AS total_gastado
FROM dbo.Ventas
GROUP BY id_cliente
HAVING COUNT(*	) > 1;


--CONSULTA 4

WITH total_por_producto AS(
	SELECT
		id_producto AS producto,
		SUM(precio) AS precio_total
	FROM dbo.Productos
	GROUP BY id_producto
)
SELECT
	producto,
	precio_total,
	CASE
		WHEN precio_total > (SELECT AVG(precio_total) FROM total_por_producto) THEN 'Por encima'
		ELSE 'Por debajo'
	END AS resultado
FROM total_por_producto;


--1: El producto 1 fue el mayor generador de ingresos durante el mes
--2: El producto 2 fue el mas vendido del mes
--3: Los clientes 1 y 5 concentran la mayor cantidad de gastos

