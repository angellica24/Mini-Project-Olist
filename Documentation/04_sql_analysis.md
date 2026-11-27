# SQL Analysis

## 1. Overview

SQL analysis was conducted using MySQL Workbench to perform data quality validation, prepare structured database tables, and develop business analysis views for the Olist E-Commerce Data Analysis project.

The main objective was to establish reliable analytical datasets and generate business-oriented insights related to sales performance, product categories, delivery timeliness, customer reviews, and payment characteristics.

## 2. Database Environment

| Component | Description |
|---|---|
| Database Management System | MySQL |
| Database Client | MySQL Workbench |
| Database Name | olist_ecommerce |
| SQL Scripts | 25 sequential scripts |
| Main Output | Clean tables and business analysis views |

## 3. SQL Development Workflow

The SQL development process was organized into four major stages.

### 3.1 Database and Staging Preparation

The initial stage focused on preparing the database environment and creating staging tables.

Scripts:
- 01_create_database.sql
- 02_create_orders_staging.sql

### 3.2 Data Quality Investigation

This stage focused on identifying and investigating potential data quality issues before creating the final analytical tables.

Scripts:

| Script | Analysis |
|---|---|
| 03_data_quality_missing_values.sql | Missing value identification |
| 04_missing_values_detailed.sql | Detailed missing value analysis |
| 05_missing_values_investigation.sql | Missing value investigation |
| 06_missing_values_anomaly_review.sql | Missing value anomaly review |
| 07_missing_values_followup.sql | Follow-up validation |
| 08_duplicate_checking.sql | Duplicate record checking |
| 09_duplicate_investigation_reviews.sql | Review duplication investigation |
| 10_reviews_key_validation.sql | Review key validation |
| 11_geolocation_investigation.sql | Geolocation investigation |
| 12_geolocation_conflict_review.sql | Geolocation conflict review |
| 13_numeric_format_validation.sql | Numeric format validation |
| 14_numeric_range_validation.sql | Numeric range validation |
| 15_numeric_anomaly_investigation.sql | Numeric anomaly investigation |
| 16_date_format_validation.sql | Date format validation |
| 17_date_chronology_validation.sql | Date chronology validation |
| 18_date_anomaly_investigation.sql | Date anomaly investigation |
| 19_date_calendar_validation.sql | Calendar date validation |

### 3.3 Clean Database Preparation

After the investigation and validation stages, cleaned database tables were prepared.

Scripts:
- 20_create_orders_clean.sql
- 21_create_customers_clean.sql
- 22_create_order_items_clean.sql
- 23_create_core_tables_clean.sql

These scripts establish structured tables for subsequent business analysis.

### 3.4 Business Analysis and Validation

The final stage focused on creating analytical views and validating the delivery and customer review analysis.

Scripts:
- 24_build_business_analysis_views.sql
- 25_validate_delivery_review_analysis.sql

## 4. Business Analysis Views

The SQL analysis produced six main analytical outputs.

| View / Report | Rows | Analytical Purpose |
|---|---:|---|
| monthly_sales | 23 | Monthly sales performance |
| category_sales | 74 | Sales performance by product category |
| delivery_review_order_level | 96,282 | Order-level delivery and review analysis |
| delivery_rating_summary | 2 | Customer review comparison by delivery group |
| payment_methods | 5 | Payment method characteristics |
| credit_card_installments | 6 | Credit card installment distribution |

### 4.1 Monthly Sales Analysis

The monthly sales analysis evaluates sales performance over time.

Key metrics include:

- Purchase month.
- Number of delivered orders.
- Number of sold item rows.
- Merchandise sales value in BRL.
- Freight value in BRL.
- Average merchandise sales per order.

This analysis helps identify monthly sales patterns and changes in business performance.

### 4.2 Product Category Analysis

The category sales analysis evaluates the contribution of different product categories to total merchandise sales.

Key metrics include:

- Product category.
- Number of delivered orders.
- Number of sold item rows.
- Total merchandise sales in BRL.

The results provide a basis for identifying categories with the highest sales contribution.

### 4.3 Delivery and Customer Review Analysis

This analysis combines delivery information and customer review data at the order level.

The analytical dataset contains 96,282 eligible delivered orders.

The delivery classification consists of:

| Delivery Group | Orders |
|---|---:|
| On time / early | 89,750 |
| Late | 6,532 |
| Total | 96,282 |

The analysis also evaluates:

- Review coverage.
- Average customer review scores.
- Reviews submitted after delivery.
- Customer satisfaction differences between delivery groups.

The SQL validation confirms that the revised analytical view contains 96,282 eligible delivered orders.

### 4.4 Payment Method Analysis

The payment analysis evaluates transaction characteristics based on payment methods.

The main payment methods include:

- Credit card.
- Boleto.
- Voucher.
- Debit card.
- Not defined.

The analysis considers payment record counts, unique orders per method, recorded payment values, and average payment values.

### 4.5 Credit Card Installment Analysis

Credit card transactions were grouped into installment categories to evaluate payment behavior.

The installment groups include:

| Installment Group |
|---|
| 0 (needs review) |
| 1 |
| 2–3 |
| 4–6 |
| 7–12 |
| 13+ |

This analysis helps identify common installment patterns and unusual installment records.

## 5. SQL Validation Results

The SQL validation process confirmed that the analytical views were successfully generated.

Key validation results include:

- Monthly sales view: 23 records.
- Product category sales view: 74 records.
- Delivery and review analytical view: 96,282 records.
- Delivery rating summary: 2 records.
- Payment method summary: 5 records.
- Credit card installment summary: 6 records.

The delivery and review analytical view was also checked against the revised eligible order count to ensure consistency.

## 6. Important Analytical Considerations

Different analytical outputs may use different filtering criteria and data scopes.

For example, the payment analysis in the Python EDA notebook and the SQL payment method view should not automatically be treated as identical because their analytical scopes may differ.

Similarly, delivery analysis uses eligible delivered orders rather than all orders in the original dataset.

These distinctions are important when comparing results between Python, SQL, and Power BI.

## 7. SQL Analysis Outcome

The SQL development process produced structured analytical views that support business performance evaluation.

The outputs provide a foundation for:

1. Monthly sales performance analysis.
2. Product category contribution analysis.
3. Delivery timeliness evaluation.
4. Customer satisfaction comparison.
5. Payment method analysis.
6. Credit card installment behavior analysis.

The resulting analytical views were prepared to support further visualization and business insight development in Power BI.