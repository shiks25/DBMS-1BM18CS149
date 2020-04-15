create database student;
use student;
create table student(snum int,sname varchar(20),major varchar(20),lvl varchar(20),age int,primary key(snum));
create table faculty(fid int,fname varchar(20),deptid int,primary key(fid));
create table class(cname varchar(20),meetsat timestamp,room varchar(20),fid int,primary key(cname),foreign key(fid) references faculty(fid));
create table enrolled(snum int ,cname varchar(20),foreign key(snum) references student(snum),foreign key(cname) references class(cname),primary key(snum,cname));

insert into student values
(1,'Shawn','cs','sr',19),
(2,'Justin','cs','jr',20),
(3,'Rita','cs','sr',20),
(4,'Nicki','cs','jr',20),
(5,'Selena','cs','jr',20),
(6,'Rahul','cs','fr',21);

insert into faculty values
(100,'Sarita',11),
(101,'Monica',12),
(102,'Raji',13),
(103,'Manjunath',14),
(104,'Alia',15);

insert into class values
('class1','20-03-15 10:15:16','R1',103),
('class10','20-03-15 10:15:16','R128',103),
('class2','20-03-15 10:15:20','R2',101),
('class3','20-03-15 10:15:25','R3',101),
('class4','20-03-15 20:15:20','R4',103),
('class5','20-03-15 20:15:20','R3',104),
('class6','20-03-15 13:20:20','R2',103),
('class7','20-03-15 10:10:10','R3',103);

insert into enrolled values
(1,'class1'),(2,'class1'),(3,'class3'),(4,'class3'),(5,'class4'),
(1,'class5'),(2,'class5'),(3,'class5'),(4,'class5'),(5,'class5');

/*find the names of all Juniors(jr) who are enrolled in a class taught by 'Monica'; output='Nicki'*/
select s.sname from student s,enrolled e,class c,faculty f where s.snum=e.snum and e.cname=c.cname and c.fid =f.fid 
									      and s.lvl='jr'and f.fname='Monica';

																		    
/*find the names of all classes that either meet in room R128 or have five or more students enrolled ; o/p = class 10 and class 5*/
select c.cname from class c where c.room='R128' or c.cname in (select cname from enrolled  group by cname having count(cname)>=5 );

																		    
/*find the names of all students who are enrolled in two classes that meet at the same time; o/p = Selena*/
select distinct sname from student where snum in(select e1.snum from enrolled e1,enrolled e2,class c1,class c2 
						 where e1.snum=e2.snum and e1.cname <> e2.cname 
                                                 and e1.cname=c1.cname and e2.cname=c2.cname and c1.meetsat=c2.meetsat );
                                             
																		    
 /*find names of  faculty members who teach in every room in which some class is taught; o/p = Manjunath*/
 select  f.fname from faculty f,class c  where f.fid=c.fid group by c.fid having count(c.fid)= (select count(distinct room) from class);
 
																		    
 /*find names of  faculty members for whom the combined enrollment of the courses that they teach is less than five;o/p = Sarita,Monica,Raji,Manjunath*/
 SELECT DISTINCT F.fname FROM faculty F WHERE (SELECT COUNT(E.snum) FROM class C, enrolled E
WHERE C.cname = E.cname AND C.fid = F.fid) <5;

																		    
 /*find the names of the students who are not enrolled in any class;o/p ='Rahul'*/
select distinct sname from student where snum not in(select snum from enrolled );

/*for each age that appears in students find the level value that apperas most often; o/p=19-sr,20-jr,21-fr*/
SELECT age, lvl FROM student S GROUP BY age, lvl HAVING lvl IN (SELECT S1.lvl FROM student S1 
				                                WHERE S1.age = S.age GROUP BY S1.lvl, S1.age
                                                                HAVING COUNT(*) >= ALL (SELECT COUNT(*) FROM student S2 
								 WHERE s1.age = S2.age GROUP BY S2.lvl, S2.age));

