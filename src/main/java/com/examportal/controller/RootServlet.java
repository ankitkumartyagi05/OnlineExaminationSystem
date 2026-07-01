package com.examportal.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

/**
 * Root servlet that redirects to index.jsp
 * Ensures landing page loads directly at root URL
 */
@WebServlet("/")
public class RootServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Redirect to index.jsp - faster than forward
        response.sendRedirect(request.getContextPath() + "/index.jsp");
    }
}
