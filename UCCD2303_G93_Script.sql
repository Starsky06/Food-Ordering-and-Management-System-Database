/*
COURSE CODE: UCCD2303
PROGRAMME : CS
GROUP NUMBER :G093
GROUP LEADER NAME & EMAIL:Ho Yu Hao (hyhao2004@1utar.my)
MEMBER 2 NAME:Chong Kai Jian
MEMBER 3 NAME:Leow Yi Kang
Submission date and time (DD-MON-YY): 29-4-2025 4PM

*/

DROP TABLE Customer CASCADE CONSTRAINTS;
DROP TABLE Restaurant CASCADE CONSTRAINTS;
DROP TABLE Reservation CASCADE CONSTRAINTS;
DROP TABLE Payment CASCADE CONSTRAINTS;
DROP TABLE Orders CASCADE CONSTRAINTS;
DROP TABLE Employee CASCADE CONSTRAINTS;
DROP TABLE Receipt CASCADE CONSTRAINTS;
DROP TABLE Order_Item CASCADE CONSTRAINTS;
DROP TABLE Report CASCADE CONSTRAINTS;
DROP TABLE Menu CASCADE CONSTRAINTS;
DROP TABLE Inventory CASCADE CONSTRAINTS;
DROP TABLE Supplier CASCADE CONSTRAINTS;
DROP TABLE Inventory_Transaction CASCADE CONSTRAINTS;
DROP TABLE Dine_In CASCADE CONSTRAINTS;
DROP TABLE Take_Away CASCADE CONSTRAINTS;
DROP TABLE Manager CASCADE CONSTRAINTS;
DROP TABLE Cashier CASCADE CONSTRAINTS;
DROP TABLE Chef CASCADE CONSTRAINTS;

CREATE TABLE Customer (
    Customer_ID VARCHAR2(15) PRIMARY KEY,
    First_Name VARCHAR2(30),
    Last_Name VARCHAR2(30),
    Email VARCHAR2(50),
    Phone VARCHAR2(15),
    Address VARCHAR2(100),
    Loyalty_Points INT,
    Date_joined DATE
);
CREATE TABLE Employee (
    Employee_ID VARCHAR(15) PRIMARY KEY,
    FirstName VARCHAR2(30),
    LastName VARCHAR2(30),
    Phone VARCHAR2(15),
    Email VARCHAR2(50),
    Employee_Type VARCHAR2(20),
    HourlyRate DECIMAL(10,2),
    Address VARCHAR2(100)
);
CREATE TABLE Menu (
    Menu_Item_ID VARCHAR2(15) PRIMARY KEY,
    Item_Name VARCHAR2(50),
    Description VARCHAR2(100),
    Price DECIMAL(10,2),
    Category VARCHAR2(20)
);
CREATE TABLE Supplier (
    Supplier_ID VARCHAR2(15) PRIMARY KEY,
    Supplier_Name VARCHAR2(50),
    Contact_Info VARCHAR2(15),
    Address VARCHAR2(100)
);
CREATE TABLE Restaurant (
    Restaurant_ID VARCHAR2(15) PRIMARY KEY,
    RestaurantName VARCHAR2(50),
    Location VARCHAR2(100),
    OperationgHours VARCHAR2(20),
    ContactInfo VARCHAR2(15),
    Employee_ID VARCHAR2(15),
    FOREIGN KEY (Employee_ID) REFERENCES Employee(Employee_ID)
);
CREATE TABLE Reservation (
    Reservation_ID VARCHAR2(15) PRIMARY KEY,
    Reservation_Date DATE,
    Reservation_Time VARCHAR2(15),
    NumberOfPeople INT,
    Customer_ID VARCHAR2(15),
    Employee_ID VARCHAR2(15),
    FOREIGN KEY (Customer_ID) REFERENCES Customer(Customer_ID),
    FOREIGN KEY (Employee_ID) REFERENCES Employee(Employee_ID)
);
CREATE TABLE Payment (
    Payment_ID VARCHAR2(15) PRIMARY KEY,
    Payment_Amount DECIMAL(10,2),
    Payment_Method VARCHAR2(20),
    Payment_Date DATE,
    Customer_ID VARCHAR2(15),
    FOREIGN KEY (Customer_ID) REFERENCES Customer(Customer_ID)
);
CREATE TABLE Orders (
    Order_ID VARCHAR2(15) PRIMARY KEY,
    Order_date DATE,
    Order_Status VARCHAR2(20),
    Order_time VARCHAR2(15),
    Total_Amount DECIMAL(10,2),
    Order_Type VARCHAR2(20),
    Customer_ID VARCHAR2(15),
    Restaurant_ID VARCHAR2(15),
    FOREIGN KEY (Customer_ID) REFERENCES Customer(Customer_ID),
    FOREIGN KEY (Restaurant_ID) REFERENCES Restaurant(Restaurant_ID)
);
CREATE TABLE Receipt (
    Receipt_ID VARCHAR2(15) PRIMARY KEY,
    ReceiptDate DATE,
    AmountPaid DECIMAL(10,2),
    ReceiptStatus VARCHAR2(20),
    Payment_ID VARCHAR2(15),
    Order_ID VARCHAR2(15),
    FOREIGN KEY (Payment_ID) REFERENCES Payment(Payment_ID),
    FOREIGN KEY (Order_ID) REFERENCES Orders(Order_ID)
);
CREATE TABLE Order_Item (
    Order_Item_ID VARCHAR2(15) PRIMARY KEY,
    Quantity INT,
    Price DECIMAL(10,2),
    Order_ID VARCHAR2(15),
    Menu_Item_ID VARCHAR2(15),
    FOREIGN KEY (Order_ID) REFERENCES Orders(Order_ID),
    FOREIGN KEY (Menu_Item_ID) REFERENCES Menu(Menu_Item_ID)
);
CREATE TABLE Inventory (
    Inventory_ID VARCHAR2(50) PRIMARY KEY,
    Item_Name VARCHAR2(30),
    Category VARCHAR2(20),
    UnitPrice DECIMAL(10,2),
    QuantityInStock INT,
    RestockLevel INT,
    Employee_ID VARCHAR2(15),
    FOREIGN KEY (Employee_ID) REFERENCES Employee(Employee_ID)
);
CREATE TABLE Report (
    Report_ID VARCHAR2(15) PRIMARY KEY,
    ReportDate DATE,
    TotalSales DECIMAL(10,2),
    NumberOfOrders INT,
    Order_ID VARCHAR2(15),
    Inventory_ID VARCHAR2(15),
    Employee_ID VARCHAR2(15),
    FOREIGN KEY (Order_ID) REFERENCES Orders(Order_ID),
    FOREIGN KEY (Inventory_ID) REFERENCES Inventory(Inventory_ID),
    FOREIGN KEY (Employee_ID) REFERENCES Employee(Employee_ID)
);
CREATE TABLE Inventory_Transaction (
    Transaction_ID VARCHAR2(15) PRIMARY KEY,
    Transaction_Type VARCHAR2(20),
    Quantity INT,
    Transaction_Date DATE,
    Cost DECIMAL(10,2),
    Inventory_ID VARCHAR2(15),
    Supplier_ID VARCHAR2(15),
    FOREIGN KEY (Inventory_ID) REFERENCES Inventory(Inventory_ID),
    FOREIGN KEY (Supplier_ID) REFERENCES Supplier(Supplier_ID)
);
CREATE TABLE Dine_In (
    Order_ID VARCHAR2(15) PRIMARY KEY,
    Serv_Charge DECIMAL(10,2),
    Table_Location VARCHAR2(30),
    Waiting_Number INT,
    FOREIGN KEY (Order_ID) REFERENCES Orders(Order_ID)
);
CREATE TABLE Take_Away (
    Order_ID VARCHAR2(15) PRIMARY KEY,
    Delivery_Address VARCHAR2(100),
    Food_App VARCHAR2(90),
    FOREIGN KEY (Order_ID) REFERENCES Orders(Order_ID)
);
CREATE TABLE Manager (
    Employee_ID VARCHAR2(15) PRIMARY KEY,
    Permissions VARCHAR2(50),
    Experience INT,
    FOREIGN KEY (Employee_ID) REFERENCES Employee(Employee_ID)
);
CREATE TABLE Cashier (
    Employee_ID VARCHAR2(15) PRIMARY KEY,
    Machine_Number VARCHAR2(15),
    FOREIGN KEY (Employee_ID) REFERENCES Employee(Employee_ID)
);
CREATE TABLE Chef (
    Employee_ID VARCHAR2(15) PRIMARY KEY,
    Specialization VARCHAR2(50),
    Experience INT,
    FOREIGN KEY (Employee_ID) REFERENCES Employee(Employee_ID)
);

--(insert records into Customer table)
INSERT INTO Customer VALUES('C-10001', 'James', 'Choo', 'james.choo@gmail.com', '012-3456789', '123 Taman Rich', 120, TO_DATE('2025-04-21', 'YYYY-MM-DD'));
INSERT INTO Customer VALUES('C-10002', 'Alice', 'Tan', 'alice.tan@gmail.com', '012-8887766', '89 Jalan Merdeka', 80, TO_DATE('2025-03-18', 'YYYY-MM-DD'));
INSERT INTO Customer VALUES('C-10003', 'Ravi', 'Kumar', 'ravi.k@gmail.com', '011-4567890', '77 Taman Aman', 150, TO_DATE('2025-02-10', 'YYYY-MM-DD'));
INSERT INTO Customer VALUES('C-10004', 'Sarah', 'Lim', 'sarah.lim@gmail.com', '019-3344556', '45 Jalan Hijau', 95, TO_DATE('2025-04-05', 'YYYY-MM-DD'));
INSERT INTO Customer VALUES('C-10005', 'Amir', 'Zain', 'amirz@gmail.com', '010-2233445', '29 Taman Putih', 60, TO_DATE('2025-01-25', 'YYYY-MM-DD'));

--(insert records into Employee table)
INSERT INTO Employee VALUES ('E-12021', 'John', 'Doe', '012-3456789', 'john@gmail.com', 'Manager', 20.50, '123 Elm St');
INSERT INTO Employee VALUES ('E-12022', 'Clara', 'Ng', '013-6789123', 'clara@gmail.com', 'Cashier', 15.00, '45 Jalan Indah');
INSERT INTO Employee VALUES ('E-12023', 'Farid', 'Ismail', '016-8877665', 'farid@gmail.com', 'Chef', 25.00, '89 Taman Hijau');
INSERT INTO Employee VALUES ('E-12024', 'Mei', 'Wong', '018-2233445', 'mei@gmail.com', 'Waiter', 13.00, '78 Jalan Anggerik');
INSERT INTO Employee VALUES ('E-12025', 'Raj', 'Subra', '019-3322110', 'raj@gmail.com', 'Manager', 22.00, '34 Taman Seri');
INSERT INTO Employee VALUES ('E-13001', 'Aina', 'Hassan', '014-9988776', 'aina.hassan@mail.com', 'Manager', 18.50, '12 Taman Bukit');
INSERT INTO Employee VALUES ('E-13002', 'Hugo', 'Chin', '010-9988123', 'hugo.chin@mail.com', 'Manager', 21.00, '78 Jalan Murni');
INSERT INTO Employee VALUES ('E-13003', 'Nadia', 'Razak', '011-2233889', 'nadia.razak@mail.com', 'Manager', 19.00, '25 Taman Selamat');
INSERT INTO Employee VALUES ('E-13004', 'Kelvin', 'Yip', '017-4455667', 'kelvin.yip@mail.com', 'Cashier', 14.50, '101 Jalan Wangsa');
INSERT INTO Employee VALUES ('E-13005', 'Linda', 'Chong', '012-5566887', 'linda.chong@mail.com', 'Cashier', 15.25, '67 Taman Suria');
INSERT INTO Employee VALUES ('E-13006', 'Hafiz', 'Salleh', '018-3344778', 'hafiz.salleh@mail.com', 'Cashier', 15.00, '98 Jalan Cempaka');
INSERT INTO Employee VALUES ('E-13007', 'Grace', 'Teo', '016-8899001', 'grace.teo@mail.com', 'Cashier', 14.75, '14 Jalan Amanah');
INSERT INTO Employee VALUES ('E-13008', 'Siva', 'Kumar', '013-9988775', 'siva.kumar@mail.com', 'Chef', 26.00, '77 Taman Bunga');
INSERT INTO Employee VALUES ('E-13009', 'Akira', 'Tanaka', '019-4455666', 'akira.tanaka@mail.com', 'Chef', 24.00, '23 Jalan Jepun');
INSERT INTO Employee VALUES ('E-13010', 'Betty', 'Lim', '017-2233445', 'betty.lim@mail.com', 'Chef', 23.50, '56 Taman Damai');
INSERT INTO Employee VALUES ('E-13011', 'Yusuf', 'Ali', '010-1122334', 'yusuf.ali@mail.com', 'Chef', 25.00, '11 Jalan Sejahtera');

--(insert records into Menu table)
INSERT INTO Menu VALUES ('MI-1001', 'Margherita', 'Tomato and cheese pizza', 12.50, 'Main');
INSERT INTO Menu VALUES ('MI-1002', 'Spaghetti', 'Creamy Alfredo sauce', 18.00, 'Main');
INSERT INTO Menu VALUES ('MI-1003', 'Caesar Salad', 'Romaine, cheese, croutons', 15.00, 'Side');
INSERT INTO Menu VALUES ('MI-1004', 'Ice Cream', 'Vanilla scoop', 8.50, 'Dessert');
INSERT INTO Menu VALUES ('MI-1005', 'Fried Rice', 'Chicken fried rice', 13.00, 'Main');

--(insert records into Supplier table)
INSERT INTO Supplier VALUES ('SUP-1001', 'Best Supplies', '012-3456789','123 Taman Durian');
INSERT INTO Supplier VALUES ('SUP-1002', 'FreshMart', '011-2233445','45 Jalan Pasar');
INSERT INTO Supplier VALUES ('SUP-1003', 'FoodieSource', '018-5566778','78 Taman Selera');
INSERT INTO Supplier VALUES ('SUP-1004', 'PackPro', '017-6677889','99 Jalan Industri');
INSERT INTO Supplier VALUES ('SUP-1005', 'DailyGrain', '019-1122334','66 Taman Makanan');

--(insert records into Restaurant table)
INSERT INTO Restaurant VALUES('R-1001', 'The Bistro', '123 Taman Fruit', '9:00-22:00', '012-3456789', 'E-12021');
INSERT INTO Restaurant VALUES('R-1002', 'Nasi House', '45 Jalan Emas', '10:00-20:00', '011-5566778', 'E-12022');
INSERT INTO Restaurant VALUES('R-1003', 'Pizza Palace', '99 Jalan Aman', '11:00-23:00', '013-6677889', 'E-12023');
INSERT INTO Restaurant VALUES('R-1004', 'Sushi World', '78 Taman Sakura', '12:00-21:00', '017-3322110', 'E-12024');
INSERT INTO Restaurant VALUES('R-1005', 'Curry Corner', '12 Taman Rempah', '8:00-20:00', '019-7788990', 'E-12025');

--(insert records into Reservation table)
INSERT INTO Reservation VALUES ('RE-1001', TO_DATE('2025-04-21', 'YYYY-MM-DD'), '18:30', 5, 'C-10001', 'E-12021');
INSERT INTO Reservation VALUES ('RE-1002', TO_DATE('2025-04-22', 'YYYY-MM-DD'), '19:00', 2, 'C-10002', 'E-12022');
INSERT INTO Reservation VALUES ('RE-1003', TO_DATE('2025-04-23', 'YYYY-MM-DD'), '20:00', 4, 'C-10003', 'E-12023');
INSERT INTO Reservation VALUES ('RE-1004', TO_DATE('2025-04-24', 'YYYY-MM-DD'), '17:30', 3, 'C-10004', 'E-12024');
INSERT INTO Reservation VALUES ('RE-1005', TO_DATE('2025-04-25', 'YYYY-MM-DD'), '18:00', 6, 'C-10005', 'E-12025');

--(insert records into Payment table)
INSERT INTO Payment VALUES ('PAY-1001', 100.00, 'Credit Card', TO_DATE('2025-04-21', 'YYYY-MM-DD'), 'C-10001');
INSERT INTO Payment VALUES ('PAY-1002', 75.50, 'Cash', TO_DATE('2025-04-22', 'YYYY-MM-DD'), 'C-10002');
INSERT INTO Payment VALUES ('PAY-1003', 60.00, 'Debit Card', TO_DATE('2025-04-23', 'YYYY-MM-DD'), 'C-10003');
INSERT INTO Payment VALUES ('PAY-1004', 90.25, 'Visa Card', TO_DATE('2025-04-24', 'YYYY-MM-DD'), 'C-10004');
INSERT INTO Payment VALUES ('PAY-1005', 120.00, 'TNG', TO_DATE('2025-04-25', 'YYYY-MM-DD'), 'C-10005');

--(insert records into Orders table)
INSERT INTO Orders VALUES (
'OR-1001', TO_DATE('2025-04-21', 'YYYY-MM-DD'),  'Pending', '18:30', 250.00, 'Dine-in', 'C-10001', 'R-1001');
INSERT INTO Orders VALUES (
'OR-1002', TO_DATE('2025-04-22', 'YYYY-MM-DD'),  'Completed', '12:15', 90.00, 'Takeaway', 'C-10002', 'R-1002');
INSERT INTO Orders VALUES (
'OR-1003', TO_DATE('2025-04-23', 'YYYY-MM-DD'),  'Completed', '14:00', 110.00, 'Dine-in', 'C-10003', 'R-1003');
INSERT INTO Orders VALUES (
'OR-1004', TO_DATE('2025-04-24', 'YYYY-MM-DD'),  'Cancelled', '17:45', 0.00, 'Takeaway', 'C-10004', 'R-1004');
INSERT INTO Orders VALUES (
'OR-1005', TO_DATE('2025-04-25', 'YYYY-MM-DD'),  'Completed', '20:30', 150.00, 'Dine-in', 'C-10005', 'R-1005');
INSERT INTO Orders VALUES (
'OR-1006', TO_DATE('2025-04-26', 'YYYY-MM-DD'),  'Pending', '11:45', 135.00, 'Takeaway', 'C-10001', 'R-1002');
INSERT INTO Orders VALUES (
'OR-1007', TO_DATE('2025-04-26', 'YYYY-MM-DD'),  'Completed', '19:00', 85.00, 'Dine-in', 'C-10002', 'R-1003');
INSERT INTO Orders VALUES (
'OR-1008', TO_DATE('2025-04-27', 'YYYY-MM-DD'),  'Completed', '13:30', 200.00, 'Takeaway', 'C-10003', 'R-1004');
INSERT INTO Orders VALUES (
'OR-1009', TO_DATE('2025-04-27', 'YYYY-MM-DD'),  'Cancelled', '15:45', 0.00, 'Takeaway', 'C-10004', 'R-1001');
INSERT INTO Orders VALUES (
'OR-1010', TO_DATE('2025-04-28', 'YYYY-MM-DD'),  'Completed', '18:00', 175.00, 'Dine-in', 'C-10005', 'R-1005');

--(insert records into Receipt table)
INSERT INTO Receipt VALUES ('REC-1001', TO_DATE('2025-04-22', 'YYYY-MM-DD'), 250.00, 'Paid', 'PAY-1001', 'OR-1001');
INSERT INTO Receipt VALUES ('REC-1002', TO_DATE('2025-04-22', 'YYYY-MM-DD'), 90.00, 'Paid', 'PAY-1002', 'OR-1002');
INSERT INTO Receipt VALUES ('REC-1003', TO_DATE('2025-04-23', 'YYYY-MM-DD'), 110.00, 'Paid', 'PAY-1003', 'OR-1003');
INSERT INTO Receipt VALUES ('REC-1004', TO_DATE('2025-04-24', 'YYYY-MM-DD'), 0.00, 'Cancelled', 'PAY-1004', 'OR-1004');
INSERT INTO Receipt VALUES ('REC-1005', TO_DATE('2025-04-25', 'YYYY-MM-DD'), 150.00, 'Paid', 'PAY-1005', 'OR-1005');

--(insert records into Order_Item table)
INSERT INTO Order_Item VALUES ('ITEM-2001', 2, 25.00, 'OR-1001', 'MI-1001');
INSERT INTO Order_Item VALUES ('ITEM-2002', 1, 50.00, 'OR-1002', 'MI-1002');
INSERT INTO Order_Item VALUES ('ITEM-2003', 3, 20.00, 'OR-1003', 'MI-1003');
INSERT INTO Order_Item VALUES ('ITEM-2004', 0, 0.00, 'OR-1004', 'MI-1004');
INSERT INTO Order_Item VALUES ('ITEM-2005', 2, 75.00, 'OR-1005', 'MI-1005');

--(insert records into Inventory table)
INSERT INTO Inventory VALUES ('INV-1001', 'Olive Oil', 'Food', 5.50, 100, 20, 'E-12021');
INSERT INTO Inventory VALUES ('INV-1002', 'Cheese', 'Food', 3.20, 80, 15, 'E-12022');
INSERT INTO Inventory VALUES ('INV-1003', 'Pasta', 'Food', 2.75, 150, 25, 'E-12023');
INSERT INTO Inventory VALUES ('INV-1004', 'Napkins', 'Supply', 1.00, 500, 100, 'E-12024');
INSERT INTO Inventory VALUES ('INV-1005', 'Chicken', 'Food', 6.75, 60, 10, 'E-12025');

--(insert records into Report table)
INSERT INTO Report VALUES ('REP-1001', TO_DATE('2025-04-22', 'YYYY-MM-DD'), 5000.00, 50, 'OR-1001', 'INV-1001', 'E-12021');
INSERT INTO Report VALUES ('REP-1002', TO_DATE('2025-04-23', 'YYYY-MM-DD'), 3200.00, 35, 'OR-1002', 'INV-1002', 'E-12022');
INSERT INTO Report VALUES ('REP-1003', TO_DATE('2025-04-24', 'YYYY-MM-DD'), 2750.00, 28, 'OR-1003', 'INV-1003', 'E-12023');
INSERT INTO Report VALUES ('REP-1004', TO_DATE('2025-04-25', 'YYYY-MM-DD'), 6000.00, 60, 'OR-1004', 'INV-1004', 'E-12024');
INSERT INTO Report VALUES ('REP-1005', TO_DATE('2025-04-26', 'YYYY-MM-DD'), 4500.00, 40, 'OR-1005', 'INV-1005', 'E-12025');

--(insert records into Inventory_Transaction table)
INSERT INTO Inventory_Transaction VALUES ('TRX-1001', 'Purchase', 50, TO_DATE('2025-04-22', 'YYYY-MM-DD'), 275.00, 'INV-1001', 'SUP-1001');
INSERT INTO Inventory_Transaction VALUES ('TRX-1002', 'Purchase', 40, TO_DATE('2025-04-23', 'YYYY-MM-DD'), 128.00, 'INV-1002', 'SUP-1002');
INSERT INTO Inventory_Transaction VALUES ('TRX-1003', 'Sale', 30, TO_DATE('2025-04-24', 'YYYY-MM-DD'), 82.50, 'INV-1003', 'SUP-1003');
INSERT INTO Inventory_Transaction VALUES ('TRX-1004', 'Restock', 100, TO_DATE('2025-04-25', 'YYYY-MM-DD'), 100.00, 'INV-1004', 'SUP-1004');
INSERT INTO Inventory_Transaction VALUES ('TRX-1005', 'Purchase', 60, TO_DATE('2025-04-26', 'YYYY-MM-DD'), 405.00, 'INV-1005', 'SUP-1005');

--(insert records into Take_Away table)
INSERT INTO Take_Away VALUES ('OR-1002', '123 Taman Seni', 'UberEats');
INSERT INTO Take_Away VALUES ('OR-1004', '45 Jalan Padi', 'GrabFood');
INSERT INTO Take_Away VALUES ('OR-1006', '67 Taman Hijau', 'ShopeeFood');
INSERT INTO Take_Away VALUES ('OR-1008', '89 Jalan Dahlia', 'FoodPanda');
INSERT INTO Take_Away VALUES ('OR-1009', '23 Jalan Kenari', 'AirAsiaFood');

--(insert records into Dine_In table)
INSERT INTO Dine_In VALUES ('OR-1001', 5.00, 'Table5', 25);
INSERT INTO Dine_In VALUES ('OR-1003', 5.00, 'Table7', 18);
INSERT INTO Dine_In VALUES ('OR-1005', 5.00, 'Table1', 10);
INSERT INTO Dine_In VALUES ('OR-1007', 4.00, 'Table9', 33);
INSERT INTO Dine_In VALUES ('OR-1010', 6.00, 'Table3', 12);

--(insert records into Manager table)
INSERT INTO Manager VALUES ('E-12021', 'Full Access', 5);
INSERT INTO Manager VALUES ('E-12025', 'Full Access', 7);
INSERT INTO Manager VALUES ('E-13001', 'Limited', 3);
INSERT INTO Manager VALUES ('E-13002', 'Full Access', 6);
INSERT INTO Manager VALUES ('E-13003', 'Read-only', 2);

--(insert records into Cashier table)
INSERT INTO Cashier VALUES ('E-12022', 'M01');
INSERT INTO Cashier VALUES ('E-13004', 'M02');
INSERT INTO Cashier VALUES ('E-13005', 'M03');
INSERT INTO Cashier VALUES ('E-13006', 'M04');
INSERT INTO Cashier VALUES ('E-13007', 'M05');

--(insert records into Chef table)
INSERT INTO Chef VALUES ('E-12023', 'Pastry', 7);
INSERT INTO Chef VALUES ('E-13008', 'Grilling', 6);
INSERT INTO Chef VALUES ('E-13009', 'Sushi', 8);
INSERT INTO Chef VALUES ('E-13010', 'Baking', 4);
INSERT INTO Chef VALUES ('E-13011', 'Sauces', 5);

commit;
