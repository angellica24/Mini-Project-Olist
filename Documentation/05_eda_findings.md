# EDA Findings — Olist E-Commerce Analysis

## 1. Overview

Exploratory Data Analysis (EDA) was conducted to understand the characteristics of Olist's e-commerce transactions and identify meaningful business patterns.

The analysis focused on four main areas:

1. Sales performance and product category contribution.
2. Delivery performance and customer satisfaction.
3. Payment methods and transaction characteristics.
4. Customer review behavior based on delivery timeliness.

The analysis was performed using Python and Pandas, supported by data visualization to identify patterns and communicate findings.

## 2. Sales Performance and Product Categories

The sales analysis covered 110,197 order item records from 96,478 unique orders, involving 32,216 products and 74 product categories.

The total Gross Merchandise Value (GMV) reached BRL 13,221,498.11, with an Average Order Value (AOV) of BRL 137.04.

### 2.1 Key Findings

- The health_beauty category contributed the highest merchandise sales.
- The watches_gifts category ranked second in sales contribution.
- The bed_bath_table category was another major contributor.
- Sales contribution was concentrated in several leading product categories.

### 2.2 Business Insights

The results indicate that a number of product categories play a significant role in Olist's sales performance.

These categories may provide opportunities for inventory prioritization, promotional planning, and category-level business strategies.

## 3. Delivery Performance Analysis

Delivery performance was evaluated using delivered orders that met the analytical eligibility criteria.

Out of 96,478 delivered orders, 96,282 orders were eligible for delivery performance analysis.

### 3.1 Delivery Performance Summary

| Metric | Result |
|---|---:|
| Total delivered orders | 96,478 |
| Eligible delivered orders | 96,282 |
| On time / early orders | 89,750 |
| Late orders | 6,532 |
| Excluded orders | 196 |
| Late delivery percentage | 6.78% |
| Average delivery duration | 12.51 days |

### 3.2 Key Findings

Most eligible orders were delivered on time or earlier than the estimated delivery date.

However, 6,532 orders were classified as late deliveries, representing 6.78% of eligible delivered orders.

The average delivery duration was 12.51 days.

### 3.3 Business Insights

Although most orders were delivered on time or early, late deliveries remain an important operational issue.

Monitoring delivery performance can help identify potential logistics problems and improve the overall customer experience.

## 4. Customer Review Analysis

Customer satisfaction was evaluated by comparing review scores between late deliveries and orders delivered on time or earlier.

### 4.1 Review Score Comparison

| Delivery Group | Average Review Score |
|---|---:|
| Late | 2.27 |
| On time / early | 4.29 |

### 4.2 Key Findings

Orders delivered late received a substantially lower average review score than orders delivered on time or earlier.

The average review score for late orders was 2.27, compared with 4.29 for on-time or early deliveries.

### 4.3 Business Insights

The findings indicate an association between delivery timeliness and customer satisfaction.

Late deliveries are associated with lower customer review scores, suggesting that delivery performance is an important factor in the customer experience.

Improving delivery reliability may help strengthen customer satisfaction.

## 5. Payment Method Analysis

The payment analysis covered 100,756 payment records with a total recorded payment value of BRL 15,422,461.77.

The analysis evaluated payment methods, transaction values, payment records, and installment characteristics.

### 5.1 Payment Method Distribution

| Payment Method | Payment Records | Payment Value Share |
|---|---:|---:|
| Credit Card | 74,586 | 78.46% |
| Boleto | 19,191 | 17.96% |
| Voucher | 5,493 | 2.22% |
| Debit Card | 1,486 | 1.35% |

### 5.2 Key Findings

Credit cards were the dominant payment method, contributing 78.46% of the total recorded payment value.

Boleto was the second-largest payment method based on transaction value contribution.

Voucher and debit card transactions represented smaller portions of the overall payment value.

### 5.3 Credit Card Installment Analysis

Credit card transactions were further examined based on the number of installments.

The installment distribution was grouped into the following categories:

- 1 installment.
- 2–3 installments.
- 4–6 installments.
- 7–12 installments.
- 13 or more installments.

Two credit card payment records contained zero installments and were flagged for further review.

### 5.4 Business Insights

The findings indicate that credit cards play a major role in Olist's payment ecosystem.

Understanding installment preferences can support payment strategy evaluation and help businesses understand customer transaction behavior.

## 6. Data Quality Considerations

Several data quality conditions were identified and investigated during the EDA process.

These conditions were documented to ensure that analytical conclusions were based on appropriate data.

Important considerations included:

- Delivered orders with missing delivery timestamps.
- Delivery timestamps occurring before the purchase date.
- Delivery timestamps occurring before carrier handover.
- Missing delivery classification and delay calculations.
- Credit card payment records with zero installments.

A total of 196 delivered orders were excluded from the eligible delivery performance analysis because they did not meet the established analytical criteria.

These records were retained in the original datasets and were not automatically deleted.

## 7. Key Business Insights

Based on the exploratory analysis, several important findings were identified.

### 7.1 Product Category Contribution

Sales performance was concentrated in several leading product categories, particularly health_beauty, watches_gifts, and bed_bath_table.

### 7.2 Delivery Performance

Most eligible delivered orders arrived on time or early, but 6.78% experienced late delivery.

### 7.3 Customer Satisfaction

Late deliveries were associated with lower average customer review scores, highlighting the importance of reliable delivery performance.

### 7.4 Payment Characteristics

Credit cards dominated payment activity, contributing 78.46% of total recorded payment value.

### 7.5 Data Quality

Data validation and anomaly investigation were necessary to establish appropriate analytical populations and prevent misleading conclusions.

## 8. Conclusion

The EDA results provide an overview of Olist's business performance across sales, delivery operations, customer satisfaction, and payment behavior.

The findings highlight the importance of leading product categories, reliable delivery performance, and credit card transactions within the e-commerce business.

The analysis also indicates an association between delivery timeliness and customer satisfaction.

These findings provide a foundation for further business intelligence analysis and dashboard development using Power BI.