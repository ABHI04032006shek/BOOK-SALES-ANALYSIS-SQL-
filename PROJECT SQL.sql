--CREATION OF TABLE BOOK

CREATE TABLE BOOK(
     Book_ID INT PRIMARY KEY,
	 Title  VARCHAR(200),
	 Author VARCHAR(50),
	 Genre  VARCHAR(50),
	 Published_Year INT,
	 Price NUMERIC(10,2),
	 Stock INT

);
--RETERIVAL OF ALL DATA IN BOOKS TABLE

SELECT * FROM BOOK;

--CREATION OF CUSTOMERS YTABLE

CREATE TABLE CUSTOMERS(
    Customer_ID INT PRIMARY KEY,
	Customer_Name VARCHAR(100),
	Email VARCHAR(100) NOT NULL,
	Phone INT,
	City VARCHAR(50),
	Country VARCHAR(50)

);
--RETERIVE CUSTOMERS DATA

SELECT * FROM CUSTOMERS;

--ALTER COLUMNS DATA TYPE

ALTER TABLE CUSTOMERS
ALTER COLUMN Phone TYPE VARCHAR(15);

--ALTER COLUMNS DATA TYPE

ALTER TABLE CUSTOMERS
ALTER COLUMN Country  TYPE VARCHAR(100);

--CREATE ORDER TABLE
CREATE TABLE ORDER_(
    Order_ID INT PRIMARY KEY,
	Customer_ID INT,
	Book_ID INT,
	Order_Date DATE,
	Quantity INT,
	Total_Amount NUMERIC(10,2),
	FOREIGN KEY(Customer_ID) 
	   REFERENCES CUSTOMERS(Customer_ID),
	FOREIGN KEY(Book_ID)
	   REFERENCES BOOK(Book_ID)


);

--RETERIVE ALL DATA FROM ORDER TABLE

SELECT * FROM ORDER_;

-- Retrieve all books in the "Fiction" genre.

SELECT * FROM BOOK 
WHERE Genre ='Fiction';

-- Find books published after the year 1950

SELECT * FROM BOOK 
WHERE  Published_Year>1950;

--List all customers from Canada.

SELECT * FROM CUSTOMERS
WHERE  Country='Canada';

-- Show orders placed in November 2023.

SELECT * FROM ORDER_
WHERE Order_Date BETWEEN '2023-11-01' AND '2023-11-30' ;

-- Retrieve the total stock of books available.

SELECT SUM(Stock) AS Total_stock
FROM BOOK;

--Find the details of the most expensive book.

SELECT * FROM BOOK
ORDER BY Price DESC 
LIMIT 1;

--Show all customers who ordered more than 1 quantity of a book.

SELECT C.Customer_Name,SUM(O.Quantity) AS Total_order
FROM CUSTOMERS  C
JOIN ORDER_ O
ON  O.CUSTOMER_ID=C.CUSTOMER_ID
GROUP BY C.Customer_Name
HAVING SUM(O.Quantity)>1;

--Retrieve all orders where the total amount exceeds $20.

SELECT * FROM ORDER_
WHERE total_amount>20;

--List all genres available in the Books table.

SELECT DISTINCT(Genre) FROM BOOK;

--Find the book with the lowest stock.

SELECT * FROM BOOK
ORDER BY Stock ASC 
LIMIT 1;

--Calculate the total revenue generated from all orders.

SELECT SUM(Total_Amount) AS Total_Revenue 
FROM ORDER_;

-- Retrieve the total number of books sold for each genre.

SELECT B.Genre,SUM(O.Quantity) AS Total_Quantity
FROM BOOK B
JOIN ORDER_ O
ON B.BOOK_ID=O.BOOK_ID
GROUP BY B.Genre;

--Find the average price of books in the "Fantasy" genre.

SELECT ROUND(AVG(Price),2) AS Average_Price
FROM BOOK 
WHERE Genre='Fantasy';

--List customers who have placed at least 2 orders.

SELECT C.CUSTOMER_NAME
FROM CUSTOMERS C
JOIN ORDER_ O
ON C.Customer_ID=O.Customer_ID
GROUP BY C.CUSTOMER_ID,C.CUSTOMER_NAME
HAVING COUNT(O.ORDER_ID)>=2;

--Find the most frequently ordered book.

SELECT B.TITLE,COUNT(*) AS Total_order
FROM BOOK B
JOIN ORDER_ O
ON B.Book_ID=O.Book_ID
GROUP BY B.Book_ID,B.TITLE
ORDER BY Total_order DESC
LIMIT 1;

--Show the top 3 most expensive books of the Fantasy genre

SELECT Genre,TITLE,PRICE
FROM BOOK
WHERE Genre='Fantasy'
ORDER BY Price DESC 
LIMIT 3;

--Retrieve the total quantity of books sold by each author

SELECT B.Author,SUM(O.Quantity) AS Total_Quantity_sold
FROM BOOK B
JOIN ORDER_ O
ON B.Book_ID=O.Book_ID
GROUP BY B.Author ;

--List the cities where customers who spent over $30 are located.

SELECT C.City,SUM(O.Total_Amount) AS EXPENDITURE
FROM CUSTOMERS C
JOIN ORDER_ O
ON C.Customer_ID=O.Customer_ID
GROUP BY C.City
HAVING SUM(O.Total_Amount)>30;

--Find the customer who spent the most on orders.

SELECT C.Customer_Name,COUNT(*) AS Total_order
FROM CUSTOMERS C
JOIN ORDER_ O
ON  C.Customer_ID=O.Customer_ID
GROUP BY C.CUSTOMER_ID,C.Customer_Name
ORDER BY Total_order DESC
LIMIT 1;

--Calculate the stock remaining after fulfilling all orders

SELECT B.Title,B.Stock-COALESCE(SUM(O.Quantity),0) AS Remaining_stock
From Book B
LEFT JOIN ORDER_ O
ON B.Book_ID=O.Book_ID
GROUP BY B.Book_ID,B.Title,B.stock;
























