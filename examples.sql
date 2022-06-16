-- List table columns according to conditions
SELECT TableName = tbl.TABLE_SCHEMA + '.' + tbl.TABLE_NAME,
       ColumnName = col.COLUMN_NAME,
	   ColumnDataType = col.DATA_TYPE
FROM INFORMATION_SCHEMA.TABLES tbl
INNER JOIN
INFORMATION_SCHEMA.COLUMNS col
ON col.TABLE_NAME = tbl.TABLE_NAME
AND col.TABLE_SCHEMA = tbl.TABLE_SCHEMA
WHERE tbl.TABLE_TYPE = 'BASE TABLE' AND tbl.TABLE_NAME LIKE 'Customer'


-- Select all columns
SELECT * 
FROM SalesLT.Customer


-- Select subset of columns
SELECT CustomerID, Title
FROM SalesLT.Customer


-- Add filtering with WHERE clause
SELECT *
FROM SalesLT.Product
WHERE StandardCost > 500


-- Add operators to WHERE clause
SELECT *
FROM SalesLT.Product
WHERE Color = 'Black'
OR Color = 'Red'


SELECT Name, Color
FROM SalesLT.Product
WHERE Color IN ('Red', 'Black')


SELECT Name, Color, StandardCost
FROM SalesLT.Product
WHERE StandardCost between 50 and 100


-- Example aggregate
SELECT count(ProductID), Color
FROM SalesLT.Product
GROUP BY Color


-- Examples using HAVING to filter when working with aggregates. 
SELECT count(ProductID), Color
FROM SalesLT.Product
GROUP BY Color
HAVING count(ProductID) > 10


-- Note we can still use WHERE in the query, just not on the column used in the aggregate functio
SELECT count(ProductID) as CountID, Color
FROM SalesLT.Product
WHERE ListPrice > 500
GROUP BY Color
HAVING count(ProductID) > 10


-- Sorting results
SELECT count(ProductID) AS CountID, Color
FROM SalesLT.Product
WHERE ListPrice > 500
GROUP BY Color
HAVING count(ProductID) > 10
ORDER BY CountID ASC


-- Note NULL is not zero
SELECT *
FROM SalesLT.Product
WHERE Color IS NULL

SELECT *
FROM SalesLT.Product
WHERE Color IS NOT NULL


-- Selecting ranges
SELECT TOP 10 *
FROM SalesLT.Product


SELECT TOP 10 StandardCost
FROM SalesLT.Product
ORDER BY StandardCost DESC


SELECT TOP 10 PERCENT StandardCost
FROM SalesLT.Product
ORDER BY StandardCost DESC


SELECT Name, MAX(StandardCost)
FROM SalesLT.Product
GROUP BY Name


SELECT Name, MIN(StandardCost)
FROM SalesLT.Product
GROUP BY Name


SELECT Name, AVG(StandardCost)
FROM SalesLT.Product
GROUP BY Name


SELECT COUNT(*)
FROM SalesLT.Product


SELECT COUNT(*)
FROM SalesLT.Product
WHERE Color = 'Black'


-- Fuzzy lookups with LIKE. Note wildcard
SELECT Name
FROM SalesLT.Product
WHERE Name LIKE '%Mountain%'


-- Alias for column and table
SELECT Name AS 'Product Name'
FROM SalesLT.Product
WHERE Name LIKE '%Mountain%'


SELECT t.name as 'Table Name', s.name as 'Schema Name'
FROM sys.tables t
LEFT JOIN sys.schemas s on t.schema_id = s.schema_id


-- Joins for taking columns from different tables and aligning them side by side in the result set
-- Inner - Rows that have matches from both sides
-- Left  - All from the left, matches from the right
-- Right - All from the right, matches from the left
-- Full outer - All rows that have a match on either side

SELECT c.FirstName, c.LastName, ca.AddressID
FROM SalesLT.Customer c
INNER JOIN SalesLT.CustomerAddress ca
ON c.CustomerID = ca.CustomerID


SELECT c.FirstName, c.LastName, ca.AddressID
FROM SalesLT.Customer c
LEFT JOIN SalesLT.CustomerAddress ca
ON c.CustomerID =
ca.CustomerID

SELECT c.FirstName, c.LastName, ca.AddressID
FROM SalesLT.Customer c
RIGHT JOIN SalesLT.CustomerAddress ca
ON c.CustomerID = ca.CustomerID


SELECT c.FirstName, c.LastName, ca.AddressID
FROM SalesLT.Customer c
FULL OUTER JOIN SalesLT.CustomerAddress ca
ON c.CustomerID = ca.CustomerID


SELECT p.ProductID, p.Name,
       pm.Name AS "Product Model Name",
	   pmx.Culture
FROM SalesLT.Product p
INNER JOIN SalesLT.ProductModel pm
ON p.ProductModelID = pm.ProductModelID
INNER JOIN SalesLT.ProductModelProductDescription pmx
ON pm.ProductModelID = pmx.ProductModelID



-- Sub qeury
SELECT *
FROM SalesLT.Product
WHERE ProductModelID in
(SELECT ProductModelID from SalesLT.ProductModel
WHERE ProductModelID = 6)


-- Union for stacking results
SELECT City FROM SalesLT.Address
UNION
SELECT City FROM SalesLT.Address
ORDER BY City


-- Logic Conditions
SELECT Name, StandardCost, "Price Comment" = 
	CASE
		WHEN StandardCost > 1000 THEN 'Expensive'
		ELSE 'Affordable'
	END
FROM SalesLT.Product


-- Insert specific columns
INSERT INTO SalesLT.Customer
(FirstName, LastName, PasswordHash, PasswordSalt)
VALUES ('JP', 'Boyd', 'L/Rlwxzp4w7RWmEgXX+/A7cXaePEPcp+KwQhl2fJL7w=', 'eiCRDs8=')


-- Insert another table
SELECT *
INTO SalesLT.Customer_Test
FROM SalesLT.Customer

SELECT *
FROM SalesLT.Customer_Test
WHERE LastName = 'Boyd'


-- Update
UPDATE SalesLT.Customer_Test
SET Suffix = 'Mr'
WHERE LastName = 'Boyd'


-- Delete
DELETE FROM SalesLT.Customer_Test
WHERE LastName = 'Boyd'


-- Create Database
CREATE DATABASE jpbtest


SELECT *
FROM sys.databases


-- Delete Database
DROP DATABASE jpbtest


-- Create Table
CREATE TABLE jpbtest
(
	FirstName VARCHAR(20),
	LastName VARCHAR(20)
)


-- Amend Table
ALTER TABLE jpbtest
ADD Title VARCHAR(20)


-- Create index with keys of interest to speed up query performance, to save doing a full table scan
CREATE INDEX Test_Index 
ON SalesLT.Product
(Name, Color)


SELECT * 
FROM sys.indexes
WHERE name = 'Test_Index'


DROP INDEX Test_Index
ON SalesLT.Product


--- Create a view
SELECT * 
FROM SalesLT.Customer


CREATE VIEW SalesLT.CustomerMinimum
AS 
SELECT CustomerID, Title
FROM SalesLT.Customer
	

SELECT *
FROM SalesLT.CustomerMinimum
