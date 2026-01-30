-- Find the duplicate record in email col-- 
use customer;
select * from customer;


-- Reterive emp who earn more than their manger-- 
select e,name As Employee , e.salary As Emp_salary , M.salary  As Manger_salary from Employee E join Employee  M on e.manger_id = M.manger_id where e.salary > m.salary;


-- Find the employee who joined in the last 6 Months -- 
select emp_name from Employee where join_date >= date_sub(curdate() , interval 6 Month);



-- Get Department no emp - 
select D.dept_name from Employee E left join Department D on E.dept_id = d.dept_id where e.id is null;



-- Write a query to find employee with salary greater then average salary in entire campany -- 

select emp_name , salary from Employee where salary > (
select Avg(salary) from Employee);



-- Min and max purchase date for each customer-- 
select customer_id , min(order_date) As first_purchase , max(order_date) As last_purchase from employee group by customer_id;


-- 24 . Write a query to find the num of emp in each job title-- 

select job_title , count(emp_id) As Total_emp from Employee group by job_title;


-- 25 - Find the emp who don't have assigned any department 

select Emp_id from Employee where dept_id is null;


-- 26 - find duplicate in table - 
select Product_id , count(*) As Count from Product group by product_id having count(*) > 1;


-- How to find last 10 record in a table-- 
select * from table_name order by emp_id desc limit 10;


-- Find the emp who joined in year 2020 
select * from customer where year(join_date) = 2022;


-- customer whose name start with"A"
select * from customer where name like 'A%';



-- Find the dept_id with highest number of emp-- 
select dept_id , count(*) As Total_emp from table_name group by dept_id order by count(*) limit 1;


-- How to get the count of emp in each dept-- 
select dept_name , count(*) As Total_emp from Department group by dept_name;
            
            
            

-- write a query to find the duplicates-- 
select col , col2 ,count(*) As count from customer
 group by col , col2 
 having count >1;
 
with duplicates As (
select col , col2  , row_number() over (partition by `Customer Id` , Age , Gender order by `Customer Id`) As rn from customer) 
delete from Customer where `Customer ID` in (
select `Customer ID` from duplicates where rn > 1
);


-- second highest salary-- u
use customer;
select * from customer;
select distinct `Purchase Amount (USD)` from customer order by `Purchase Amount (USD)` desc limit 1 offset 1;



-- write a query to fetch the top 3 performing Location based on `Purchase Amount (USD)` -- 

-- sales
-- product_id , product_name , sale

select Location , sum(`Purchase Amount (USD)`) As Total_purchases from customer group by Location order by Total_purchases desc limit 3;

SELECT Location, Total_Purchases
FROM (
    SELECT 
        Location,
        SUM(`Purchase Amount (USD)`) AS Total_Purchases,
        RANK() OVER (ORDER BY SUM(`Purchase Amount (USD)`) DESC) AS rnk
    FROM customer
    GROUP BY Location
) Ranked_Locations
WHERE rnk <= 3;




-- cumulative sum of sales
-- Assume table - customer
-- col - order_date , product_id , product_name , Amount

select order_date , product_id , product_name , Amount , sum(Amount) over (partition by product_id order by order_date) As cumulative_sum
from sales;



-- Write a query to identify customers who have made purchase above 5000 multiple times 

-- Assume table - Transaction_table
-- col - customer_id , Transaction_id , Transaction

select customer_id , count(*) As Total_customer from Transaction_table Where transaction > 5000 group by customer_id having count(*) > 1;




-- customers who have not made any purchases last 6 months
-- customer - customer_id 
-- Orders - order_id , order_date , customer_id

select C.customer_id from customer c join orders o on c.customer_id = o.order_id where o.order_date >= date_sub(curdate() , interval 6 month) And C.customer_id is null;


select Location , Total_Purchases from 
(
select Location ,  SUM(`Purchase Amount (USD)`) AS Total_Purchases,  RANK() OVER (ORDER BY  SUM(`Purchase Amount (USD)`) DESC) AS rnk
FROM customer 
group by Location
) Ranked 
where rnk <=3;


-- Write a query to Fetch the max transcation for each customer-- 
-- Table - Transaction 
-- col - customer_id , Transaction_id , Amount

select customer_id , max(Amount) As Max_transaction from Transaction group by customer_id;

-- Write a query to calculate most profitable region based on transaction data --
-- Table - Transaction 
-- col - customer_id , Transaaction_id ,  Amount , Region

select Region As Top_Profitable_region , sum(Amount) As Total_Amount from Transaction group by Region order by Total_Amount Desc limit 1;








 
