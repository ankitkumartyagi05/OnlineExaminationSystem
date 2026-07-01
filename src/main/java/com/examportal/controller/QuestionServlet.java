package com.examportal.controller;

import java.io.IOException;
import java.math.BigDecimal;
import java.sql.SQLException;

import com.examportal.dao.QuestionDAO;
import com.examportal.model.Question;
import com.examportal.model.User;
import com.examportal.util.SessionUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/question/*")
public class QuestionServlet extends HttpServlet {

    private final QuestionDAO questionDAO = new QuestionDAO();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        if (!SessionUtil.hasRole(request, "FACULTY")) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String pathInfo = request.getPathInfo();
        if ("/create".equals(pathInfo)) {
            createQuestion(request, response);
        } else if ("/delete".equals(pathInfo)) {
            deleteQuestion(request, response);
        }
    }

    private void createQuestion(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        try {
            User user = SessionUtil.getCurrentUser(request);
            Question question = new Question();
            
            String categoryName = request.getParameter("category");
            Long categoryId = questionDAO.findCategoryIdByName(categoryName);
            question.setCategoryId(categoryId);
            question.setCreatedBy(user.getUserId());
            question.setQuestionText(request.getParameter("questionText"));
            question.setOptionA(request.getParameter("optionA"));
            question.setOptionB(request.getParameter("optionB"));
            question.setOptionC(request.getParameter("optionC"));
            question.setOptionD(request.getParameter("optionD"));
            question.setCorrectAnswer(request.getParameter("correctAnswer"));
            String marksValue = request.getParameter("marks");
            if (marksValue == null || marksValue.isBlank()) {
                marksValue = "1.00";
            }
            question.setMarks(new BigDecimal(marksValue));
            String negativeMarksValue = request.getParameter("negativeMarks");
            if (negativeMarksValue == null || negativeMarksValue.isBlank()) {
                negativeMarksValue = "0.25";
            }
            question.setNegativeMarks(new BigDecimal(negativeMarksValue));
            question.setDifficultyLevel(request.getParameter("difficultyLevel"));
            question.setIsActive(true);

            questionDAO.createQuestion(question);
            request.setAttribute("success", "Question created successfully");
        } catch (SQLException e) {
            System.err.println("Database error in QuestionServlet.createQuestion: " + e.getMessage());
            e.printStackTrace();
            request.setAttribute("error", "An internal database error occurred. Please contact the administrator.");
        } catch (Exception e) {
            System.err.println("Error in QuestionServlet.createQuestion: " + e.getMessage());
            e.printStackTrace();
            request.setAttribute("error", "Error creating question: " + e.getMessage());
        }
        response.sendRedirect(request.getContextPath() + "/faculty/questionBank");
    }

    private void deleteQuestion(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        try {
            Long questionId = Long.parseLong(request.getParameter("questionId"));
            questionDAO.deleteQuestion(questionId);
            request.setAttribute("success", "Question deleted successfully");
        } catch (SQLException e) {
            System.err.println("Database error in QuestionServlet.deleteQuestion: " + e.getMessage());
            e.printStackTrace();
            request.setAttribute("error", "An internal database error occurred. Please contact the administrator.");
        } catch (Exception e) {
            System.err.println("Error in QuestionServlet.deleteQuestion: " + e.getMessage());
            e.printStackTrace();
            request.setAttribute("error", "Error deleting question: " + e.getMessage());
        }
        response.sendRedirect(request.getContextPath() + "/faculty/questionBank");
    }
}
