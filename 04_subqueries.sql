-- SUBCONSULTAS EN MySQL
USE tienda;

-- =========================
-- 1) Subconsulta con IN
-- Productos vendidos al menos una vez
SELECT *
FROM productos
WHERE id IN (SELECT producto_id FROM ventas);

-- =========================
-- 2) Subconsulta con NOT IN
-- Productos que nunca se vendieron
SELECT *
FROM productos
WHERE id NOT IN (SELECT producto_id FROM ventas);

-- =========================
-- 3) Subconsulta ESCALAR (un solo valor)
-- Productos por encima del precio promedio global
SELECT id, nombre, precio
FROM productos
WHERE precio > (SELECT AVG(precio) FROM productos)
ORDER BY precio DESC;

-- =========================
-- 4) Subconsulta en FROM (tabla derivada)
-- Total vendido por producto (cantidad * ventas)
SELECT t.producto, t.total_vendido
FROM (
    SELECT p.nombre AS producto, SUM(v.cantidad) AS total_vendido
    FROM ventas v
    INNER JOIN productos p ON p.id = v.producto_id
    GROUP BY p.nombre
) AS t
ORDER BY t.total_vendido DESC;

-- =========================
-- 5) Subconsulta CORRELACIONADA
-- Clientes cuyo total gastado supera el promedio de TODOS los clientes
-- (compara cada cliente contra el promedio global)
SELECT c.id, c.nombre
FROM clientes c
WHERE (
    SELECT SUM(v.cantidad * p.precio)
    FROM ventas v
    INNER JOIN productos p ON p.id = v.producto_id
    WHERE v.cliente_id = c.id
) > (
    SELECT AVG(total_por_cliente) FROM (
        SELECT SUM(v2.cantidad * p2.precio) AS total_por_cliente
        FROM ventas v2
        INNER JOIN productos p2 ON p2.id = v2.producto_id
        GROUP BY v2.cliente_id
    ) t_avg
);

-- =========================
-- 6) EXISTS vs NOT EXISTS
-- Clientes que realizaron al menos una compra (EXISTS)
SELECT c.*
FROM clientes c
WHERE EXISTS (
    SELECT 1 FROM ventas v WHERE v.cliente_id = c.id
);

-- Clientes que nunca compraron (NOT EXISTS)
SELECT c.*
FROM clientes c
WHERE NOT EXISTS (
    SELECT 1 FROM ventas v WHERE v.cliente_id = c.id
);

-- =========================
-- 7) TOP N con subconsulta
-- Producto más caro p
