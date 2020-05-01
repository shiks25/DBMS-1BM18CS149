create database books;
use books;
create table publisher(pname varchar(20),phno varchar(20),address varchar(60), primary key(pname));
create table book(bid int,title varchar(40),pname varchar(30), pub_year varchar(10),primary key(bid),foreign key(pname) references publisher(pname));
create table book_authors(bid int,author_name varchar(20),primary key(bid,author_name),foreign key(bid) references book(bid) on delete cascade);
create table branch(branch_id int,address varchar(30),brname varchar(30),primary key(branch_id));
create table book_lend(bid int,branch_id int,card_no int ,date_out date,due_date date,primary key(bid,branch_id,card_no),foreign key(bid) references book(bid) on delete cascade,foreign key(branch_id) references branch(branch_id));
create table book_copies(bid int,branch_id int, copies int,primary key(bid,branch_id),foreign key(bid) references book(bid) on delete cascade,foreign key(branch_id) references branch(branch_id));

INSERT INTO publisher VALUES ('MCGRAW-HILL', '9989076587', 'BANGALORE'),('PEARSON', '9889076565', 'NEWDELHI'),('RANDOM HOUSE', '7455679345', 'HYDERABAD'),('HACHETTE LIVRE', '8970862340', 'CHENNAI'),
('GRUPO PLANETA', '7756120238', 'BANGALORE');

INSERT INTO BOOK VALUES (1,'DBMS','MCGRAW-HILL','JAN-2017');
INSERT INTO BOOK VALUES (2,'ADBMS','MCGRAW-HILL','JUN-2016');
INSERT INTO BOOK VALUES (3,'CN', 'PEARSON','SEP-2016');
INSERT INTO BOOK VALUES (4,'CG', 'GRUPO PLANETA','SEP-2015');
INSERT INTO BOOK VALUES (5,'OS','PEARSON','MAY-2016');

INSERT INTO BOOK_AUTHORS VALUES (1,'NAVATHE'),(2,'NAVATHE'),(3,'TANENBAUM'),(4,'EDWARD ANGEL'),(5,'GALVIN');

INSERT INTO branch VALUES (10,'RR NAGAR','BANGALORE'),(11,'RNSIT','BANGALORE'),(12,'RAJAJI NAGAR', 'BANGALORE'), (13,'NITTE','MANGALORE'), (14,'MANIPAL','UDUPI');

INSERT INTO BOOK_COPIES VALUES (1, 10, 10);
INSERT INTO BOOK_COPIES VALUES (1, 11, 5);
INSERT INTO BOOK_COPIES VALUES (2, 12, 2);
INSERT INTO BOOK_COPIES VALUES (2, 13, 5);
INSERT INTO BOOK_COPIES VALUES (3, 14, 7);
INSERT INTO BOOK_COPIES VALUES (5, 10, 1);
INSERT INTO BOOK_COPIES VALUES (4, 11, 3);

INSERT INTO BOOK_LEND VALUES ( 1, 10, 101,'2017-01-01','2017-06-01');
INSERT INTO BOOK_LEND VALUES (3, 14, 101,'2017-01-11','2017-03-11');
INSERT INTO BOOK_LEND VALUES ( 2, 13, 101,'2017-02-21','2017-04-21');
INSERT INTO BOOK_LEND VALUES ( 4, 11, 101,'2017-03-15','2017-07-15');
INSERT INTO BOOK_LEND VALUES ( 1, 11, 104,'2017-04-12','2017-05-12');

/*Retrieve details of all books in the library – id, title, name of publisher, authors, number of copies in each branch, etc.*/
SELECT B.bid, B.title, B.pname, A.author_name,C.copies, L.branch_id FROM book B, book_authors A, book_copies C, branch L
WHERE B.bid=A.bid AND B.bid=C.bid AND L.branch_id=C.branch_id;

/*Get the particulars of borrowers who have borrowed more than 3 books, but from Jan 2017 to Jun 2017.*/
SELECT CARD_NO FROM BOOK_LEND WHERE DATE_OUT BETWEEN '2017-01-01' AND '2017-06-01' group by card_no having count(card_no)>3;

/*Delete a book in BOOK table. Update the contents of other tables to reflect this data manipulation operation.*/
delete from book where bid=3;
select a.bid,b.bid,c.bid from book_authors a,book_copies b,book_lend c where a.bid=3 and b.bid=3 and c.bid=3;

/*Partition the BOOK table based on year of publication. Demonstrate its working with a simple query.*/
CREATE VIEW V_PUBLICATION AS SELECT PUB_YEAR FROM BOOK;
select * from V_PUBLICATION;

/*Create a view of all books and its number of copies that are currently available in the Library.*/
CREATE VIEW V_BOOKS AS
SELECT B.bid, B.TITLE, C.copies
FROM BOOK B, BOOK_COPIES C, BRANCH L
WHERE B.bid=C.bid AND C.BRANCH_ID=L.BRANCH_ID;
select * from V_BOOKS;






