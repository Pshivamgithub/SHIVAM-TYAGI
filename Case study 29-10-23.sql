select count(distinct product_name) from product_details;


#Q1

select product_details.product_name,Sum(sales.qty) AS sales_count
from product_details
JOIN sales
ON product_details.product_id= sales.prod_id
GROUP BY product_details.product_name
ORDER BY sales_count desc;

#Q2

select product_details.product_name,Sum(sales.price * sales.qty) AS sales_revenue
from product_details
JOIN sales
ON product_details.product_id= sales.prod_id
GROUP BY product_details.product_name
ORDER BY sales_revenue desc;
                 #OR
select sum(price*qty) as no_dis_revenue from sales; #1056489


#Q3
select product_details.product_name,Sum( sales.price * sales.discount * sales.qty)/100 AS sales_discount
from product_details
JOIN sales
ON product_details.product_id= sales.prod_id
GROUP BY product_details.product_name
ORDER BY sales_discount desc; 

              #OR
 SELECT sum(price* qty *discount)/100 AS total_discount from sales;      #129682.6000 
 
  #Q4
 select count(distinct txn_id) as uniqe_transction
 from sales; #2054
 
 #Q5
 WITH cte_transaction_product as(
 select txn_id,
 count(distinct prod_id) as product_count
 from sales
 group by txn_id)
 select round(avg(product_count)) as avg_unique_product
 from cte_transaction_product ;  #6 
 
 
 select count( distinct txn_id) from sales; #2054
 
 #Q6
 
 
 WITH cte_transaction_discount as(
 select txn_id,
 sum(price*qty*discount)/100 as total_discount
 from sales
 group by txn_id)
 select round(avg(total_discount)) as avg_discount
 from cte_transaction_discount ; 
 
 
 
 #Q7
 WITH cte_member_revenue as 
(select member, txn_id,sum(price*qty) as revenue 
from sales group by member, txn_id)
select member, round(avg(revenue),2) as avg_revenue 
from cte_member_revenue
group by member;
 
select count(member) from sales where member='True'; #7292
select count(member) from sales where member='false'; #5065
select count(member) from sales ;

#	Q8

select product_details.product_name,Sum(sales.price * sales.qty) AS sales_revenue
from product_details
 INNER JOIN sales
ON product_details.product_id= sales.prod_id
GROUP BY product_details.product_name
ORDER BY sales_revenue desc
limit 3 ;


#Q 9


select segment_name, count(segment_id) 
from product_details 
group by segment_name;


select  pd.segment_name, pd.segment_id,
sum(se.qty) as total_qty,
 sum(se.price*se.qty) AS total_revenue,
 sum(se.price*se.qty*se.discount)/100 as total_discount 
from sales se
INNER JOIN product_details pd
ON se.prod_id=pd.product_id
group by pd.segment_id desc
order by pd.segment_id ;
 
#Q 10


 select product_details.segment_id,product_details.segment_name,
 product_details.product_id,product_details.product_name,
 sum(sales.qty) as product_quantity from sales
 INNER JOIN product_details
 ON sales.prod_id=product_details.product_id
 group by product_details.segment_id,product_details.segment_name,
 product_details.product_id,product_details.product_name
 order by product_quantity desc
 limit 5 ;
              
  #Q 11
  
  select  pd.category_name, pd.category_id,
sum(se.qty) as total_qty,
 sum(se.price*se.qty) AS total_revenue,
 sum(se.price*se.qty*se.discount)/100 as total_discount 
from sales se
INNER JOIN product_details pd
ON se.prod_id=pd.product_id
group by pd.category_id desc
order by pd.category_id ;
  
  
  
  #Q12
 select product_details.category_id,product_details.category_name,
 product_details.product_id,product_details.product_name,
 sum(sales.qty) as product_quantity from sales
 INNER JOIN product_details
 ON sales.prod_id=product_details.product_id
 group by product_details.category_id,product_details.category_name,
 product_details.product_id,product_details.product_name
 order by product_quantity desc
 limit 5 ;
  
  
              