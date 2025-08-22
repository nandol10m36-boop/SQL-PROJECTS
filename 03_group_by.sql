-- Base de datos
USE tienda;

-- Consultas con GROUP BY

-- 1. Total de productos por categoría
SELECT categoria, COUNT(*) AS cantidad_productos
FROM productos
GROUP BY categoria;

-- 2. Precio promedio por categoría
SELECT categoria, AVG(precio) AS precio_promedio
FROM productos
GROUP BY categoria;

-- 3. Categorías con más de 1 producto
SELECT categoria, COUNT(*) AS cantidad_productos
FROM productos
GROUP BY categoria
HAVING COUNT(*) > 1;

-- 4. Clientes y total gastado en todas sus compras
SELECT c.nombre, SUM(p.precio * v.cantidad) AS total_gastado
FROM ventas v
INNER JOIN clientes c ON v.cliente_id = c.id
INNER JOIN productos p ON v.producto_id = p.id
GROUP BY c.nombre
ORDER BY total_gastado DESC;

-- 5. Productos más vendidos (cantidad total)
SELECT p.nombre, SUM(v.cantidad) AS total_vendido
FROM ventas v
INNER JOIN productos p ON v.producto_id = p.id
GROUP BY p.nombre
ORDER BY total_vendido DESC;
