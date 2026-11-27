# Power BI Dashboard Documentation

## 1. Overview

The Power BI dashboard represents the Business Intelligence stage of the Olist E-Commerce Data Analysis project.

The dashboard was developed to transform prepared datasets and analytical results into interactive visualizations that support business performance monitoring and decision-making.

The dashboard focuses on presenting key information related to sales performance, product categories, delivery operations, customer satisfaction, and payment characteristics.

## 2. Tools and Environment

The dashboard development process used the following tools:

| Component | Technology |
|---|---|
| Business Intelligence Tool | Microsoft Power BI |
| Dashboard Development | Power BI Desktop |
| Data Preparation | Python |
| Database Management | MySQL |
| Data Visualization | Power BI Visualizations |
| Project Format | PBIX and PBIP |

The Power BI project is maintained through the following project files:

- Olist_Ecommerce_Dashboard.pbix
- Olist_Ecommerce_Dashboard.pbip
- Olist_Ecommerce_Dashboard.Report
- Olist_Ecommerce_Dashboard.SemanticModel

## 3. Dashboard Objectives

The main objectives of the dashboard are:

1. Monitor overall e-commerce sales performance.
2. Identify product categories with the highest sales contribution.
3. Evaluate delivery performance and late delivery rates.
4. Understand the relationship between delivery timeliness and customer satisfaction.
5. Analyze payment method distribution and transaction characteristics.
6. Present business insights through interactive visualizations.

## 4. Business Analysis Scope

The dashboard is designed around four major business analysis areas.

### 4.1 Sales Performance Analysis

This section focuses on understanding sales performance and product category contribution.

Key performance indicators include:

- Gross Merchandise Value (GMV).
- Average Order Value (AOV).
- Total orders.
- Sales contribution by product category.
- Monthly sales performance.

The analysis helps identify sales patterns and product categories that contribute significantly to overall business revenue.

### 4.2 Delivery Performance Analysis

This section evaluates the efficiency of order delivery operations.

Key performance indicators include:

- Total delivered orders.
- On-time and early delivery orders.
- Late delivery orders.
- Late delivery percentage.
- Average delivery duration.

The analysis provides an overview of delivery reliability and operational performance.

### 4.3 Customer Satisfaction Analysis

This section examines customer review scores in relation to delivery performance.

Key indicators include:

- Average customer review score.
- Average review score for late deliveries.
- Average review score for on-time or early deliveries.
- Review distribution by delivery group.

The analysis helps identify differences in customer satisfaction across delivery performance categories.

### 4.4 Payment Analysis

This section evaluates transaction characteristics and payment behavior.

Key indicators include:

- Total payment value.
- Payment record distribution.
- Payment value contribution by method.
- Payment method characteristics.
- Credit card installment distribution.

The analysis provides insights into customer payment preferences and transaction behavior.

## 5. Key Analytical Results

The following results were obtained from the Python EDA and SQL analysis stages and provide the analytical foundation for the dashboard.

### 5.1 Sales Performance

| Metric | Result |
|---|---:|
| Unique Orders | 96,478 |
| Order Item Records | 110,197 |
| Total Products | 32,216 |
| Product Categories | 74 |
| Total GMV | BRL 13,221,498.11 |
| Average Order Value | BRL 137.04 |

The health_beauty category recorded the highest merchandise sales contribution, followed by watches_gifts and bed_bath_table.

### 5.2 Delivery Performance

| Metric | Result |
|---|---:|
| Eligible Delivered Orders | 96,282 |
| On Time / Early Orders | 89,750 |
| Late Orders | 6,532 |
| Late Delivery Rate | 6.78% |
| Average Delivery Duration | 12.51 days |

Most eligible delivered orders arrived on time or earlier than the estimated delivery date.

### 5.3 Customer Satisfaction

| Delivery Group | Average Review Score |
|---|---:|
| Late | 2.27 |
| On Time / Early | 4.29 |

Late deliveries were associated with substantially lower average customer review scores.

### 5.4 Payment Characteristics

| Metric | Result |
|---|---:|
| Total Payment Records | 100,756 |
| Total Payment Value | BRL 15,422,461.77 |
| Credit Card Payment Value Share | 78.46% |
| Boleto Payment Value Share | 17.96% |
| Voucher Payment Value Share | 2.22% |
| Debit Card Payment Value Share | 1.35% |

Credit cards represented the largest contribution to total recorded payment value.

## 6. Data Model and Analytical Preparation

The dashboard development was supported by the cleaned datasets and SQL analytical outputs prepared in the previous stages.

The analytical preparation included:

- Standardizing dataset structures and data types.
- Preparing cleaned order and transaction data.
- Establishing business-oriented analytical views.
- Validating delivery and review analysis.
- Preparing payment and product category summaries.

The analytical datasets provide a consistent foundation for presenting business performance indicators.

The detailed table relationships and DAX measure definitions are maintained as part of the Power BI semantic model.

## 7. Business Insights

The analytical results provide several important business insights:

### 7.1 Product Category Contribution

A small number of product categories contributed significantly to overall merchandise sales. Understanding category performance can support inventory planning and promotional strategies.

### 7.2 Delivery Performance

Although most eligible orders were delivered on time or early, 6.78% experienced late delivery. Delivery performance remains an important operational area to monitor.

### 7.3 Customer Satisfaction

Late deliveries were associated with lower average customer review scores. Improving delivery reliability may contribute to a better customer experience.

### 7.4 Payment Behavior

Credit cards dominated the recorded payment value, indicating their importance within the Olist payment ecosystem.

## 8. Data Limitations and Considerations

Several considerations should be taken into account when interpreting dashboard results:

- Delivery performance analysis uses 96,282 eligible delivered orders rather than all original orders.
- Some delivered orders were excluded because they did not meet the analytical eligibility criteria.
- Different analytical outputs may use different filtering conditions and data scopes.
- Payment records and unique orders represent different measurement units.
- Unusual data conditions were investigated and documented rather than automatically removed.

These considerations help ensure that dashboard insights are interpreted appropriately.

## 9. Conclusion

The Power BI dashboard represents the final visualization stage of the Olist E-Commerce Data Analysis project.

By integrating data preparation, SQL analysis, and exploratory findings, the dashboard provides a business-oriented overview of sales performance, product categories, delivery operations, customer satisfaction, and payment behavior.

The dashboard transforms analytical results into meaningful business information that can support performance monitoring and data-driven decision-making.