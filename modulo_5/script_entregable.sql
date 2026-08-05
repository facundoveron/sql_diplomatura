--- Asegúrate de estar conectado a tu base de datos de PostgreSQL donde tienes las tablas de ventas, 
--- regiones y productos (creadas en módulos anteriores). 

select * from ventas;
select * from regiones;
select * from productos;

--- Crea una CTE llamada ventas_por_region. 
--- Dentro de ella, debes unir las tablas necesarias para obtener el nombre de la región y la suma total de las ventas (SUM(monto)). 

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
    r.nombre,
    v.total_ventas
FROM regiones r
JOIN ventas_por_region v
    ON r.id_region = v.id_region
ORDER BY v.total_ventas DESC;

--- Utiliza la CTE creada en una sentencia SELECT final. 
--- En este paso final, filtra los resultados para mostrar solo las regiones cuyo gran total de ventas sea superior al promedio general de todas las ventas 
--- (puedes usar una subconsulta simple dentro del WHERE para este promedio).

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