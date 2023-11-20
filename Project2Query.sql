USE assignment3;
/*
What is the total final price for the Highland House project? 
Be sure to apply the discount to derive the final price (e.g., ExtendedPrice x (1-Discount) = FinalPrice).
Do not store FinalPrice in your database. 
Instead, it will be a derived value from your SQL calculation. Round the result to two decimal places.
*/
SELECT ProjectID, ROUND(SUM(ExtendedPrice * (1-(Discount/100))),2) AS FinalPrice
FROM project, supplier
WHERE Supplier_supplierID = supplierID
AND ProjectID = 1;

/*
What the total final price for all items, grouped by category and sorted in descending order of total final price? 
Be sure to apply the discount to derive the total final price and round the result to two decimal places
*/
SELECT ROUND(SUM(ExtendedPrice * (1-(Discount/100))),2) AS FinalPrice, Category
FROM Supplier,Project, Item
WHERE  SupplierID = Supplier_SupplierID AND Item_ItemID = ItemID
GROUP BY Category
ORDER BY FinalPrice DESC;

-- c.	List all of the company projects (project name), the owner name and contact information for each project, 
-- the equipment (item description) needed for that project, and the total final price (which includes the discount, 
-- defined above). Round the result to two decimal places and sort first by project name, and then by item description.
--  (To sort by two fields, just add a comma between both in the ORDER BY clause (e.g., ORDER BY projectname, itemdescription). 

SELECT
    ProjectOwner.ProjectName AS ProjectName,
    CONCAT(ownerinfo.OwnerFName, ' ', ownerinfo.OwnerLName) AS OwnerName,
    Supplier.PhoneNumber AS ContactInformation,
    Item.ItemDescription AS Equipment,
    ROUND(SUM(Project.ExtendedPrice * (1 - (Supplier.Discount / 100))), 2) AS TotalFinalPrice
FROM
    ProjectOwner
    JOIN Project ON ProjectOwner.ProjectID = Project.ProjectID
    JOIN Supplier ON Project.Supplier_SupplierID = Supplier.SupplierID
    JOIN ownerinfo ON ProjectOwner.OwnerInfo_OwnerID = ownerinfo.OwnerID
    JOIN Item ON Project.Item_ItemID = Item.ItemID
GROUP BY
    ProjectName, OwnerName, ContactInformation, Equipment
ORDER BY
    ProjectName, Equipment;
    
-- d.	List the total final price (defined above) grouped by each supplier name. Round the result to two 
-- decimal places. Sort the result in descending order by total final price. 
    SELECT
    Supplier.Supplier AS SupplierName,
    ROUND(SUM(Project.ExtendedPrice * (1 - (Supplier.Discount / 100))), 2) AS TotalFinalPrice
FROM
    Project
    JOIN Supplier ON Project.Supplier_SupplierID = Supplier.SupplierID
GROUP BY
    SupplierName
ORDER BY
    TotalFinalPrice DESC;


-- What is the total cost for each project? Discount included.
SELECT ProjectName, ROUND(SUM(ExtendedPrice * (1-(Discount/100))),2) AS FinalPrice
FROM project, supplier, ProjectOwner
WHERE Supplier_supplierID = supplierID AND ProjectOwner.ProjectID = Project.ProjectID
GROUP BY ProjectName;

-- What is the difference between the cost of each project with and without the discount?
SELECT ProjectName, ROUND(SUM(ExtendedPrice * (1-(Discount/100))),2) AS FinalPrice, ROUND(SUM(ExtendedPrice),2) AS NoDiscount,  ROUND(SUM(ExtendedPrice),2) - ROUND(SUM(ExtendedPrice * (1-(Discount/100))),2) AS Difference
FROM project, supplier, ProjectOwner
WHERE Supplier_supplierID = supplierID AND ProjectOwner.ProjectID = Project.ProjectID
GROUP BY ProjectName;

-- This is a Subquery that Selects all categories and outputs the total final price for all items in that category -- 
SELECT Category, 
(SELECT ROUND(SUM(ExtendedPrice * (1 - (Discount / 100))), 2)
     FROM Supplier s
     JOIN Project p ON s.SupplierID = p.Supplier_SupplierID
     JOIN Item i ON p.Item_ItemID = i.ItemID
     WHERE i.Category = Item.Category) AS FinalPrice
FROM Item
GROUP BY Category;
