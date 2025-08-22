-- Base de datos de ejemplo
USE tienda;

-- Crear tabla clientes
CREATE TABLE clientes (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    ciudad VARCHAR(50)
);

-- Crear tabla ventas
CREATE TABLE ventas (
    id INT AUTO_INCREMENT PRIMARY KEY,
    cliente_id INT,
    producto_id INT,
    cantidad INT,
    fecha DATE,
    FOREIGN KEY (cliente_id) REFERENCES clientes(id),
    FOREIGN KEY (producto_id) REFERENCES productos(id)
);

-- Insertar clientes
INSERT INTO clientes (nombre, ciudad) VALUES
('Juan Pérez', 'Buenos Aires'),
('María Gómez', 'Córdoba'),
('Carlos Ruiz', 'Rosario');

-- Insertar ventas
INSERT INTO ventas (cliente_id, producto_id, cantidad, fecha) VALUES
(1, 1, 1, '2025-01-10'),
(1, 3, 2, '2025-01-15'),
(2, 2, 1, '2025-01-20'),
(3, 5, 3, '2025-02-01');

-- Consultas JOIN

-- 1. Mostrar todas las ventas con nombre del cliente y producto
SELECT v.id, c.nombre AS cliente, p.nombre AS producto, v.cantidad, v.fecha
FROM ventas v
INNER JOIN clientes c ON v.cliente_id = c.id
INNER JOIN productos p ON v.producto_id = p.id;

-- 2. Ventas realizadas por clientes de Buenos Aires
SELECT c.nombre, p.nombre AS producto, v.cantidad
FROM ventas v
INNER JOIN clientes c ON v.cliente_id = c.id
INNER JOIN productos p ON v.producto_id = p.id
WHERE c.ciudad = 'Buenos Aires';

-- 3. Total de productos vendidos agrupados por cliente
SELECT c.nombre, SUM(v.cantidad) AS total_comprado
FROM ventas v
INNER JOIN clientes c ON v.cliente_id = c.id
GROUP BY c.nombre
ORDER BY total_comprado DESC;
