set pagesize 100
set linesize 200

drop table salary;
drop table leave;
drop table employee;
drop table department;
drop table position;

create table department(
department_id number(10),
department_name varchar(20),
primary key(department_id)
);

create table position(
position_id number(10),
position_name varchar(20),
primary key(position_id)
);

create table employee(
employee_id number(10),
first_name varchar(20),
last_name varchar(20),
date_of_birth varchar(20),
gender varchar(10),
contact_number number(15),
email_address varchar(20),
address varchar(30),
department_id number(10),
position_id number(10),
primary key(employee_id),
foreign key (department_id) references department(department_id),
foreign key (position_id) references position(position_id)
);

create table salary(
salary_id number(10),
employee_id number(10),
salary_amount number(10),
effective_date varchar(20),
primary key(salary_id),
foreign key(employee_id) references employee(employee_id)
);

create table leave(
leave_id number(10),
employee_id number(10),
leave_type varchar(20),
start_date varchar(20),
end_date varchar(20),
reason varchar(20),
status varchar(20),
primary key(leave_id),
foreign key(employee_id) references employee(employee_id)
);

--DDL
alter table department add department_alter varchar(20);
alter table department modify department_alter varchar(23);
alter table department rename column department_alter to department_alter2;
alter table department drop column department_alter2;









