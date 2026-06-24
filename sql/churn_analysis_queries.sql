-- =====================================================
-- CUSTOMER LIFECYCLE & CHURN RISK ANALYSIS
-- Telco Customer Churn Dataset
-- =====================================================

-- =====================================================
-- 1. OVERALL CHURN RATE
-- =====================================================

SELECT
COUNT(*) AS Total_Customers,
SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS Churned_Customers,
ROUND(
100.0 * SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) / COUNT(*),
2
) AS Churn_Rate_Percentage
FROM Telco_Churn;

-- =====================================================
-- 2. CHURN BY TENURE COHORT
-- Business Question:
-- Where does churn spike in the customer lifecycle?
-- =====================================================

WITH tenure_cohorts AS (
SELECT *,
CASE
WHEN tenure <= 6 THEN '0-6 Months'
WHEN tenure <= 12 THEN '7-12 Months'
WHEN tenure <= 24 THEN '13-24 Months'
WHEN tenure <= 48 THEN '25-48 Months'
ELSE '49+ Months'
END AS tenure_cohort
FROM Telco_Churn
)

SELECT
tenure_cohort,
COUNT(*) AS Total_Customers,
SUM(CASE WHEN Churn='Yes' THEN 1 ELSE 0 END) AS Churned_Customers,
ROUND(
100.0 * SUM(CASE WHEN Churn='Yes' THEN 1 ELSE 0 END) / COUNT(*),
2
) AS Churn_Rate
FROM tenure_cohorts
GROUP BY tenure_cohort
ORDER BY MIN(
CASE
WHEN tenure_cohort='0-6 Months' THEN 1
WHEN tenure_cohort='7-12 Months' THEN 2
WHEN tenure_cohort='13-24 Months' THEN 3
WHEN tenure_cohort='25-48 Months' THEN 4
ELSE 5
END
);

-- =====================================================
-- 3. CHURN BY CONTRACT TYPE
-- =====================================================

SELECT
Contract,
COUNT(*) AS Total_Customers,
SUM(CASE WHEN Churn='Yes' THEN 1 ELSE 0 END) AS Churned_Customers,
ROUND(
100.0 * SUM(CASE WHEN Churn='Yes' THEN 1 ELSE 0 END) / COUNT(*),
2
) AS Churn_Rate
FROM Telco_Churn
GROUP BY Contract
ORDER BY Churn_Rate DESC;

-- =====================================================
-- 4. CHURN BY PAYMENT METHOD
-- =====================================================

SELECT
PaymentMethod,
COUNT(*) AS Total_Customers,
SUM(CASE WHEN Churn='Yes' THEN 1 ELSE 0 END) AS Churned_Customers,
ROUND(
100.0 * SUM(CASE WHEN Churn='Yes' THEN 1 ELSE 0 END) / COUNT(*),
2
) AS Churn_Rate
FROM Telco_Churn
GROUP BY PaymentMethod
ORDER BY Churn_Rate DESC;

-- =====================================================
-- 5. CHURN BY INTERNET SERVICE
-- =====================================================

SELECT
InternetService,
COUNT(*) AS Total_Customers,
SUM(CASE WHEN Churn='Yes' THEN 1 ELSE 0 END) AS Churned_Customers,
ROUND(
100.0 * SUM(CASE WHEN Churn='Yes' THEN 1 ELSE 0 END) / COUNT(*),
2
) AS Churn_Rate
FROM Telco_Churn
GROUP BY InternetService
ORDER BY Churn_Rate DESC;

-- =====================================================
-- 6. HIGH-RISK CUSTOMER SEGMENT ANALYSIS
-- Contract × Payment Method
-- =====================================================

SELECT
Contract,
PaymentMethod,
COUNT(*) AS Total_Customers,
SUM(CASE WHEN Churn='Yes' THEN 1 ELSE 0 END) AS Churned_Customers
FROM Telco_Churn
GROUP BY Contract, PaymentMethod
ORDER BY Churned_Customers DESC;

-- =====================================================
-- 7. RANK CONTRACT TYPES BY CHURN RATE
-- Window Function Example
-- =====================================================

WITH contract_churn AS (
SELECT
Contract,
COUNT(*) AS Total_Customers,
SUM(CASE WHEN Churn='Yes' THEN 1 ELSE 0 END) AS Churned_Customers,
ROUND(
100.0 * SUM(CASE WHEN Churn='Yes' THEN 1 ELSE 0 END) / COUNT(*),
2
) AS Churn_Rate
FROM Telco_Churn
GROUP BY Contract
)

SELECT *,
RANK() OVER (
ORDER BY Churn_Rate DESC
) AS Churn_Rank
FROM contract_churn;

-- =====================================================
-- 8. MONTHLY REVENUE AT RISK
-- Estimate revenue associated with churned customers
-- =====================================================

SELECT
SUM(MonthlyCharges) AS Revenue_At_Risk
FROM Telco_Churn
WHERE Churn='Yes';

-- =====================================================
-- 9. REVENUE AT RISK BY CONTRACT TYPE
-- =====================================================

SELECT
Contract,
ROUND(SUM(MonthlyCharges),2) AS Revenue_At_Risk
FROM Telco_Churn
WHERE Churn='Yes'
GROUP BY Contract
ORDER BY Revenue_At_Risk DESC;

-- =====================================================
-- 10. HIGHEST RISK SEGMENT REVENUE
-- Month-to-Month + Electronic Check
-- =====================================================

SELECT
COUNT(*) AS Churned_Customers,
ROUND(SUM(MonthlyCharges),2) AS Revenue_At_Risk
FROM Telco_Churn
WHERE Contract='Month-to-month'
AND PaymentMethod='Electronic check'
AND Churn='Yes';

