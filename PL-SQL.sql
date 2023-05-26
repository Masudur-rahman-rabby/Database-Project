
--PL/SQL variable declaration and print value

set serveroutput on
declare 

department_id department.department_id%type;
department_name department.department_name%type;

employee_id employee.employee_id%type;
first_name employee.first_name%type;
last_name employee.last_name%type;


begin
select department_id,department_name into department_id,department_name from department where department_id=2;
select employee_id,first_name,last_name into employee_id,first_name,last_name from employee where employee_id=3;
dbms_output.put_line('DEPT_id: '||department_id|| ' DEPT_name: '||department_name||' EMP_ID: '||employee_id||' F_NAME: '||first_name||' L_NAME: '||last_name);

end;
/

--Insert and set default value

set serveroutput on
declare 

leave_id leave.leave_id%type:=11;
employee_id leave.employee_id%type:=5;
leave_type leave.leave_type%type:='Sick';
start_date leave.start_date%type:='2023-06-01';
end_date leave.end_date%type:='2023-06-09';
reason leave.reason%type:='Cold fever';
status leave.status%type:='Pending';

begin
insert into leave values(leave_id,employee_id,leave_type,start_date,end_date,reason,status);
end;
/

--Row type

set serveroutput on
declare 
pos_row position%rowtype;
begin
select position_id,position_name into pos_row.position_id,pos_row.position_name from position where position_id=3;
end;
/

--Row count and Cursor

set serveroutput on
declare 
cursor salary_cursor is select * from salary;
salary_row salary%rowtype;

begin

open salary_cursor;
fetch salary_cursor into salary_row.salary_id,salary_row.employee_id,salary_row.salary_amount,salary_row.effective_date;
while salary_cursor%found loop
dbms_output.put_line('SAL_ID: '||salary_row.salary_id||' EMP_ID: '||salary_row.employee_id||' AMOUNT: '||salary_row.salary_amount||' EFFECTIVE_DATE: '||salary_row.effective_date);
dbms_output.put_line('Row count: '|| salary_cursor%rowcount);
fetch salary_cursor into salary_row.salary_id,salary_row.employee_id,salary_row.salary_amount,salary_row.effective_date;
end loop;
close salary_cursor;

end;
/

--FOR LOOP/WHILE LOOP/ARRAY with extend() function

set serveroutput on
declare
cnt number;
first_name employee.first_name%type;
last_name employee.last_name%type;
type NAME_ARRAY1 is VARRAY(10) of employee.first_name%type;
F_NAME_ARRAY NAME_ARRAY1:=NAME_ARRAY1();
type NAME_ARRAY2 is VARRAY(10) of employee.last_name%type;
L_NAME_ARRAY NAME_ARRAY2:=NAME_ARRAY2();

begin
cnt:=1;
for x in 1..10
loop
select first_name,last_name into first_name,last_name from employee where employee_id=x;
F_NAME_ARRAY.extend();
L_NAME_ARRAY.extend();
F_NAME_ARRAY(cnt):=first_name;
L_NAME_ARRAY(cnt):=last_name;
cnt:= cnt+1;
end loop;
cnt:=1;
while cnt<=10
loop
dbms_output.put_line('First name: '||F_NAME_ARRAY(cnt)||' Last name: '||L_NAME_ARRAY(cnt)||' Full name: '||F_NAME_ARRAY(cnt)||' '||L_NAME_ARRAY(cnt));
cnt:=cnt+1;
end loop;
end;
/

--without extend()

set serveroutput on
declare
cnt number;
total_salary_cost number;
salary_amount salary.salary_amount%type;
type ARR is VARRAY(10) of salary.salary_amount%type;
S_AMM ARR:=ARR(0,0,0,0,0,0,0,0,0,0);

begin
total_salary_cost:=0;
cnt:=1;
for x in 1..10
loop
select salary_amount into salary_amount from salary where salary_id=x;
S_AMM(cnt):=salary_amount;
total_salary_cost:=total_salary_cost + S_AMM(cnt);
cnt:=cnt+1;
end loop;

dbms_output.put_line('Total cost for salary: '||total_salary_cost);
end;
/

--IF /ELSEIF /ELSE

set serveroutput on
declare
cnt number;
total_salary_cost number;
salary_amount salary.salary_amount%type;
type ARR is VARRAY(10) of salary.salary_amount%type;
S_AMM ARR:=ARR(0,0,0,0,0,0,0,0,0,0);

begin
cnt:=1;
for x in 1..10
loop
select salary_amount into salary_amount from salary where salary_id=x;
S_AMM(cnt):=salary_amount;
cnt:=cnt+1;
end loop;

cnt:=1;
while cnt<=10
LOOP
if S_AMM(cnt)<=4000
then 
S_AMM(cnt):=S_AMM(cnt)+1000;
dbms_output.put_line('Salary incremented 1000 taka. New salary: '||S_AMM(cnt));
else 
dbms_output.put_line('No incrementation done..');

end if;
cnt:=cnt+1;
END LOOP;

end;
/

--Procedure

create or replace Procedure leave_status(
    var1 in number,
    var2 out varchar2
)
as 
proc char(20);
begin
proc:='From procedure: ';
select status into var2 from leave where employee_id=var1;
dbms_output.put_line(proc||'The Employ no: '||var1||' Leave status: '||var2);
end;
/

set serveroutput on
declare
employee_id leave.employee_id%type:=7;
status leave.status%type;

begin
leave_status(employee_id,status);
end;
/

--Function

set serveroutput on
create or replace function l_stat(var1 in number) return varchar as 
value leave.status%type;
begin
select status into value from leave where employee_id=var1;
 return value;
 end;
 /

 set serveroutput on
 declare
 value varchar(20);
 begin
 value:=l_stat(7);
 end;
 /

 --Drop function or procedure
 drop procedure leave_status;
 drop function l_stat;

 --Thank you!! That's all for this database project 