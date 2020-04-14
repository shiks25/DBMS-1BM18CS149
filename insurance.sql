show databases;
create database Insurance;
use Insurance;
create table Person(
driver_id varchar(20),
name1 varchar(30),
address varchar(50),
PRIMARY KEY(driver_id));
create table Car (reg_num varchar(20),model varchar(20),y  int,PRIMARY KEY(reg_num));
create table accident(report_num int, accident_date date, location varchar(25), PRIMARY KEY(report_num));
create table Owns (
  driver_id varchar(20),reg_num varchar(30),
  PRIMARY KEY(driver_id,reg_num),
  FOREIGN KEY(driver_id) REFERENCES Person(driver_id),
   FOREIGN KEY(reg_num) REFERENCES Car(reg_num));
  create table participated(driver_id varchar(25), reg_num varchar(25), report_num int, damage_amount int, PRIMARY KEY(driver_id, reg_num, report_num), FOREIGN KEY(driver_id) REFERENCES person(driver_id), FOREIGN KEY(reg_num) REFERENCES car(reg_num), FOREIGN KEY(report_num) REFERENCES accident(report_num));
   
   insert into Person values("A01","Richard","Srinivas nagar");
   insert into Person values("A02","Pradeep","Rajajinagar");
   insert into Person values("A03","Smith","Ashok nagar");
   insert into Person values("A04","Venu","NR Colony");
   insert into Person values("A05","Jhon","Hanumanth nagar");
   
   insert into Car values("KA052250","Indica",1990);
   insert into Car values("KA031181","Lancer",1957);
   insert into Car values("KA095477","Toyota",1998);
   insert into Car values("KA053408","Honda",2008);
   insert into Car values("KA041702","Audi",2005);
   
   insert into Owns values("A01","KA052250");
   insert into Owns values("A02","KA053408");
   insert into Owns values("A03","KA031181");
   insert into Owns values("A04","KA095477");
   insert into Owns values("A05","KA041702");
   
 insert into accident values(11,"2003-01-01","Mysore Road");
insert into accident values(12,"2004-02-02","South end Circle");
insert into accident values(13,"2003-01-21","Bull temple Road");
insert into accident values(14,"2008-02-17","Mysore Road");
insert into accident values(15,"2005-03-04","Kanakpura Road");
select * from accident;

 insert into participated values("A01", "KA052250", 11, 10000);
insert into participated values("A02", "KA053408", 12, 50000);
insert into participated values("A03", "KA095477", 13, 25000);
insert into participated values("A04", "KA031181", 14, 3000);
insert into participated values("A05", "KA041702", 15, 5000);


update participated
set damage_amount=25000
where reg_num="KA053408" AND report_num=12;
select * from participated;

insert into accident values(16,"2019-02-17","Basvanagudi");
select * from accident ;

Select count(distinct driver_id)as count from participated, accident where participated.report_num=accident.report_num and accident_date like "2008%";

select count(participated.report_num) as count from participated,Car where participated.reg_num=Car.reg_num and car.model="Audi";