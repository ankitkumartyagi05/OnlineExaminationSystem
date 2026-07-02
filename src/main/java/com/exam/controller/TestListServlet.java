// Placeholder
package com.exam.controller;

import com.exam.model.Candidate;
import com.exam.model.Test;
import com.exam.service.TestService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

@WebServlet("/tests")
public class TestListServlet extends HttpServlet {
    private final TestService testService = new TestService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        if (session.getAttribute("candidate") == null) {
            response.sendRedirect(request.getContextPath() + "/register");
            return;
        }
        try {
            List<Test> tests = testService.getActiveTests();
            request.setAttribute("tests", tests);
        } catch (Exception e) {
            request.setAttribute("tests", java.util.Collections.emptyList());
        }
        request.getRequestDispatcher("/jsp/available-tests.jsp").forward(request, response);
    }
}