package com.examportal.controller;

import com.examportal.model.User;
import com.examportal.util.SessionUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/student/dashboard")
public class StudentDashboardServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        User user = SessionUtil.getLoggedInUser(request);

        // ── Not logged in or wrong role → kick to login ──
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        if (!"STUDENT".equalsIgnoreCase(user.getRole())) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        request.setAttribute("user", user);
        request.setAttribute("fullName", user.getFullName());
        request.setAttribute("email", user.getEmail());

        // ── Adjust this path to wherever your dashboard.jsp actually lives ──
        // Common locations:
        //   Option A: request.getRequestDispatcher("/WEB-INF/views/student/dashboard.jsp")
        //   Option B: request.getRequestDispatcher("/student/dashboard.jsp")
        //   Option C: request.getRequestDispatcher("/dashboard.jsp")
        try {
            request.getRequestDispatcher("/WEB-INF/views/student/dashboard.jsp").forward(request, response);
        } catch (Exception e) {
            // Fallback: try webapp root
            try {
                request.getRequestDispatcher("/student/dashboard.jsp").forward(request, response);
            } catch (Exception e2) {
                System.err.println("[StudentDashboardServlet] Cannot find dashboard.jsp: " + e2.getMessage());
                response.sendError(404, "Dashboard page not found. Check JSP path in StudentDashboardServlet.");
            }
        }
    }
}
