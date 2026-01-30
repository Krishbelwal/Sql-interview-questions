-- Question Set 1
-- SQL Interview Practice

-- Q1: Find duplicate records in the email column
SELECT email, COUNT(*) AS count
FROM customer
GROUP BY email
HAVING count > 1;

-- Q2: Retrieve employees who earn more than their manager
SELECT e.emp_name AS Employee,
       e.salary AS Emp_salary,
       m.salary AS Manager_salary
FROM Employee e
JOIN Employee m ON e.manager_id = m.emp_id
WHERE e.salary > m.salary;

-- Q3: Find employees who joined in the last 6 months
SELECT emp_name
FROM Employee
WHERE join_date >= DATE_SUB(CURDATE(), INTERVAL 6 MONTH);

-- Q4: Departments with no employees
SELECT d.dept_name
FROM Department d
LEFT JOIN Employee e ON e.dept_id = d.dept_id
WHERE e.emp_id IS NULL;

-- Q5: Find employees with salary greater than average
SELECT emp_name, salary
FROM Employee
WHERE salary > (SELECT AVG(salary) FROM Employee);

-- Q6: Min and max purchase date for each customer
SELECT customer_id,
       MIN(order_date) AS first_purchase,
       MAX(order_date) AS last_purchase
FROM orders
GROUP BY customer_id;

-- Q7: Count of employees per job title
SELECT job_title, COUNT(emp_id) AS Total_emp
FROM Employee
GROUP BY job_title;

-- Q8: Employees without a department
SELECT emp_id
FROM Employee
WHERE dept_id IS NULL;

-- Q9: Find duplicate products
SELECT product_id, COUNT(*) AS Count
FROM Product
GROUP BY product_id
HAVING COUNT(*) > 1;

-- Q10: Last 10 records from a table
SELECT *
FROM Employee
ORDER BY emp_id DESC
LIMIT 10;

-- Q11: Employees who joined in year 2020
SELECT *
FROM Employee
WHERE YEAR(join_date) = 2020;

-- Q12: Customers whose name starts with 'A'
SELECT *
FROM customer
WHERE name LIKE 'A%';

-- Q13: Department with the highest number of employees
SELECT dept_id, COUNT(*) AS Total_emp
FROM Employee
GROUP BY dept_id
ORDER BY Total_emp DESC
LIMIT 1;

-- Q14: Count of employees in each department
SELECT d.dept_name, COUNT(e.emp_id) AS Total_emp
FROM Department d
LEFT JOIN Employee e ON e.dept_id = d.dept_id
GROUP BY d.dept_name;

-- Q15: Second highest salary
SELECT DISTINCT salary
FROM Employee
ORDER BY salary DESC
LIMIT 1 OFFSET 1;

-- Q16: Top 3 performing locations based on purchase amount
SELECT Location, SUM(`Purchase Amount (USD)`) AS Total_purchases
FROM customer
GROUP BY Location
ORDER BY Total_purchases DESC
LIMIT 3;

-- Using RANK() for handling ties
SELECT Location, Total_Purchases
FROM (
    SELECT Location,
           SUM(`Purchase Amount (USD)`) AS Total_Purchases,
           RANK() OVER (ORDER BY SUM(`Purchase Amount (USD)`) DESC) AS rnk
    FROM customer
    GROUP BY Location
) Ranked_Locations
WHERE rnk <= 3;

-- Q17: Cumulative sum of sales per product
SELECT order_date,
       product_id,
       product_name,
       Amount,
       SUM(Amount) OVER (PARTITION BY product_id ORDER BY order_date) AS cumulative_sum
FROM sales;

-- Q18: Customers with purchases above 5000 multiple times
SELECT customer_id, COUNT(*) AS Total_customer
FROM Transaction_table
WHERE transaction > 5000
GROUP BY customer_id
HAVING COUNT(*) > 1;

-- Q19: Customers who have not made purchases in the last 6 months
SELECT c.customer_id
FROM customer c
LEFT JOIN orders o 
    ON c.customer_id = o.customer_id
    AND o.order_date >= DATE_SUB(CURDATE(), INTERVAL 6 MONTH)
WHERE o.order_id IS NULL;

-- Q20: Max transaction for each customer
SELECT customer_id, MAX(Amount) AS Max_transaction
FROM Transaction
GROUP BY customer_id;

-- Q21: Most profitable region based on transaction data
SELECT Region AS Top_Profitable_region, SUM(Amount) AS Total_Amount
FROM Transaction
GROUP BY Region
ORDER BY Total_Amount DESC
LIMIT 1;
