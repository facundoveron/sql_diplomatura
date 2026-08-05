--- Asegúrate de estar conectado a tu base de datos de PostgreSQL donde tienes las tablas de ventas, 
--- regiones y productos (creadas en módulos anteriores).

WITH ventas_por_region AS (
    SELECT
        r.nombre,
        SUM(v.monto) AS total_ventas
    FROM ventas v
    JOIN regiones r ON v.id_region = r.id_region
    JOIN productos p ON v.id_producto = p.id_producto
    GROUP BY r.nombre
)
SELECT
    nombre,
    total_ventas
FROM ventas_por_region
WHERE total_ventas > (
    SELECT AVG(total_ventas)
    FROM ventas_por_region
)
ORDER BY total_ventas DESC;