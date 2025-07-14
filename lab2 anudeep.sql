Enter password: ********
Welcome to the MySQL monitor.  Commands end with ; or \g.
Your MySQL connection id is 11
Server version: 8.0.42 MySQL Community Server - GPL

Copyright (c) 2000, 2025, Oracle and/or its affiliates.

Oracle is a registered trademark of Oracle Corporation and/or its
affiliates. Other names may be trademarks of their respective
owners.

Type 'help;' or '\h' for help. Type '\c' to clear the current input statement.
question-Lab 2: Use the Student management system Database and table from our previous lab and write a sql query to achieve the below scenario. 

 Assume you are managing a university database that tracks student enrollments in various courses. You have two tables, "Student" and "Enrollment". The goal is to retrieve information about each student's ID, first name, last name, and their enrollment details, including the enrollment ID and the associated course ID. 

 Hint:Use inner join to retrieve data. Submission: Create an SQL script file containing your solutions for all tasks (queries). Name the file "lab_assignment1.sql" Provide comments above each query to indicate the query's purpose

mysql> show databases;
+--------------------+
| Database           |
+--------------------+
| anp_d1378          |
| anp_d1379          |
| anp_d1380          |
| emp_db             |
| employee1          |
| information_schema |
| joins              |
| lab2               |
| mysql              |
| onlinestore        |
| onlinestores       |
| performance_schema |
| sakila             |
| santosh            |
| student            |
| sys                |
| world              |
+--------------------+
17 rows in set (0.00 sec)

mysql> create database Lab;
Query OK, 1 row affected (0.01 sec)

mysql> use Lab;
Database changed
mysql> create table student(student_id varchar(10) not null primary key,first_name varchar(15) not null, last_name varchar(15) not null);
Query OK, 0 rows affected (0.03 sec)

mysql> desc student;
+------------+-------------+------+-----+---------+-------+
| Field      | Type        | Null | Key | Default | Extra |
+------------+-------------+------+-----+---------+-------+
| student_id | varchar(10) | NO   | PRI | NULL    |       |
| first_name | varchar(15) | NO   |     | NULL    |       |
| last_name  | varchar(15) | NO   |     | NULL    |       |
+------------+-------------+------+-----+---------+-------+
3 rows in set (0.00 sec)

mysql> insert into student values('S101','RAM','PAL');
Query OK, 1 row affected (0.01 sec)

mysql> insert into student values('S102','RAMESH','KUMAR');
Query OK, 1 row affected (0.01 sec)

mysql> insert into student values('S103','SURAJ','MORE');
Query OK, 1 row affected (0.01 sec)

mysql> insert into student values('S104','SANTOSH','RAJ');
Query OK, 1 row affected (0.01 sec)

mysql> insert into student values('S105','YESH','SHARMA');
Query OK, 1 row affected (0.01 sec)

mysql> select * from student;
+------------+------------+-----------+
| student_id | first_name | last_name |
+------------+------------+-----------+
| S101       | RAM        | PAL       |
| S102       | RAMESH     | KUMAR     |
| S103       | SURAJ      | MORE      |
| S104       | SANTOSH    | RAJ       |
| S105       | YESH       | SHARMA    |
+------------+------------+-----------+
5 rows in set (0.00 sec)

mysql> create table enrollment(e_id varchar(10) not null primary key,course_id varchar(10) not null,student_id varchar(10),foreign key(student_id) references student(student_id));
Query OK, 0 rows affected (0.03 sec)

mysql> desc enrollment;
+------------+-------------+------+-----+---------+-------+
| Field      | Type        | Null | Key | Default | Extra |
+------------+-------------+------+-----+---------+-------+
| e_id       | varchar(10) | NO   | PRI | NULL    |       |
| course_id  | varchar(10) | NO   |     | NULL    |       |
| student_id | varchar(10) | YES  | MUL | NULL    |       |
+------------+-------------+------+-----+---------+-------+
3 rows in set (0.00 sec)

mysql> insert into enrollment values('E201','C301','S101');
Query OK, 1 row affected (0.00 sec)

mysql> insert into enrollment values('E202','C302','S102');
Query OK, 1 row affected (0.02 sec)

mysql> insert into enrollment values('E203','C303','S103');
Query OK, 1 row affected (0.03 sec)

mysql> insert into enrollment values('E204','C304','S104');
Query OK, 1 row affected (0.02 sec)

mysql> insert into enrollment values('E205','C305',null);
Query OK, 1 row affected (0.01 sec)

mysql> select * from enrollment;
+------+-----------+------------+
| e_id | course_id | student_id |
+------+-----------+------------+
| E201 | C301      | S101       |
| E202 | C302      | S102       |
| E203 | C303      | S103       |
| E204 | C304      | S104       |
| E205 | C305      | NULL       |
+------+-----------+------------+
5 rows in set (0.00 sec)

mysql> select first_name,last_name,e_id,course_id from student inner join enrollment on student.student_id=enrollment.student_id;
+------------+-----------+------+-----------+
| first_name | last_name | e_id | course_id |
+------------+-----------+------+-----------+
| RAM        | PAL       | E201 | C301      |
| RAMESH     | KUMAR     | E202 | C302      |
| SURAJ      | MORE      | E203 | C303      |
| SANTOSH    | RAJ       | E204 | C304      |
+------------+-----------+------+-----------+
4 rows in set (0.00 sec)

mysql> select first_name,last_name,e_id,course_id from student left join enrollment on student.student_id=enrollment.student_id;
+------------+-----------+------+-----------+
| first_name | last_name | e_id | course_id |
+------------+-----------+------+-----------+
| RAM        | PAL       | E201 | C301      |
| RAMESH     | KUMAR     | E202 | C302      |
| SURAJ      | MORE      | E203 | C303      |
| SANTOSH    | RAJ       | E204 | C304      |
| YESH       | SHARMA    | NULL | NULL      |
+------------+-----------+------+-----------+
5 rows in set (0.00 sec)

mysql> select first_name,last_name,e_id,course_id from student right join enrollment on student.student_id=enrollment.student_id;
+------------+-----------+------+-----------+
| first_name | last_name | e_id | course_id |
+------------+-----------+------+-----------+
| RAM        | PAL       | E201 | C301      |
| RAMESH     | KUMAR     | E202 | C302      |
| SURAJ      | MORE      | E203 | C303      |
| SANTOSH    | RAJ       | E204 | C304      |
| NULL       | NULL      | E205 | C305      |
+------------+-----------+------+-----------+
5 rows in set (0.00 sec)

mysql> select first_name,last_name,e_id,course_id from student cross join enrollment on student.student_id=enrollment.student_id;
+------------+-----------+------+-----------+
| first_name | last_name | e_id | course_id |
+------------+-----------+------+-----------+
| RAM        | PAL       | E201 | C301      |
| RAMESH     | KUMAR     | E202 | C302      |
| SURAJ      | MORE      | E203 | C303      |
| SANTOSH    | RAJ       | E204 | C304      |
+------------+-----------+------+-----------+
4 rows in set (0.00 sec)
