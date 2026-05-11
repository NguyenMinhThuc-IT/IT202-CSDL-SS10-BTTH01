CREATE DATABASE IF NOT EXISTS LabOptimization_DB;
USE LabOptimization_DB;

CREATE TABLE customers (
    customerNumber INT PRIMARY KEY,
    customerName VARCHAR(50),
    contactLastName VARCHAR(50),
    contactFirstName VARCHAR(50),
    phone VARCHAR(50),
    addressLine1 VARCHAR(50),
    city VARCHAR(50),
    country VARCHAR(50)
);

-- Thêm dữ liệu mẫu (Fake data) để chạy demo
INSERT INTO customers (customerNumber, customerName, contactLastName, contactFirstName, city, country)
VALUES 
(1, 'Atelier graphique', 'Schmitt', 'Carine', 'Nantes', 'France'),
(2, 'Signal Gift Stores', 'King', 'Jean', 'Las Vegas', 'USA'),
(3, 'La Rochelle Gifts', 'Labrune', 'Janine', 'Nantes', 'France'),
(4, 'Baane Mini Imports', 'Bergulfsen', 'Jonas', 'Stavern', 'Norway'),
(5, 'Mini Wheels Co.', 'Murphy', 'Diane', 'San Francisco', 'USA');

-- Bước 1: Đo lường hiệu năng ban đầu (Trước khi có Index)
EXPLAIN ANALYZE
SELECT * FROM customers
WHERE city = 'Nantes' AND contactLastName = 'Labrune';

-- Bước 2: Tạo chỉ mục đơn (Single Index)
CREATE INDEX idx_city ON customers(city);

-- Bước 3: Tạo chỉ mục phức hợp (Composite Index)
CREATE INDEX idx_customer_search ON customers(city, contactLastName);

-- Bước 4: Kiểm tra và So sánh hiệu năng
EXPLAIN ANALYZE
SELECT * FROM customers
WHERE city = 'Nantes' AND contactLastName = 'Labrune';

-- Bước 5: Dọn dẹp hệ thống
DROP INDEX idx_city ON customers;
DROP INDEX idx_customer_search ON customers;