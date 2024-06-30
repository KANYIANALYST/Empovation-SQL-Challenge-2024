--WEEK 1
-- "count the Total Number of Orders Per Customer order in desc" 
 
SELECT  
    CustomerKey,  
    COUNT(Order_Number) AS total_orders 
FROM  
    Sales GROUP BY  
    CustomerKey ORDER BY  
    total_orders DESC; 


 
-- "List of Products Sold in 2020" 
 
SELECT DISTINCT 
    p.ProductKey, 
    p.Product_Name 
FROM  
    Sales o 
JOIN  
    Products p ON o.ProductKey = p.ProductKey 
WHERE  
    YEAR(o.Order_Date) = 2020; 

	
--"Find all Customer Details from California (CA)" 
 
SELECT * FROM Customers 
WHERE  
State_Code = 'CA'; 
 
 -- "Salculate the Total Sales Quantity for product 2115" 
 
SELECT  
    ProductKey, 
    SUM(Quantity) AS total_sales_quantity 
FROM  
    Sales 
WHERE  
    ProductKey = 2115 
GROUP BY  
    ProductKey; 

-- "Top 5 Stores with the Most Sales Transactions" 
 
SELECT TOP 5 
    StoreKey, 
    COUNT(Order_Number) AS total_transactions 
FROM  
    Sales GROUP BY  
    StoreKey ORDER BY  
    total_transactions DESC 


--WEEK 2
--Write a query to find the average unit price of products in each category 

SELECT      category, 
    AVG(Unit_Price_USD) AS average_unit_price FROM      products GROUP BY      category; 


-- Write a query to count the number of orders placed by each gender. 

SELECT  
    c.gender, 
    COUNT(o.Order_Number) AS order_count 
FROM  
    Sales o 
JOIN  
    Customers c ON o.CustomerKey = c.CustomerKey 
GROUP BY  
    c.gender; 


-- Write a query to list all products that have never been sold. 
SELECT  
    p.ProductKey, 
    p.product_name FROM  
    Products p 
LEFT JOIN  
    Sales od ON p.Productkey = od.ProductKey WHERE  
    od.Order_Number IS NULL; 


-- Write a query to show the total amount in USD, round to 2 decimal point for orders made in other currencies,  
     --using the Exchange Rates table to convert the prices.. 
SELECT  
    s.Order_Number, 
    ROUND(SUM(s.Quantity * p.Unit_Price_USD * e.Exchange), 2) AS total_amount_usd FROM  
    Sales s 
 	JOIN  
    Products p ON s.ProductKey = p.ProductKey JOIN  
    exchange_rates e ON s.Currency_Code = e.currency 
WHERE s.Currency_Code!='USD' 
GROUP BY  
    s.Order_Number; 

--WEEK 3

-- Write a query to analyze whether larger stores (in terms of square meters) have higher sales volumes.

WITH StoreSales AS (
SELECT  s.StoreKey, s.Square_Meters, SUM(sa.Quantity) AS TotalSales
FROM 
    Stores s
    JOIN 
        Sales sa ON s.StoreKey = sa.StoreKey
GROUP BY s.StoreKey, s.Square_Meters
)
SELECT 
    Square_Meters,
    AVG(TotalSales) AS AverageSales
FROM 
    StoreSales
GROUP BY 
    Square_Meters
ORDER BY 
    Square_Meters;


--  Write a query to segment customers into groups based on their purchase behaviors 
--   (e.g., total spend, number of orders) and demographics (e.g., state, gender).

WITH CustomerAggregates AS (
    SELECT 
        c.CustomerKey,
        c.Name,
        c.State,
        c.Gender,
        COUNT(s.Order_Number) AS NumberOfOrders,
        SUM(s.Quantity * p.Unit_Price_USD) AS TotalSpend
    FROM 
        Customers c
    JOIN 
        Sales s ON c.CustomerKey = s.CustomerKey
    JOIN 
        Products p ON s.ProductKey = p.ProductKey
    GROUP BY 
        c.CustomerKey, c.Name, c.State, c.Gender
),
CustomerSegments AS (
    SELECT 
        CustomerKey,
        Name,
        State,
        Gender,
        NumberOfOrders,
        TotalSpend,
        CASE 
            WHEN TotalSpend > 1000 THEN 'High Spender'
            WHEN TotalSpend BETWEEN 500 AND 1000 THEN 'Medium Spender'
            ELSE 'Low Spender'
        END AS SpendCategory,
        CASE 
            WHEN NumberOfOrders > 10 THEN 'Frequent Buyer'
            WHEN NumberOfOrders BETWEEN 5 AND 10 THEN 'Regular Buyer'
            ELSE 'Occasional Buyer'
        END AS OrderFrequency
    FROM 
        CustomerAggregates
)
SELECT 
    CustomerKey,
    Name,
    State,
    Gender,
    NumberOfOrders,
    TotalSpend,
    SpendCategory,
    OrderFrequency
FROM 
    CustomerSegments
ORDER BY 
    TotalSpend DESC, NumberOfOrders DESC;



-- Write a query to calculate the total sales volume for each store, then rank stores based on their sales volume.
WITH StoreSales AS (
    SELECT 
        s.StoreKey,
       
        SUM(sa.Quantity) AS TotalSales
    FROM 
        Stores s
    JOIN 
        Sales sa ON s.StoreKey = sa.StoreKey
    GROUP BY 
        s.StoreKey
)
SELECT 
    StoreKey,
    TotalSales,
    RANK() OVER (ORDER BY TotalSales DESC) AS SalesRank
FROM 
    StoreSales
ORDER BY 
    SalesRank;


-- Write a query to retrieve daily sales volumes, then calculate a running total of sales over time, ordered by date.
WITH DailySales AS (
    SELECT 
        CONVERT(DATE, Order_Date) AS SaleDate,
        SUM(Quantity) AS DailySalesVolume
    FROM 
        Sales
    GROUP BY 
        CONVERT(DATE, Order_Date)
)
SELECT 
    SaleDate,
    DailySalesVolume,
    SUM(DailySalesVolume) OVER (ORDER BY SaleDate) AS RunningTotalSales
FROM 
    DailySales
ORDER BY 
    SaleDate;


-- Write a query to calculate the lifetime value of each customer based on their country

WITH CustomerLTV AS (
    SELECT 
        c.CustomerKey,
        c.Country,
        SUM(s.Quantity * p.Unit_Price_USD) AS TotalSpend
    FROM 
        Customers c
    JOIN 
        Sales s ON c.CustomerKey = s.CustomerKey
    JOIN 
        Products p ON s.ProductKey = p.ProductKey
    GROUP BY 
        c.CustomerKey, c.Country
),
CountryLTV AS (
    SELECT 
        Country,
        AVG(TotalSpend) AS AverageLTV
    FROM 
        CustomerLTV
    GROUP BY 
        Country
)
SELECT 
    Country,
    AverageLTV,
    RANK() OVER (ORDER BY AverageLTV DESC) AS LTVRank
FROM 
    CountryLTV
ORDER BY 
    LTVRank;


--BONUS QUESTION Write a query to calculate the lifetime value of each customer based on the total amount they’ve spent.
SELECT 
    c.CustomerKey,
    c.Name,
    SUM(s.Quantity * p.Unit_Price_USD) AS LifetimeValue
FROM 
    Customers c
JOIN 
    Sales s ON c.CustomerKey = s.CustomerKey
JOIN 
    Products p ON s.ProductKey = p.ProductKey
GROUP BY 
    c.CustomerKey, c.Name
ORDER BY 
    LifetimeValue DESC;


--WEEK 4

--Write a query to calculate the total annual sales per product category for the current year 
--and the previous year, and then use window functions to calculate the year-over-year growth percentage.

WITH AnnualSales AS (
    SELECT 
        c.Category,
        YEAR(s.Order_Date) AS SalesYear,
        SUM(s.Quantity * p.Unit_Price_USD) AS TotalSales
    FROM 
        Categories c
    JOIN 
        Products p ON c.CategoryKey = p.CategoryKey
    JOIN 
        Sales s ON p.ProductKey = s.ProductKey
    WHERE 
        s.Order_Date >= '2016-01-01' AND s.Order_Date <= '2021-01-01'
        OR s.Order_Date >= '2016-01-01' AND s.Order_Date < '2022-01-01'
    GROUP BY 
        c.Category, YEAR(s.Order_Date)
),
SalesWithGrowth AS (
    SELECT 
        Category,
        SalesYear,
        TotalSales,
        LAG(TotalSales) OVER (PARTITION BY Category ORDER BY SalesYear) AS PreviousYearSales
    FROM 
        AnnualSales
)
SELECT 
    Category,
    SalesYear,
    TotalSales,
    PreviousYearSales,
    CASE 
        WHEN PreviousYearSales IS NULL THEN 0
        ELSE ((TotalSales - PreviousYearSales) * 100.0 / PreviousYearSales)
    END AS YoYGrowthPercentage
FROM 
    SalesWithGrowth
WHERE 
    SalesYear = 2021 OR SalesYear = 2020
ORDER BY 
    Category, SalesYear;


--Write a SQL query to find each customer’s purchase rank within the store they bought from, 
--based on the total price of the order (quantity * unit price).

WITH OrderTotals AS (
    SELECT 
        s.CustomerKey,
        s.StoreKey,
        s.ProductKey,
        SUM(s.Quantity * p.Unit_Price_USD) AS TotalPrice
    FROM 
        Products p
    JOIN 
        Sales s ON p.ProductKey = s.ProductKey
    GROUP BY 
        s.CustomerKey, s.StoreKey, s.ProductKey
),
CustomerPurchaseRank AS (
    SELECT 
        ot.CustomerKey,
        ot.StoreKey,
        ot.ProductKey,
        ot.TotalPrice,
        RANK() OVER (PARTITION BY ot.StoreKey ORDER BY ot.TotalPrice DESC) AS PurchaseRank
    FROM 
        OrderTotals ot
)
SELECT 
    c.CustomerKey,
    c.Name,
    st.StoreKey,
    cp.ProductKey,
    cp.TotalPrice,
    cp.PurchaseRank
FROM 
    CustomerPurchaseRank cp
JOIN 
    Customers c ON cp.CustomerKey = c.CustomerKey
JOIN 
    Stores st ON cp.StoreKey = st.StoreKey
ORDER BY 
    st.StoreKey, cp.PurchaseRank;


--Perform a customer retention analysis to determine the percentage of customers who made 
--repeat purchases within three months of their initial purchase. Calculate the percentage of retained customers by gender, age group, and location.


-- Calculate initial purchase date for each customer
WITH InitialPurchases AS (
    SELECT 
        CustomerKey,
        MIN(Order_Date) AS InitialPurchaseDate
    FROM 
        Sales
    GROUP BY 
        CustomerKey
),

--Identify customers with repeat purchases within three months of their initial purchase
RepeatPurchases AS (
    SELECT 
        s.CustomerKey,
        COUNT(DISTINCT s.Order_Date) AS NumberOfOrders,
        i.InitialPurchaseDate
    FROM 
        Sales s
    JOIN 
        InitialPurchases i ON s.CustomerKey = i.CustomerKey
    WHERE 
        s.Order_Date > i.InitialPurchaseDate 
        AND s.Order_Date <= DATEADD(MONTH, 3, i.InitialPurchaseDate)
    GROUP BY 
        s.CustomerKey, i.InitialPurchaseDate
),

-- Classify customers as retained or not
CustomerRetention AS (
    SELECT 
        c.CustomerKey,
        c.Gender,
        CASE 
            WHEN DATEDIFF(YEAR, c.Birthday, GETDATE()) < 20 THEN 'Under 20'
            WHEN DATEDIFF(YEAR, c.Birthday, GETDATE()) BETWEEN 20 AND 29 THEN '20-29'
            WHEN DATEDIFF(YEAR, c.Birthday, GETDATE()) BETWEEN 30 AND 39 THEN '30-39'
            WHEN DATEDIFF(YEAR, c.Birthday, GETDATE()) BETWEEN 40 AND 49 THEN '40-49'
            ELSE '50 and above'
        END AS AgeGroup,
        c.Country,
        CASE 
            WHEN r.CustomerKey IS NOT NULL THEN 1
            ELSE 0
        END AS IsRetained
    FROM 
        Customers c
    LEFT JOIN 
        RepeatPurchases r ON c.CustomerKey = r.CustomerKey
),

-- Calculate retention rate by demographics
RetentionRate AS (
    SELECT 
        Gender,
        AgeGroup,
        Country,
        COUNT(CustomerKey) AS TotalCustomers,
        SUM(IsRetained) AS RetainedCustomers,
        (SUM(IsRetained) * 100.0 / COUNT(CustomerKey)) AS RetentionRate
    FROM 
        CustomerRetention
    GROUP BY 
        Gender, AgeGroup, Country
)

-- Final output
SELECT 
    Gender,
    AgeGroup,
    Country,
    TotalCustomers,
    RetainedCustomers,
    RetentionRate
FROM 
    RetentionRate
ORDER BY 
    Gender, AgeGroup, Country;


--Analyze historical sales data to identify the top-selling products in each product category for each store. 
--Determine the optimal product assortment for each store based on sales performance, product popularity, and profit margins.




-- Calculate total sales quantity and profit for each product in each category for each store
WITH ProductSales AS (
    SELECT 
        s.StoreKey,
        c.CategoryKey,
        p.ProductKey,
        p.Product_Name,
        SUM(s.Quantity) AS TotalQuantitySold,
        SUM(s.Quantity * (p.Unit_Price_USD - p.Unit_Cost_USD)) AS TotalProfit
    FROM 
        Sales s
    JOIN 
        Products p ON s.ProductKey = p.ProductKey
    JOIN 
        Categories c ON p.CategoryKey = c.CategoryKey
    GROUP BY 
        s.StoreKey, c.CategoryKey, p.ProductKey, p.Product_Name
),

-- Rank products within each category for each store based on quantity sold and profit
RankedProductSales AS (
    SELECT 
        ps.StoreKey,
        ps.CategoryKey,
        ps.ProductKey,
        ps.Product_Name,
        ps.TotalQuantitySold,
        ps.TotalProfit,
        RANK() OVER (PARTITION BY ps.StoreKey, ps.CategoryKey ORDER BY ps.TotalQuantitySold DESC, ps.TotalProfit DESC) AS SalesRank
    FROM 
        ProductSales ps
),

-- Select top-selling products for each category in each store
TopProducts AS (
    SELECT 
        StoreKey,
        CategoryKey,
        ProductKey,
        Product_Name,
        TotalQuantitySold,
        TotalProfit
    FROM 
        RankedProductSales
    WHERE 
        SalesRank <= 5 
),

-- Aggregate the top products for each store and category into a comma-separated list
OptimalProductAssortment AS (
    SELECT 
        StoreKey,
        CategoryKey,
        STRING_AGG(Product_Name, ', ') AS ProductAssortment,
        SUM(TotalQuantitySold) AS TotalQuantitySold
    FROM 
        TopProducts
    GROUP BY 
        StoreKey, CategoryKey
)

-- Final output
SELECT 
    s.StoreKey,
    c.Category,
    o.ProductAssortment,
    o.TotalQuantitySold
FROM 
    OptimalProductAssortment o
JOIN 
    Stores s ON o.StoreKey = s.StoreKey
JOIN 
    Categories c ON o.CategoryKey = c.CategoryKey
ORDER BY 
    s.StoreKey, c.Category;


