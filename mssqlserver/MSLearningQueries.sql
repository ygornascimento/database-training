--Use SELECT queries to retrieve data
SELECT * FROM SalesLT.Product;

SELECT Name, StandardCost, ListPrice
FROM SalesLT.Product;

SELECT Name, ListPrice - StandardCost AS Markup
FROM SalesLT.Product

SELECT ProductNumber, Color, Size, Color + ', ' + Size AS ProductDetails
FROM SalesLT.Product;

--Work with data types
SELECT ProductID + ': ' + Name AS ProductName --ERROR: Conversion failed when converting the varchar value ': ' to data type int.
FROM SalesLT.Product

SELECT CAST(ProductID AS varchar(5)) + ': ' + Name AS ProductName
FROM SalesLT.Product;

SELECT CONVERT(varchar(5), ProductID) + ': ' + Name AS ProductName
FROM SalesLT.Product;

/*
The CAST function is an ANSI standard part of the SQL language that is available in most database systems, 
while CONVERT is a SQL Server specific function.
*/

SELECT SellStartDate,
	CONVERT(nvarchar(30), SellStartDate) AS ConvertedDate,
	CONVERT(nvarchar(30), SellStartDate, 126) AS ISO8601FormatDate
FROM SalesLT.Product;

SELECT Name, CAST(Size AS Integer) AS NumericSize --ERROR: Conversion failed when converting the nvarchar value 'M' to data type int.
FROM SalesLT.Product;

SELECT Name, TRY_CAST(Size AS Integer) AS NumericSize
FROM SalesLT.Product;

-- Handle NULL Values