SELECT * FROM Bike_Sales;
--cost vs revenue vs profit by year and month//country
SELECT Country
,Year
,CASE
WHEN Month = 'January' THEN 1
WHEN Month = 'February' THEN 2
WHEN Month = 'March' THEN 3
WHEN Month = 'April' THEN 4
WHEN Month = 'May' THEN 5
WHEN Month = 'June' THEN 6
WHEN Month = 'July' THEN 7
WHEN Month = 'August' THEN 8
WHEN Month = 'September' THEN 9
WHEN Month = 'October' THEN 10
WHEN Month = 'November' THEN 11
WHEN Month = 'December' THEN 12
END AS Month
,SUM(Cost) AS [Cost]
,SUM(Revenue) AS [Revenue]
,SUM(Profit) AS [Profit]
INTO country_crp
FROM Bike_Sales
GROUP BY Country
,Year
,Month
ORDER BY Year
,Month;
--profits from states
SELECT State
,SUM(Profit) AS [Profit]
INTO states_profit
FROM Bike_Sales
WHERE Country = 'United States'
GROUP BY State
ORDER BY Profit DESC;
-- most wanted, profitable products, sub category and product category//gender
SELECT Product_Category as Category
,Sub_Category AS Subcategory
,SUM(CAST(Order_Quantity AS INT)) AS [Purchased Products]
,SUM(Profit) AS [Profit]
,SUM(CASE WHEN Customer_Gender = 'F' THEN (CAST(Order_Quantity AS INT)) ELSE 0 END) AS [Purchased Products by Women]
,SUM(CASE WHEN Customer_Gender = 'M' THEN (CAST(Order_Quantity AS INT)) ELSE 0 END) AS [Purchased Products by Men]
,SUM(CASE WHEN Customer_Gender = 'F' THEN Profit ELSE 0 END) AS [Profit by Women]
,SUM(CASE WHEN Customer_Gender = 'M' THEN Profit ELSE 0 END) AS [Profit by Men]
,SUM(CASE WHEN Age_Group = 'Youth (<25)' THEN (CAST(Order_Quantity AS INT)) ELSE 0 END) AS [Purchased Products by Youth (<25)]
,SUM(CASE WHEN Age_Group = 'Young Adults (25-34)' THEN (CAST(Order_Quantity AS INT)) ELSE 0 END) AS [Purchased Products by Young Adults (25-34)]
,SUM(CASE WHEN Age_Group = 'Adults (35-64)' THEN (CAST(Order_Quantity AS INT)) ELSE 0 END) AS [Purchased Products by Adults (35-64)]
,SUM(CASE WHEN Age_Group = 'Seniors (64+)' THEN (CAST(Order_Quantity AS INT)) ELSE 0 END) AS [Purchased Products by Seniors (64+)]
,SUM(CASE WHEN Age_Group = 'Youth (<25)' THEN Profit ELSE 0 END) AS [Profit by Youth (<25)]
,SUM(CASE WHEN Age_Group = 'Young Adults (25-34)' THEN Profit ELSE 0 END) AS [Profit by Young Adults (25-34)]
,SUM(CASE WHEN Age_Group = 'Adults (35-64)' THEN Profit ELSE 0 END) AS [Profit by Adults (35-64)]
,SUM(CASE WHEN Age_Group = 'Seniors (64+)' THEN Profit ELSE 0 END) AS [Profit by Seniors (64+)]
INTO products
FROM Bike_Sales
GROUP BY Product_Category 
,Sub_Category
ORDER BY Product_Category
,Sub_Category;
--2015 profit vs 2016 profit in %
SELECT Year
,SUM(Profit) AS [Profit]
INTO year_profit
FROM Bike_Sales
WHERE Year in(2015,2016)
GROUP BY Year;
--profit by age group
SELECT Age_Group
,SUM(Profit) AS [Profit]
INTO age_group_profit
FROM Bike_Sales 
GROUP BY Age_Group;

SELECT * FROM year_profit;
SELECT DISTINCT(SELECT Profit
FROM year_profit
WHERE Year = '2015') AS profit_2015
,(SELECT Profit
FROM year_profit
WHERE Year = '2016') AS profit_2016
INTO yearly_profit
FROM year_profit;