package com.examportal.service;

import java.sql.SQLException;

import com.examportal.dao.FacultyDAO;
import com.examportal.dao.StudentDAO;
import com.examportal.dao.UserDAO;
import com.examportal.model.Faculty;
import com.examportal.model.Student;
import com.examportal.model.User;
import com.examportal.util.PasswordUtil;
import com.examportal.util.ValidationUtil;

public class AuthService {

    private final UserDAO userDAO = new UserDAO();
    private final StudentDAO studentDAO = new StudentDAO();
    private final FacultyDAO facultyDAO = new FacultyDAO();

    public User login(String email, String password) throws SQLException, Exception {
        if (!ValidationUtil.isValidEmail(email)) throw new Exception("Invalid email format");
        
        User user = userDAO.findByEmail(email);
        if (user == null) throw new Exception("User not found");
        if (!PasswordUtil.verifyPassword(password, user.getPasswordHash())) throw new Exception("Invalid password");
        
        return user;
    }

    public User register(String email, String password, String fullName, String role, String phone,
                         String rollNumber, String course, String branch, Integer semester, Integer year,
                         String employeeId, String department, String designation, String specialization)
            throws SQLException, Exception {
        if (!ValidationUtil.isValidEmail(email)) throw new Exception("Invalid email format");
        if (!ValidationUtil.isValidPassword(password)) throw new Exception("Password must be 8+ chars, with uppercase, lowercase, digit, and special char");
        if (!ValidationUtil.isNotEmpty(fullName)) throw new Exception("Full name is required");
        if (!ValidationUtil.isNotEmpty(role)) throw new Exception("Role is required");

        if ("FACULTY".equalsIgnoreCase(role)) {
            return registerFaculty(email, password, fullName, phone, employeeId, department, designation, specialization);
        }
        if ("STUDENT".equalsIgnoreCase(role)) {
            return registerStudent(email, password, fullName, phone, rollNumber, course, branch, semester);
        }

        throw new Exception("Unsupported role: " + role);
    }

    public User registerStudent(String email, String password, String fullName, String phone, 
                                String rollNumber, String course, String branch, Integer semester) throws SQLException, Exception {
        
        if (!ValidationUtil.isValidEmail(email)) throw new Exception("Invalid email format");
        if (!ValidationUtil.isValidPassword(password)) throw new Exception("Password must be 8+ chars, with uppercase, lowercase, digit, and special char");
        if (!ValidationUtil.isNotEmpty(fullName)) throw new Exception("Full name is required");
        if (!ValidationUtil.isNotEmpty(rollNumber)) throw new Exception("Roll number is required");

        User user = new User();
        user.setEmail(email);
        user.setPasswordHash(PasswordUtil.hashPassword(password));
        user.setRole("STUDENT");
        user.setFullName(fullName);
        user.setPhone(phone);
        user.setStatus("ACTIVE");
        
        Long userId = userDAO.createUser(user);
        user.setUserId(userId);

        Student student = new Student();
        student.setUserId(userId);
        student.setRollNumber(rollNumber);
        student.setCourse(course);
        student.setSemester(semester);
        studentDAO.createStudent(student);

        return user;
    }

    public User registerFaculty(String email, String password, String fullName, String phone,
                                String employeeId, String department, String designation, String specialization)
            throws SQLException, Exception {
        if (!ValidationUtil.isValidEmail(email)) throw new Exception("Invalid email format");
        if (!ValidationUtil.isValidPassword(password)) throw new Exception("Password must be 8+ chars, with uppercase, lowercase, digit, and special char");
        if (!ValidationUtil.isNotEmpty(fullName)) throw new Exception("Full name is required");
        if (!ValidationUtil.isNotEmpty(employeeId)) throw new Exception("Employee ID is required");

        User user = new User();
        user.setEmail(email);
        user.setPasswordHash(PasswordUtil.hashPassword(password));
        user.setRole("FACULTY");
        user.setFullName(fullName);
        user.setPhone(phone);
        user.setStatus("ACTIVE");

        Long userId = userDAO.createUser(user);
        user.setUserId(userId);

        Faculty faculty = new Faculty();
        faculty.setUserId(userId);
        faculty.setEmployeeId(employeeId);
        faculty.setDepartment(department);
        faculty.setDesignation(designation);
        faculty.setSpecialization(specialization);
        facultyDAO.createFaculty(faculty);

        return user;
    }
}