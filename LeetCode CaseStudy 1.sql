
--- LEETCODE AMAZON CASE STUDY---------------------

--Creating warehouse_inventory Table
CREATE TABLE warehouse_inventory (
    warehouse VARCHAR(10),
    product VARCHAR(10),
    units INT
);

--Inserting Records
INSERT INTO warehouse_inventory (warehouse, product, units) VALUES ('ABC1', 'XYZ', 3);
INSERT INTO warehouse_inventory (warehouse, product, units) VALUES ('ABC1', 'DEF', 4);
INSERT INTO warehouse_inventory (warehouse, product, units) VALUES ('ABC1', 'LMN', 12);
INSERT INTO warehouse_inventory (warehouse, product, units) VALUES ('ABC1', 'GHI', 4);
INSERT INTO warehouse_inventory (warehouse, product, units) VALUES ('ABC2', 'XYZ', 10);
INSERT INTO warehouse_inventory (warehouse, product, units) VALUES ('ABC2', 'PQR', 1);
INSERT INTO warehouse_inventory (warehouse, product, units) VALUES ('ABC2', 'LMN', 4);
INSERT INTO warehouse_inventory (warehouse, product, units) VALUES ('ABC2', 'GHI', 7);
INSERT INTO warehouse_inventory (warehouse, product, units) VALUES ('ABC3', 'XYZ', 5);
INSERT INTO warehouse_inventory (warehouse, product, units) VALUES ('ABC3', 'PQR', 3);
INSERT INTO warehouse_inventory (warehouse, product, units) VALUES ('ABC3', 'GHI', 10);
INSERT INTO warehouse_inventory (warehouse, product, units) VALUES ('ABC3', 'LMN', 2);

-- Displaying records
SELECT * FROM warehouse_inventory

-- Creating Table product_dimensions_inches
CREATE TABLE product_dimensions_inches (
    product VARCHAR(10),
    width INT,   -- W (Width)
    length INT,  -- L (Length)
    height INT   -- H (Height)
);

-- Inserting Records
INSERT INTO product_dimensions_inches (product, width, length, height) VALUES ('XYZ', 12, 10, 8);
INSERT INTO product_dimensions_inches (product, width, length, height) VALUES ('PQR', 4, 3, 3);
INSERT INTO product_dimensions_inches (product, width, length, height) VALUES ('LMN', NULL, 5, 2);
INSERT INTO product_dimensions_inches (product, width, length, height) VALUES ('GHI', 10, 3, NULL);
INSERT INTO product_dimensions_inches (product, width, length, height) VALUES ('DEF', 3, 2, 4);
INSERT INTO product_dimensions_inches (product, width, length, height) VALUES ('JKL', 2, NULL, 2);

-- Displaying Records
SELECT * FROM product_dimensions_inches

-- Questions For BI Engineer

--------------------------------------------------
-- 1. How many unique products does the company have in inventory? correct

SELECT COUNT(DISTINCT(product))AS UNIQUE_PRODUCT_COUNT
FROM warehouse_inventory;

--------------------------------------------------
-- 2. How many units per warehouse?
SELECT warehouse, SUM(units) AS Total_Units 
FROM warehouse_inventory
GROUP BY warehouse

--------------------------------------------------
-- 3. How much cubic feet of volume does the inventory occupy in each warehouse?

WITH volume_Warehouse AS
(
    SELECT 
        wi.warehouse, 
        wi.product, 
        SUM((pd.width / 12.0) * (pd.length / 12.0) * (pd.height / 12.0) * wi.units) AS total_cubic_feet
    FROM 
        warehouse_inventory wi
    JOIN 
        product_dimensions_inches pd
    ON 
        wi.product = pd.product
    WHERE 
        pd.width IS NOT NULL 
        AND pd.length IS NOT NULL 
        AND pd.height IS NOT NULL  -- Ensure all dimensions are available for calculation
    GROUP BY 
        wi.warehouse, wi.product
)

SELECT * FROM volume_Warehouse;

--------------------------------------------------
-- 4. What % of cubic feet of volume does each warehouse contribute to the entire network?
WITH volume_Warehouse AS
(
    SELECT 
        wi.warehouse, 
        SUM((pd.width / 12.0) * (pd.length / 12.0) * (pd.height / 12.0) * wi.units) AS total_cubic_feet
    FROM 
        warehouse_inventory wi
    JOIN 
        product_dimensions_inches pd
    ON 
        wi.product = pd.product
    WHERE 
        pd.width IS NOT NULL 
        AND pd.length IS NOT NULL 
        AND pd.height IS NOT NULL  -- Ensure all dimensions are available for calculation
    GROUP BY 
        wi.warehouse
)

SELECT 
    vw.warehouse, 
    (vw.total_cubic_feet / (SELECT SUM(total_cubic_feet) FROM volume_Warehouse) * 100) AS percentage_contribution
FROM 
    volume_Warehouse vw;

--------------------------------------------------
-- 5. How many units of inventory in the company are either missing or have incomplete dimensions?

SELECT 
    SUM(wi.units) AS total_incomplete_units
FROM 
    warehouse_inventory wi
JOIN 
    product_dimensions_inches pd
ON 
    wi.product = pd.product
WHERE 
    pd.width IS NULL 
    OR pd.length IS NULL 
    OR pd.height IS NULL;

--------------------------------------------------
-- 6. What are the 3 most common products per warehouse?

WITH RankedProducts AS (
    SELECT 
        wi.warehouse, 
        wi.product, 
        wi.units,
        ROW_NUMBER() OVER (PARTITION BY wi.warehouse ORDER BY wi.units DESC) AS product_rank
    FROM 
        warehouse_inventory wi
)

SELECT 
    warehouse, 
    product, 
    units
FROM 
    RankedProducts
WHERE 
    product_rank <= 3
ORDER BY 
    warehouse, product_rank;

--------------------------------------------------