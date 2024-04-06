-- This query selects all columns from the [dbo].[CARS_INFO] table, returning all rows and columns.
SELECT * 
FROM [dbo].[CARS_INFO]

--This query selects distinct values from the fuel_type column of the [dbo].[CARS_INFO] table, eliminating duplicates.
SELECT DISTINCT fuel_type
fROM [dbo].[CARS_INFO]

-- This query calculates the minimum and maximum values in the length column of the [dbo].[CARS_INFO] table.
SELECT 
   MIN(length) AS MIN_LENGTH ,
   MAX(length) AS MAX_LENGTH 
   from [dbo].[CARS_INFO]
--This query selects all columns from the [dbo].[CARS_INFO] table where the num_of_doors column has a NULL value.
 SELECT *
 FROM [dbo].[CARS_INFO]
 WHERE num_of_doors is null 

 
 --This query selects the num_of_doors column from the [dbo].[CARS_INFO] table.
 SELECT num_of_doors 
 from [dbo].[CARS_INFO]

 --This query updates the num_of_doors column to 'four' for rows where make is 'dodge', fuel_type is 'gas', and body_style is 'sedan'.
  UPDATE
  [dbo].[CARS_INFO] 
SET
  num_of_doors = 'four'
WHERE
  make = 'dodge'
  AND fuel_type = 'gas'
  AND body_style = 'sedan';

-- This query selects all columns from the [dbo].[CARS_INFO] table where the num_of_doors column has a NULL value after the update.
SELECT *
 FROM [dbo].[CARS_INFO]
 WHERE num_of_doors is null 

 -- This query updates the num_of_doors column to 'four' for rows where make is 'mazda', fuel_type is 'diesel', and body_style is 'sedan'.
  UPDATE
  [dbo].[CARS_INFO] 
 SET
  num_of_doors = 'four'
  WHERE
  make = 'mazda'
  AND fuel_type = 'diesel'
  AND body_style = 'sedan';


--This query selects distinct values from the num_of_cylinders column of the [dbo].[CARS_INFO] table.

SELECT DISTINCT num_of_cylinders 
from [dbo].[CARS_INFO] 


--This query updates the num_of_cylinders column to 'two' where it was mistakenly recorded as 'tow'.
   
   UPDATE [dbo].[CARS_INFO] 
   SET num_of_cylinders = 'two'
   Where num_of_cylinders = 'tow';

 --This query calculates the minimum and maximum values of the compression_ratio column, excluding the value 70.

   SELECT
  MIN(compression_ratio) AS min_compression_ratio,
  MAX(compression_ratio) AS max_compression_ratio
FROM 
[dbo].[CARS_INFO] 
where compression_ratio <> 70 ;


--his query counts the number of rows where the compression_ratio column is equal to 70.

SELECT COUNT(*) AS ROWS_TO_DELET
FROM [dbo].[CARS_INFO] 
WHERE compression_ratio = 70

--This query deletes rows from the [dbo].[CARS_INFO] table where the compression_ratio column is equal to 70.

DELETE [dbo].[CARS_INFO]
WHERE compression_ratio = 70;

--This query selects distinct values from the drive_wheels column of the [dbo].[CARS_INFO] table.

SELECT DISTINCT drive_wheels
from [dbo].[CARS_INFO] 


--This query selects distinct values from the drive_wheels column and calculates the length of each value in the [dbo].[CARS_INFO] table using the LEN function.

SELECT
  DISTINCT drive_wheels,

  len(drive_wheels)
      
	  AS string_length   

from [dbo].[CARS_INFO] ; 

--This query selects the maximum value from the price column of the [dbo].[CARS_INFO] table.

SELECT MAX(price) as max_price 
from [dbo].[CARS_INFO]





