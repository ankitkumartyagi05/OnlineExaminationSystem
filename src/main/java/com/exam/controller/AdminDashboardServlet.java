package com.exam.controller;

import com.exam.service.CandidateService;
import com.exam.service.QuestionService;
import com.exam.service.ResultService;
import com.exam.service.TestService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/admin")
public class AdminDashboardServlet extends HttpServlet {
    private final CandidateService candidateService = new CandidateService();
    private final QuestionService questionService = new QuestionService();
    private final TestService testService = new TestService();
    private final ResultService resultService = new ResultService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            request.setAttribute("totalCandidates", candidateService.getTotalCandidates());
            request.setAttribute("totalQuestions", questionService.getTotalQuestions());
            request.setAttribute("totalTests", testService.getActiveTestCount());
            request.setAttribute("totalResults", resultService.getTotalResults());
            request.setAttribute("subjects", questionService.getAllSubjects());
            request.setAttribute("recentResults", resultService.getAllResults().subList(0, Math.min(5, resultService.getAllResults().size())));
        } catch (Exception e) {
            request.setAttribute("totalCandidates", 0);
            request.setAttribute("totalQuestions", 0);
            request.setAttribute("totalTests", 0);
            request.setAttribute("totalResults", 0);
            request.setAttribute("subjects", java.util.Collections.emptyList());
            request.setAttribute("recentResults", java.util.Collections.emptyList());
        }
        request.getRequestDispatcher("/jsp/admin/dashboard.jsp").forward(request, response);
    }
}