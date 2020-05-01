create database market;
use market;
create table salesman(sales_id int,sname varchar(30),scity varchar(30),commission varchar(10),primary key(sales_id));
create table customer(cust_id int,cust_name varchar(30),ccity varchar(30),grade int,sales_id int,primary key(cust_id),foreign key(sales_id) references salesman(sales_id)on delete cascade);
create table orders(ord_no int,purchase_amt int ,ord_date date,sales_id int,cust_id int,primary key(ord_no),foreign key(sales_id) references salesman(sales_id) on delete cascade,foreign key(cust_id) references customer(cust_id) on delete cascade);
drop table orders;
drop table customer;
INSERT INTO SALESMAN VALUES (1000, 'JOHN','BANGALORE','25 %'), (2000, 'RAVI','BANGALORE','20 %'), (3000, 'KUMAR','MYSORE','15 %'),
(4000, 'SMITH','DELHI','30 %'),(5000, 'HARSHA','HYDRABAD','15 %');
 INSERT INTO CUSTOMER VALUES(10, 'PREETHI','BANGALORE', 100, 1000),(11, 'VIVEK','MANGALORE', 300, 1000), (12, 'BHASKAR','CHENNAI', 400, 2000),
 (13, 'CHETHAN','BANGALORE', 200, 2000), (14, 'MAMATHA','BANGALORE', 400, 3000);

INSERT INTO orders VALUES (50, 5000, '2017-05-04', 1000, 10), (51, 450, '2017-01-20', 2000, 10), (52, 1000, '2017-02-24', 2000, 13), (53, 3500, '2017-04-13', 3000, 14),
(54, 550, '2017-03-09', 2000, 12);

/*Count the customers with grades above Bangalore’s average.*/
select count(cust_id) from customer where grade > (select avg(grade) from customer where ccity='BANGALORE');

/*Find the name and numbers of all salesmen who had more than one customer.*/
SELECT s.sales_id, s.sname
FROM salesman s
WHERE 1<(select count(c.sales_id)
				from customer c
                where s.sales_id=c.sales_id);
                
/*List all salesmen and indicate those who have and don’t have customers in their cities (Use UNION operation.)*/
SELECT s.sales_id, s.sname, cust_name, commission
FROM salesman s, customer c
WHERE s.scity = c.ccity
UNION
SELECT sales_id, sname, 'NO MATCH', commission
FROM salesman
WHERE NOT scity = ANY
(SELECT ccity
FROM customer)
ORDER BY 2 DESC;
/*Create a view that finds the salesman who has the customer with the highest order of a day.*/
CREATE VIEW ELITSALESMAN AS
SELECT B.ord_date, A.sales_id, A.sname
FROM salesman A, orders B
WHERE A.sales_id = B.sales_id
AND B.purchase_amt=(SELECT MAX(purchase_amt)
FROM orders C
WHERE C.ORD_DATE = B.ORD_DATE);
select * from ELITSALESMAN;

/*Demonstrate the DELETE operation by removing salesman with id 1000. All his orders must also be deleted.*/
/*added on delete cascade to foreign key constraint*/
DELETE FROM SALESMAN
WHERE sales_id=1000;

select * from orders;

