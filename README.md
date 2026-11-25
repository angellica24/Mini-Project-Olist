# Olist E-Commerce Business Intelligence Dashboard

An end-to-end Business Intelligence project analyzing Brazilian e-commerce data to evaluate sales performance, delivery operations, customer satisfaction, and payment transactions using Power BI, Python, and SQL.

---

## Project Overview

This project focuses on analyzing the business performance of Olist, a Brazilian e-commerce platform, using Business Intelligence techniques. The main objective is to transform raw e-commerce data into meaningful business insights through data analysis, data modeling, and interactive dashboard development.

The analysis provides an overview of sales performance, product category contributions, delivery efficiency, customer satisfaction, and payment behavior. The findings are presented through an interactive Power BI dashboard to support data-driven business decision-making.

## Project Objectives

- Analyze overall merchandise sales and delivered order performance.
- Identify monthly sales trends and high-performing product categories.
- Evaluate delivery performance and identify the proportion of late deliveries.
- Analyze customer satisfaction based on delivery performance.
- Understand customer payment preferences and credit card installment patterns.
- Present business insights through interactive and informative visualizations.

## Tools & Technologies

| Tool | Purpose |
|---|---|
| Power BI Desktop | Data modeling, dashboard development, and visualization |
| Python | Data processing and exploratory data analysis |
| SQL | Data querying and analysis |
| CSV / Excel | Dataset storage and management |
| GitHub | Project version control and documentation |

## Python Utilities

Python scripts are used to validate and preprocess the Olist order reviews dataset before it is used in the analysis.

The project includes three supporting scripts:

- `check_reviews_csv.py` – Checks CSV structure consistency by identifying records with an incorrect number of columns.
- `inspect_reviews_row.py` – Inspects selected records to investigate potential data irregularities.
- `prepare_reviews_tsv.py` – Converts the original review CSV dataset into TSV format while validating column consistency.

These scripts support the data preparation process, particularly in handling the order reviews dataset.

## Dataset

The project uses the Olist Brazilian E-Commerce dataset, which contains information related to e-commerce transactions and operations.

The dataset covers several business aspects, including:

- Orders and order items
- Customers and sellers
- Product categories
- Payments and installments
- Customer reviews
- Delivery and logistics information
- Geolocation data

The dataset files used in this project are organized in the `Dataset` folder.

## Dashboard Overview

The Power BI dashboard consists of three main analytical pages.

### 1. Sales Performance

This page provides an overview of the platform's sales performance and product category contributions.

**Key Performance Indicators:**
- Total Merchandise Sales (BRL): 13.22 Million
- Total Delivered Orders: Approximately 96 Thousand

**Visualizations:**
- Monthly Sales Trend (BRL)
- Top 10 Product Categories by Sales (BRL)

**Business Focus:**

Identify sales trends over time and determine which product categories contribute most significantly to overall merchandise sales.

![Sales Performance Dashboard](Screenshots/01-sales-performance.png)

### 2. Delivery & Customer Satisfaction

This page evaluates delivery performance and examines the relationship between delivery conditions and customer satisfaction.

**Key Performance Indicators:**
- Late Delivery Rate: 6.78%
- Total Eligible Delivered Orders: Approximately 96 Thousand

**Visualizations:**
- Delivery Performance by Delivery Group
- Average Customer Review Score by Delivery Group

**Business Focus:**

Evaluate delivery efficiency by comparing on-time or early deliveries with late deliveries. The analysis also highlights differences in customer review scores between delivery groups.

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

1. **Sales Performance:** Total merchandise sales reached approximately BRL 13.22 million, with around 96 thousand delivered orders.

2. **Product Categories:** Health and beauty, watches and gifts, and bed, bath and table were among the leading product categories by merchandise sales.

3. **Delivery Performance:** The late delivery rate was approximately 6.78%, indicating that most eligible delivered orders were classified as on time or early.

4. **Customer Satisfaction:** On-time or early deliveries recorded an average review score of approximately 4.3, while late deliveries recorded approximately 2.3.

5. **Payment Behavior:** Credit cards represented the largest share of recorded payment methods, accounting for approximately 73.92% of payment records.

These findings demonstrate how Business Intelligence can help identify operational performance patterns and areas that may require further business improvement.

## Repository Structure

```text
Mini-Project-Olist/
│
├── Dataset/
│   └── Olist dataset files
│
├── Olist_Ecommerce_Dashboard.Report/
│   └── Power BI report files
│
├── Olist_Ecommerce_Dashboard.SemanticModel/
│   └── Data model files
│
├── Python/
│   └── Python analysis files
│
├── SQL/
│   └── SQL query files
│
├── Screenshots/
│   ├── 01-sales-performance.png
│   ├── 02-delivery-customer-satisfaction.png
│   └── 03-payment-transaction-analysis.png
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

This project was developed as an academic and professional portfolio project to demonstrate practical knowledge of Business Intelligence and data analytics.

It showcases the application of data analysis, data visualization, data modeling, and business interpretation to transform raw e-commerce data into actionable insights.

## Author

**Angellica Ivana**

Information Systems Student

Areas of Interest:
- Business Intelligence
- Data Analytics
- Business Analysis
- Data Visualization

GitHub: [@angellica24](https://github.com/angellica24)

---

*This project is part of my learning journey in Business Intelligence and Data Analytics.*
