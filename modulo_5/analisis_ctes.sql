--- Asegúrate de estar conectado a tu base de datos de PostgreSQL donde tienes las tablas de ventas, 
--- regiones y productos (creadas en módulos anteriores).

--- 1. Definición de la CTE (Common Table Expression):
--- Se unen las tablas ventas, regiones y productos para calcular el 
--- monto total de ventas por cada región.
WITH ventas_por_region AS (
    SELECT
        r.nombre,
        SUM(v.monto) AS total_ventas
    FROM ventas v
    JOIN regiones r ON v.id_region = r.id_region
    JOIN productos p ON v.id_producto = p.id_producto
    GROUP BY r.nombre
)

--- 2. Consulta principal y filtrado:
--- Se obtienen las regiones desde la CTE y se aplica un filtro mediante una subconsulta
--- para mostrar únicamente aquellas regiones cuyas ventas superen el promedio general.
SELECT
    nombre,
    total_ventas
FROM ventas_por_region
WHERE total_ventas > (
    SELECT AVG(total_ventas)
    FROM ventas_por_region
)
ORDER BY total_ventas DESC;
