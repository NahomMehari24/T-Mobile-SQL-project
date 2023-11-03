USE INFO_330_PROJ_11
-- add some data to database
-- insert 2000 customers from Peeps.dbo.tblcustomer
INSERT INTO TblCustomers (CustomerID, CustomerFname, CustomerLname, CustomerCity,CustomerState, CustomerZip, CustomerBirth)
SELECT TOP 2000 CustomerID, CustomerFname, CustomerLname, CustomerCity, CustomerState, CustomerZIP, DateofBirth)
FROM Peeps.dbo.tblcustomer


SELECT TOP 2000*
FROM Peeps.dbo.tblcustomer

-- INSERT INTO STATUS

INSERT INTO TblStatus ( StatusTypeName, StatusDescr)
VALUES ('Suspended', 'Plan has been suspended')

INSERT INTO TblStatus ( StatusTypeName, StatusDescr)
VALUES ('On-Going', 'Plan is concurrent')

INSERT INTO TblStatus ( StatusTypeName, StatusDescr)
VALUES ('Expired', 'Contract period expired')

INSERT INTO TblStatus ( StatusTypeName, StatusDescr)
VALUES ('On Hold', 'Disputes, Investigations')

-- Insert Into Requests

INSERT INTO TblRequest_Type (RequestTypeName, RequestDescr)
VALUES ('Water Damage', 'Water Broke Phone')

INSERT INTO TblRequest_Type ( RequestTypeName, RequestDescr)
VALUES ('Cracked Screen', 'Crack of Screen of the Device')

INSERT INTO TblRequest_Type ( RequestTypeName, RequestDescr)
VALUES ('Broken LCD Screen', 'Broken Liquid Crystal Display')

INSERT INTO TblRequest_Type ( RequestTypeName, RequestDescr)
VALUES ('Software Issue', 'Screen & Software Delays')

INSERT INTO TblRequest_Type ( RequestTypeName, RequestDescr)
VALUES ('Battery Issue', 'Quick Battery Drainage')

-- Insert Into Plan Type

INSERT INTO TblPlan_Type (PlanType)
VALUES ('Essentials')

INSERT INTO TblPlan_Type (PlanType)
VALUES ('Business')

INSERT INTO TblPlan_Type (PlanType)
VALUES ('Magenta')

INSERT INTO TblPlan_Type (PlanType)
VALUES ('Magenta MAX')

INSERT INTO TblPlan_Type (PlanType)
VALUES ('Family')

-- Insert Into Employee Type

INSERT INTO tblEmployee_Type  (EmployeeTypeName, EmployeeDescr)
VALUES ('Human Resources Specialist', 'Helps Facilitate Human Relations')

INSERT INTO tblEmployee_Type  (EmployeeTypeName, EmployeeDescr)
VALUES ('Customer Service Rep', 'Handles Inqueries, Assistance, & More')

INSERT INTO tblEmployee_Type  (EmployeeTypeName, EmployeeDescr)
VALUES ('Retail Sales Associate', 'Assist the Selling of Devices in Store')

INSERT INTO tblEmployee_Type  (EmployeeTypeName, EmployeeDescr)
VALUES ('Marketing Specialist', 'Oversees Marketing Campaigns')

INSERT INTO tblEmployee_Type  (EmployeeTypeName, EmployeeDescr)
VALUES ('Network Engineer', 'Design & Implement Network Infrastructure')

INSERT INTO tblEmployee_Type  (EmployeeTypeName, EmployeeDescr)
VALUES ('Retail Store Manager', 'Oversees operations of all T-Mobile Locations')

INSERT INTO tblEmployee_Type  (EmployeeTypeName, EmployeeDescr)
VALUES ('IT Support Specialist', 'Tech Assistance to maintain systems')

