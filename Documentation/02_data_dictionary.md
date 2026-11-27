# Olist Data Dictionary

## 1. Overview

This document describes the main datasets used in the Olist E-Commerce Data Analysis project. It provides an overview of each table, its purpose, record count, and important columns used throughout the analytical process.

The datasets were prepared and cleaned using Python before being used for further analysis in SQL and Power BI.

## 2. Dataset Summary

The following tables represent the cleaned datasets used in the Exploratory Data Analysis (EDA) process.

| Dataset | Rows | Columns | Description |
|---|---:|---:|---|
| orders | 99,441 | 15 | Customer order and delivery information |
| order_items | 112,650 | 7 | Individual products purchased within orders |
| products | 32,951 | 9 | Product attributes and category information |
| category_translation | 71 | 2 | Product category translation mapping |
| payments | 103,886 | 5 | Payment transaction records |
| reviews | 99,224 | 7 | Customer review information |

## 3. Table Descriptions

### 3.1 Orders

**Purpose:** Stores order-level information, including purchase timestamps, order status, and delivery dates.

| Column | Description |
|---|---|
| order_id | Unique identifier of an order |
| customer_id | Identifier of the customer who placed the order |
| order_status | Current or final status of the order |
| order_purchase_timestamp | Date and time when the order was placed |
| order_approved_at | Date and time when the order payment was approved |
| order_delivered_carrier_date | Date when the order was handed over to the carrier |
| order_delivered_customer_date | Date when the order was delivered to the customer |
| order_estimated_delivery_date | Estimated delivery date provided to the customer |
| delivery_group | Derived delivery classification: Late or On time / early |
| delivery_delay_days | Derived number of days between actual and estimated delivery dates |
| delivery_duration_days | Derived delivery duration in days |

### 3.2 Order Items

**Purpose:** Contains item-level transaction details, including product identifiers, seller information, prices, and freight charges.

| Column | Description |
|---|---|
| order_id | Identifier of the associated order |
| order_item_id | Sequential item number within an order |
| product_id | Identifier of the purchased product |
| seller_id | Identifier of the seller |
| shipping_limit_date | Deadline for the seller to hand over the item |
| price | Price of the purchased product in BRL |
| freight_value | Shipping cost in BRL |

### 3.3 Products

**Purpose:** Contains product attributes used to analyze product categories and sales performance.

| Column | Description |
|---|---|
| product_id | Unique identifier of a product |
| product_category_name | Original product category name |
| product_name_lenght | Length of the product name |
| product_description_lenght | Length of the product description |
| product_photos_qty | Number of product photos |
| product_weight_g | Product weight in grams |
| product_length_cm | Product length in centimeters |
| product_height_cm | Product height in centimeters |
| product_width_cm | Product width in centimeters |

### 3.4 Category Translation

**Purpose:** Provides English translations of the original Portuguese product category names.

| Column | Description |
|---|---|
| product_category_name | Original product category name |
| product_category_name_english | English translation of the product category |

### 3.5 Payments

**Purpose:** Stores payment transaction information associated with customer orders.

| Column | Description |
|---|---|
| order_id | Identifier of the associated order |
| payment_sequential | Sequential number of the payment within an order |
| payment_type | Payment method used by the customer |
| payment_installments | Number of installments selected |
| payment_value | Payment amount in BRL |

### 3.6 Reviews

**Purpose:** Contains customer feedback and review information associated with completed orders.

| Column | Description |
|---|---|
| review_id | Unique identifier of a review |
| order_id | Identifier of the associated order |
| review_score | Customer satisfaction score, ranging from 1 to 5 |
| review_comment_title | Short title of the customer review |
| review_comment_message | Customer review message |
| review_creation_date | Date when the review was created |
| review_answer_timestamp | Date and time when the review was answered |

## 4. Derived Analytical Variables

Several additional variables were created during the data preparation and analytical process.

| Variable | Description |
|---|---|
| delivery_group | Classifies delivered orders as Late or On time / early |
| delivery_delay_days | Measures the difference between actual and estimated delivery dates |
| delivery_duration_days | Measures the time between purchase and customer delivery |
| purchase_month | Extracted purchase month used for monthly sales analysis |
| merchandise_sales | Total product sales value, excluding freight charges |
| review_score | Customer satisfaction rating used in delivery and review analysis |

## 5. Data Usage

The datasets are used across three main analytical areas:

1. **Sales and Product Analysis:** Uses orders, order_items, products, and category_translation to evaluate sales trends and product category performance.
2. **Delivery and Customer Review Analysis:** Uses orders and reviews to examine delivery timeliness and customer satisfaction.
3. **Payment Analysis:** Uses payments to evaluate payment methods, transaction values, and credit card installment patterns.

## 6. Notes

- All monetary values are expressed in Brazilian Real (BRL).
- The dataset record counts represent the cleaned datasets loaded in the Python EDA notebook.
- Derived analytical variables are distinguished from the original dataset columns.
- This document focuses on the main analytical fields and does not represent an exhaustive description of every field in the original Olist dataset.