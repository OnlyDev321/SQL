CREATE TABLE employees (
    employee_id NUMBER,
    department_id NUMBER,
    name VARCHAR2(50),
    salary NUMBER
);

INSERT INTO employees VALUES (101, 10, 'An',    5000);
INSERT INTO employees VALUES (102, 10, 'Bình',  6000);
INSERT INTO employees VALUES (103, 10, 'Chi',   6000);
INSERT INTO employees VALUES (104, 20, 'Dũng',  7000);
INSERT INTO employees VALUES (105, 20, 'Em',    8000);

-- Dùng RANK() để xếp hạng lương theo từng phòng ban
SELECT employee_id, name, department_id, salary, RANK() 
OVER (PARTITION BY department_id ORDER BY salary DESC) AS rank_in_dept
FROM employees;
-- trong phòng ban 10 thì 6000 là cao nhất nhưng thằng chi và bình trùng nhau cho nên
-- thằng an nhảy tới rank thứ 3
-- trong phòng ban 11 thì thằng em cao hơn thằng dũng cho nên sắp thứ tự vậy là đúng 

-- giống ở trên nhưng dùng DENSE_RANK() để in thứ hạng liên tiếp ko bỏ qua số giống nhau
SELECT employee_id, name, department_id, salary, DENSE_RANK()
OVER (PARTITION BY department_id ORDER BY salary DESC) AS rank_in_dense
FROM EMPLOYEES;

-- Câu SQL này dùng để chia các nhân viên thành 3 nhóm (tiles) 
-- dựa theo lương (salary) giảm dần, bằng cách sử dụng hàm phân tích NTILE(3).
SELECT employee_id, name, salary,
       NTILE(3) OVER (ORDER BY salary DESC) AS salary_tile
FROM employees;