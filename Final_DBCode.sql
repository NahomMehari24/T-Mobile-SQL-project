USE INFO_330_Proj_11

-- 1) Two (2) stored procedures to populate transactional tables

CREATE PROCEDURE GetCustyID2
@F VARCHAR(60),
@L VARCHAR(60),
@DOB DATE,
@Custy INT OUTPUT
AS 
SET @Custy = (SELECT CustomerID
FROM tblCUSTOMER
WHERE CustomerFName = @F
AND CustomerLName = @L 
AND CustomerBirthDate = @DOB)

DECLARE @CID2 INT, @PID2 INT, @AID2 INT
EXEC GetCustyID2
@F = @F1
@L = @l1
@DOB = DOB2

CREATE PROCEDURE GetAccID2
@BDate DATE,
@EDate DATE,
@AccID INT OUTPUT
AS 
SET @AccID = (SELECT AccountID
FROM tblACCOUNT
WHERE BeginDate = @BDate
AND EndDate = @EDate)

DECLARE @CID2 INT, @PID2 INT, @AID2 INT
GetAccID2
@BDate = @BDate2
EDate = EDate2


CREATE PROCEDURE GetPlanyID2
@Plan_N VARCHAR(50),
@Plan_P NUMERIC(10,2),
@Planny INT OUTPUT
AS 
SET @Planny = ( SELECT PlanID 
FROM tblPLAN
WHERE PlanName = @Plan_N
AND PlanPrice = @Plan_P)

DECLARE @CID2 INT, @PID2 INT, @AID2 INT
GetPlanyID2
@Plan_P = @Plan_P1
@Plan_N = @Plan_N1

CREATE PROCEDURE INSERT_INTOtblAcc_Cust
@F1 VARCHAR(60),
@L1 VARCHAR(60) ,
@DOB1 DATE,
@BDate1 DATE,
@EDate1 DATE,
@Plan_N1 VARCHAR(50),
@Plan_P1 NUMERIC(10,2)
AS 
INSERT INTO tblACC_CUST (AccountCustID, CustomerID, AccountID, PlanID)
VALUES (AccountCustID, CID2, AID2, PID2)



/*

--

*/


-- SP2
CREATE PROCEDURE GetStatyID
@StatusTN VARCHAR(25),
@StatusD VARCHAR(150),
@Staty INT OUTPUT
AS
SET @Staty = (SELECT StatusID
FROM tblSTATUS S 
WHERE @Staty = S.StatusID)

DECLARE @S_ID INT, @C_ID INT
EXEC GetStatyID
@StatusTN = StatusTN1,
@StatusD = StatusD1,
@Staty = @S_ID OUTPUT

DECLARE @ST_ID2 INT, @C_ID2 INT
EXEC GetCustyID
@F = F1,
@L = L1,
@DOB = DOB1,
@Custy = @C_ID


CREATE PROCEDURE GetCustyID2
@F VARCHAR(60),
@L VARCHAR(60),
@DOB DATE,
@Custy INT OUTPUT
AS 
SET @Custy = (SELECT CustomerID
FROM tblCUSTOMER
WHERE CustomerFName = @F
AND CustomerLName = @L 
AND CustomerBirthDate = @DOB)

CREATE PROCEDURE Insert_Into_TblCust_Stat
@F1 VARCHAR(60),
@L1 VARCHAR(60),
@DOB1 DATE,
@StatusTN VARCHAR(25),
@StatusD VARCHAR(150)
AS
INSERT INTO tblCUST_STAT (CustomerStatID, CustStatDate, CustomerID, StatusID)
VALUES (CustomerStatID, CustStatDate, @CustStatDate, @C_ID, @S_ID)



-- 2) Write the SQL code to create two business rules leveraging User-Defined Functions (UDF) 
-- in addition to a sentence or two to describe the purpose/intent of each business rule.
/*

*/
-- CUSTOMERS FROM THE STATE OF ALABAMA, WITH A FIRST NAME THAT STARTS WITH 'L',AND THAT ARE ABOVE 75 YO 
-- MAY NOT BE ALLOWED TO SIGNED UP FOR A PLAN WITH T-MOBILE
CREATE FUNCTION UDFnahomm()
RETURNS INT 
AS 
BEGIN

DECLARE @RET INT = 0
IF 
EXISTS (SELECT * 
FROM tblCUSTOMER C 
JOIN tblACC_CUST AC ON C.CustomerID = AC.CustomerID
JOIN tblPLAN P ON AC.PlanID = P.PlanID
WHERE C.CustomerFName LIKE 'L%'
AND C.CustomerState = 'Alabama'
AND C.CustomerBirthDate < DATEADD(Year, -75, GETDATE())
)

BEGIN
SET @RET = 1
END 
RETURN @RET
END

ALTER TABLE tblPLAN WITH NOCHECK
ADD CONSTRAINT CK_NoCust_AL_75
CHECK(dbo.UDFnahomm() = 0)

/*
-- CUSTOMERS WITH FROM VERO BEACH, FL WITH A STATUS OF SUSPENDED AND WHO HAVE A ZIP CODE OF 334, 206 or 360  MAY NOT BE ALLOWED TO
-- REQUEST SERVICE FOR THEIR DEVICE FROM T-MOBILE
*/
CREATE FUNCTION udfnahomm2()
RETURNS INT
AS 
BEGIN

DECLARE @RET INT = 0

IF 
EXISTS(SELECT *
FROM tblCUSTOMER C 
JOIN tblCUST_STAT CST ON C.CustomerID = CST.CustomerID
JOIN tblSTATUS S ON CST.StatusID = S.StatusID
JOIN tblACC_CUST AC ON C.CustomerID = AC.CustomerID
JOIN tblACCOUNT A ON AC.AccountID = A.AccountID
JOIN tblDEVICE D ON AC.AccountCustID = D.AccountCustID 
JOIN tblREQUEST R ON D.DeviceID = R.DeviceID
WHERE S.StatusTypeName = 'Suspended'
AND C.CustomerCity = 'Vero Beach'
AND C.CustomerState = 'Florida, FL'
AND C.CustomerZip IN ('334', '206', '360')
)

BEGIN 
SET @RET = 1 
END
RETURN @RET
END

ALTER TABLE tblREQUEST WITH NOCHECK
ADD CONSTRAINT CK_NoCust_VeroBeach_ZCode
CHECK(dbo.udfnahomm2() = 0)


-- 3) Write the SQL code two computed columns leveraging UDFs

CREATE FUNCTION UDF_CC_NahomM(@PK INT)
RETURNS NUMERIC(10,2)
AS 
BEGIN 

DECLARE @RET NUMERIC(10,2) =

(SELECT SUM(StoreRevenue) AS MoneyPerStore
FROM tblSTORE S 
JOIN tblLOCATION L ON S.LocationID = L.LocationID
WHERE LocationState NOT IN ('Washington', 'California', 'Vermont', 'Delaware')
GROUP BY StoreID
HAVING SUM(StoreRevenue) > 5000000
AND StoreID = @PK)

RETURN @RET 
END 

ALTER TABLE tblSTORE 
ADD UDF_CC_NahomM AS (dbo.UDF_CC_NahomM(StoreID))

---

CREATE FUNCTION UDF_CC_NahomM4 (@PK INT)
RETURNS NUMERIC(10,2)
AS 
BEGIN 

DECLARE @RET NUMERIC(10,2) = (
SELECT SUM(D.DiscountAmount) AS TotalDiscount_TX_FL
FROM tblDISCOUNT D 
JOIN tblORDER_PROD OP ON D.DiscountID = OP.DiscountID
JOIN tblORDER O ON OP.OrderID = O.OrderID
JOIN tblSTORE S ON O.StoreID = S.StoreID
JOIN tblLOCATION L ON S.LocationID = S.LocationID
WHERE LocationState = 'Texas'
OR LocationState = 'Florida'
GROUP BY D.DiscountID
HAVING SUM(DiscountAmount) > 175
AND D.DiscountID = @PK)

RETURN @RET
END 

ALTER TABLE tblDISCOUNT
ADD UDF_CC_NahomM4 AS (dbo.UDF_CC_NahomM4(DiscountID))



-- 4) Write the SQL code to create two different complex queries (defined below)

-- SELECT THE LARGEST DIFFERENCE BETWEEN MAX AND MIN DISCOUNT's RECIEVED IN OREGON FROM CUSTOMERS BORN IN OR AFTER 1976

SELECT MAX(D.DiscountAmount) - MIN(D.DiscountAmount) AS Largest_Total_Diff
FROM tblCUSTOMER C 
JOIN tblACC_CUST AC ON C.CustomerID = AC.CustomerID
JOIN tblORDER O ON AC.AccountCustID = O.AccountCustID
JOIN tblORDER_PROD OP ON O.OrderID = O.OrderID 
JOIN tblDISCOUNT D ON OP.DiscountID = D.DiscountID
JOIN tblSTORE S ON O.StoreID = O.StoreID 
JOIN tblLOCATION L ON S.LocationID = L.LocationID
WHERE LocationState = ('Oregon')
AND CustomerBirthDate > '1975-12-31'


--- 

-- SELECT THE TOP 10 STORES, GENERATING ATLEAST 1,000,000 IN REVENUE, ON PRODUCTS THAT ARE 
-- MOBILE PHONE OR TABLETS, IN OREGON, WASHINGTON OR CALIFORNIA

SELECT TOP 10 SUM(S.StoreRevenue) AS AnnualRevenue, S.StoreID
FROM tblLOCATION L 
JOIN tblSTORE S ON L.LocationID = S.LocationID
JOIN tblORDER O ON S.StoreID = O.StoreID
JOIN tblORDER_PROD OP ON O.OrderID = OP.OrderID
JOIN tblPRODUCT P ON OP.ProductID = P.ProductID
JOIN tblPROD_TYPE PT ON P.ProdTypeID = PT.ProdTypeID
WHERE L.LocationState IN ('Oregon', 'Washington', 'California')
AND PT.ProdTypeName = 'Mobile Phone'
OR PT.ProdTypeName = 'Tablet'
GROUP BY S.StoreID
HAVING SUM(StoreRevenue) > 1000000
ORDER BY AnnualRevenue DESC
