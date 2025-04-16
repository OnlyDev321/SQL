-- Table student
CREATE TABLE student (
    pID CHAR(13) PRIMARY KEY,
    name VARCHAR2(30),
    deptName VARCHAR2(30),
    salary CHAR(13)
);

INSERT into student
VALUES ('10','LEE','CS','8000');
INSERT into student 
VALUES ('11','choi','CS','7000');
INSERT into student 
VALUES('13','yoon','CS','6000');
INSERT into student
VALUES('21','Yang','EE','7000');
INSERT into student 
VALUES('22','PARK','EE','6000');
INSERT into STUDENT
VALUES('31','Han','Media','9000');
INSERT into STUDENT
VALUES('32','Palk','Media','6000');

-- table professor
CREATE TABLE professor(
    deptName VARCHAR2(30),
    count NUMBER(1)
);

insert into professor
VALUES('CS',3);
insert into professor
VALUES('EE',2);
insert into professor
VALUES('media',2);

-- table professor2
CREATE TABLE professor2(
    deptName VARCHAR2(30),
    avg_salary CHAR(13)
);

insert into professor2 
VALUES('CS','7000');
insert into professor2
VALUES('EE','6500');
insert into professor2
VALUES('Media','7500');

-- delete 1 data in table with primary key
DELETE FROM student
where pID = '32';

SELECT * FROM STUDENT;
SELECT * FROM professor;
SELECT * FROM professor2;

-- find salary in table professor2
SELECT deptName FROM professor2 WHERE TO_NUMBER(avg_salary) > 6900;
-- TO_NUMBER(avg_salary) dùng để ép kiểu từ CHAR(13) sang kiểu số, vì cột avg_salary được định nghĩa là CHAR(13).