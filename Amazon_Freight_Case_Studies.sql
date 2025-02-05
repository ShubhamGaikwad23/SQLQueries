-- Create the Customers table
CREATE TABLE Customers (
    id INT PRIMARY KEY,
    name VARCHAR(50)
);

-- Insert data into the Customers table
INSERT INTO Customers (id, name) VALUES
(1, 'Joe'),
(2, 'Henry'),
(3, 'Sam'),
(4, 'Max');



-- Create the Orders2 table
CREATE TABLE Orders2 (
    id INT PRIMARY KEY,
    customerId INT,
    FOREIGN KEY (customerId) REFERENCES Customers(id)
);

-- Insert data into the Orders table
INSERT INTO Orders2 (id, customerId) VALUES
(1, 3),
(2, 1);


SELECT * FROM Customers;
SELECT * FROM Orders2;

SELECT 
	C.id
FROM
	Customers C
		LEFT JOIN
	Orders2 O
	ON C.id = O.id;

	---------------------------------------------------------------
SELECT CAST(10 AS FLOAT)/3;
------------------------------------------------------------------------

CREATE TABLE PlayersTable2 (
    PlayerID INT,
    PlayerName NVARCHAR(50),
    GameDate DATE
);

INSERT INTO PlayersTable2 (PlayerID, PlayerName, GameDate)
VALUES
(1, 'Alice', '2025-01-01'),
(2, 'Bob', '2025-01-01'),
(3, 'Charlie', '2025-01-02'),
(1, 'Alice', '2025-01-02'),
(2, 'Bob', '2025-01-03'),
(4, 'Diana', '2025-01-03'),
(3, 'Charlie', '2025-01-03'),
(5, 'Eve', '2025-01-04'),
(4, 'Diana', '2025-01-04');

SELECT * FROM PlayersTable2;

SELECT 
	LAG(PlayerID,1) OVER(ORDER BY PlayerID) AS Previous,PlayerID
FROM	
	PlayersTable2

SELECT PlayerName FROM PlayersTable2 WHERE PlayerID%2 = 1;

------------------------------------------------------------------

---------------------- Amazon Freight - CASE STUDY 1  ------------------------------

--Shipments Table

CREATE TABLE Shipments (
    ShipmentID INT PRIMARY KEY,
    RouteID INT,
    ShipmentDate DATE,
    Cost DECIMAL(10, 2)
);

INSERT INTO Shipments (ShipmentID, RouteID, ShipmentDate, Cost) VALUES
(1, 101, '2024-01-01', 500.00),
(2, 102, '2024-01-01', 600.00),
(3, 101, '2024-01-02', 450.00),
(4, 103, '2024-01-03', 800.00),
(5, 104, '2024-01-04', 300.00),
(6, 101, '2024-01-05', 500.00);

---------------------------------------------------------------

-- Routes Table
CREATE TABLE Routes (
    RouteID INT PRIMARY KEY,
    Source VARCHAR(50),
    Destination VARCHAR(50)
);

INSERT INTO Routes (RouteID, Source, Destination) VALUES
(101, 'Seattle', 'Los Angeles'),
(102, 'Chicago', 'New York'),
(103, 'Dallas', 'San Francisco'),
(104, 'Houston', 'Denver');

SELECT * FROM Routes;

-- TruckUtilization Table
CREATE TABLE TruckUtilization (
    TruckID INT PRIMARY KEY,
    MaxCapacity INT,
    UsedCapacity INT
);

INSERT INTO TruckUtilization (TruckID, MaxCapacity, UsedCapacity) VALUES
(1, 2000, 1500),
(2, 2500, 2000),
(3, 1800, 1400),
(4, 3000, 2200);

SELECT 

-- ShipmentDelays Table
CREATE TABLE ShipmentDelays (
    ShipmentID INT PRIMARY KEY,
    RouteID INT,
    PlannedArrival DATETIME, -- Use DATETIME for storing date and time
    ActualArrival DATETIME   -- Use DATETIME for the second column as well
);

INSERT INTO ShipmentDelays (ShipmentID, RouteID, PlannedArrival, ActualArrival) VALUES
(1, 101, '2024-01-01 10:00:00', '2024-01-01 12:00:00'),
(2, 102, '2024-01-01 11:00:00', '2024-01-01 11:30:00'),
(3, 101, '2024-01-02 09:00:00', '2024-01-02 10:00:00'),
(4, 103, '2024-01-03 14:00:00', '2024-01-03 18:00:00'),
(5, 104, '2024-01-04 08:00:00', '2024-01-04 08:30:00');


SELECT * FROM ShipmentDelays;

-- TruckLogs Table
CREATE TABLE TruckLogs (
    TruckID INT,
    StartTime DATETIME,
    EndTime DATETIME2
);

INSERT INTO TruckLogs (TruckID, StartTime, EndTime) VALUES
(1, '2024-01-01 08:00:00', '2024-01-01 16:00:00'),
(1, '2024-01-02 08:00:00', '2024-01-02 14:00:00'),
(2, '2024-01-01 09:00:00', '2024-01-01 17:00:00'),
(3, '2024-01-03 10:00:00', '2024-01-03 18:00:00'),
(4, '2024-01-04 12:00:00', '2024-01-04 20:00:00');


-- Carriers Table
CREATE TABLE Carriers (
    CarrierID INT PRIMARY KEY,
    CarrierType VARCHAR(20) -- 'Amazon' or 'Third-Party'
);

INSERT INTO Carriers (CarrierID, CarrierType) VALUES
(1, 'Amazon'),
(2, 'Third-Party'),
(3, 'Amazon'),
(4, 'Third-Party');

-- Customers Table
CREATE TABLE Customers2 (
    CustomerID INT PRIMARY KEY,
    SignupDate DATE
);

INSERT INTO Customers2 (CustomerID, SignupDate) VALUES
(1, '2024-01-01'),
(2, '2024-01-05'),
(3, '2024-01-10'),
(4, '2024-01-15'),
(5, '2024-01-20');

----------------------------------------------------------------------

--Case Study 1: 
	/*Calculate Total Shipments Per Day
	Problem: You are given a Shipments table with the following schema:
	ShipmentID (integer)
	RouteID (integer)
	ShipmentDate (date)
	Write a query to calculate the total number of shipments handled by Amazon Freight on each day.*/
SELECT
    ShipmentDate,
    COUNT(*) AS TotalShipments
FROM
    Shipments
GROUP BY
    ShipmentDate
ORDER BY
    ShipmentDate;


--Case Study 2:
	/*Identify Active Routes
	Problem: From the Shipments table, identify all unique routes that had at least one shipment.*/
SELECT 
	DISTINCT RouteId
FROM
	Shipments;

--Case Study 3:
	/*Calculate Revenue Per Route
	Problem: You are given a Shipments table with:
	ShipmentID (integer)
	RouteID (integer)
	Cost (decimal)
	Write a query to calculate the total revenue (sum of Cost) for each route.*/
SELECT 
	RouteID,
	SUM(Cost) AS Revenue
FROM	
	Shipments
GROUP BY RouteID;

--Case Study 4:
	/*Utilization Rate
	Problem: You are given a TruckUtilization table with:

	TruckID (integer)
	MaxCapacity (integer)
	UsedCapacity (integer)
	Write a query to calculate the utilization rate (percentage of UsedCapacity out of MaxCapacity) for each truck.*/
SELECT * FROM TruckUtilization;

SELECT
	TruckID,
	ROUND(SUM(UsedCapacity * 1.0 /MaxCapacity),2) AS utilizationrate
FROM	
	TruckUtilization
GROUP BY TruckID;

SELECT
    TruckID,
    ROUND((UsedCapacity * 100.0) / MaxCapacity, 2) AS UtilizationRate
FROM
    TruckUtilization;

--Case Study 5: Optimize Routes by Cost
	/*Problem: You are given a Shipments table with:

	ShipmentID (integer)
	RouteID (integer)
	Cost (decimal)
	And a Routes table with:

	RouteID (integer)
	Source (varchar)
	Destination (varchar)
	Write a query to identify the top 5 most expensive routes (by total cost).*/

SELECT * FROM Shipments;

SELECT * FROM Routes;

SELECT
	TOP 5 S.RouteID,
	R.Source,
	R.Destination,
	SUM(S.Cost) AS TotalCost
FROM	
	Shipments S
		LEFT JOIN
	Routes R
ON S.RouteID = R.RouteID
GROUP BY S.RouteID, R.Source, R.Destination
ORDER BY TotalCost DESC;

--Case Study 6: Predict Delays
	/*Problem: You are given a ShipmentDelays table with:

	ShipmentID (integer)
	RouteID (integer)
	PlannedArrival (timestamp)
	ActualArrival (timestamp)
	Write a query to calculate the delay (in hours) for each shipment and identify routes with an average delay of more than 2 hours.*/

SELECT * FROM ShipmentDelays;

SELECT
	ShipmentID, 
	AVG(Datediff(HOUR, ActualArrival, PlannedArrival)) AS Avg
FROM	
	ShipmentDelays
GROUP BY ShipmentID
HAVING AVG(Datediff(HOUR, ActualArrival, PlannedArrival)) > 2 ;

----------------------------------------------------------------------------------------------
--Case Study 7: Idle Time Analysis
	/*Problem: You are given a TruckLogs table with:

	TruckID (integer)
	StartTime (timestamp)
	EndTime (timestamp)
	Write a query to calculate the total idle time (hours) for each truck, assuming StartTime and EndTime represent the times a truck was in operation.*/

SELECT * FROM TruckLogs;

WITH Active AS
(
SELECT 
	TruckID,
	SUM(DateDIFF(HOUR, StartTime, EndTime)) AS Active_Hrs
FROM 
	TruckLogs 
GROUP BY TruckID
),

Total_Available AS
(
SELECT 
	TruckID,
	24 * (COUNT(DISTINCT StartTime)) AS Total_Hrs
FROM 
	TruckLogs 
GROUP BY TruckID
)

SELECT
	A.TruckID,
	T.Total_Hrs - A.Active_Hrs AS IDLE_Time
FROM 
	Active A
		JOIN
	Total_Available T
ON A.TruckID = T.TruckID;

------------------------------------------------------------------------------

--Case Study 8: Efficiency of Third-Party Carriers
	/*Problem: You are given a Carriers table with:

	CarrierID (integer)
	CarrierType (varchar) -- values: "Amazon", "Third-Party"
	And a Shipments table with:

	ShipmentID (integer)
	CarrierID (integer)
	Cost (decimal)
	Write a query to calculate the average shipment cost for Amazon carriers versus third-party carriers.*/

SELECT * FROM Carriers;
SELECT * FROM Shipments;

SELECT
	AVG(Cost) AS Avg_Cost,
	C.CarrierType
FROM
	Shipments S
		JOIN
	Carriers C
ON S.ShipmentID = C.CarrierID
GROUP BY C.CarrierType;

------------------------------------------------------------------------
/*Question 1: Shipment Volume by Week
You are given a Shipments table with the following columns:

ShipmentID (integer)
RouteID (integer)
ShipmentDate (date)
Write a query to calculate the total number of shipments handled per week.*/

SELECT * FROM Shipments;

SELECT
	DATEPART(WEEK,ShipmentDate) AS WEEK,
	COUNT(shipments) AS Total
FROM 
	Shipments
GROUP BY DATEPART(WEEK,ShipmentDate);

/*Question 2: Average Cost per Shipment
From the Shipments table, calculate the average cost per shipment for each route. */

SELECT 
	ShipmentID,
	AVG(Cost) AS Average_Cost
FROM
	Shipments
GROUP BY ShipmentID;

/*Question 3: Route Utilization
You have the following tables:

Routes Table:

RouteID (integer)
TruckCapacity (integer)
Shipments Table:

RouteID (integer)
ShipmentWeight (integer)
Write a query to calculate the utilization rate (percentage of ShipmentWeight to TruckCapacity) for each route. */

SELECT * FROM Routes;
SELECT * FROM Shipments;

SELECT
    r.RouteID,
    SUM(s.ShipmentWeight) * 100.0 / r.TruckCapacity AS UtilizationRate
FROM
    Routes r
JOIN
    Shipments s ON r.RouteID = s.RouteID
GROUP BY
    r.RouteID, r.TruckCapacity;



/*Question 4: Delays by Route
You are given a ShipmentDelays table with:

ShipmentID (integer)
RouteID (integer)
PlannedArrival (timestamp)
ActualArrival (timestamp)
Write a query to calculate the average delay (in hours) for each route.*/


SELECT * FROM ShipmentDelays;

SELECT
	RouteID,
	SUM(Datediff(Hour, ActualArrival, PlannedArrival)) AS Avg_Delay
FROM ShipmentDelays
GROUP BY RouteID;

/*Question 5: Identify Low-Cost Routes
From the Shipments table, identify the 3 routes with the lowest average shipping cost.*/

SELECT * FROM Shipments;

SELECT 
	TOP 3 RouteID,
	AVG(Cost) As Average_Cost
FROM	
	Shipments
GROUP BY RouteID
ORDER BY AVG(Cost);

/*Question 6: Driver Performance
You are given a Drivers table and a Shipments table:

Drivers Table:

DriverID (integer)
DriverName (varchar)
Shipments Table:

ShipmentID (integer)
DriverID (integer)
ShipmentDate (date)
Distance (integer) -- in miles
Write a query to find the total distance driven by each driver for the past month. */

SELECT * FROM Drive

SELECT
    d.DriverName,
    SUM(s.Distance) AS TotalDistance
FROM
    Drivers d
JOIN
    Shipments s ON d.DriverID = s.DriverID
WHERE
    ShipmentDate >= DATEADD(MONTH, -1, GETDATE())
GROUP BY
    d.DriverName;


/*Question 7: Revenue vs. Cost Analysis
You are given a Shipments table with:

ShipmentID (integer)
RouteID (integer)
Revenue (decimal)
Cost (decimal)
Write a query to calculate the profit margin (percentage of (Revenue - Cost) / Revenue) for each route.*/

SELECT * FROM Shipments;

SELECT 

FROM
	Shipments

	SELECT
    RouteID,
    ROUND((SUM(Revenue - Cost) * 100.0) / SUM(Revenue), 2) AS ProfitMargin
FROM
    Shipments
GROUP BY
    RouteID;


/*Question 8: Unused Routes
You have the following tables:

Routes Table:

RouteID (integer)
Shipments Table:

RouteID (integer)
Write a query to find all routes that have never been used in the Shipments table. */


/* Question 9: Peak Shipping Days
From the Shipments table, find the top 3 days with the highest total number of shipments. */

SELECT
    r.RouteID
FROM
    Routes r
LEFT JOIN
    Shipments s ON r.RouteID = s.RouteID
WHERE
    s.RouteID IS NULL;



--------------------------------------------------------------------------------------------
-- Shipments2 Table
CREATE TABLE Shipments2 (
    ShipmentID INT PRIMARY KEY,
    RouteID INT,
    ShipmentDate DATE,
    ShipmentWeight INT,
    Revenue DECIMAL(10, 2),
    Cost DECIMAL(10, 2),
    DriverID INT
);

INSERT INTO Shipments2 (ShipmentID, RouteID, ShipmentDate, ShipmentWeight, Revenue, Cost, DriverID) VALUES
(1, 101, '2024-01-01', 200, 500.00, 300.00, 1),
(2, 102, '2024-01-02', 450, 800.00, 500.00, 2),
(3, 103, '2024-01-02', 100, 200.00, 150.00, 3),
(4, 101, '2024-01-03', 300, 600.00, 400.00, 1),
(5, 102, '2024-01-03', 250, 700.00, 450.00, 2);

-- Routes2 Table
CREATE TABLE Routes2 (
    RouteID INT PRIMARY KEY,
    Source VARCHAR(100),
    Destination VARCHAR(100),
    TruckCapacity INT
);

INSERT INTO Routes2 (RouteID, Source, Destination, TruckCapacity) VALUES
(101, 'Seattle', 'Portland', 500),
(102, 'New York', 'Boston', 600),
(103, 'Chicago', 'Detroit', 400);

-- Drivers Table
CREATE TABLE Drivers2 (
    DriverID INT PRIMARY KEY,
    DriverName VARCHAR(100)
);

INSERT INTO Drivers2 (DriverID, DriverName) VALUES
(1, 'John Doe'),
(2, 'Jane Smith'),
(3, 'Bob Johnson');

-- ShipmentDelays Table
CREATE TABLE ShipmentDelays2 (
    ShipmentID INT PRIMARY KEY,
    RouteID INT,
    PlannedArrival DATETIME,
    ActualArrival DATETIME
);

INSERT INTO ShipmentDelays2 (ShipmentID, RouteID, PlannedArrival, ActualArrival) VALUES
(1, 101, '2024-01-02 10:00:00', '2024-01-02 12:00:00'),
(2, 102, '2024-01-03 14:00:00', '2024-01-03 14:30:00'),
(3, 103, '2024-01-03 08:00:00', '2024-01-03 09:00:00'),
(4, 101, '2024-01-04 11:00:00', '2024-01-04 13:30:00'),
(5, 102, '2024-01-05 16:00:00', '2024-01-05 17:00:00');

---------------------------------------------------------------
/*Case Study Questions
Question 1: Calculate Profit Per Route
Write a query to calculate the total profit (Revenue - Cost) for each route.*/

SELECT * FROM Shipments2;

SELECT
	RouteID,
	SUM(Revenue - Cost) AS Profit
FROM Shipments2
GROUP BY RouteID;

/*Question 2: Identify Delays
From the ShipmentDelays table, calculate the average delay (in hours) for each route. */


SELECT * FROM ShipmentDelays2;

SELECT 
	RouteID,
	AVG(DATEDIFF(HOUR, PlannedArrival, ActualArrival)) AS AVG_Delay
FROM 
	ShipmentDelays2
GROUP BY RouteID;

/*Question 3: Route Utilization
Using the Routes and Shipments tables, calculate the average truck utilization (percentage of ShipmentWeight to TruckCapacity) for each route.*/

SELECT * FROM Routes2;
SELECT * FROM Shipments2;

SELECT
	R.RouteID,
	ROUND(SUM(S.ShipmentWeight * 100 / R.TruckCapacity),2) AS truck_Utilization
FROM	
	Shipments2 S
		RIGHT JOIN
	Routes2 R
ON S.RouteID = R.RouteID
GROUP BY R.RouteID;

/*Question 4: Identify Top Drivers
Using the Shipments and Drivers tables, find the total revenue generated by each driver, and rank the drivers based on revenue.*/

SELECT * FROM Shipments2;
SELECT * FROM Drivers2;

SELECT
	D.DriverID,
	SUM(S.Revenue) AS Revenue
FROM 
	Drivers2 D
		LEFT JOIN
	Shipments2 S
ON D.DriverID = S.DriverID
GROUP BY D.DriverID
ORDER BY Revenue;

/*Question 5: Find Idle Routes
Identify all routes from the Routes table that have no shipments recorded in the Shipments table. */

SELECT * FROM Routes2;
SELECT * FROM Shipments2;

SELECT
	R.RouteID,
	R.Source,
	R.Destination
FROM	
	Routes2 R
		RIGHT JOIN
	Shipments2 S
ON R.RouteID = S.RouteID
WHERE S.RouteID IS NULL;

/*Question 6: Peak Shipping Routes
From the Shipments table, identify the top 3 routes with the highest total shipment weight. */

SELECT * FROM Shipments2;

SELECT 
	TOP 3 RouteID,
	SUM(ShipmentWeight) AS TotalShipmentWeight
FROM	
	Shipments2
GROUP BY RouteID
ORDER BY TotalShipmentWeight DESC;

/*Question 7: Shipment Weight Categorization
Classify shipments from the Shipments table into "Light" (less than 100 lbs), "Medium" (100-500 lbs), and "Heavy" (greater than 500 lbs). Count the number of shipments in each category. */

SELECT * FROM Shipments2;

SELECT
	CASE WHEN ShipmentWeight < 100 THEN 'Light' 
		 WHEN ShipmentWeight BETWEEN 100 AND 500 THEN 'Medium'
		 WHEN ShipmentWeight > 500 THEN 'Heavy'
	END AS Category,
	COUNT(*) ShipmentCount

FROM
	Shipments2
GROUP BY CASE WHEN ShipmentWeight < 100 THEN 'Light' 
	     WHEN ShipmentWeight BETWEEN 100 AND 500 THEN 'Medium'
	     WHEN ShipmentWeight > 500 THEN 'Heavy'
	     END;

/*Question 8: Revenue Trends
Write a query to calculate the total revenue generated each day from shipments.*/

SELECT * FROM Shipments2;

SELECT
	ShipmentDate,
	SUM(Revenue)
FROM
	Shipments2
GROUP BY ShipmentDate;

/*Question 9: Delays Exceeding Threshold
Identify all shipments from the ShipmentDelays table that had a delay exceeding 2 hours.*/

SELECT * FROM ShipmentDelays2;

SELECT
    ShipmentID,
    RouteID,
    DATEDIFF(HOUR, PlannedArrival, ActualArrival) AS DelayHours
FROM
    ShipmentDelays
WHERE
    DATEDIFF(HOUR, PlannedArrival, ActualArrival) > 2;


/*Question 10: Monthly Route Analysis
Using the Shipments table, calculate the total revenue, total cost, and total shipment weight for each route on a monthly */

SELECT * FROM Shipments2;

SELECT
	Datepart(Year, ShipmentDate) AS Year,
	Datepart(Month, ShipmentDate) AS Month,
	RouteID,
	SUM(Revenue) AS Total_Revenue,
	SUM(Cost) AS Total_Cost,
	SUM(ShipmentWeight) AS Total_Weight
FROM
	Shipments2 
GROUP BY RouteID, Datepart(Year, ShipmentDate), Datepart(Month, ShipmentDate);

SELECT LEFT(CONVERT(VARCHAR, ShipmentDate, 23), 7) AS YearMonth
FROM Shipments2;

------------------------------------------------------------------------------
/* Question 1: Identify the Most Profitable Driver by Route
Write a query to find the most profitable driver (based on total profit: Revenue - Cost) for each route. */

SELECT * FROM Drivers2;
SELECT * FROM Routes;
SELECT * FROM Shipments2;
SELECT * FROM TruckLogs;
SELECT * FROM TruckUtilization;
SELECT * FROM ShipmentDelays2;

WITH Profit AS
(SELECT 
	DriverID,
	SUM(Revenue - Cost) AS Profit
FROM 
	Shipments2
GROUP BY DriverID
)

SELECT
	DriverID
FROM
	Profit
WHERE Profit = (SELECT MAX(Profit) FROM Profit);

/* Question 2: Calculate Route-Level Utilization Trends
Write a query to calculate the average truck utilization (percentage of ShipmentWeight to TruckCapacity) for each route, grouped by month and year. Include months even if no shipments occurred. */



/* Question 3: Delayed Revenue Impact
From the ShipmentDelays and Shipments tables, calculate the total revenue lost for shipments delayed by more than 3 hours. */

SELECT
	S1.ShipmentID,
	SUM(S2.Revenue) AS Loss
FROM
	ShipmentDelays2 S1
		JOIN
	Shipments2 S2
ON S1.ShipmentID = S2.ShipmentID
WHERE DATEDIFF(HOUR, PlannedArrival, ActualArrival) > 3
GROUP BY S1.ShipmentID;

/* Question 4: Driver Utilization Report
Generate a report showing the following for each driver:
Total shipments handled
Total distance traveled
Total revenue generated
Average shipment weight
Assume Distance is available in the Shipments table. */






/*Question 5: Predictive Metrics for Delays
Using the ShipmentDelays table, calculate:

The percentage of shipments delayed for each route
The average delay time (in hours) for each route
The maximum delay time for each route*/



/*Question 6: Underutilized Routes
Identify routes where the average truck utilization (percentage of ShipmentWeight to TruckCapacity) was less than 50% for all shipments.*/




/*Question 7: Shipment Cost Efficiency
Identify the top 5 routes that had the lowest cost efficiency, defined as (Cost / ShipmentWeight).*/




/*Question 8: Monthly Profit Trend by Driver
Write a query to calculate the monthly profit trend for each driver, grouped by driver and month, showing:

Month
Total revenue
Total cost
Total profit */





/*Question 9: Consecutive Delayed Shipments
Identify routes where two or more consecutive shipments were delayed by more than 2 hours. Include the shipment IDs and delay times.*/





/*Question 10: Revenue Breakdown by Shipment Weight Categories
Using shipment weight categories ("Light," "Medium," "Heavy"), calculate:

Total revenue generated by each category
Percentage contribution of each category to the total revenue */




----------------------------------------------------------------------
-- Window Functions based Questions

/*Question 1: Rank Routes by Total Profit
Using the Shipments table, rank the routes based on their total profit (Revenue - Cost). Include the total profit and the rank in the output. */

SELECT * FROM Shipments2;

SELECT
	RouteId,
	SUM(Revenue - Cost) AS Total_Profit,
	RANK() OVER(ORDER BY SUM(Revenue - Cost) DESC) AS Rank
FROM
	Shipments2
GROUP BY RouteID;

--Question 2: Calculate Cumulative Revenue
--Using the Shipments table, calculate the cumulative revenue for each route over time, ordered by ShipmentDate. Include ShipmentID, ShipmentDate, and cumulative revenue in the output.


SELECT
    RouteID,
    ShipmentID,
    ShipmentDate,
    SUM(Revenue) OVER (PARTITION BY RouteID ORDER BY ShipmentDate) AS CumulativeRevenue
FROM
    Shipments2;

--Question 3: Find Top Shipment per Driver
--Using the Shipments table, find the top shipment (highest revenue) for each driver. Include DriverID, ShipmentID, and Revenue.

SELECT * FROM Shipments2;

WITH Rank_Driver AS
(
SELECT
	DriverID,
	ShipmentID,
	Revenue,
	RANK() OVER(PARTITION BY DriverID ORDER BY Revenue DESC) AS Rank
FROM
	Shipments2
)

SELECT
	DriverID,
	ShipmentID,
	Revenue
FROM
	Rank_Driver
WHERE Rank = 1;

--Question 4: Average Delay per Shipment
--Using the ShipmentDelays table, calculate the average delay (in hours) for each shipment and compare it to the overall average delay across all shipments. Include ShipmentID, RouteID, AverageDelayPerShipment, and OverallAverageDelay.

SELECT * FROM ShipmentDelays2;

WITH Delays AS (
    SELECT
        ShipmentID,
        RouteID,
        DATEDIFF(HOUR, PlannedArrival, ActualArrival) AS DelayHours
    FROM
        ShipmentDelays
),

OverallAverage AS (
    SELECT
        AVG(DelayHours) AS OverallAverageDelay
    FROM
        Delays
)

SELECT
    d.ShipmentID,
    d.RouteID,
    AVG(d.DelayHours) OVER (PARTITION BY d.ShipmentID) AS AverageDelayPerShipment,
    o.OverallAverageDelay
FROM
    Delays d
CROSS JOIN
    OverallAverage o;

--Question 5: Identify Consecutive Shipment Growth
--Using the Shipments table, identify shipments where the revenue increased compared to the previous shipment for the same route. Include ShipmentID, RouteID, Revenue, and the revenue difference from the previous shipment.

SELECT * FROM Shipments2;

WITH Prev_Current AS
(
SELECT
	ShipmentID,
	RouteID,
	Revenue,
	LAG(Revenue) OVER(PARTITION BY RouteID ORDER BY ShipmentID) AS Previous_Revenue
FROM	
	Shipments2
)

SELECT
	ShipmentID,
	RouteID,
	Revenue,
	(Revenue - Previous_Revenue) AS Differenct
FROM
	Prev_Current
WHERE Revenue > Previous_Revenue;


--Question 6: Find Percentage of Revenue Contribution
--Using the Shipments table, calculate the percentage contribution of each shipment's revenue to the total revenue for its route. Include ShipmentID, RouteID, Revenue, and PercentageContribution.
SELECT
    ShipmentID,
    RouteID,
    Revenue,
    CAST((Revenue * 100.0) / SUM(Revenue) OVER (PARTITION BY RouteID) AS DECIMAL(10,2)) AS PercentageContribution
FROM
    Shipments2;



                             --OR
WITH TotalRevenuePerRoute AS (
    SELECT 
        RouteID, 
        SUM(Revenue) AS TotalRevenue
    FROM 
        Shipments2
    GROUP BY 
        RouteID
)
SELECT 
    s.ShipmentID, 
    s.RouteID, 
    s.Revenue, 
     CAST(ROUND((s.Revenue * 100.0) / t.TotalRevenue, 2) AS DECIMAL(10, 2)) AS PercentageContribution
FROM 
    Shipments2 s
JOIN 
    TotalRevenuePerRoute t
ON 
    s.RouteID = t.RouteID;




--Question 7: Calculate Running Average of Profit
--Using the Shipments table, calculate the running average profit (Revenue - Cost) for each route, ordered by ShipmentDate.

SELECT * FROM Shipments2;

SELECT
    RouteID,
    ShipmentID,
    ShipmentDate,
    SUM(Revenue - Cost) OVER (PARTITION BY RouteID ORDER BY ShipmentDate) / 
    ROW_NUMBER() OVER (PARTITION BY RouteID ORDER BY ShipmentDate) AS RunningAverageProfit
FROM
    Shipments2;



--Question 8: Rank Drivers by Monthly Revenue
--Using the Shipments and Drivers tables, rank drivers by their monthly revenue within each month. Include DriverID, DriverName, Month, Revenue, and the rank.

SELECT * FROM Shipments2;
SELECT * FROM Drivers2;

SELECT
    s.DriverID,
    d.DriverName,
    DATEPART(MONTH, s.ShipmentDate) AS Month,
    SUM(s.Revenue) AS MonthlyRevenue,
    RANK() OVER (PARTITION BY DATEPART(MONTH, s.ShipmentDate) ORDER BY SUM(s.Revenue) DESC) AS Rank
FROM
    Shipments2 s
JOIN
    Drivers2 d ON s.DriverID = d.DriverID
GROUP BY
    s.DriverID, d.DriverName, DATEPART(MONTH, s.ShipmentDate);


SELECT
    s.DriverID,
    d.DriverName,
    DATEPART(MONTH, s.ShipmentDate) AS Month,
    SUM(s.Revenue) AS MonthlyRevenue,
    RANK() OVER (ORDER BY SUM(s.Revenue) DESC) AS Rank
FROM
    Shipments2 s
JOIN
    Drivers2 d ON s.DriverID = d.DriverID
GROUP BY
    s.DriverID, d.DriverName, DATEPART(MONTH, s.ShipmentDate);



SELECT
    s.DriverID,
    d.DriverName,
    YEAR(s.ShipmentDate) AS Year,
    DATEPART(MONTH, s.ShipmentDate) AS Month,
    SUM(s.Revenue) AS MonthlyRevenue,
    RANK() OVER (
        PARTITION BY YEAR(s.ShipmentDate), DATEPART(MONTH, s.ShipmentDate)
        ORDER BY SUM(s.Revenue) DESC
    ) AS Rank
FROM
    Shipments2 s
JOIN
    Drivers2 d ON s.DriverID = d.DriverID
GROUP BY
    s.DriverID,
    d.DriverName,
    YEAR(s.ShipmentDate),
    DATEPART(MONTH, s.ShipmentDate);




--Question 9: Find Longest Delay Streak
--Using the ShipmentDelays table, find the longest streak of consecutive delayed shipments for each route. Include RouteID and the streak length.


WITH DelayedShipments AS (
    SELECT
        ShipmentID,
        RouteID,
        CASE
            WHEN DATEDIFF(HOUR, PlannedArrival, ActualArrival) > 0 THEN 1
            ELSE 0
        END AS IsDelayed
    FROM
        ShipmentDelays
),
Streaks AS (
    SELECT
        RouteID,
        ShipmentID,
        IsDelayed,
        ROW_NUMBER() OVER (PARTITION BY RouteID ORDER BY ShipmentID) -
        ROW_NUMBER() OVER (PARTITION BY RouteID, IsDelayed ORDER BY ShipmentID) AS StreakID
    FROM
        DelayedShipments
)
SELECT
    RouteID,
    COUNT(*) AS LongestStreak
FROM
    Streaks
WHERE
    IsDelayed = 1
GROUP BY
    RouteID, StreakID
ORDER BY
    LongestStreak DESC;




--Question 10: Calculate Revenue Difference by Month
--Using the Shipments table, calculate the difference in total revenue between consecutive months for each route. Include RouteID, Month, TotalRevenue, and RevenueDifference.


WITH MonthlyRevenue AS (
    SELECT
        RouteID,
        DATEPART(YEAR, ShipmentDate) AS Year,
        DATEPART(MONTH, ShipmentDate) AS Month,
        SUM(Revenue) AS TotalRevenue
    FROM
        Shipments2
    GROUP BY
        RouteID, DATEPART(YEAR, ShipmentDate), DATEPART(MONTH, ShipmentDate)
)
SELECT
    RouteID,
    Year,
    Month,
    TotalRevenue,
    TotalRevenue - LAG(TotalRevenue) OVER (PARTITION BY RouteID ORDER BY Year, Month) AS RevenueDifference
FROM
    MonthlyRevenue;
