create database office;
use office;
create table supplier(sid int,sname varchar(20),city varchar(30),primary key(sid));
create table parts(pid int,pname varchar(30),color varchar(20),primary key(pid));
create table catalog(sid int,pid int,primary key(sid,pid),foreign key(sid) references supplier(sid),foreign key(pid) references parts(pid));
alter table catalog
add cost int;

insert into supplier values(10001, 'Acme Widget', 'Bangalore'),
(10002, 'Johns', 'Kolkata'),
(10003, 'Vimal', 'Mumbai'),
(10004, 'Reliance', 'Delhi');

insert into parts values(20001, 'Book', 'Red'),
(20002, 'Pen', 'Red'),
(20003, 'Pencil', 'Green'),
(20004, 'Mobile', 'Green'),
(20005, 'Charger', 'Black');

insert into catalog values(10001,20001,10),
(10001,20002,10),
(10001,20003,30),
(10001,20004,10),
(10001,20005,10),
(10002,20001,10),
(10002,20002,20),
(10003,20003,30),
(10004,20003,40);

select distinct p.pname from parts p,catalog c
where p.pid=c.pid;

select  sname from supplier s
where s.sid in  (select sid from catalog group by sid having count(pid)=5 );
                    
select distinct sname from supplier s,catalog c,parts p
where s.sid=c.sid and c.pid = p.pid and p.color='red';

select pname from parts p
where p.pid not in( select pid from catalog where sid!=(select sid from supplier where sname='Acme Widget'));

select distinct c.sid from catalog c where c.cost>(select avg(cost) from catalog c1 where c1.pid=c.pid);

select p.pname ,s.sname from parts p,catalog c,supplier s where c.pid=p.pid and c.sid=s.sid and c.cost=(select max(c1.cost) from catalog c1 where c1.pid=c.pid);



