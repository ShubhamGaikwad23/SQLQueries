
CREATE TABLE ORDERS (
    order_id VARCHAR(10),
    customer_id INT,
    order_datetime DATETIME,
    item_id VARCHAR(10),
    order_quantity INT
);



INSERT INTO ORDERS (order_id, customer_id, order_datetime, item_id, order_quantity) VALUES
('A-001', 32483, '2018-12-15 09:15:22', 'B000', 3),
('A-005', 21456, '2019-01-12 09:28:35', 'B001', 1),
('A-005', 21456, '2019-01-12 09:28:35', 'B005', 1),
('A-006', 42491, '2019-01-16 02:52:07', 'B008', 2);


SELECT * FROM ORDERS;

