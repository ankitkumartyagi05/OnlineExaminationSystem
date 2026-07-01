package com.examportal.controller;

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
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

/**
 * Admin dashboard servlet — restricted to ADMIN role
 * Displays system statistics and admin controls
 */
@WebServlet("/admin/dashboard")
public class AdminDashboardServlet extends HttpServlet {

    private final UserDAO userDAO = new UserDAO();
    private final StudentDAO studentDAO = new StudentDAO();
    private final FacultyDAO facultyDAO = new FacultyDAO();
    private final ExamDAO examDAO = new ExamDAO();
    private final QuestionDAO questionDAO = new QuestionDAO();
    private final ResultDAO resultDAO = new ResultDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        User user = (session != null) ? (User) session.getAttribute("loggedInUser") : null;

        if (user == null || !"ADMIN".equalsIgnoreCase(user.getRole())) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        request.setAttribute("user", user);
        request.setAttribute("fullName", user.getFullName());
        request.setAttribute("email", user.getEmail());

        try {
            request.setAttribute("studentCount", studentDAO.countAllStudents());
            request.setAttribute("facultyCount", facultyDAO.countAllFaculty());
            request.setAttribute("examCount", examDAO.countAllExams());
            request.setAttribute("questionCount", questionDAO.countAllQuestions());
            request.setAttribute("attemptCount", resultDAO.countTotalAttempts());
            request.setAttribute("passedCount", resultDAO.countPassedStudents());
            
            List<User> users = userDAO.findAllUsers();
            request.setAttribute("recentUsers", users.subList(0, Math.min(5, users.size())));
            
            request.getRequestDispatcher("/admin/dashboard.jsp").forward(request, response);
        } catch (SQLException e) {
            System.err.println("Database error in AdminDashboardServlet: " + e.getMessage());
            e.printStackTrace();
            request.setAttribute("error", "An internal database error occurred.");
            response.sendError(500, "Database error loading admin dashboard.");
        }
    }
}
