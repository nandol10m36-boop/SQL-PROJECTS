-- Crear base de datos de ejemplo
CREATE DATABASE IF NOT EXISTS tienda;
USE tienda;

-- Crear tabla productos
CREATE TABLE productos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    categoria VARCHAR(50),
    precio DECIMAL(10,2),
    stock INT
);

-- Insertar datos de prueba
INSERT INTO productos (nombre, categoria, precio, stock) VALUES
('Laptop', 'Electrónica', 850.00, 10),
('Teléfono', 'Electrónica', 500.00, 25),
('Silla Gamer', 'Muebles', 200.00, 5),
('Escritorio', 'Muebles', 300.00, 8),
('Auriculares', 'Accesorios', 50.00, 40);

-- Consultas básicas
-- 1. Mostrar todos los productos
SELECT * FROM productos;

-- 2. Filtrar productos de la categoría 'Muebles'
SELECT nombre, precio FROM productos WHERE categoria = 'Muebles';

-- 3. Calcular el precio promedio de todos los productos
SELECT AVG(precio) AS precio_promedio FROM productos;

-- 4. Contar cuántos productos tienen stock mayor a 10
SELECT COUNT(*) AS productos_en_stock FROM productos WHERE stock > 10;
