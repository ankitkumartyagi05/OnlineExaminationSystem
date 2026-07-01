package com.examportal.controller;

import java.io.IOException;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.Map;

import com.examportal.dao.ExamDAO;
import com.examportal.dao.StudentDAO;
import com.examportal.model.Exam;
import com.examportal.model.Result;
import com.examportal.model.Student;
import com.examportal.model.User;
import com.examportal.service.EvaluationService;
import com.examportal.util.SessionUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/exam/*")
public class ExamServlet extends HttpServlet {

    private final ExamDAO examDAO = new ExamDAO();
    private final EvaluationService evaluationService = new EvaluationService();
    private final StudentDAO studentDAO = new StudentDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getPathInfo();
        if (action == null) action = "";

        try {
            if (action.equals("/take")) {
                Long examId = Long.parseLong(req.getParameter("examId"));
                Exam exam = examDAO.findById(examId);
                req.setAttribute("exam", exam);
                req.getRequestDispatcher("/student/takeExam.jsp").forward(req, resp);
            }
        } catch (SQLException e) {
            System.err.println("Database error in ExamServlet.doGet: " + e.getMessage());
            e.printStackTrace();
            req.setAttribute("error", "An internal database error occurred. Please contact the administrator.");
            req.getRequestDispatcher("/error.jsp").forward(req, resp);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getPathInfo();
        
        try {
            if (action == null) {
                resp.sendRedirect(req.getContextPath() + "/login");
                return;
            }

            if (action.equals("/start")) {
                Long examId = Long.parseLong(req.getParameter("examId"));
                User user = SessionUtil.getCurrentUser(req);
                if (user == null) {
                    resp.sendRedirect(req.getContextPath() + "/login");
                    return;
                }
                Student student = studentDAO.findByUserId(user.getUserId());
                
                Long attemptId = evaluationService.startExam(examId, student.getStudentId());
                req.getSession().setAttribute("attemptId", attemptId);
                
                resp.sendRedirect(req.getContextPath() + "/exam/take?examId=" + examId);
                
            } else if (action.equals("/submit")) {
                Long examId = Long.parseLong(req.getParameter("examId"));
                User user = SessionUtil.getCurrentUser(req);
                if (user == null) {
                    resp.sendRedirect(req.getContextPath() + "/login");
                    return;
                }
                Student student = studentDAO.findByUserId(user.getUserId());
                Long attemptId = (Long) req.getSession().getAttribute("attemptId");
                
                Exam exam = examDAO.findById(examId);
                Map<Long, String> answers = new HashMap<>();
                
                for (var q : exam.getQuestions()) {
                    String ans = req.getParameter("q_" + q.getQuestionId());
                    if (ans != null) {
                        answers.put(q.getQuestionId(), ans);
                    }
                }
                
                Result result = evaluationService.submitExam(attemptId, examId, student.getStudentId(), answers);
                req.getSession().removeAttribute("attemptId");
                
                req.setAttribute("result", result);
                req.setAttribute("exam", exam);
                req.getRequestDispatcher("/student/result.jsp").forward(req, resp);
            } else {
                resp.sendError(HttpServletResponse.SC_NOT_FOUND);
            }
        } catch (SQLException e) {
            System.err.println("Database error in ExamServlet.doPost: " + e.getMessage());
            e.printStackTrace();
            req.setAttribute("error", "An internal database error occurred. Please contact the administrator.");
            req.getRequestDispatcher("/error.jsp").forward(req, resp);
        } catch (Exception e) {
            System.err.println("Error in ExamServlet.doPost: " + e.getMessage());
            e.printStackTrace();
            req.setAttribute("error", e.getMessage());
            req.getRequestDispatcher("/error.jsp").forward(req, resp);
        }
    }
}