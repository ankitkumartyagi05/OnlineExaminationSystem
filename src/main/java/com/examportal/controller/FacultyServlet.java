package com.examportal.controller;

import com.examportal.dao.FacultyDAO;
import com.examportal.dao.QuestionDAO;
import com.examportal.model.Faculty;
import com.examportal.model.User;
import com.examportal.service.ExamService;
import com.examportal.util.SessionUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.Arrays;
import java.util.List;
import java.util.stream.Collectors;

@WebServlet("/faculty/*")
public class FacultyServlet extends HttpServlet {

    private final FacultyDAO facultyDAO = new FacultyDAO();
    private final ExamService examService = new ExamService();
    private final QuestionDAO questionDAO = new QuestionDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        if (!SessionUtil.hasRole(request, "FACULTY")) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String pathInfo = request.getPathInfo();
        if (pathInfo == null)
            pathInfo = "/dashboard";

        switch (pathInfo) {
            case "/dashboard":
                showDashboard(request, response);
                break;
            case "/createExam":
                showCreateExam(request, response);
                break;
            case "/manageExam":
                showManageExam(request, response);
                break;
            case "/questionBank":
                showQuestionBank(request, response);
                break;
            case "/reports":
                showReports(request, response);
                break;
            default:
                response.sendError(HttpServletResponse.SC_NOT_FOUND);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        if (!SessionUtil.hasRole(request, "FACULTY")) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String pathInfo = request.getPathInfo();
        if ("/createExam".equals(pathInfo)) {
            createExam(request, response);
        } else if ("/deleteExam".equals(pathInfo)) {
            deleteExam(request, response);
        }
    }

    private void showDashboard(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            User user = SessionUtil.getCurrentUser(request);
            Faculty faculty = facultyDAO.findByUserId(user.getUserId());
            request.setAttribute("faculty", faculty);
            request.setAttribute("exams", examService.getExamsByCreator(user.getUserId()));
            request.setAttribute("questions", questionDAO.findByCreator(user.getUserId()));
            request.getRequestDispatcher("/faculty/dashboard.jsp").forward(request, response);
        } catch (Exception e) {
            request.setAttribute("error", "Error: " + e.getMessage());
            request.getRequestDispatcher("/error.jsp").forward(request, response);
        }
    }

    private void showCreateExam(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            request.setAttribute("categories", questionDAO.findAllCategories());
            User user = SessionUtil.getCurrentUser(request);
            request.setAttribute("questions", questionDAO.findByCreator(user.getUserId()));
            request.getRequestDispatcher("/faculty/createExam.jsp").forward(request, response);
        } catch (Exception e) {
            request.setAttribute("error", "Error: " + e.getMessage());
            request.getRequestDispatcher("/error.jsp").forward(request, response);
        }
    }

    private void showManageExam(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            User user = SessionUtil.getCurrentUser(request);
            request.setAttribute("exams", examService.getExamsByCreator(user.getUserId()));
            request.getRequestDispatcher("/faculty/manageExam.jsp").forward(request, response);
        } catch (Exception e) {
            request.setAttribute("error", "Error: " + e.getMessage());
            request.getRequestDispatcher("/error.jsp").forward(request, response);
        }
    }

    private void showQuestionBank(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            User user = SessionUtil.getCurrentUser(request);
            request.setAttribute("questions", questionDAO.findByCreator(user.getUserId()));
            request.setAttribute("categories", questionDAO.findAllCategories());
            request.getRequestDispatcher("/faculty/questionBank.jsp").forward(request, response);
        } catch (Exception e) {
            request.setAttribute("error", "Error: " + e.getMessage());
            request.getRequestDispatcher("/error.jsp").forward(request, response);
        }
    }

    private void showReports(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            User user = SessionUtil.getCurrentUser(request);
            request.setAttribute("exams", examService.getExamsByCreator(user.getUserId()));
            request.getRequestDispatcher("/faculty/reports.jsp").forward(request, response);
        } catch (Exception e) {
            request.setAttribute("error", "Error: " + e.getMessage());
            request.getRequestDispatcher("/error.jsp").forward(request, response);
        }
    }

    private void createExam(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            User user = SessionUtil.getCurrentUser(request);
            com.examportal.model.Exam exam = new com.examportal.model.Exam();
            exam.setTitle(request.getParameter("title"));
            exam.setDescription(request.getParameter("description"));
            exam.setCreatedBy(user.getUserId());

            String categoryName = request.getParameter("category");
            Long categoryId = questionDAO.findCategoryIdByName(categoryName);
            exam.setCategoryId(categoryId);

            exam.setDurationMinutes(Integer.parseInt(request.getParameter("durationMinutes")));
            exam.setPassPercentage(new java.math.BigDecimal(
                    request.getParameter("passPercentage")));
            exam.setNegativeMarking("on".equals(request.getParameter("negativeMarking")));
            String negativeMarksValue = request.getParameter("negativeMarks");
            if (negativeMarksValue == null || negativeMarksValue.isBlank()) {
                negativeMarksValue = "0.25";
            }
            exam.setNegativeMarksPerQuestion(new java.math.BigDecimal(negativeMarksValue));
            exam.setRandomizeQuestions("on".equals(request.getParameter("randomizeQuestions")));

            String startTimeStr = request.getParameter("startTime");
            String endTimeStr = request.getParameter("endTime");
            exam.setStartTime(java.time.LocalDateTime.parse(startTimeStr.replace(" ", "T")));
            exam.setEndTime(java.time.LocalDateTime.parse(endTimeStr.replace(" ", "T")));

            String[] questionIds = request.getParameterValues("questionIds");
            List<Long> qIds = Arrays.asList(questionIds).stream()
                    .map(Long::parseLong).collect(Collectors.toList());

            Long examId = examService.createExam(exam, qIds);
            request.setAttribute("success", "Exam created successfully! ID: " + examId);
            response.sendRedirect(request.getContextPath() + "/faculty/manageExam");
        } catch (Exception e) {
            request.setAttribute("error", "Error creating exam: " + e.getMessage());
            showCreateExam(request, response);
        }
    }

    private void deleteExam(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            Long examId = Long.parseLong(request.getParameter("examId"));
            examService.deleteExam(examId);
            request.setAttribute("success", "Exam deleted successfully");
        } catch (Exception e) {
            request.setAttribute("error", "Error deleting exam: " + e.getMessage());
        }
        response.sendRedirect(request.getContextPath() + "/faculty/manageExam");
    }
}