# Customer Lifecycle & Churn Risk Analysis Dashboard

## Business Question

Most churn projects focus on predicting who will churn. This project focuses on a more actionable business question:

**Where in the customer lifecycle does churn spike, and which customer segments contribute most to customer attrition?**

## Dataset

Telco Customer Churn Dataset (Kaggle)

* 7,043 telecom customers
* Customer demographics and subscription information
* Contract type, payment method, internet service, tenure, and churn status

## Tools Used

* SQL (CTEs, conditional aggregation, business analysis queries)
* Power BI
* DAX
* Excel / CSV Dataset

## Analysis

The project explores:

1. Overall churn rate
2. Churn by tenure cohort (customer lifecycle analysis)
3. Churn by contract type
4. Churn by payment method
5. Churn by internet service type
6. High-risk customer segment identification
7. Contract × Payment Method churn analysis

## Key Findings

* Overall churn rate: **26.54%** (1,869 of 7,043 customers)
* **88.5% of churn originates from Month-to-Month contracts**, making contract type the strongest churn driver.
* **Electronic Check users account for 57.3% of total churn**, significantly higher than other payment methods.
* Fiber Optic customers exhibit higher churn than DSL and non-internet-service customers.
* **Highest-risk segment: Month-to-Month + Electronic Check (994 churned customers)**, representing the largest concentration of churn.

## Business Recommendations

* Encourage customers to migrate from Month-to-Month plans to annual contracts.
* Promote automatic payment methods to improve customer retention.
* Focus retention campaigns on early-tenure customers.
* Investigate customer experience and pricing concerns among Fiber Optic users.

## Dashboard Preview
<img width="573" height="334" alt="Dashboard" src="https://github.com/user-attachments/assets/d2301fa6-c66c-414f-8114-0b4321b33c6f" />

## Dashboard Features

* KPI Monitoring
* Customer Lifecycle Analysis
* Contract Type Analysis
* Payment Method Analysis
* Internet Service Analysis
* Churn Distribution Analysis
* High-Risk Customer Segment Matrix
* Interactive Slicers and Filters

## Repository Structure

customer-churn-analysis-dashboard/

├── README.md
├── dashboard/
│ ├── dashboard.png
│ └── churn_dashboard.pbix
├── sql/
│ └── churn_analysis_queries.sql
└── dataset/
└── telco_customer_churn.csv

## Author

**Spandana B V**

Aspiring Data Analyst | Power BI | SQL | Data Visualization
