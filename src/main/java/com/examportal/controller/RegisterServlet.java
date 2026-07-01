package com.examportal.controller;

import com.examportal.model.User;
import com.examportal.service.AuthService;
import com.examportal.util.SessionUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {

    private final AuthService authService = new AuthService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        request.getRequestDispatcher("/register.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {

        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String fullName = request.getParameter("fullName");
        String role = request.getParameter("role");
        String phone = request.getParameter("phone");

        // Student-specific fields
        String rollNumber = request.getParameter("rollNumber");
        String course = request.getParameter("course");
        String branch = request.getParameter("branch");
        String semesterStr = request.getParameter("semester");
        String yearStr = request.getParameter("yearOfAdmission");

        // Faculty-specific fields
        String employeeId = request.getParameter("employeeId");
        String department = request.getParameter("department");
        String designation = request.getParameter("designation");
        String specialization = request.getParameter("specialization");

        Integer semester = null;
        Integer year = null;
        if (semesterStr != null && !semesterStr.trim().isEmpty()) {
            semester = Integer.parseInt(semesterStr);
        }
        if (yearStr != null && !yearStr.trim().isEmpty()) {
            year = Integer.parseInt(yearStr);
        }

        try {
            User user = authService.register(email, password, fullName, role, phone,
                rollNumber, course, branch, semester, year,
                employeeId, department, designation, specialization);
            SessionUtil.createUserSession(request, user);

            String contextPath = request.getContextPath();
            switch (user.getRole()) {
                case "FACULTY":
                    response.sendRedirect(contextPath + "/faculty/dashboard");
                    break;
                case "STUDENT":
                    response.sendRedirect(contextPath + "/student/dashboard");
                    break;
                default:
                    response.sendRedirect(contextPath + "/login");
            }
        } catch (SQLException e) {
            System.err.println("Database error during registration: " + e.getMessage());
            e.printStackTrace();
            request.setAttribute("error", "An internal database error occurred. Please try again later.");
            preserveFormData(request, email, fullName, role, phone, rollNumber, course, 
                branch, semesterStr, yearStr, employeeId, department, designation, specialization);
            request.getRequestDispatcher("/register.jsp").forward(request, response);
        } catch (Exception e) {
            System.err.println("Error during registration: " + e.getMessage());
            e.printStackTrace();
            request.setAttribute("error", e.getMessage());
            preserveFormData(request, email, fullName, role, phone, rollNumber, course, 
                branch, semesterStr, yearStr, employeeId, department, designation, specialization);
            request.getRequestDispatcher("/register.jsp").forward(request, response);
        }
    }

    private void preserveFormData(HttpServletRequest request, String email, String fullName, 
            String role, String phone, String rollNumber, String course, String branch, 
            String semesterStr, String yearStr, String employeeId, String department, 
            String designation, String specialization) {
        request.setAttribute("email", email);
        request.setAttribute("fullName", fullName);
        request.setAttribute("role", role);
        request.setAttribute("phone", phone);
        request.setAttribute("rollNumber", rollNumber);
        request.setAttribute("course", course);
        request.setAttribute("branch", branch);
        request.setAttribute("semester", semesterStr);
        request.setAttribute("yearOfAdmission", yearStr);
        request.setAttribute("employeeId", employeeId);
        request.setAttribute("department", department);
        request.setAttribute("designation", designation);
        request.setAttribute("specialization", specialization);
    }
}