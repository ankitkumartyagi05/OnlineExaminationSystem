// Placeholder
package com.exam.controller;

import com.exam.model.Candidate;
import com.exam.service.CandidateService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/register")
public class CandidateServlet extends HttpServlet {
    private final CandidateService candidateService = new CandidateService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("/jsp/register.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String name = request.getParameter("name");
        String rollNumber = request.getParameter("rollNumber");
        String email = request.getParameter("email");
        String mobile = request.getParameter("mobile");
        String college = request.getParameter("college");
        String course = request.getParameter("course");

        if (name == null || name.trim().isEmpty() || rollNumber == null || rollNumber.trim().isEmpty() ||
                email == null || email.trim().isEmpty() || mobile == null || mobile.trim().isEmpty() ||
                college == null || college.trim().isEmpty() || course == null || course.trim().isEmpty()) {
            request.setAttribute("error", "All fields are required.");
            request.getRequestDispatcher("/jsp/register.jsp").forward(request, response);
            return;
        }

        Candidate candidate = new Candidate(name.trim(), rollNumber.trim(), email.trim(), mobile.trim(), college.trim(), course.trim());

        try {
            int id = candidateService.register(candidate);
            if (id == -1) {
                request.setAttribute("error", "A candidate with this Roll Number already exists.");
                request.getRequestDispatcher("/jsp/register.jsp").forward(request, response);
                return;
            }
            candidate.setId(id);
            HttpSession session = request.getSession();
            session.setAttribute("candidate", candidate);
            response.sendRedirect(request.getContextPath() + "/tests");
        } catch (Exception e) {
            request.setAttribute("error", "Registration failed. Please try again.");
            request.getRequestDispatcher("/jsp/register.jsp").forward(request, response);
        }
    }
}