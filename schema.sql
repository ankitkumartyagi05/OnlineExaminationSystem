CREATE DATABASE IF NOT EXISTS online_examination;
USE online_examination;

CREATE TABLE candidates (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    roll_number VARCHAR(50) NOT NULL UNIQUE,
    email VARCHAR(100) NOT NULL,
    mobile VARCHAR(15) NOT NULL,
    college VARCHAR(150) NOT NULL,
    course VARCHAR(100) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE questions (
    id INT AUTO_INCREMENT PRIMARY KEY,
    subject VARCHAR(100) NOT NULL,
    question TEXT NOT NULL,
    option_a VARCHAR(500) NOT NULL,
    option_b VARCHAR(500) NOT NULL,
    option_c VARCHAR(500) NOT NULL,
    option_d VARCHAR(500) NOT NULL,
    correct_answer VARCHAR(10) NOT NULL CHECK (correct_answer IN ('A','B','C','D')),
    marks INT NOT NULL DEFAULT 1,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE tests (
    id INT AUTO_INCREMENT PRIMARY KEY,
    test_name VARCHAR(200) NOT NULL,
    subject VARCHAR(100) NOT NULL,
    total_questions INT NOT NULL,
    total_marks INT NOT NULL,
    duration_minutes INT NOT NULL,
    pass_percentage DECIMAL(5,2) NOT NULL DEFAULT 40.00,
    status VARCHAR(20) NOT NULL DEFAULT 'ACTIVE',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE candidate_answers (
    id INT AUTO_INCREMENT PRIMARY KEY,
    candidate_id INT NOT NULL,
    test_id INT NOT NULL,
    question_id INT NOT NULL,
    selected_answer VARCHAR(10),
    is_correct TINYINT(1) DEFAULT 0,
    FOREIGN KEY (candidate_id) REFERENCES candidates(id),
    FOREIGN KEY (test_id) REFERENCES tests(id),
    FOREIGN KEY (question_id) REFERENCES questions(id)
);

CREATE TABLE results (
    id INT AUTO_INCREMENT PRIMARY KEY,
    candidate_id INT NOT NULL,
    test_id INT NOT NULL,
    exam_name VARCHAR(200) NOT NULL,
    total_questions INT NOT NULL,
    correct_answers INT NOT NULL,
    wrong_answers INT NOT NULL,
    marks_obtained DECIMAL(10,2) NOT NULL,
    total_marks DECIMAL(10,2) NOT NULL,
    percentage DECIMAL(5,2) NOT NULL,
    pass_fail VARCHAR(10) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (candidate_id) REFERENCES candidates(id),
    FOREIGN KEY (test_id) REFERENCES tests(id)
);

CREATE TABLE performance (
    id INT AUTO_INCREMENT PRIMARY KEY,
    candidate_id INT NOT NULL,
    subject VARCHAR(100) NOT NULL,
    attempts INT NOT NULL DEFAULT 0,
    highest_score DECIMAL(10,2) NOT NULL DEFAULT 0,
    average_score DECIMAL(10,2) NOT NULL DEFAULT 0,
    last_attempt_date TIMESTAMP NULL,
    FOREIGN KEY (candidate_id) REFERENCES candidates(id),
    UNIQUE KEY uk_candidate_subject (candidate_id, subject)
);

INSERT INTO questions (subject, question, option_a, option_b, option_c, option_d, correct_answer, marks) VALUES
('Java', 'What is the default value of a boolean variable in Java?', 'true', 'false', 'null', '0', 'B', 1),
('Java', 'Which keyword is used to inherit a class in Java?', 'implements', 'inherits', 'extends', 'super', 'C', 1),
('Java', 'Which of these is not a Java primitive type?', 'int', 'boolean', 'String', 'char', 'C', 1),
('Java', 'What does JVM stand for?', 'Java Variable Machine', 'Java Virtual Machine', 'Java Visual Machine', 'Java Verified Machine', 'B', 1),
('Java', 'Which collection class allows duplicate elements?', 'Set', 'HashSet', 'ArrayList', 'TreeSet', 'C', 1),
('Java', 'What is the size of an int variable in Java?', '16 bits', '32 bits', '64 bits', '8 bits', 'B', 1),
('Java', 'Which method is the entry point of a Java program?', 'start()', 'run()', 'main()', 'init()', 'C', 1),
('Java', 'Which of these is used to handle exceptions in Java?', 'try-catch', 'do-while', 'for-each', 'if-else', 'A', 1),
('Java', 'What is the parent class of all classes in Java?', 'Object', 'Class', 'Super', 'Main', 'A', 1),
('Java', 'Which keyword prevents a class from being inherited?', 'static', 'final', 'abstract', 'volatile', 'B', 1),
('DBMS', 'What does SQL stand for?', 'Structured Query Language', 'Simple Query Language', 'Sequential Query Language', 'Standard Query Language', 'A', 1),
('DBMS', 'Which command is used to retrieve data from a database?', 'GET', 'FETCH', 'SELECT', 'RETRIEVE', 'C', 1),
('DBMS', 'What is a Primary Key?', 'A key used for sorting', 'A unique identifier for each record', 'A foreign reference', 'An index key', 'B', 1),
('DBMS', 'Which SQL clause is used to filter records?', 'GROUP BY', 'HAVING', 'WHERE', 'ORDER BY', 'C', 1),
('DBMS', 'What is a Foreign Key?', 'A key from another table', 'A key to join tables', 'A reference to primary key of another table', 'A backup key', 'C', 1),
('DBMS', 'Which command is used to remove all records from a table without logging?', 'DELETE', 'REMOVE', 'TRUNCATE', 'DROP', 'C', 1),
('DBMS', 'What does DBMS stand for?', 'Database Management System', 'Data Backup Management System', 'Database Manipulation System', 'Data Management Storage', 'A', 1),
('DBMS', 'Which JOIN returns all records from both tables?', 'INNER JOIN', 'LEFT JOIN', 'RIGHT JOIN', 'FULL OUTER JOIN', 'D', 1),
('DBMS', 'Which normal form eliminates transitive dependency?', '1NF', '2NF', '3NF', 'BCNF', 'C', 1),
('Python', 'Which of these is used to define a function in Python?', 'function', 'func', 'def', 'define', 'C', 1),
('Python', 'What is the output of type(1)?', 'int', 'integer', 'number', 'str', 'A', 1),
('Python', 'Which data structure is immutable in Python?', 'List', 'Dictionary', 'Set', 'Tuple', 'D', 1),
('Python', 'What does pip stand for?', 'Python Install Packages', 'Pip Installs Packages', 'Package Installer for Python', 'Python Integration Platform', 'B', 1),
('Python', 'Which keyword is used for exception handling in Python?', 'catch', 'handle', 'except', 'throw', 'C', 1),
('Python', 'What is the output of len([1,2,3])?', '2', '3', '4', 'Error', 'B', 1),
('Python', 'Which loop is used to iterate over a sequence?', 'for', 'while', 'do-while', 'foreach', 'A', 1),
('Python', 'What is a lambda function in Python?', 'Named function', 'Anonymous function', 'Recursive function', 'Built-in function', 'B', 1),
('Python', 'Which method adds an element to the end of a list?', 'insert()', 'add()', 'append()', 'push()', 'C', 1);

INSERT INTO tests (test_name, subject, total_questions, total_marks, duration_minutes, pass_percentage, status) VALUES
('Java Fundamentals Assessment', 'Java', 10, 10, 15, 40.00, 'ACTIVE'),
('Database Management Systems Test', 'DBMS', 10, 10, 15, 40.00, 'ACTIVE'),
('Python Programming Assessment', 'Python', 10, 10, 15, 40.00, 'ACTIVE');