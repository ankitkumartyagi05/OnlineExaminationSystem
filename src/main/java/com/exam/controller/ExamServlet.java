// Placeholder
package com.exam.controller;

import com.exam.model.Candidate;
import com.exam.model.Question;
import com.exam.model.Result;
import com.exam.model.Test;
import com.exam.service.PerformanceService;
import com.exam.service.QuestionService;
import com.exam.service.ResultService;
import com.exam.service.TestService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@WebServlet({"/instructions", "/start-exam", "/submit-exam"})
public class ExamServlet extends HttpServlet {
    private final TestService testService = new TestService();
    private final QuestionService questionService = new QuestionService();
    private final ResultService resultService = new ResultService();
    private final PerformanceService performanceService = new PerformanceService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String path = request.getServletPath();
        HttpSession session = request.getSession();
        Candidate candidate = (Candidate) session.getAttribute("candidate");

        if (candidate == null) {
            response.sendRedirect(request.getContextPath() + "/register");
            return;
        }

        try {
            if ("/instructions".equals(path)) {
                int testId = Integer.parseInt(request.getParameter("testId"));
                Test test = testService.getTestById(testId);
                if (test == null || !"ACTIVE".equals(test.getStatus())) {
                    response.sendRedirect(request.getContextPath() + "/tests");
                    return;
                }
                int availableQuestions = questionService.getQuestionCountBySubject(test.getSubject());
                if (availableQuestions < test.getTotalQuestions()) {
                    request.setAttribute("error", "Not enough questions available for this test.");
                    response.sendRedirect(request.getContextPath() + "/tests");
                    return;
                }
                Result existingResult = resultService.getResult(candidate.getId(), testId);
                if (existingResult != null) {
                    session.setAttribute("result", existingResult);
                    response.sendRedirect(request.getContextPath() + "/result");
                    return;
                }
                request.setAttribute("test", test);
                request.setAttribute("availableQuestions", availableQuestions);
                request.getRequestDispatcher("/jsp/instructions.jsp").forward(request, response);

            } else if ("/start-exam".equals(path)) {
                int testId = Integer.parseInt(request.getParameter("testId"));
                Test test = testService.getTestById(testId);
                if (test == null) {
                    response.sendRedirect(request.getContextPath() + "/tests");
                    return;
                }
                Result existingResult = resultService.getResult(candidate.getId(), testId);
                if (existingResult != null) {
                    session.setAttribute("result", existingResult);
                    response.sendRedirect(request.getContextPath() + "/result");
                    return;
                }
                List<Question> questions = questionService.getRandomQuestions(test.getSubject(), test.getTotalQuestions());
                if (questions.size() < test.getTotalQuestions()) {
                    response.sendRedirect(request.getContextPath() + "/tests");
                    return;
                }
                session.setAttribute("examTest", test);
                session.setAttribute("examQuestions", questions);
                session.setAttribute("examStartTime", System.currentTimeMillis());
                request.getRequestDispatcher("/jsp/exam.jsp").forward(request, response);
            }
        } catch (Exception e) {
            response.sendRedirect(request.getContextPath() + "/tests");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        if (!"/submit-exam".equals(request.getServletPath())) {
            response.sendRedirect(request.getContextPath() + "/tests");
            return;
        }

        HttpSession session = request.getSession();
        Candidate candidate = (Candidate) session.getAttribute("candidate");
        Test test = (Test) session.getAttribute("examTest");
        @SuppressWarnings("unchecked")
        List<Question> questions = (List<Question>) session.getAttribute("examQuestions");

        if (candidate == null || test == null || questions == null) {
            response.sendRedirect(request.getContextPath() + "/tests");
            return;
        }

        try {
            Map<Integer, String> answers = new HashMap<>();
            for (Question q : questions) {
                String ans = request.getParameter("answer_" + q.getId());
                if (ans != null && !ans.trim().isEmpty()) {
                    answers.put(q.getId(), ans.trim().toUpperCase());
                }
            }

            Result result = resultService.evaluateAndSave(candidate.getId(), test, questions, answers);
            result.setCandidateName(candidate.getName());
            result.setRollNumber(candidate.getRollNumber());
            performanceService.updatePerformance(result);

            session.removeAttribute("examTest");
            session.removeAttribute("examQuestions");
            session.removeAttribute("examStartTime");
            session.setAttribute("result", result);

            response.sendRedirect(request.getContextPath() + "/result");
        } catch (Exception e) {
            request.setAttribute("error", "Error submitting exam. Please contact administrator.");
            request.getRequestDispatcher("/jsp/exam.jsp").forward(request, response);
        }
    }
}