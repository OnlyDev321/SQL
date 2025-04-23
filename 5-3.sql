CREATE TABLE professor (
    pID NUMBER PRIMARY KEY,
    name VARCHAR2(20),
    salary number(8,2)
);

INSERT INTO professor
VALUES(10,'hau',2000);
INSERT INTO professor
VALUES(20,'hieu',3000);
INSERT INTO professor
VALUES(30,'nhi',2500);

-- toán tử <> là toán tử khác, tìm tên có salary = 3000 và pID khác 10
SELECT name 
from professor
where salary = 3000 AND pID <> 10;

-- tìm tên có tiền lương cao nhất trong professor
SELECT name
from PROFESSOR
where salary = (
    SELECT MAX(salary) FROM PROFESSOR
);

-- in ra name và salary có pID là 10,20,30
SELECT name,salary
FROM PROFESSOR 
where pID IN(10,20,30);

-- cách 2
SELECT name,salary 
FROM PROFESSOR 
where pID=10 or pID=20 or pID=30;


SELECT * FROM PROFESSOR;

-- table teacher
CREATE TABLE teacher (
    cID NUMBER PRIMARY key,
    semester NUMBER,
    year VARCHAR2(4),
    pID NUMBER
);

INSERT into teacher
VALUES(1,2,'2023',10);
INSERT into teacher 
VALUES(2,1,'2023',10);
INSERT into teacher 
VALUES(3,1,'2024',11);
INSERT into teacher 
VALUES(4,2,'2024',12);

SELECT * FROM teacher;
-- tìm tất cả các giáo sư có pID là 10, 20, 30 (distinct là không lặp lại)
SELECT COUNT(distinct pID) FROM TEACHER;


-- Chỉ lấy thông tin của professor có pID = 10, vì chỉ người này từng dạy trong bảng teacher.
-- 🔎 Với dữ liệu hiện tại:
-- 	•	teacher có pID: 10, 10, 11, 12
-- 	•	professor có pID: 10, 20, 30
-- → Kết quả trả về là: chỉ có giáo sư pID = 10 vì 10 tồn tại trong cả hai bảng.
SELECT *
FROM professor p
WHERE EXISTS (
    SELECT 1
    FROM teacher t
    WHERE t.pID = p.pID
);

--  Chọn name của professor có salary lớn hơn tất cả các giáo sư còn lại → chính là người lương cao nhất.
-- ✅ Cách 1: Dùng ALL trong so sánh
SELECT name
FROM PROFESSOR p
WHERE p.salary > ALL (
    select p2.salary
    from professor p2 
    where p2.pID <> p.PID
);

-- ✅ Cách 2: Mô phỏng “for all” bằng NOT EXISTS + phủ định điều kiện
SELECT p.name
FROM professor p
WHERE NOT EXISTS (
    SELECT *
    FROM professor p2
    WHERE p2.salary > p.salary
);

-- tìm tất cả tên giáo sư không bị trùng lặp trong bảng professor(dùng UNIQUE hay DISTINCT đều được)
SELECT UNIQUE name
FROM professor;
SELECT DISTINCT name
FROM professor;

-- dùng các hàm tổng hợp để tính toán các giá trị trong bảng professor
SELECT max(salary)
FROM professor;

SELECT min(salary)
FROM professor;

SELECT avg(salary)
FROM professor;

SELECT sum(salary)
FROM professor;

-- Câu lệnh sẽ trả về 2 giáo sư có mức lương thấp nhất trong bảng professor.
SELECT * 
FROM (
    SELECT * FROM professor ORDER BY salary 
) WHERE ROWNUM <= 2;

-- Câu lệnh sẽ trả về 2 giáo sư có mức lương cao nhất trong bảng professor.
SELECT * 
FROM (
    SELECT * FROM professor ORDER BY salary DESC
) WHERE ROWNUM <= 2;