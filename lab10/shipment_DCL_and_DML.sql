-- Write valid DML statements to retrieve tuples from the databases. The 
-- query may contain appropriate DML and DCL commands such as:
-- Select with
-- %like, between, where clause
-- Order by
-- Set Operations
-- Exists and not exists
-- Join operations
-- Aggregate functions
-- Group by
-- Group by having
-- Nested and correlated nested Queries
-- Grant and revoke permission
-- Add 3 more tuples in each table

-- 1> list the customers who have letter 'r' in their name
SELECT name
FROM customer
WHERE name LIKE 'r';

-- 2> list all the names of customers and products who have ordered items in the month of october
SELECT C.name,OI.order_amount
FROM customer AS C, order_info AS OI
WHERE C.customer_id = OI.cust_id AND  OI.order_date LIKE '%10%';

-- 3>list the items in descending order of price
SELECT item_name,unit_price
FROM item
ORDER BY unit_price DESC;

-- 4>list the customers who have shopped for 10K or more
SELECT customer_id,name,order_amount
FROM customer,order_info
WHERE customer_id=cust_id AND order_amount>9999
ORDER BY order_amount DESC;

-- 5> how much is the total sales
SELECT SUM(order_amount) AS 'TOTAL SALES '
FROM order_info;

-- 6>How much does an average customer spend on orders
SELECT AVG(order_amount) AS 'Averege Spending'
FROM order_info;

-- 7>List the order_id and order_date ship_date of all orders shipped from warehouses other than Banglore
SELECT O.order_id,O.order_date,S.ship_date,W.city
FROM order_info AS O,shipment AS S,warehouse AS W
WHERE O.order_id=S.ord_id AND S.whouse_id= W.warehouse_id;

-- 8>Select customer who has not done payment
SELECT *
FROM customer
WHERE customer_id IN(
		SELECT cust_id
        FROM order_info
        WHERE order_id NOT IN(
			SELECT ord_id
            FROM shipment
            WHERE payment = 'done'));
            

-- 9> list the name and quantity of items ordered
SELECT I.item_name,OI.quantity
FROM item AS I,order_item AS OI
WHERE I.item_id=OI.itm_id
ORDER BY OI.quantity DESC;

-- 10> List the item and its source and destination addresses
SELECT DISTINCT I.item_name,W.city,C.city
FROM customer AS C,warehouse AS W, item AS I,order_item AS OI
WHERE C.customer_id IN(
	SELECT cust_id
    FROM order_info
    WHERE order_id IN (
		SELECT ord_id
        FROM shipment
        WHERE whouse_id=W.warehouse_id) AND order_id IN(SELECT o_id FROM order_item WHERE itm_id=item_id));
