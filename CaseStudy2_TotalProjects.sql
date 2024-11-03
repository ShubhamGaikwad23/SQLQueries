------ Creating Table --------

CREATE TABLE Projects (
    Task_ID INT PRIMARY KEY,
    Start_Date DATE,
    End_Date DATE
);

----- Inserting Data ---------------------------

INSERT INTO Projects (Task_ID, Start_Date, End_Date) VALUES
(1, '2015-10-01', '2015-10-02'),
(2, '2015-10-02', '2015-10-03'),
(3, '2015-10-03', '2015-10-04'),
(4, '2015-10-13', '2015-10-14'),
(5, '2015-10-14', '2015-10-15'),
(6, '2015-10-28', '2015-10-29'),
(7, '2015-10-30', '2015-10-31');

----- Inserting New Column ---------------------------

ALTER TABLE Projects 
ADD Hours INT;

------Inserting Data in New Column----------------------------

UPDATE Projects
SET Hours = 
    CASE 
        WHEN Task_ID = 1 THEN 8
        WHEN Task_ID = 2 THEN 6
        WHEN Task_ID = 3 THEN 10
        WHEN Task_ID = 4 THEN 12
        WHEN Task_ID = 5 THEN 8
        WHEN Task_ID = 6 THEN 5
        WHEN Task_ID = 7 THEN 9
        ELSE 0  -- Default value if Task_ID doesn't match any case
    END;


----- Display Data ----------------------------------
SELECT * FROM Projects
-----------------------------------------------------

------Row Number Window Function------------------------------

SELECT Start_Date, End_Date, ROW_NUMBER() OVER(ORDER BY Start_Date) AS R 
FROM Projects


SELECT Start_Date, End_date,ROW_NUMBER() OVER(ORDER BY Start_Date) AS R,
DATEADD(DAY, -ROW_NUMBER() OVER (ORDER BY Start_Date), Start_Date) AS ProjectGroup
FROM Projects

---------Final Answer--------------------------------------------

WITH ProjectGroups AS (
    SELECT 
        Task_ID,
        Start_Date,
        End_Date,
        DATEADD(DAY, -ROW_NUMBER() OVER (ORDER BY Start_Date), Start_Date) AS ProjectGroup
    FROM Projects
),
ProjectDates AS (
    SELECT 
        MIN(Start_Date) AS Start_Date,
        MAX(End_Date) AS End_Date
    FROM ProjectGroups
    GROUP BY ProjectGroup
)
SELECT 
    Start_Date,
    End_Date
FROM ProjectDates
ORDER BY DATEDIFF(DAY, Start_Date, End_Date), Start_Date;
------------------------------------------------------------------------


