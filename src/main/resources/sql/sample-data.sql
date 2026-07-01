-- Insert Categories
INSERT IGNORE INTO categories (category_id, name, description) VALUES 
(1, 'Java Programming', 'Core Java, OOP, Collections'),
(2, 'Database Management', 'SQL, Normalization, Transactions');

-- Insert Users (Password: password123)
-- BCrypt hash for 'password123' is below
INSERT IGNORE INTO users (user_id, email, password_hash, role, full_name, phone, status) VALUES 
(1, 'admin@exam.com', '$2a$10$N9qo8uLOickgx2ZMRZoMy.MrqDJKVZp8rUgJm6FqSvSbFqYJvKJkK', 'ADMIN', 'System Admin', '9876543210', 'ACTIVE'),
(2, 'superadmin@exam.com', '$2a$10$N9qo8uLOickgx2ZMRZoMy.MrqDJKVZp8rUgJm6FqSvSbFqYJvKJkK', 'ADMIN', 'Super Admin', '9876543219', 'ACTIVE'),
(3, 'faculty@exam.com', '$2a$10$N9qo8uLOickgx2ZMRZoMy.MrqDJKVZp8rUgJm6FqSvSbFqYJvKJkK', 'FACULTY', 'Dr. Rajesh Kumar', '9876543211', 'ACTIVE'),
(4, 'student@exam.com', '$2a$10$N9qo8uLOickgx2ZMRZoMy.MrqDJKVZp8rUgJm6FqSvSbFqYJvKJkK', 'STUDENT', 'John Doe', '9876543213', 'ACTIVE');

-- Insert Faculty
INSERT IGNORE INTO faculty (faculty_id, user_id, employee_id, department) VALUES 
(1, 3, 'FAC001', 'Computer Science');

-- Insert Student
INSERT IGNORE INTO students (student_id, user_id, roll_number, course, semester) VALUES 
(1, 4, 'CS2021001', 'B.Tech', 5);

-- Insert Questions
INSERT IGNORE INTO questions (question_id, category_id, created_by, question_text, option_a, option_b, option_c, option_d, correct_answer, marks, negative_marks) VALUES
(1, 1, 3, 'Which of the following is NOT a primitive data type in Java?', 'int', 'String', 'boolean', 'double', 'B', 1.00, 0.25),
(2, 1, 3, 'What is the size of int data type in Java?', '2 bytes', '4 bytes', '8 bytes', 'Depends on system', 'B', 1.00, 0.25),
(3, 1, 3, 'Which keyword is used to inherit a class in Java?', 'implements', 'inherits', 'extends', 'super', 'C', 1.00, 0.25),
(4, 1, 3, 'Which collection class allows duplicate elements?', 'Set', 'HashSet', 'ArrayList', 'TreeSet', 'C', 2.00, 0.50),
(5, 1, 3, 'What is the parent class of all classes in Java?', 'Object', 'Class', 'Super', 'Parent', 'A', 1.00, 0.25);

-- Insert Exam
INSERT IGNORE INTO exams (exam_id, title, description, category_id, created_by, total_questions, total_marks, duration_minutes, pass_percentage, negative_marking, randomize_questions, start_time, end_time, status) VALUES
(1, 'Java Fundamentals Test', 'Comprehensive test on Java basics', 1, 3, 5, 6.00, 10, 35.00, TRUE, TRUE, '2024-01-01 00:00:00', '2026-12-31 23:59:59', 'PUBLISHED');

-- Map Questions to Exam (Exam ID 1)
INSERT IGNORE INTO exam_questions (id, exam_id, question_id) VALUES 
(1, 1, 1), 
(2, 1, 2), 
(3, 1, 3), 
(4, 1, 4), 
(5, 1, 5);