TASK:1

CREATE DATABASE TechShop

 CREATE TABLE Customers(
    Customer_id varchar(50)not null primary key,
    Firstname varchar(50),
    Lastname varchar(50),
     Email VARCHAR(320),
    Phone NVARCHAR(50),
    Address VARCHAR(255)
);
 CREATE TABLE Products(
 Product_id varchar(50) not null primary key,
 Product_name varchar(50),
 Description varchar(255),
 Price decimal(10,2)
 );

 CREATE TABLE Orders(
 Order_id varchar(50)not null primary key,
 Customer_id varchar(50), 
 Order_date varchar(15),
 Total_amount decimal(10,2),
 foreign key (Customer_id) references Customers(Customer_id)
 );
 
CREATE TABLE OrderDetails(
Oredr_DetailID varchar(50) not null primary key,
Order_id varchar(50),
Product_id varchar(50),
Quantity varchar(50),
foreign key (Order_id) references Orders(Order_id),
foreign key (Product_id) references Products(Product_id)
);


CREATE TABLE Inventory(
Inventory_id varchar(50) not null primary key,
Product_id varchar(50),
Quantity_Instock varchar(50),
Last_Stock_Update varchar(50),
foreign key (Product_id) references Products(Product_id)
);

INSERT INTO Customers (Customer_id, Firstname, Lastname, Email, Phone, Address)
VALUES
('101', 'John', 'Doe', 'john.doe@example.com', '9876543210', '123 Main St, Chennai'),
('102', 'Jane', 'Smith', 'jane.smith@example.com', '8765432109', '45 MG Road, Coimbatore'),
('103', 'Amit', 'Patel', 'amit.patel@example.com', '7654321098', '7 Anna Salai, Madurai'),
('104', 'Priya', 'Rao', 'priya.rao@example.com', '6543210987', '88 Nehru St, Trichy'),
('105', 'Rahul', 'Sharma', 'rahul.sharma@example.com', '5432109876', '102 Gandhi Nagar, Salem'),
('106', 'Divya', 'Nair', 'divya.nair@example.com', '4321098765', '56 Valluvar Rd, Erode'),
('107', 'Vikram', 'Singh', 'vikram.singh@example.com', '3210987654', '21 Periyar St, Thanjavur'),
('108', 'Meena', 'Iyer', 'meena.iyer@example.com', '2109876543', '34 Bharathi Nagar, Tuticorin'),
('109', 'Karthik', 'Kumar', 'karthik.kumar@example.com', '1098765432', '12 Beach Road, Pondicherry'),
('110', 'Sneha', 'Mishra', 'sneha.mishra@example.com', '9988776655', '67 North St, Tirunelveli');

select * from Customers

INSERT INTO Products (Product_id, Product_name, Description, Price)
VALUES
('PROD001', 'Wireless Mouse', 'Ergonomic wireless mouse with USB receiver', 799.99),
('PROD002', 'Keyboard', 'Standard USB keyboard with soft keys', 499.50),
('PROD003', 'LED Monitor', '24-inch full HD LED monitor', 8499.00),
('PROD004', 'Laptop Stand', 'Adjustable aluminum laptop stand', 1199.00),
('PROD005', 'Webcam', 'HD 1080p webcam with microphone', 1599.75),
('PROD006', 'Pen Drive', '32GB USB 3.0 pen drive', 349.00),
('PROD007', 'External Hard Drive', '1TB portable external hard drive', 4399.90),
('PROD008', 'Bluetooth Speaker', 'Mini portable Bluetooth speaker', 999.00),
('PROD009', 'Smart Watch', 'Water-resistant smartwatch with fitness tracking', 2999.99),
('PROD010', 'Gaming Headset', 'Over-ear gaming headset with mic', 1899.49);

select * from Products
ALTER TABLE Products
ADD Category VARCHAR(100);
UPDATE Products
SET Category = 'Electronics'
WHERE Product_id IN ('PROD001', 'PROD002', 'PROD003', 'PROD005','PROD006','PROD007','PROD008','PROD009','PROD010'); 



INSERT INTO Orders (Order_id, Customer_id, Order_date, Total_amount)
VALUES
('ORD001', '101', '2025-06-01', 1999.99),
('ORD002', '102', '2025-06-02', 3499.50),
('ORD003', '103', '2025-06-03', 899.00),
('ORD004', '104', '2025-06-04', 1249.75),
('ORD005', '105', '2025-06-05', 2499.00),
('ORD006', '106', '2025-06-06', 749.00),
('ORD007', '107', '2025-06-07', 1450.25),
('ORD008', '108', '2025-06-08', 990.00),
('ORD009', '109', '2025-06-09', 3100.45),
('ORD010', '110', '2025-06-10', 1899.99);

select * from Orders

INSERT INTO OrderDetails (Oredr_DetailID, Order_id, Product_id, Quantity)
VALUES
('OD001', 'ORD001', 'PROD001', '2'),
('OD002', 'ORD002', 'PROD003', '1'),
('OD003', 'ORD003', 'PROD005', '4'),
('OD004', 'ORD004', 'PROD002', '1'),
('OD005', 'ORD005', 'PROD010', '2'),
('OD006', 'ORD006', 'PROD006', '5'),
('OD007', 'ORD007', 'PROD008', '3'),
('OD008', 'ORD008', 'PROD004', '1'),
('OD009', 'ORD009', 'PROD007', '2'),
('OD010', 'ORD010', 'PROD009', '1');

INSERT INTO Inventory (Inventory_id, Product_id, Quantity_Instock, Last_Stock_Update)
VALUES
('INV001', 'PROD001', '150', '2025-06-01'),
('INV002', 'PROD002', '120', '2025-06-02'),
('INV003', 'PROD003', '80', '2025-06-03'),
('INV004', 'PROD004', '100', '2025-06-04'),
('INV005', 'PROD005', '75', '2025-06-05'),
('INV006', 'PROD006', '300', '2025-06-06'),
('INV007', 'PROD007', '60', '2025-06-07'),
('INV008', 'PROD008', '110', '2025-06-08'),
('INV009', 'PROD009', '90', '2025-06-09'),
('INV010', 'PROD010', '50', '2025-06-10');

select * from Products


TASK 2:
1)
SELECT Firstname,Lastname,Email FROM Customers
2)
SELECT 
    O.Order_id,
    O.Order_date,
    C.Firstname,
    C.Lastname
FROM 
    Orders O
JOIN 
    Customers C ON O.Customer_id = C.Customer_id;
3)
INSERT INTO Customers (Customer_id, Firstname, Lastname, Email, Phone, Address)
VALUES ('111','Akil','john','akil12@gmail.com','8658897655','523 Pillayar St, Chennai')
4)
UPDATE Products
SET Price = Price * 1.10
WHERE 
    Product_name LIKE '%Mouse%' OR
    Product_name LIKE '%Keyboard%' OR
    Product_name LIKE '%Monitor%' OR
    Product_name LIKE '%Laptop%' OR
    Product_name LIKE '%Webcam%' OR
    Product_name LIKE '%Drive%' OR
    Product_name LIKE '%Speaker%' OR
    Product_name LIKE '%Watch%' OR
    Product_name LIKE '%Headset%';
5)

DECLARE @OrderId VARCHAR(50) = 'ORD005'

DELETE FROM OrderDetails
WHERE Order_id = @OrderId

DELETE FROM Orders
WHERE Order_id = @OrderId

6)
INSERT INTO Orders (Order_id, Customer_id, Order_date, Total_amount)
VALUES
('ORD011', '111', '2025-07-02', 4200.99)

7)
DECLARE @CustomerId VARCHAR(50) = '105';           
DECLARE @NewEmail VARCHAR(320) = 'varma@gamil.com'; 
DECLARE @NewAddress VARCHAR(255) = '2/313 New Street, Chennai'; 

UPDATE Customers
SET 
    Email = @NewEmail,
    Address = @NewAddress
WHERE 
    Customer_id = @CustomerId;

 8)
 UPDATE Orders
SET Total_amount = sub.Total
FROM Orders o
JOIN (
    SELECT 
        od.Order_id,
        SUM(CAST(od.Quantity AS INT) * p.Price) AS Total
    FROM OrderDetails od
    JOIN Products p ON od.Product_id = p.Product_id
    GROUP BY od.Order_id
) AS sub ON o.Order_id = sub.Order_id;
9)
DECLARE @CustomerId VARCHAR(50) = '106';


DELETE FROM OrderDetails
WHERE Order_id IN (
    SELECT Order_id FROM Orders WHERE Customer_id = @CustomerId
);

DELETE FROM Orders
WHERE Customer_id = @CustomerId;
10)
INSERT INTO Products (Product_id, Product_name, Description, Price)
VALUES ('PROD011', 'Wireless Earbuds', 'Noise-cancelling Bluetooth earbuds with charging case', 2499.00);
11)
ALTER TABLE Orders
ADD Status VARCHAR(20);
DECLARE @OrderId VARCHAR(50) = 'ORD007';
DECLARE @NewStatus VARCHAR(20) = 'Shipped';

UPDATE Orders
SET Status = @NewStatus
WHERE Order_id = @OrderId;

12)
ALTER TABLE Customers
ADD Order_Count INT DEFAULT 0;

UPDATE Customers
SET Order_Count = ISNULL(sub.OrderTotal, 0)
FROM Customers c
LEFT JOIN (
    SELECT Customer_id, COUNT(*) AS OrderTotal
    FROM Orders
    GROUP BY Customer_id
) sub ON c.Customer_id = sub.Customer_id;
select * from Customers

TASK 3:
1)
SELECT 
    o.Order_id,
    o.Order_date,
    c.Firstname + ' ' + c.Lastname AS Customer_Name
FROM Orders o
JOIN Customers c ON o.Customer_id = c.Customer_id;

2)
SELECT 
    p.Product_name,
    SUM(CAST(od.Quantity AS INT) * p.Price) AS Total_Revenue
FROM OrderDetails od
JOIN Products p ON od.Product_id = p.Product_id
GROUP BY p.Product_name;

3)
SELECT DISTINCT 
    c.Firstname,
    c.Lastname,
    c.Email,
    c.Phone
FROM Customers c
JOIN Orders o ON c.Customer_id = o.Customer_id;

4)
SELECT TOP 1 
    p.Product_name,
    SUM(CAST(od.Quantity AS INT)) AS Total_Quantity_Ordered
FROM OrderDetails od
JOIN Products p ON od.Product_id = p.Product_id
GROUP BY p.Product_name
ORDER BY Total_Quantity_Ordered DESC;

5)
SELECT 
    Product_name
    
FROM Products;

6)
SELECT 
    c.Firstname + ' ' + c.Lastname AS Customer_Name,
    AVG(o.Total_amount) AS Avg_OrderValue
FROM Customers c
JOIN Orders o ON c.Customer_id = o.Customer_id
GROUP BY c.Firstname, c.Lastname;

7)
SELECT TOP 1 
    o.Order_id,
    c.Firstname + ' ' + c.Lastname AS Customer_Name,
    o.Total_amount AS Total_Revenue
FROM Orders o
JOIN Customers c ON o.Customer_id = c.Customer_id
ORDER BY o.Total_amount DESC;

8)
SELECT 
    p.Product_name,
    COUNT(*) AS Times_Ordered
FROM OrderDetails od
JOIN Products p ON od.Product_id = p.Product_id
GROUP BY p.Product_name;

DECLARE @ProductName VARCHAR(100) = 'Smart Watch';
9)
SELECT DISTINCT 
    c.Firstname,
    c.Lastname,
    c.Email,
    c.Phone
FROM Customers c
JOIN Orders o ON c.Customer_id = o.Customer_id
JOIN OrderDetails od ON o.Order_id = od.Order_id
JOIN Products p ON od.Product_id = p.Product_id
WHERE p.Product_name = @ProductName;

10)

DECLARE @StartDate DATE = '2025-06-01';
DECLARE @EndDate DATE = '2025-06-10';

SELECT 
    SUM(Total_amount) AS Total_Revenue
FROM Orders
WHERE CAST(Order_date AS DATE) BETWEEN @StartDate AND @EndDate;

TASK 4:
1)
SELECT 
    Customer_id, Firstname, Lastname
FROM Customers
WHERE Customer_id NOT IN (
    SELECT DISTINCT Customer_id FROM Orders
)
2)
SELECT COUNT(*) AS Total_Products
FROM Products;
3)
SELECT SUM(Total_amount) AS Total_Revenue
FROM Orders;
4)
DECLARE @CategoryName VARCHAR(100) = 'Electronics';

SELECT 
    AVG(CAST(od.Quantity AS INT)) AS Average_Quantity_Ordered
FROM OrderDetails od
JOIN Products p ON od.Product_id = p.Product_id
WHERE p.Category = @CategoryName
5)
DECLARE @CustomerId VARCHAR(50) = '108';

SELECT 
    SUM(Total_amount) AS Total_Revenue
FROM Orders
WHERE Customer_id = @CustomerId;
6)
SELECT TOP 1 
    c.Firstname + ' ' + c.Lastname AS Customer_Name,
    COUNT(o.Order_id) AS Order_Count
FROM Customers c
JOIN Orders o ON c.Customer_id = o.Customer_id
GROUP BY c.Firstname, c.Lastname
ORDER BY Order_Count DESC;
7)
SELECT TOP 1 
    p.Category,
    SUM(CAST(od.Quantity AS INT)) AS Total_Quantity_Ordered
FROM OrderDetails od
JOIN Products p ON od.Product_id = p.Product_id
GROUP BY p.Category
ORDER BY Total_Quantity_Ordered DESC;
8)
SELECT TOP 1 
    c.Firstname + ' ' + c.Lastname AS Customer_Name,
    SUM(o.Total_amount) AS Total_Spent
FROM Customers c
JOIN Orders o ON c.Customer_id = o.Customer_id
GROUP BY c.Firstname, c.Lastname
ORDER BY Total_Spent DESC;
9)
SELECT 
    AVG(Total_amount) AS Average_Order_Value
FROM Orders;
10)
SELECT 
    c.Firstname + ' ' + c.Lastname AS Customer_Name,
    COUNT(o.Order_id) AS Order_Count
FROM Customers c
LEFT JOIN Orders o ON c.Customer_id = o.Customer_id
GROUP BY c.Firstname, c.Lastname;








