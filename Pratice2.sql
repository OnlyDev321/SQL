CREATE TABLE Secondtable (
    id char(13) PRIMARY KEY,
    name VARCHAR(30),
    height NUMBER(4,1)
);

INSERT into Secondtable 
VALUES('11','Hong Gildong',165.3);

DELETE from Secondtable
where id='11';

INSERT into SECONDTABLE
VALUES('12','hau',170.3);

drop table SECONDTABLE;

SELECT * FROM SECONDTABLE;

DESCRIBE SECONDTABLE;

SELECT * FROM tab;

show user;

TRUNCATE table SECONDTABLE;

SPOOL /Users/hau/Documents/WorkSpace/oracle/script/output.txt;
SELECT * FROM SECONDTABLE;
SPOOL OFF;
