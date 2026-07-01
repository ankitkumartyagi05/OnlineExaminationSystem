package com.examportal.controller;

import com.examportal.model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

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
            request.getRequestDispatcher("/WEB-INF/views/faculty/dashboard.jsp").forward(request, response);
        } catch (Exception e) {
            try {
                request.getRequestDispatcher("/faculty/dashboard.jsp").forward(request, response);
            } catch (Exception e2) {
                System.err.println("[FacultyDashboardServlet] Cannot find dashboard.jsp: " + e2.getMessage());
                response.sendError(404, "Dashboard page not found. Check JSP path in FacultyDashboardServlet.");
            }
        }
    }
}
