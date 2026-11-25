# Olist E-Commerce Business Intelligence Dashboard

An end-to-end Business Intelligence portfolio project analyzing Brazilian e-commerce data to evaluate sales performance, delivery operations, customer satisfaction, and payment transactions using SQL, Python, and Power BI.

---

## Project Overview

This project analyzes the business performance of Olist, a Brazilian e-commerce platform, using Business Intelligence and data analytics techniques.

The objective is to transform raw e-commerce datasets into meaningful business insights through data preparation, data quality validation, SQL analysis, data modeling, and interactive dashboard development.

The analysis focuses on five main business areas: sales performance, product category contributions, delivery efficiency, customer satisfaction, and payment behavior. The results are presented through an interactive Power BI dashboard to support data-driven business decision-making.

## Project Objectives

- Analyze overall merchandise sales and delivered order performance.
- Identify monthly sales trends and high-performing product categories.
- Evaluate delivery performance and identify the proportion of late deliveries.
- Compare customer review scores between delivery performance groups.
- Analyze customer payment preferences and credit card installment patterns.
- Develop interactive dashboards to communicate business insights effectively.

## Tools & Technologies

| Tool | Purpose |
|---|---|
| MySQL | Data staging, data quality checks, data cleaning, transformation, and business analysis |
| Python | CSV structure validation, data inspection, and review dataset preprocessing |
| Power BI Desktop | Data modeling, dashboard development, and visualization |
| Git & GitHub | Version control, project management, and documentation |

## Dataset

This project uses the Olist Brazilian E-Commerce dataset, which contains information about e-commerce transactions, customers, products, sellers, payments, reviews, and logistics.

The analysis covers nine datasets:

1. Customers
2. Geolocation
3. Orders
4. Order Items
5. Order Payments
6. Order Reviews
7. Products
8. Sellers
9. Product Category Translation

The original datasets are organized in the `Dataset` directory.

## Data Preparation & Analysis

The data preparation and analysis process consists of three main components.

### 1. SQL – Data Preparation and Business Analysis

MySQL is used to prepare and analyze the Olist datasets.

The SQL workflow includes:

- Creating raw staging tables for the nine datasets.
- Performing data quality checks to identify data irregularities.
- Investigating missing values, duplicate records, and data inconsistencies.
- Preparing cleaned datasets for analytical purposes.
- Creating business-oriented tables and views.
- Validating analytical results before dashboard development.

Raw staging tables initially preserve source values using VARCHAR and TEXT data types to support data validation and cleaning.

### 2. Python – Data Validation and Preprocessing

Python is used to support the preparation of the order reviews dataset.

The project includes three supporting scripts:

- `check_reviews_csv.py` – Checks CSV structure consistency by identifying records with an incorrect number of columns.
- `inspect_reviews_row.py` – Inspects selected records to investigate potential data irregularities.
- `prepare_reviews_tsv.py` – Converts the original review CSV dataset into TSV format while validating column consistency.

These utilities support the review dataset preparation process.

### 3. Power BI – Data Modeling and Visualization

Power BI Desktop is used to develop the analytical dashboard based on the prepared business datasets.

The dashboard consists of three main analytical pages, each focusing on a different aspect of business performance.

## Dashboard Overview

### 1. Sales Performance

This page provides an overview of Olist's sales performance and product category contributions.

**Key Performance Indicators:**

- Total Merchandise Sales (BRL): 13.22 Million
- Total Delivered Orders: 96 Thousand

**Visualizations:**

- Monthly Sales Trend (BRL)
- Top 10 Product Categories by Sales (BRL)

**Business Focus:**

Identify sales trends over time and determine which product categories contribute most significantly to overall merchandise sales.

![Sales Performance Dashboard](Screenshots/01-sales-performance.png)

### 2. Delivery & Customer Satisfaction

This page evaluates delivery performance and compares customer satisfaction across delivery groups.

**Key Performance Indicators:**

- Late Delivery Rate: 6.78%
- Total Eligible Delivered Orders: 96 Thousand

**Visualizations:**

- Delivery Performance by Delivery Group
- Average Customer Review Score by Delivery Group

**Business Focus:**

Evaluate delivery efficiency by comparing on-time or early deliveries with late deliveries. The analysis also examines differences in average customer review scores between the two delivery groups.

![Delivery and Customer Satisfaction Dashboard](Screenshots/02-delivery-customer-satisfaction.png)

### 3. Payment & Transaction Analysis

This page provides insights into customer payment preferences and credit card installment behavior.

**Visualizations:**

- Payment Methods Distribution
- Credit Card Installment Distribution

**Business Focus:**

Understand the distribution of payment methods used by customers and identify the most common credit card installment patterns.

![Payment and Transaction Analysis Dashboard](Screenshots/03-payment-transaction-analysis.png)

## Key Business Insights

Based on the dashboard analysis, several findings can be highlighted:

1. **Sales Performance:** Total merchandise sales reached approximately BRL 13.22 million, with 96,478 delivered orders.

2. **Product Categories:** Health and beauty, watches and gifts, and bed, bath and table were among the leading product categories by merchandise sales.

3. **Delivery Performance:** The late delivery rate was approximately 6.78%, indicating that most eligible delivered orders were classified as on time or early.

4. **Customer Satisfaction:** On-time or early deliveries recorded an average review score of approximately 4.3, while late deliveries recorded approximately 2.3. This indicates a notable difference in customer review scores between the two delivery groups.

5. **Payment Behavior:** Credit cards represented the largest share of recorded payment transactions, accounting for approximately 73.92% of payment records.

These findings demonstrate how Business Intelligence can help identify business performance patterns, evaluate operational efficiency, and highlight areas that may require further investigation.

## Repository Structure

```text
Mini-Project-Olist/
│
├── Dataset/
│   ├── Raw/
│   └── Processed/
│
├── Documentation/
│
├── Python/
│   ├── check_reviews_csv.py
│   ├── inspect_reviews_row.py
│   └── prepare_reviews_tsv.py
│
├── SQL/
│   └── SQL scripts for data preparation and analysis
│
├── Screenshots/
│   ├── 01-sales-performance.png
│   ├── 02-delivery-customer-satisfaction.png
│   └── 03-payment-transaction-analysis.png
│
├── Olist_Ecommerce_Dashboard.Report/
│
├── Olist_Ecommerce_Dashboard.SemanticModel/
│
├── Olist_Ecommerce_Dashboard.pbip
├── Olist_Ecommerce_Dashboard.pbix
├── .gitignore
├── .gitattributes
└── README.md
```

## How to Use This Project

To explore the Power BI dashboard:

1. Clone or download this repository.
2. Open `Olist_Ecommerce_Dashboard.pbix` using Power BI Desktop, or open `Olist_Ecommerce_Dashboard.pbip` to access the Power BI Project format.
3. Ensure that the dataset file paths and data source connections are configured correctly.
4. Refresh the data if required.
5. Navigate through the three dashboard pages to explore the analysis.

**Note:** Data source paths may need to be adjusted depending on the local directory where the repository is stored.

## Project Scope

This project was developed as a Business Intelligence and Data Analytics portfolio project to demonstrate practical knowledge of data preparation, SQL querying, data quality validation, data modeling, dashboard development, and business interpretation.

It showcases the process of transforming raw e-commerce data into structured analytical information and presenting the results through interactive visualizations.

## Author

**Angellica Ivana**

Information Systems Student

Areas of Interest:
- Data Analytics
- Business Intelligence
- Business Analysis
- Data Visualization

GitHub: [@angellica24](https://github.com/angellica24)

---

*This project is part of my portfolio development in Business Intelligence and Data Analytics.*
