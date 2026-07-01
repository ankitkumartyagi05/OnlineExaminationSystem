package com.examportal.controller;

import com.examportal.model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

/**
 * Faculty dashboard servlet — restricted to FACULTY role
 */
@WebServlet("/faculty/dashboard")
public class FacultyDashboardServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        User user = (session != null) ? (User) session.getAttribute("loggedInUser") : null;

        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        if (!"FACULTY".equalsIgnoreCase(user.getRole())) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        request.setAttribute("user", user);
        request.setAttribute("fullName", user.getFullName());
        request.setAttribute("email", user.getEmail());

        try {
            request.getRequestDispatcher("/faculty/dashboard.jsp").forward(request, response);
        } catch (Exception e) {
            System.err.println("[FacultyDashboardServlet] Error loading dashboard: " + e.getMessage());
            e.printStackTrace();
            response.sendError(500, "Error loading faculty dashboard.");
        }
    }
}
