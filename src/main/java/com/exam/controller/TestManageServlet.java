package com.exam.controller;

import com.exam.model.Test;
import com.exam.service.QuestionService;
import com.exam.service.TestService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.math.BigDecimal;
import java.util.List;

@WebServlet({"/admin/tests", "/admin/add-test", "/admin/delete-test", "/admin/toggle-test"})
public class TestManageServlet extends HttpServlet {
    private final TestService testService = new TestService();
    private final QuestionService questionService = new QuestionService();

    private void setSubjectsAndCounts(HttpServletRequest request) throws Exception {
        List<String> subjects = questionService.getAllSubjects();
        request.setAttribute("subjects", subjects);
        
        java.util.Map<String, Integer> subjectCounts = new java.util.HashMap<>();
        for (String sub : subjects) {
            subjectCounts.put(sub, questionService.getQuestionCountBySubject(sub));
        }
        request.setAttribute("subjectCounts", subjectCounts);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String path = request.getServletPath();

        try {
            if ("/admin/tests".equals(path)) {
                List<Test> tests = testService.getAllTests();
                request.setAttribute("tests", tests);
                request.getRequestDispatcher("/jsp/admin/manage-tests.jsp").forward(request, response);

            } else if ("/admin/add-test".equals(path)) {
                setSubjectsAndCounts(request);
                request.getRequestDispatcher("/jsp/admin/add-test.jsp").forward(request, response);

            } else if ("/admin/delete-test".equals(path)) {
                int id = Integer.parseInt(request.getParameter("id"));
                testService.deleteTest(id);
                response.sendRedirect(request.getContextPath() + "/admin/tests?deleted=true");

            } else if ("/admin/toggle-test".equals(path)) {
                int id = Integer.parseInt(request.getParameter("id"));
                testService.toggleTestStatus(id);
                response.sendRedirect(request.getContextPath() + "/admin/tests?toggled=true");
            }
        } catch (Exception e) {
            response.sendRedirect(request.getContextPath() + "/admin/tests");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        if (!"/admin/add-test".equals(request.getServletPath())) {
            response.sendRedirect(request.getContextPath() + "/admin/tests");
            return;
        }

        try {
            String testName = request.getParameter("testName");
            String subject = request.getParameter("subject");
            String totalQuestionsParam = request.getParameter("totalQuestions");
            String durationParam = request.getParameter("durationMinutes");
            String passPercentageParam = request.getParameter("passPercentage");

            if (testName == null || testName.trim().isEmpty() || subject == null || subject.trim().isEmpty() ||
                    totalQuestionsParam == null || totalQuestionsParam.trim().isEmpty() ||
                    durationParam == null || durationParam.trim().isEmpty()) {
                request.setAttribute("error", "All fields are required.");
                setSubjectsAndCounts(request);
                request.getRequestDispatcher("/jsp/admin/add-test.jsp").forward(request, response);
                return;
            }

            int totalQuestions = Integer.parseInt(totalQuestionsParam.trim());
            int duration = Integer.parseInt(durationParam.trim());
            double passPercentage = passPercentageParam != null && !passPercentageParam.trim().isEmpty() ?
                    Double.parseDouble(passPercentageParam.trim()) : 40.0;

            Test t = new Test();
            t.setTestName(testName.trim());
            t.setSubject(subject.trim());
            t.setTotalQuestions(totalQuestions);
            t.setTotalMarks(totalQuestions);
            t.setDurationMinutes(duration);
            t.setPassPercentage(BigDecimal.valueOf(passPercentage).setScale(2, java.math.RoundingMode.HALF_UP));
            t.setStatus("ACTIVE");

            testService.createTest(t);
            response.sendRedirect(request.getContextPath() + "/admin/tests?added=true");
        } catch (Exception e) {
            request.setAttribute("error", "Failed to create test. Check your inputs.");
            try {
                setSubjectsAndCounts(request);
            } catch (Exception ex) { /* ignore */ }
            request.getRequestDispatcher("/jsp/admin/add-test.jsp").forward(request, response);
        }
    }
}