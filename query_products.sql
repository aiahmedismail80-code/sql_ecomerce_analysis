SELECT 
p.product_name,
SUM(oi.quantity) AS sold
FROM order_items_big oi
JOIN products_big p
ON oi.product_id = p.product_id
GROUP BY p.product_name
ORDER BY sold DESC
LIMIT 10;

SELECT 
c.country,
SUM(p.price * oi.quantity) AS revenue
FROM customers_big  c
JOIN orders_big o ON c.customer_id = o.customer_id
JOIN order_items_big oi ON o.order_id = oi.order_id
JOIN products_big p ON oi.product_id = p.product_id
GROUP BY c.country
ORDER BY revenue DESC;

SELECT 
DATE_TRUNC('month',order_date) AS month,
COUNT(order_id) AS total_orders
FROM orders_big
GROUP BY month
ORDER BY month;

المبيعات الخاصة بدولة الامارات
SELECT *
FROM customers_big
WHERE country = 'UAE';

عدد العملاء في كل دولة
SELECT country, COUNT(*) AS total_customers
FROM customers_big
GROUP BY country;

متوسط سعر النتجات 
SELECT AVG(price) AS avg_price
FROM products_big;

عدد الطلبات لكل عميل
SELECT customer_id, COUNT(order_id) AS total_orders
FROM orders_big
GROUP BY customer_id;

اول 10 طلبات
SELECT *
FROM orders_big
LIMIT 10;
ترتيب المنتجات حسب السعر
SELECT *
FROM products_big
ORDER BY price DESC;

عدد لدول عشوائي
SELECT DISTINCT city
FROM customers_big;

افضل النتجات مبيعا
SELECT p.product_name, SUM(oi.quantity) AS total_sold
FROM order_items_big oi
JOIN products_big p ON oi.product_id = p.product_id
GROUP BY p.product_name
ORDER BY total_sold DESC
LIMIT 10;

اجمالي الايرادات
SELECT SUM(p.price * oi.quantity) AS revenue
FROM order_items_big oi
JOIN products_big p ON oi.product_id = p.product_id

SELECT c.customer_name,
SUM(p.price * oi.quantity) AS total_spent
FROM customers_big c
JOIN orders_big o ON c.customer_id = o.customer_id
JOIN order_items_big oi ON o.order_id = oi.order_id
JOIN products_big p ON oi.product_id = p.product_id
GROUP BY c.customer_name
ORDER BY total_spent DESC
LIMIT 5;

SELECT DATE_TRUNC('month', order_date) AS month,
COUNT(order_id) AS total_orders
FROM orders_big
GROUP BY month
ORDER BY month;