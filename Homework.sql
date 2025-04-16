DROP TABLE Students;
DROP TABLE Courses;
DROP TABLE Enrollments;
DROP SEQUENCE seq_student_id;

-- 0.search SEQUENCE
SELECT seq_student_id.NEXTVAL FROM dual;
--  1. Tạo SEQUENCE
CREATE SEQUENCE seq_student_id START WITH 1 INCREMENT BY 1;
--  2. Tạo bảng Students (sử dụng sequence)
CREATE TABLE Students (
    student_id NUMBER PRIMARY KEY,
    name VARCHAR2(50),
    email VARCHAR2(100)
);
--  3. Tạo bảng Courses
CREATE TABLE Courses (
    course_id NUMBER PRIMARY KEY,
    course_name VARCHAR2(100),
    credit NUMBER CHECK (credit BETWEEN 1 AND 5) 
    -- one check clause 
    -- trong tiếng anh credit là tín chỉ
);
-- 🔹 4. Tạo bảng Enrollments (có khóa ngoại)
CREATE TABLE Enrollments (
    enrollment_id NUMBER PRIMARY KEY,
    student_id NUMBER,
    course_id NUMBER,
    grade CHAR(2),
    -- Có 2 ràng buộc khóa ngoại At least one foreign key
    FOREIGN KEY (student_id) REFERENCES Students(student_id),
    FOREIGN KEY (course_id) REFERENCES Courses(course_id)
);
-- ✅ Thêm dữ liệu (ít nhất 5 dòng mỗi bảng, có null)
-- 🔹 Students
INSERT INTO Students VALUES (seq_student_id.NEXTVAL, 'Nguyen Van A', 'a@example.com');
INSERT INTO Students VALUES (seq_student_id.NEXTVAL, 'Tran Thi B', NULL);
INSERT INTO Students VALUES (seq_student_id.NEXTVAL, 'Le Van C', 'c@example.com');
INSERT INTO Students VALUES (seq_student_id.NEXTVAL, 'Pham Thi D', NULL);
INSERT INTO Students VALUES (seq_student_id.NEXTVAL, 'Hoang Van E', 'e@example.com');
SELECT * FROM STUDENTS;
-- 🔹 Courses
INSERT INTO Courses VALUES (101, 'Math', NULL);
INSERT INTO Courses VALUES (102, 'Physics', 4);
INSERT INTO Courses VALUES (103, 'Chemistry', NULL);
INSERT INTO Courses VALUES (104, 'Biology', 2);
INSERT INTO Courses VALUES (105, 'English', 5);
SELECT * FROM COURSES;
-- 🔹 Enrollments
INSERT INTO Enrollments VALUES (1, 1, 101, 'A');
INSERT INTO Enrollments VALUES (2, 2, 102, NULL);
INSERT INTO Enrollments VALUES (3, 3, 103, 'B');
INSERT INTO Enrollments VALUES (4, 4, 104, NULL);
INSERT INTO Enrollments VALUES (5, 5, 105, 'C');
SELECT * FROM ENROLLMENTS;
-- ✅ Thực hiện 10 câu SQL
-- 1. Hiển thị tất cả bản ghi của Students
SELECT * FROM Students;
-- 2. Hiển thị tất cả bản ghi của Courses
SELECT * FROM Courses;
-- 3. Hiển thị tất cả bản ghi của Enrollments
SELECT * FROM Enrollments;
-- 4. Kiểm tra ràng buộc FOREIGN KEY 
SELECT * FROM Enrollments 
WHERE student_id NOT IN (SELECT student_id FROM Students)
   OR course_id NOT IN (SELECT course_id FROM Courses);
-- Câu lệnh này kiểm tra các bản ghi trong bảng Enrollments để tìm những bản ghi có khóa ngoại không hợp lệ. 
-- Cụ thể, nó tìm các bản ghi mà student_id không tồn tại trong bảng Students hoặc course_id không tồn tại trong bảng Courses.
-- Nếu có bản ghi nào không thỏa mãn các ràng buộc khóa ngoại, câu lệnh sẽ trả về những bản ghi đó.
-- 5. JOIN 3 bảng: Students, Enrollments, Courses
SELECT s.name, c.course_name, e.grade
FROM Students s
JOIN Enrollments e ON s.student_id = e.student_id
JOIN Courses c ON e.course_id = c.course_id;
-- 6. Sử dụng toán tử TẬP HỢP (SET OPERATOR - UNION)
SELECT name FROM Students WHERE student_id <= 2
UNION
SELECT name FROM Students WHERE student_id >= 4;
-- 7. Sử dụng IS NULL (tìm sinh viên chưa có email)
SELECT * FROM Students WHERE email IS NULL;
-- 8. Sử dụng ORDER BY (sắp xếp sinh viên theo tên)
SELECT * FROM Students ORDER BY name ASC;
-- 9. Tính tổng số sinh viên đăng ký cho mỗi môn học
SELECT c.course_name, COUNT(e.enrollment_id) AS total_students
FROM Courses c
LEFT JOIN Enrollments e ON c.course_id = e.course_id
GROUP BY c.course_name;
-- 10. Lấy tất cả học viên học môn có số tín chỉ >= 4
SELECT s.name, c.course_name
FROM Students s
JOIN Enrollments e ON s.student_id = e.student_id
JOIN Courses c ON e.course_id = c.course_id
WHERE c.credit >= 4;