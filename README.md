# SQL Challenge Analysis Documentation

## Overview
This document provides a comprehensive overview of the SQL analyses performed during the SQL Challenge. The analyses span various aspects of the business, including sales performance, customer behavior, and product assortment optimization. This documentation includes data cleaning processes, business insights, and recommendations derived from the analyses.

## Tools and Environment
For this analysis, Microsoft SQL Server Management Studio (SSMS) was used. The database named "Electronics_store" was created, and the datasets were uploaded into this database.

## Datasets
The analysis was conducted using Electronic Store dataset from Empovation with the following files:

1. **Products**: Information about products including product ID, name, category, and price.
2. **Categories**: Details about product categories.
3. **Customers**: Customer information including customer ID, name, gender, age, location, and purchase history.
4. **Stores**: Store details including store ID, name, and size.
5. **Sales**: Sales transactions including sales ID, store ID, product ID, quantity, and sales date.
6. **Pproducts**: Additional product-related information.

## Data Upload and Setup
1. **Database Creation**: The "Electronics_store" database was created using SSMS.
2. **Dataset Upload**: The dataset files were uploaded into the database. Each dataset was stored in a corresponding table: Products, Categories, Customers, Stores, Sales, and Pproducts.

## Data Cleaning
Before analysis, the datasets were cleaned to ensure data integrity and consistency. The following steps were taken:

1. **Data Types**: Ensured that data types for each column were appropriate (e.g., dates formatted correctly, numeric fields correctly typed).
2. **Date Formatting**: Standardized date formats to ensure consistency across analyses.
3. **Consistency Checks**: Ensured consistency in categorical values (e.g., gender, location) to avoid discrepancies in grouping and aggregation.

## Analysis and Insights

### 1. Count the Total Orders
**Objective**: Count the total number of orders per customer.

**Insight**: The number of orders per customer provides insights into customer engagement and loyalty.

### 2. List of Products Sold in 2020
**Objective**: List all products sold in the year 2020.

**Insight**: Understanding product sales in a specific year helps identify trends and product popularity over time.

### 3. Find Customers in a Specific City
**Objective**: Retrieve customer details from California (CA).

**Insight**: Geographical analysis helps in tailoring marketing strategies and understanding regional customer preferences.

### 4. Calculate Total Sales Quantity
**Objective**: Calculate the total sales quantity for product 2115.

**Insight**: Identifying the sales volume of a specific product aids in inventory management and product performance assessment.

### 5. Store Information Retrieval
**Objective**: Retrieve the top 5 stores with the most sales transactions.

**Insight**: Identifying top-performing stores helps in understanding the factors contributing to their success and replicating best practices across other stores.

### 6. Impact of Store Size on Sales Volume
**Objective**: Analyze whether larger stores have higher sales volumes.

**Insight**: Understanding the relationship between store size and sales volume can inform decisions about store expansions and layout optimizations.

### 7. Customer Segmentation by Purchase Behavior and Demographics
**Objective**: Segment customers based on purchase behaviors and demographics.

**Insight**: Customer segmentation helps in creating targeted marketing campaigns and improving customer satisfaction.

### 8. Ranking Stores by Sales Volume
**Objective**: Calculate and rank stores based on their total sales volume.

**Insight**: Ranking stores by sales volume helps in performance benchmarking and identifying opportunities for improvement.

### 9. Running Total of Sales Over Time
**Objective**: Calculate a running total of sales over time, ordered by date.

**Insight**: Monitoring sales trends over time helps in forecasting and identifying seasonal patterns.

### 10. Lifetime Value (LTV) of Customers by Country
**Objective**: Calculate the LTV of each customer based on their country.

**Insight**: Understanding LTV by country aids in allocating marketing resources efficiently and tailoring strategies for different regions.

### 11. Year-over-Year Growth in Sales per Category
**Objective**: Calculate the year-over-year growth percentage in sales for each product category.

**Insight**: Analyzing growth trends helps in identifying high-growth categories and making informed product development decisions.

### 12. Customer’s Purchase Rank Within Store
**Objective**: Find each customer’s purchase rank within the store they bought from, based on total order price.

**Insight**: Ranking customers helps in identifying top customers and tailoring loyalty programs to enhance retention.

### 13. Customer Retention Analysis
**Objective**: Analyze customer retention by determining the percentage of customers who made repeat purchases within three months of their initial purchase.

**Insight**: Understanding retention rates and factors influencing retention helps in improving customer loyalty and lifetime value.

### 14. Optimal Product Assortment for Each Store
**Objective**: Identify the top-selling products in each category for each store to determine the optimal product assortment.

**Insight**: Optimizing product assortment based on sales performance and profit margins helps in maximizing sales revenue and improving customer satisfaction.

## Recommendations

1. **Enhance Customer Loyalty Programs**: Use insights from customer segmentation and retention analysis to develop targeted loyalty programs aimed at increasing repeat purchases.
2. **Optimize Product Assortment**: Implement the optimal product assortments identified for each store to improve sales performance and customer satisfaction.
3. **Focus on High-Growth Categories**: Invest in the development and promotion of high-growth product categories to capitalize on market trends.
4. **Expand High-Performing Stores**: Consider expanding or replicating the strategies of top-performing stores to boost overall sales.
5. **Tailor Marketing Strategies by Region**: Use geographical insights to tailor marketing campaigns to regional preferences and improve customer engagement.
6. **Monitor Seasonal Trends**: Regularly monitor sales trends and adjust inventory and marketing strategies to capitalize on seasonal demand patterns.

## Conclusion
The SQL analyses performed during the challenge provided valuable insights into various aspects of the business, including customer behavior, product performance, and store operations. By leveraging these insights, the company can make data-driven decisions to enhance customer satisfaction, optimize operations, and drive revenue growth.
