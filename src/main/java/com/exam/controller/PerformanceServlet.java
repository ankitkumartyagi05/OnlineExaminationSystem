// Placeholder
package com.exam.controller;

import com.exam.model.Candidate;
import com.exam.model.Performance;
import com.exam.model.Result;
import com.exam.service.PerformanceService;
import com.exam.service.ResultService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

@WebServlet("/performance")
public class PerformanceServlet extends HttpServlet {
    private final ResultService resultService = new ResultService();
    private final PerformanceService performanceService = new PerformanceService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        Candidate candidate = (Candidate) session.getAttribute("candidate");

        if (candidate == null) {
            response.sendRedirect(request.getContextPath() + "/register");
            return;
        }

        try {
            List<Result> results = resultService.getCandidateResults(candidate.getId());
            List<Performance> performances = performanceService.getCandidatePerformance(candidate.getId());

            StringBuilder subjectsJson = new StringBuilder("[");
            StringBuilder highestJson = new StringBuilder("[");
            StringBuilder averageJson = new StringBuilder("[");
            StringBuilder attemptsJson = new StringBuilder("[");

            for (int i = 0; i < performances.size(); i++) {
                Performance p = performances.get(i);
                if (i > 0) {
                    subjectsJson.append(",");
                    highestJson.append(",");
                    averageJson.append(",");
                    attemptsJson.append(",");
                }
                subjectsJson.append("\"").append(p.getSubject()).append("\"");
                highestJson.append(p.getHighestScore());
                averageJson.append(p.getAverageScore());
                attemptsJson.append(p.getAttempts());
            }
            subjectsJson.append("]");
            highestJson.append("]");
            averageJson.append("]");
            attemptsJson.append("]");

            StringBuilder historyLabels = new StringBuilder("[");
            StringBuilder historyData = new StringBuilder("[");
            for (int i = 0; i < results.size(); i++) {
                Result r = results.get(i);
                if (i > 0) {
                    historyLabels.append(",");
                    historyData.append(",");
                }
                historyLabels.append("\"").append(r.getExamName()).append("\"");
                historyData.append(r.getPercentage());
            }
            historyLabels.append("]");
            historyData.append("]");

            request.setAttribute("results", results);
            request.setAttribute("performances", performances);
            request.setAttribute("subjectsJson", subjectsJson.toString());
            request.setAttribute("highestJson", highestJson.toString());
            request.setAttribute("averageJson", averageJson.toString());
            request.setAttribute("attemptsJson", attemptsJson.toString());
            request.setAttribute("historyLabels", historyLabels.toString());
            request.setAttribute("historyData", historyData.toString());

        } catch (Exception e) {
            request.setAttribute("results", java.util.Collections.emptyList());
            request.setAttribute("performances", java.util.Collections.emptyList());
            request.setAttribute("subjectsJson", "[]");
            request.setAttribute("highestJson", "[]");
            request.setAttribute("averageJson", "[]");
            request.setAttribute("attemptsJson", "[]");
            request.setAttribute("historyLabels", "[]");
            request.setAttribute("historyData", "[]");
        }

        request.getRequestDispatcher("/jsp/performance.jsp").forward(request, response);
    }
}