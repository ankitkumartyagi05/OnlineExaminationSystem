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

@WebServlet("/login")
public class LoginServlet extends HttpServlet {

    private final AuthService authService = new AuthService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        if (SessionUtil.isLoggedIn(request)) {
            redirectToDashboard(request, response);
            return;
        }
        request.getRequestDispatcher("/login.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        try {
            User user = authService.login(email, password);
            SessionUtil.createUserSession(request, user);
            redirectToDashboard(request, response);
        } catch (SQLException e) {
            System.err.println("Database error during login: " + e.getMessage());
            e.printStackTrace();
            request.setAttribute("error", "An internal database error occurred. Please try again later.");
            request.setAttribute("email", email);
            request.getRequestDispatcher("/login.jsp").forward(request, response);
        } catch (Exception e) {
            request.setAttribute("error", e.getMessage());
            request.setAttribute("email", email);
            request.getRequestDispatcher("/login.jsp").forward(request, response);
        }
    }

    private void redirectToDashboard(HttpServletRequest request, HttpServletResponse response) 
            throws IOException {
        User user = SessionUtil.getCurrentUser(request);
        String contextPath = request.getContextPath();
        switch (user.getRole()) {
            case "ADMIN":
                response.sendRedirect(contextPath + "/admin/dashboard");
                break;
            case "FACULTY":
                response.sendRedirect(contextPath + "/faculty/dashboard");
                break;
            case "STUDENT":
                response.sendRedirect(contextPath + "/student/dashboard");
                break;
            default:
                response.sendRedirect(contextPath + "/login");
        }
    }
}