CREATE DATABASE IF NOT EXISTS ecommerce_db;
USE ecommerce_db;

SET FOREIGN_KEY_CHECKS = 0;
DROP TABLE IF EXISTS order_items;
DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS products;
DROP TABLE IF EXISTS customers;
SET FOREIGN_KEY_CHECKS = 1;

CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(50),
    city VARCHAR(50)
);

DESC customers;

CREATE TABLE products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(50),
    category VARCHAR(50),
    price DECIMAL(10,2)
);

DESC products;


CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    status VARCHAR(20),
    FOREIGN KEY (customer_id)
        REFERENCES customers(customer_id)
);

DESC orders;

CREATE TABLE order_items (
    item_id INT PRIMARY KEY,
    order_id INT,
    product_id INT,
    quantity INT,
    unit_price DECIMAL(10,2),
    FOREIGN KEY (order_id)
        REFERENCES orders(order_id),
    FOREIGN KEY (product_id)
        REFERENCES products(product_id)
);

DESC order_items;

INSERT INTO customers VALUES
(1, 'Rahul', 'Hyderabad'),
(2, 'Priya', 'Vijayawada'),
(3, 'Asha', 'Guntur'),
(4, 'Kiran', 'Hyderabad'),
(5, 'Ravi', 'Guntur');

SELECT * FROM customers;

INSERT INTO products VALUES
(101, 'Laptop', 'Electronics', 50000),
(102, 'Mobile', 'Electronics', 20000),
(103, 'Headphones', 'Accessories', 2000),
(104, 'Keyboard', 'Accessories', 1500),
(105, 'Mouse', 'Accessories', 800);

SELECT * FROM products;

INSERT INTO orders VALUES
(1001, 1, '2026-01-10', 'Delivered'),
(1002, 2, '2026-01-12', 'Delivered'),
(1003, 3, '2026-02-05', 'Pending'),
(1004, 1, '2026-02-15', 'Delivered'),
(1005, 4, '2026-03-01', 'Cancelled');

SELECT * FROM orders;

INSERT INTO order_items VALUES
(1, 1001, 101, 1, 50000),
(2, 1001, 103, 2, 2000),
(3, 1002, 102, 1, 20000),
(4, 1003, 104, 2, 1500),
(5, 1004, 103, 1, 2000),
(6, 1004, 105, 2, 800),
(7, 1005, 102, 1, 20000);

SELECT * FROM order_items;

#1. Display All Customers
SELECT * FROM customers;

#2. Display All Products
SELECT * FROM products;

#3. Find Total Number of Orders
SELECT COUNT(*) AS total_orders
FROM orders;

#4. Calculate Total Sales
SELECT SUM(quantity * unit_price) AS total_sales
FROM order_items;

#5. Find Total Sales from Delivered Orders
SELECT SUM(oi.quantity * oi.unit_price) AS delivered_sales
FROM order_items oi
JOIN orders o ON oi.order_id = o.order_id
WHERE o.status = 'Delivered';

#6. Find the Most Expensive Product
SELECT * FROM products
ORDER BY price DESC
LIMIT 1;


#7. Find Customer Order Details
SELECT c.customer_name,
       o.order_id,
       o.order_date,
       o.status
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id;


#8. Find Number of Orders by Status
SELECT status,
       COUNT(*) AS total_orders
FROM orders
GROUP BY status;

#9. Find Customers from Hyderabad
SELECT *
FROM customers
WHERE city = 'Hyderabad';

#10. Find Products Costing More Than 5000
SELECT *
FROM products
WHERE price > 5000;
#
#11. find the Cheapest Product
SELECT *FROM products
ORDER BY price ASC
LIMIT 1;

#12. Find Delivered Orders
SELECT *FROM orders
WHERE status = 'Delivered';



#13. Find Products Priced Between 1000 and 25000
SELECT * FROM products
WHERE price BETWEEN 1000 AND 25000;

#14. Find Customers Who Have Not Placed Orders
SELECT c.customer_id,c.customer_name
FROM customers c
LEFT JOIN orders o ON c.customer_id = o.customer_id
WHERE o.order_id IS NULL;

#15. Calculate Total Quantity Sold
SELECT SUM(quantity) AS total_quantity_sold
FROM order_items;

#16. Display all customers and their orders, including customers without orders.
  SELECT c.customer_name, o.order_id,o.status
  FROM customers c
  LEFT JOIN orders o ON c.customer_id = o.customer_id;

#17. Find the number of products in each order.
SELECT order_id,
COUNT(DISTINCT product_id) AS total_products
FROM order_items
GROUP BY order_id;

#18.Count Customers in Each City
SELECT city,
       COUNT(*) AS total_customers
FROM customers
GROUP BY city;

 #19. Find the Average Price of Products
SELECT AVG(price) AS average_price
FROM products;

#20. Display Complete Order Details
SELECT o.order_id,
       c.customer_name,
       p.product_name,
       oi.quantity,
       oi.unit_price,
       oi.quantity * oi.unit_price AS total_amount,
       o.status
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
JOIN order_items oi ON o.order_id = oi.order_id
JOIN products p ON oi.product_id = p.product_id;
