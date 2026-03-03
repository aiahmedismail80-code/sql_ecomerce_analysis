الايرادات لك فئة
SELECT p.category,
SUM(p.price * oi.quantity) AS revenue
FROM order_items_big oi
JOIN products_big p ON oi.product_id = p.product_id
GROUP BY p.category;

المنتجات اللتي لم يتم بيعها
SELECT product_name
FROM products_big
WHERE product_id NOT IN (
SELECT product_id FROM order_items_big
);

متوسط قيمة الطلب
SELECT AVG(order_total)
FROM (
SELECT o.order_id,
SUM(p.price * oi.quantity) AS order_total
FROM orders_big o
JOIN order_items_big oi ON o.order_id = oi.order_id
JOIN products_big p ON oi.product_id = p.product_id
GROUP BY o.order_id
) t;

الدول الاعلي مبيعا
SELECT c.country,
SUM(p.price * oi.quantity) AS revenue
FROM customers_big c
JOIN orders_big o ON c.customer_id = o.customer_id
JOIN order_items_big oi ON o.order_id = oi.order_id
JOIN products_big p ON oi.product_id = p.product_id
GROUP BY c.country
ORDER BY revenue DESC
LIMIT 1;

أفضل 3 منتجات في كل فئة
SELECT *
FROM (
SELECT p.category,
p.product_name,
SUM(oi.quantity) AS total_sold,
RANK() OVER (PARTITION BY p.category ORDER BY SUM(oi.quantity) DESC) AS rank
FROM order_items_big oi
JOIN products_big p ON oi.product_id = p.product_id
GROUP BY p.category, p.product_name
) t
WHERE rank <= 3;

أكثر عميل طلبات
SELECT c.customer_name,
COUNT(o.order_id) AS total_orders
FROM customers_big c
JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_name
ORDER BY total_orders DESC
LIMIT 1;


SELECT DATE_TRUNC('month', o.order_date) AS month,
SUM(p.price * oi.quantity) AS revenue
FROM orders_big o
JOIN order_items_big oi ON o.order_id = oi.order_id
JOIN products_big p ON oi.product_id = p.product_id
GROUP BY month
ORDER BY month;

العملاء بدون طلبات
SELECT c.customer_name
FROM customers_big c
LEFT JOIN orders_big o
ON c.customer_id = o.customer_id
WHERE o.order_id IS NULL;

ترتيب العملاء حسب الطلب
SELECT customer_id,
COUNT(order_id) AS total_orders,
RANK() OVER (ORDER BY COUNT(order_id) DESC) AS rank
FROM orders_big
GROUP BY customer_id;

اعلي طلب قيمة
SELECT o.order_id,
SUM(p.price * oi.quantity) AS order_value
FROM orders_big o
JOIN order_items_big oi ON o.order_id = oi.order_id
JOIN products_big p ON oi.product_id = p.product_id
GROUP BY o.order_id
ORDER BY order_value DESC
LIMIT 1;

متوسط المنتجات في الطلب
SELECT AVG(total_items)
FROM (
SELECT order_id,
SUM(quantity) AS total_items
FROM order_items_big
GROUP BY order_id
) t;


المدينة الاعلي طلبا
SELECT c.city,
COUNT(o.order_id) AS total_orders
FROM customers_big c
JOIN orders_big o ON c.customer_id = o.customer_id
GROUP BY c.city
ORDER BY total_orders DESC
LIMIT 1;

نسبة مبيعات كل صنف
SELECT category,
revenue,
revenue * 100.0 / SUM(revenue) OVER() AS percentage
FROM (
SELECT p.category,
SUM(p.price * oi.quantity) AS revenue
FROM order_items_big oi
JOIN products_big p ON oi.product_id = p.product_id
GROUP BY p.category
) t;


افضل 5 عملاء في كل دولة
SELECT *
FROM (
SELECT c.country,
c.customer_name,
SUM(p.price * oi.quantity) AS spending,
RANK() OVER (PARTITION BY c.country ORDER BY SUM(p.price * oi.quantity) DESC) AS rank
FROM customers_big c
JOIN orders_big o ON c.customer_id = o.customer_id
JOIN order_items_big oi ON o.order_id = oi.order_id
JOIN products_big p ON oi.product_id = p.product_id
GROUP BY c.country, c.customer_name
) t
WHERE rank <= 5;

,ترتيب المنتجات حسب الايرادات
SELECT p.product_name,
SUM(p.price * oi.quantity) AS revenue,
RANK() OVER (ORDER BY SUM(p.price * oi.quantity) DESC) AS rank
FROM order_items_big oi
JOIN products_big p ON oi.product_id = p.product_id
GROUP BY p.product_name;