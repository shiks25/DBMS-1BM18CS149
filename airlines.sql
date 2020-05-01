create database flight;
use flight;
create table flights(flno int,ffrom varchar(20), tto varchar(20),distance int,departs timestamp,arrives timestamp,price int,primary key(flno) );
insert into flights values
(101,'Bangalore','Delhi',2500,'2005-05-13 07:15:31','2005-05-13 17:15:31',5000);
insert into flights values
(102,'Bangalore','Lucknow',3000,'2005-05-13 07:15:31','2005-05-13 11:15:31',6000),
(103,'Lucknow','Delhi',500,'2005-05-13 12:15:31','2005-05-13 17:15:31',3000),
(107,'Bangalore','Frankfurt',8000,'2005-05-13 07:15:31','2005-05-13 22:15:31',60000),
(104,'Bangalore','Frankfurt',8500,'2005-05-13 07:15:31','2005-05-13 23:15:31',75000),
(105,'Kolkata','Delhi',3400,'2005-05-13 07:15:31','2005-05-13 09:15:31',7000);

create table aircraft(aid int,aname varchar(20),cruisingrange int);
alter table aircraft
add primary key(aid);
create table employees(eid int,ename varchar(20),salary int,primary key(eid)) ;
create table certified(eid int,aid int);
alter table certified
add primary key(eid,aid);
alter table certified
add foreign key(eid) references employees(eid);
alter table certified
add foreign key(aid) references aircraft(aid);

insert into aircraft values(101,'747',3000),(102,'Boeing',900),(103,'647',800),(104,'Dreamliner',10000),(105,'Boeing',3500),(106,'707',1500),(107,'Dream',120000);

insert into employees values(701,'A',50000),(702,'B',100000),(703,'C',150000),(704,'D',90000),(705,'E',40000),(706,'F',60000),(707,'G',90000);

insert into certified values(701,101),
(701,102),(701,106),(701,105),(702,104),(703,104),(704,104);
insert into certified values(702, 107),(703, 107),(704,107),(702, 101),(703, 105),(704, 105),(705, 103);

/*Find the names of aircraft such that all pilots certified to operate them have salaries more than Rs.80,000.*/
select distinct a.aname from aircraft a,certified c,employees e where a.aid=c.aid and c.eid=e.eid and e.salary>80000; 

/*For each pilot who is certified for more than three aircrafts, find the eid and the maximum cruising range of the aircraft for which she or he is certified.*/
SELECT C.eid, MAX(A.cruisingrange)
FROM Certified C, Aircraft A
WHERE C.aid = A.aid
GROUP BY C.eid
HAVING COUNT(c.eid) > 3;

/*Find the names of pilots whose salary is less than the price of the cheapest route from Bangalore to Frankfurt.*/
SELECT DISTINCT E.ename
FROM employees E
WHERE E.salary <( SELECT MIN(F.price)
					FROM flights F
                     WHERE F.ffrom = 'Bangalore' AND F.tto = 'Frankfurt' );
                     
/*For all aircraft with cruising range over 1000 Kms, find the name of the aircraft and the average salary of all pilots certified for this aircraft. */

SELECT Temp.name, Temp.AvgSalary
FROM ( SELECT A.aid, A.aname AS name, AVG (E.salary) AS AvgSalary
 FROM Aircraft A, Certified C, Employees E
 WHERE A.aid = C.aid AND C.eid = E.eid AND A.cruisingrange > 1000
 GROUP BY A.aid, A.aname )Temp;
 
 /*Find the names of pilots certified for some Boeing aircraft. */

SELECT DISTINCT E.ename
FROM Employees E, Certified C, Aircraft A
WHERE E.eid = C.eid AND C.aid = A.aid AND A.aname LIKE ‘Boeing’;

/*	Find the aids of all aircraft that can be used on routes from Bangalore to Frankfurt.*/

SELECT A.aid
FROM Aircraft A
WHERE A.cruisingrange >( SELECT MIN (F.distance)
			FROM Flights F
			WHERE F.ffrom = ‘Bangalore’ AND F.tto = ‘Frankfurt’ );

      

/*	A customer wants to travel from Bangalore to Delhi  with no more than two changes of flight. List the choice of departure times from Bangalore if the customer wants to arrive in Delhi  by 6 p.m.*/
SELECT F.departs
FROM Flights F
WHERE F.flno IN ( ( SELECT F0.flno
 FROM Flights F0
 WHERE F0.ffrom = ‘Bangalore’ AND F0.tto = ‘Delhi’
 AND extract(hour from F0.arrives) < 18 )
 UNION
( SELECT F0.flno
 FROM Flights F0, Flights F1
 WHERE F0.ffrom = ‘Bangalore’ AND F0.tto <> ‘Delhi’
 AND F0.tto = F1.ffrom AND F1.tto = ‘Delhi’
 AND F1.departs > F0.arrives
 AND extract(hour from F1.arrives) < 18)
 UNION
( SELECT F0.flno
 FROM Flights F0, Flights F1, Flights F2
 WHERE F0.ffrom = ‘Bangalore’
 AND F0.tto = F1.ffrom
 AND F1.tto = F2.ffrom
 AND F2.tto = ‘Delhi’
 AND F0.tto <> ‘Delhi’
 AND F1.tto <> ‘Delhi’
 AND F1.departs > F0.arrives
 AND F2.departs > F1.arrives
 AND extract(hour from F2.arrives) < 18));



/*Print the name and salary of every non-pilot whose salary is more than the average salary for pilots.*/

SELECT E.ename, E.salary
FROM Employees E
WHERE E.eid NOT IN ( SELECT DISTINCT C.eid
 FROM Certified C )
AND E.salary >( SELECT AVG (E1.salary)
 FROM Employees E1
 WHERE E1.eid IN
( SELECT DISTINCT C1.eid
 FROM Certified C1 ) );









