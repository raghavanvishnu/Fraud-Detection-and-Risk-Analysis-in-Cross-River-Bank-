##

use cross_river_bank;

###Ques 1 

SELECT 
    c.customer_id,
    c.name,
    c.credit_score,
    l.loan_id,
    l.loan_amount,
    l.default_risk
FROM 
    customer_table c
JOIN 
    loan_table l ON c.customer_id = l.customer_id
WHERE 
    c.credit_score < 600
    AND l.default_risk = 'High';
    
###Ques 2
    
    
    SELECT 
    loan_purpose,
    COUNT(*) AS total_loans,
    SUM(loan_amount) AS total_amount
FROM 
    loan_table
GROUP BY 
    loan_purpose
ORDER BY 
    total_amount DESC;
    
    
    
    ###Ques 3 

    SELECT 
    t.transaction_id,
    t.loan_id,
    t.transaction_amount,
    l.loan_amount
FROM 
    transaction_table t
JOIN 
    loan_table l ON t.loan_id = l.loan_id
WHERE 
    t.transaction_amount > 0.3 * l.loan_amount;
    
   
   ###Ques 4
   
    SELECT 
    loan_id,
    COUNT(*) AS missed_emi_count
FROM 
    transaction_table
WHERE 
    LOWER(remarks) LIKE '%missed%'
GROUP BY 
    loan_id
ORDER BY 
    missed_emi_count DESC;
    
###Ques 5
    
    SELECT 
    SUBSTRING_INDEX(address, ',', -1) AS region,
    COUNT(l.loan_id) AS total_loans,
    SUM(l.loan_amount) AS total_amount
FROM 
    customer_table c
JOIN 
    loan_table l ON c.customer_id = l.customer_id
GROUP BY 
    region
ORDER BY 
    total_loans DESC;
    
  ###Ques 6  
    SELECT 
    c.customer_id,
    c.name,
    c.customer_since,
    l.loan_id,
    l.loan_amount
FROM 
    customer_table c
JOIN 
    loan_table l ON c.customer_id = l.customer_id
WHERE 
    c.customer_since < DATE_SUB(CURDATE(), INTERVAL 5 YEAR);
 
 ###Ques 7
 
    SELECT 
    loan_id,
    customer_id,
    repayment_history,
    loan_amount,
    loan_status
FROM 
    loan_table
WHERE 
    repayment_history >= 9
    AND loan_status = 'Closed'
ORDER BY 
    repayment_history DESC;
    
   
   
   ###Ques 8
    
    SELECT 
    CASE 
        WHEN age < 25 THEN 'Under 25'
        WHEN age BETWEEN 25 AND 35 THEN '25-35'
        WHEN age BETWEEN 36 AND 50 THEN '36-50'
        WHEN age BETWEEN 51 AND 65 THEN '51-65'
        ELSE '65+' 
    END AS age_group,
    COUNT(l.loan_id) AS total_loans,
    SUM(l.loan_amount) AS total_amount
FROM 
    customer_table c
JOIN 
    loan_table l ON c.customer_id = l.customer_id
GROUP BY 
    age_group
ORDER BY 
    total_amount DESC;
    
    ###9
    
    
    SELECT 
    YEAR(STR_TO_DATE(transaction_date, '%m/%d/%Y %H:%i')) AS txn_year,
    MONTH(STR_TO_DATE(transaction_date, '%m/%d/%Y %H:%i')) AS txn_month,
    COUNT(*) AS total_transactions
FROM 
    transaction_table
GROUP BY 
    txn_year, txn_month
ORDER BY 
    txn_year, txn_month;
    
    
    ###10
    
    SELECT 
    t.transaction_id,
    t.customer_id,
    c.address,
    t.remarks,
    t.transaction_date
FROM 
    transaction_table t
JOIN 
    customer_table c ON t.customer_id = c.customer_id
WHERE 
    t.remarks LIKE '%IP%'
    AND SUBSTRING_INDEX(c.address, ',', -1) NOT LIKE '%IP%';
    
  #### Q11  
    SELECT 
    loan_id,
    customer_id,
    repayment_history,
    RANK() OVER (ORDER BY repayment_history DESC) AS repayment_rank
FROM 
    loan_table;
    
    
    ###Q12
    
    SELECT 
    CASE 
        WHEN credit_score < 600 THEN 'Low'
        WHEN credit_score BETWEEN 600 AND 700 THEN 'Medium'
        ELSE 'High'
    END AS credit_band,
    AVG(l.loan_amount) AS avg_loan_amount,
    COUNT(*) AS num_loans
FROM 
    customer_table c
JOIN 
    loan_table l ON c.customer_id = l.customer_id
GROUP BY 
    credit_band;
    
    #Q13
    
    SELECT 
    SUBSTRING_INDEX(c.address, ',', -1) AS region,
    SUM(l.loan_amount) AS total_disbursed,
    COUNT(l.loan_id) AS num_loans
FROM 
    customer_table c
JOIN 
    loan_table l ON c.customer_id = l.customer_id
GROUP BY 
    region
ORDER BY 
    total_disbursed DESC
LIMIT 10;

##Q 14


SELECT 
    loan_id,
    COUNT(*) AS early_repayments
FROM 
    transaction_table
WHERE 
    LOWER(remarks) LIKE '%early%'
GROUP BY 
    loan_id
ORDER BY 
    early_repayments DESC;
    
    #Q15
    
    SELECT 
    f.customer_id,
    f.sentiment_score,
    l.loan_status,
    AVG(f.sentiment_score) AS avg_sentiment,
    COUNT(*) AS feedback_count
FROM 
    customer_feedback f
JOIN 
    loan_table l ON f.loan_id = l.loan_id
GROUP BY 
    f.customer_id, l.loan_status
ORDER BY 
    avg_sentiment DESC;
    
    