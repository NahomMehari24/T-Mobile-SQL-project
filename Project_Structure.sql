DROP DATABASE INFO_330_Proj_11

USE INFO_330_Proj_11

CREATE TABLE TblCustomers(
CustomerID INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
CustomerFName VARCHAR(60) NOT NULL,
CustomerLName VARCHAR(60) NOT NULL,
CustomerBirth DATE,
CustomerCity VARCHAR(75)NOT NULL,
CustomerState VARCHAR(25) NOT NULL,
CustomerZip CHAR(5) NOT NULL)


CREATE TABLE TblAccount(
AccountID INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
BeginDate DATETIME NOT NULL,
EndDate DATETIME NULL)

CREATE TABLE TblBrand(
BrandID INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
BrandName VARCHAR(30) NOT NULL)

CREATE TABLE TblDiscount_Type(
DiscountTypeID INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
DiscountType VARCHAR(75) NOT NULL)

CREATE TABLE TblDiscount(
DiscountID INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
DiscountName VARCHAR(25) NOT NULL,
DiscountAmount NUMERIC(10,2) NULL,
DiscountTypeID INT FOREIGN KEY REFERENCES TblDiscount_Type(DiscountTypeID))

CREATE TABLE TblPlan_Type(
PlanTypeID INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
PlanType VARCHAR(50) NULL)

CREATE TABLE tblPlan(
PlanID INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
PlanName VARCHAR(50) NOT NULL,
PlanPrice NUMERIC(10,2) NOT NULL,
PlanTypeID INT FOREIGN KEY REFERENCES TblPlan_Type(PlanTypeID))

CREATE TABLE tblAcc_Cust(
AccountCustID INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
CustomerID INT FOREIGN KEY REFERENCES TblCustomers(CustomerID),
AccountID INT FOREIGN KEY REFERENCES TblAccount(AccountID),
PlanID INT FOREIGN KEY REFERENCES tblPlan(PlanID))


CREATE TABLE TblDevice (
DeviceID INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
DeviceName VARCHAR(50) NOT NULL,
AccountCustID INT FOREIGN KEY REFERENCES tblAcc_Cust(AccountCustID))

CREATE TABLE TblRequest_Type(
RequestTypeID INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
RequestTypeName VARCHAR(50) NOT NULL,
RequestDescr VARCHAR(125) NOT NULL)


CREATE TABLE TblRequests(
RequestID INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
ServiceDate Date NULL,
RequestDate Date NOT NULL,
DeviceID INT FOREIGN KEY REFERENCES TblDevice(DeviceID),
RequestTypeID INT FOREIGN KEY REFERENCES TblRequest_Type(RequestTypeID))


CREATE TABLE TblLocation(
LocationID INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
LocationName VARCHAR(50) NOT NULL,
LocationCity VARCHAR(50) NOT NULL,
LocationState VARCHAR(50) NOT NULL,
LocationZip VARCHAR(50) NOT NULL)

CREATE TABLE TblStore(
StoreID INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
StoreRevenue NUMERIC(10,2) NOT NULL,
StorePhoneNumber CHAR(10) NOT NULL,
LocationID INT FOREIGN KEY REFERENCES TblLocation(LocationID))

CREATE TABLE TblOrders(
OrderID INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
Discount NUMERIC(10,2) NULL,
Cost NUMERIC(10,2) NOT NULL, 
StoreID INT FOREIGN KEY REFERENCES tblStore(StoreID),
AccountCustID INT FOREIGN KEY REFERENCES tblAcc_Cust(AccountCustID))

-- 

CREATE TABLE tblEmployee_Type(
EmployeeTypeID INT IDENTITY (1,1) PRIMARY KEY NOT NULL,
EmployeeTypeName VARCHAR(50) NOT NULL,
EmployeeDescr VARCHAR(50) NOT NULL)

CREATE TABLE TblEmployee(
EmployeeID INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
EmployeeFname VARCHAR(75) NOT NULL,
EmployeeLname VARCHAR(75) NOT NULL,
Position VARCHAR(50) NOT NULL,
StoreID INT FOREIGN KEY REFERENCES TblStore(StoreID),
EmployeeTypeID INT FOREIGN KEY REFERENCES tblEmployee_Type(EmployeeTypeID))

CREATE TABLE TblProd_Type(
ProdTypeID INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
ProdTypeName VARCHAR(50) NOT NULL)

CREATE TABLE TblProduct(
ProductID INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
ProdPrice NUMERIC(10,2) NOT NULL,
ProdName VARCHAR(50) NOT NULL,
BrandID INT FOREIGN KEY REFERENCES TblBrand(BrandID),
ProdTypeID INT FOREIGN KEY REFERENCES TblProd_Type(ProdTypeID))

CREATE TABLE TblOrder_PROD(
Order_ProdID INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
Quantity INT NOT NULL,
OrderID INT FOREIGN KEY REFERENCES TblOrders(OrderID),
DiscountID INT FOREIGN KEY REFERENCES TblDiscount(DiscountID),
ProductID INT FOREIGN KEY REFERENCES TblProduct(ProductID))

CREATE TABLE TblEvent_Type(
EventTypeID INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
EventType VARCHAR(125) NOT NULL,
EventTypeDescr VARCHAR(125) NOT NULL)


CREATE TABLE TblEvent(
EventID INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
EventName VARCHAR(50) NOT NULL,
EventTimeStamp Datetime,
EventTypeID INT FOREIGN KEY REFERENCES TblEvent_Type(EventTypeID))

CREATE TABLE TblStatus(
StatusID INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
StatusTypeName VARCHAR(25) NOT NULL,
StatusDescr VARCHAR(25) NOT NULL)

CREATE TABLE TblNetwork_Tower(
NetworkID INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
NetworkName VARCHAR(75) NOT NULL)

CREATE TABLE TblCust_Stat(
CustomerStatID INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
CustStatDate DATE NOT NULL,
CustomerID INT FOREIGN KEY REFERENCES TblCustomers(CustomerID),
StatusID INT FOREIGN KEY REFERENCES TblStatus(StatusID))



-- ALTER TABLE STATEMENTS 

-- Add CustomerID FK into Account Tbl
-- Add RequestType into Service Request
-- Add LocationID into Store

ALTER TABLE Account
      ADD CONSTRAINT FK_Account_Cust
      FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)

      ALTER TABLE Store
      ADD CONSTRAINT FK_Store_Loc
      FOREIGN KEY (LocationID) REFERENCES Location(LocationID)

          ALTER TABLE Service_Requests
      ADD CONSTRAINT FK_ServiceReq
      FOREIGN KEY (RequestType) REFERENCES Request_Type(RequestType)

