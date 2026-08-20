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
SELECT Name, ISNULL(TRY_CAST(Size AS Integer), 0) AS NumericSize
FROM SalesLT.Product;

SELECT ProductNumber, ISNULL(Color, '') + ', ' + ISNULL(Size, '') AS ProductDetails
FROM SalesLT.Product;

SELECT Name, NULLIF(Color, 'Multi') AS SingleColor
FROM SalesLT.Product;

SELECT Name, Color AS SingleColor
FROM SalesLT.Product;

SELECT Name, COALESCE(SellEndDate, SellStartDate) AS StatusLastUpdated
FROM SalesLT.Product;

--searched CASE
SELECT Name,
	CASE
		WHEN SellEndDate IS NULL THEN 'Currently for sale'
		ELSE 'No longer available'
	END AS SalesStatus
FROM SalesLT.Product;

--simple CASE
SELECT Name,
	CASE Size
		WHEN 'S' THEN 'Small'
		WHEN 'M' THEN 'Medium'
		WHEN 'L' THEN 'Large'
		WHEN 'XL' THEN 'Extra Large'
		ELSE ISNULL(Size, 'n/a')
	END AS ProductSize
FROM SalesLT.Product;

SELECT Name,
	CASE Size
		WHEN 'S' THEN 'Small'
		WHEN 'M' THEN 'Medium'
		WHEN 'L' THEN 'Large'
		WHEN 'XL' THEN 'Extra Large'
		--ELSE ISNULL(Size, 'n/a')
	END AS ProductSize
FROM SalesLT.Product;

--Challenge 1: Retrieve customer data
/* TIP: Conhecer melhor a estrutura da tabela sem 
trazer seus dados pode amenizar o custo de processamento 
do servidor. Podemos usar o exemlo abaixo pra iniciar a pesquisa. 
1. Primeiro: conhecer a estrutura, sem buscar os dados
A pergunta mental é: “Que colunas existem nessa tabela?” */

SELECT * FROM SalesLT.Customer;

EXEC sp_help 'SalesLT.Customer';

/* Ou essa outra opção abaixo */
SELECT
	COLUMN_NAME,
	DATA_TYPE,
	CHARACTER_MAXIMUM_LENGTH,
	IS_NULLABLE
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_SCHEMA = 'SalesLT'
AND TABLE_NAME = 'Customer'
ORDER BY ORDINAL_POSITION;

/*2. Depois: olhar uma amostra dos dados
Agora muda a pergunta: “Que tipo de informação essa tabela realmente contém?”
Aí sim você consulta os dados, mas não precisa puxar tudo: */
SELECT TOP (10) * FROM SalesLT.Customer;

/*3. Uma coisa que eu acrescentaria antes de explorar dados: quantas linhas existem? */
SELECT COUNT(*) FROM SalesLT.Customer;

--Challenge 1 P2: Retrieve customer name data
/*
Create a list of all customer contact names that includes the title, first name, middle name (if any), last name, and suffix (if any) of all customers.
*/
SELECT 
	Title,
	FirstName,
	MiddleName,
	LastName,
	Suffix
FROM SalesLT.Customer;

--Challenge 1 P3: Retrieve customer names and phone numbers
/*
Each customer has an assigned salesperson. You must write a query to create a call sheet that lists:
The salesperson
A column named CustomerName that displays how the customer contact should be greeted (for example, Mr Smith)
The customer’s phone number.
*/
SELECT 
	SalesPerson,
	Title + ' ' + LastName AS CustomerName,
	Phone
FROM SalesLT.Customer;

/* Tratando os NULL */
SELECT 
	SalesPerson,
	CONCAT(Title, ' ', LastName) AS CustomerName,
	Phone
FROM SalesLT.Customer;

