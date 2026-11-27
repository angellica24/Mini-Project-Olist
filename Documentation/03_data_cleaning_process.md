# Data Cleaning Process

## 1. Overview

Data cleaning is an essential stage in the Olist E-Commerce Data Analysis project. This process aims to improve data quality, ensure consistency across datasets, and prepare reliable data for further analysis using Python, SQL, and Power BI.

The cleaning process was conducted using Python and MySQL, while the original raw datasets were preserved to maintain data integrity and traceability.

## 2. Data Preparation Workflow

The data preparation process consists of several stages:

1. **Data Inspection:** Examining the structure, dimensions, column names, and data types of the original datasets.
2. **Missing Value Analysis:** Identifying missing values and evaluating their potential impact on analysis.
3. **Duplicate Detection:** Checking duplicate records and investigating potential duplication issues.
4. **Data Type Conversion:** Standardizing date, numeric, and other relevant data types.
5. **Data Validation:** Checking key consistency, numerical ranges, and relationships between datasets.
6. **Anomaly Investigation:** Examining unusual values, inconsistent dates, and potential data quality issues.
7. **Clean Dataset Preparation:** Saving processed datasets for subsequent exploratory analysis.

## 3. Python Data Cleaning

Python was used to perform data inspection, data type conversion, data quality checks, and dataset preparation.

The main cleaning activities included:

- Inspecting dataset dimensions and column structures.
- Identifying missing values across relevant columns.
- Checking duplicate records.
- Converting date columns into appropriate datetime formats.
- Converting numeric columns into suitable numeric data types.
- Reviewing date chronology and numerical inconsistencies.
- Generating data quality reports.
- Exporting cleaned datasets in CSV format.

### 3.1 Cleaned Datasets

The Python cleaning process produced the following datasets:

| Dataset | Cleaned File |
|---|---|
| Orders | orders_python_cleaned.csv |
| Order Items | order_items_python_cleaned.csv |
| Products | products_python_cleaned.csv |
| Payments | payments_python_cleaned.csv |
| Reviews | reviews_python_cleaned.csv |
| Category Translation | category_translation_python_cleaned.csv |

### 3.2 Data Quality Reports

Several supporting reports were generated to document the cleaning process:

| Report | Purpose |
|---|---|
| missing_values_report.csv | Records missing value information |
| duplicate_check_report.csv | Documents duplicate checking results |
| date_conversion_report.csv | Documents date conversion results |
| numeric_conversion_report.csv | Documents numeric conversion results |

These reports provide supporting evidence of the data preparation process.

## 4. SQL Data Quality Validation

MySQL was used for further data quality investigation and database preparation.

A total of 25 SQL scripts were organized sequentially to support the validation and preparation process.

The SQL validation activities covered:

- Missing value investigation.
- Duplicate record checking.
- Review identifier and key validation.
- Geolocation investigation and conflict review.
- Numeric format and range validation.
- Date format and chronology validation.
- Date anomaly investigation.
- Preparation of cleaned database tables.

## 5. Data Anomaly Handling

Not all unusual records were automatically removed from the datasets.

Several conditions were investigated to understand their characteristics and potential impact on the analysis.

Examples of investigated conditions include:

- Missing delivery timestamps.
- Delivery dates occurring before purchase dates.
- Delivery dates occurring before carrier handover dates.
- Missing delivery classification.
- Missing delivery delay calculations.
- Unusual credit card installment values.

Records that did not meet specific analytical criteria were evaluated separately. This approach helps maintain transparency and prevents unsupported assumptions during data preparation.

## 6. Cleaned Dataset Storage

The processed datasets and supporting reports were stored in the following project directory:

`Dataset/Processed/Cleaned/`

The original datasets remain stored separately in:

`Dataset/Raw/`

This folder organization maintains separation between original and processed data.

## 7. Data Quality Principles

The data cleaning process followed these principles:

1. Preserve the original raw datasets.
2. Avoid removing records without sufficient justification.
3. Investigate anomalies before deciding how to handle them.
4. Maintain consistency in data types and formats.
5. Document validation results through supporting reports.
6. Ensure that cleaned datasets are suitable for subsequent analytical processes.

## 8. Outcome

The data cleaning process produced structured datasets and supporting quality reports that were subsequently used in the Exploratory Data Analysis stage.

Further SQL validation was also conducted to prepare analytical tables and business analysis views.

These outputs provide a consistent foundation for sales analysis, delivery performance evaluation, customer review analysis, payment analysis, and Power BI dashboard development.