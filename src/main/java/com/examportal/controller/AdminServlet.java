package com.examportal.controller;

import java.io.IOException;
import java.sql.SQLException;

import com.examportal.dao.ExamDAO;
import com.examportal.dao.FacultyDAO;
import com.examportal.dao.QuestionDAO;
import com.examportal.dao.ResultDAO;
import com.examportal.dao.StudentDAO;
import com.examportal.dao.UserDAO;
import com.examportal.model.User;
import com.examportal.util.SessionUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/admin/*")
public class AdminServlet extends HttpServlet {

    private final UserDAO userDAO = new UserDAO();
    private final StudentDAO studentDAO = new StudentDAO();
    private final FacultyDAO facultyDAO = new FacultyDAO();
    private final ExamDAO examDAO = new ExamDAO();
    private final QuestionDAO questionDAO = new QuestionDAO();
    private final ResultDAO resultDAO = new ResultDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        if (!SessionUtil.hasRole(request, "ADMIN")) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String pathInfo = request.getPathInfo();
        if (pathInfo == null) pathInfo = "/dashboard";

        switch (pathInfo) {
            case "/dashboard" -> showDashboard(request, response);
            case "/users" -> showUserManagement(request, response);
            case "/analytics" -> showAnalytics(request, response);
            case "/reports" -> showReports(request, response);
            default -> response.sendError(HttpServletResponse.SC_NOT_FOUND);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        if (!SessionUtil.hasRole(request, "ADMIN")) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String pathInfo = request.getPathInfo();
        if ("/toggleUserStatus".equals(pathInfo)) {
            toggleUserStatus(request, response);
        }
    }

    private void showDashboard(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        try {
            request.setAttribute("studentCount", studentDAO.countAllStudents());
            request.setAttribute("facultyCount", facultyDAO.countAllFaculty());
            request.setAttribute("examCount", examDAO.countAllExams());
            request.setAttribute("questionCount", questionDAO.countAllQuestions());
            request.setAttribute("attemptCount", resultDAO.countTotalAttempts());
            request.setAttribute("passedCount", resultDAO.countPassedStudents());
            java.util.List<User> users = userDAO.findAllUsers();
            request.setAttribute("recentUsers", users.subList(0, Math.min(5, users.size())));
            request.getRequestDispatcher("/admin/dashboard.jsp").forward(request, response);
        } catch (SQLException e) {
            System.err.println("Database error in AdminServlet.showDashboard: " + e.getMessage());
            e.printStackTrace();
            request.setAttribute("error", "An internal database error occurred. Please contact the administrator.");
            request.getRequestDispatcher("/error.jsp").forward(request, response);
        }
    }

    private void showUserManagement(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        try {
            request.setAttribute("users", userDAO.findAllUsers());
            request.setAttribute("students", studentDAO.findAllStudents());
            request.setAttribute("faculty", facultyDAO.findAllFaculty());
            request.getRequestDispatcher("/admin/userManagement.jsp").forward(request, response);
        } catch (SQLException e) {
            System.err.println("Database error in AdminServlet.showUserManagement: " + e.getMessage());
            e.printStackTrace();
            request.setAttribute("error", "An internal database error occurred. Please contact the administrator.");
            request.getRequestDispatcher("/error.jsp").forward(request, response);
        }
    }

    private void showAnalytics(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        try {
            request.setAttribute("examStats", resultDAO.getExamStatistics());
            request.setAttribute("resultStats", resultDAO.getOverallResultStatistics());
            request.setAttribute("results", resultDAO.findAllResults());
            request.getRequestDispatcher("/admin/analytics.jsp").forward(request, response);
        } catch (SQLException e) {
            System.err.println("Database error in AdminServlet.showAnalytics: " + e.getMessage());
            e.printStackTrace();
            request.setAttribute("error", "An internal database error occurred. Please contact the administrator.");
            request.getRequestDispatcher("/error.jsp").forward(request, response);
        }
    }

    private void showReports(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        try {
            request.setAttribute("exams", examDAO.findAllExams());
            request.setAttribute("results", resultDAO.findAllResults());
            request.setAttribute("students", studentDAO.findAllStudents());
            request.getRequestDispatcher("/admin/reports.jsp").forward(request, response);
        } catch (SQLException e) {
            System.err.println("Database error in AdminServlet.showReports: " + e.getMessage());
            e.printStackTrace();
            request.setAttribute("error", "An internal database error occurred. Please contact the administrator.");
            request.getRequestDispatcher("/error.jsp").forward(request, response);
        }
    }

    private void toggleUserStatus(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        try {
            long userId = Long.parseLong(request.getParameter("userId"));
            User user = userDAO.findById(userId);
            if (user != null) {
                user.setStatus("ACTIVE".equals(user.getStatus()) ? "SUSPENDED" : "ACTIVE");
                userDAO.updateUser(user);
                request.setAttribute("success", "User status updated");
            }
        } catch (SQLException e) {
            System.err.println("Database error in AdminServlet.toggleUserStatus: " + e.getMessage());
            e.printStackTrace();
            request.setAttribute("error", "An internal database error occurred. Please contact the administrator.");
        } catch (NumberFormatException e) {
            request.setAttribute("error", "Invalid user ID format.");
        }
        response.sendRedirect(request.getContextPath() + "/admin/users");
    }
}