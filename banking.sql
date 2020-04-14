create database banking_enterprise;
use banking_enterprise;
create table Branch(branch_name varchar(30),branch_city varchar(30),assets real,primary key(branch_name));
create table Bankaccount(accno int,branch_name varchar(30),balance real,primary key(accno),foreign key(branch_name) references Branch(branch_name));
create table bankcustomer(customer_name varchar(30),customer_street varchar(30),customer_city varchar(30),
primary key(customer_name));
create table depositer(customer_name varchar(20),accno int,primary key(customer_name,accno),
foreign key(customer_name) references bankcustomer(customer_name),foreign key(accno) references Bankaccount(accno));
create table loan(loan_num int,branch_name varchar(30),amount real,primary key(loan_num),foreign key(branch_name) references Branch(branch_name));
 
 insert into Branch values('SBI_Chamrajpet','Bangalore',50000),
 ('SBI_ResidencyRoad', 'Bangalore',10000),('SBI_ShivajiRoad','Bombay',20000),('SBI_ParlimentRoad','Delhi',10000),('SBI_Jantarmantare','Delhi',20000);
 
insert into Loan values(2,'SBI_ResidencyRoad',2000),
 (1,'SBI_Chamrajpet',1000),(3,'SBI_ShivajiRoad',3000),(4,'SBI_ParlimentRoad',4000),(5,'SBI_Jantarmantare',5000);

insert into BankAccount values(11, 'SBI_Jantarmantare', 2000),
(1, 'SBI_Chamrajpet', 2000),
(2, 'SBI_ResidencyRoad', 5000),(8, 'SBI_ResidencyRoad', 4000),(10, 'SBI_ResidencyRoad', 5000),
(3, 'SBI_ShivajiRoad', 6000),(6, 'SBI_ShivajiRoad', 4000),(4, 'SBI_ParlimentRoad', 9000),(9, 'SBI_ParlimentRoad', 3000),(5, 'SBI_Jantarmantare', 8000);

 insert into bankcustomer values("Avinash","Bull_Temple_Road","Bangalore"),("Dinesh","Bannergatta","Bangalore"),("Mohan","National_clg_Road","Bangalore"),("Nikil","Akbar_road","Delhi"),
 ("Ravi","prithviraj_Road","Delhi");
 
 insert into depositer values("Avinash",1),("Dinesh",2),("Nikil",4),("Ravi",5),("Avinash",8),("Nikil",9),("Dinesh",10),("Nikil",11);
 
 select c.customer_name from bankcustomer c where exists(
 select d.customer_name,count(d.customer_name) from depositer d,BankAccount ba
 where d.accno=ba.accno and c.customer_name=d.customer_name and ba.branch_name="SBI_ResidencyRoad" 
 group by d.customer_name
 having count(d.customer_name)>=2
 );
 
 select BC.customername from bankcustomer BC where not exists(
	select branch_name from Branch where branch_city = 'Delhi'
	except
    select BA.branch_name from depositer D, BankAccount BA
	where D.accno = BA.accno and BC.customer_name = D.customer_name
    );
    
delete from BankAccount where branch_name in( select branch_name from Branch where branch_city = 'Bombay' );








 
 