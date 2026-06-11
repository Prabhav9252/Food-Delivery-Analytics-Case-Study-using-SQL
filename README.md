# Food-Delivery-Analytics-Case-Study-using-SQL
# Food Delivery Analytics SQL Case Study

## Project Overview

This project simulates a real-world analytics assignment for a food delivery platform similar to Noon Food.

The objective is to analyze customer acquisition, retention, promotions, and restaurant performance using SQL.

The dataset contains order-level information, including:

* Order ID
* Customer ID
* Restaurant ID
* Cuisine
* Order Status
* Promo Code
* Order Timestamp

---

## Business Context

Noon Food launched its food delivery service, and management wants to understand:

* How customers are being acquired
* Whether customers are returning
* Which cuisines and restaurants perform best
* The effectiveness of promo campaigns
* Which users should be targeted by CRM communications

This project answers those questions using SQL.

---

## Dataset Schema

```sql
CREATE TABLE orders (
    Order_id VARCHAR(20),
    Customer_code VARCHAR(20),
    Placed_at DATETIME,
    Restaurant_id VARCHAR(10),
    Cuisine VARCHAR(20),
    Order_status VARCHAR(20),
    Promo_code_Name VARCHAR(20)
);
```

---

## SQL Concepts Demonstrated

### Aggregations

* COUNT
* DISTINCT COUNT
* GROUP BY
* HAVING

### Window Functions

* ROW_NUMBER()
* PARTITION BY
* ORDER BY

### Common Table Expressions (CTEs)

Used extensively for:

* Customer acquisition analysis
* Retention analysis
* Order ranking
* Promo attribution

### Date Functions

* DATEADD()
* MONTH()
* YEAR()
* CAST()

---

# Business Questions Solved

## 1. Top Restaurants by Cuisine

Identify the highest-performing restaurant within each cuisine category using window functions.

### Skills Demonstrated

* GROUP BY
* ROW_NUMBER()
* Ranking within partitions

---

## 2. Daily New Customer Acquisition

Measure how many customers were acquired each day based on their first order date.

### Business Value

Helps Growth teams understand customer acquisition trends.

---

## 3. January Customers Who Never Returned

Find users acquired in January 2025 who placed exactly one order and never ordered again.

### Business Value

Identifies early churn.

---

## 4. Dormant Customers Acquired Through Promotions

Identify customers:

* Acquired more than one month ago
* Used a promo on their first order
* Have not ordered in the last 7 days

### Business Value

Ideal audience for reactivation campaigns.

---

## 5. Trigger Customers After Every Third Order

Identify customers reaching every 3rd order milestone.

### Business Value

Useful for CRM automation and loyalty programs.

---

## 6. Customers Who Only Use Promo Codes

Find customers whose entire order history contains promo usage.

### Business Value

Measures promotion dependency.

---

## 7. Organic Acquisition Rate

Calculate the percentage of customers whose first order did not use a promo code.

### Business Value

Measures brand strength and organic demand.

---

# Example Analytics Insights

Using these analyses, a business could answer:

* Are promotions driving acquisition?
* Which cuisines generate the most orders?
* What percentage of customers become repeat users?
* Which customers should receive retention offers?
* How effective are CRM lifecycle campaigns?

---

# Key Learnings

This project demonstrates how SQL can be used beyond reporting to solve real business problems in:

* Product Analytics
* Growth Analytics
* Customer Retention
* CRM Targeting
* Marketplace Analytics

---

## Technologies Used

* SQL Server
* T-SQL
* Window Functions
* CTEs

