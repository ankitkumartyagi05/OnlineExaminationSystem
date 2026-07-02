package com.exam.controller;

import com.exam.model.Question;
import com.exam.service.QuestionService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet({"/admin/questions", "/admin/add-question", "/admin/edit-question", "/admin/delete-question"})
public class QuestionManageServlet extends HttpServlet {
    private final QuestionService questionService = new QuestionService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String path = request.getServletPath();

        try {
            if ("/admin/questions".equals(path)) {
                String search = request.getParameter("search");
                List<Question> questions;
                if (search != null && !search.trim().isEmpty()) {
                    questions = questionService.searchQuestions(search.trim());
                    request.setAttribute("search", search.trim());
                } else {
                    questions = questionService.getAllQuestions();
                }
                request.setAttribute("questions", questions);
                request.setAttribute("subjects", questionService.getAllSubjects());
                request.getRequestDispatcher("/jsp/admin/questions.jsp").forward(request, response);

            } else if ("/admin/add-question".equals(path)) {
                request.setAttribute("subjects", questionService.getAllSubjects());
                request.getRequestDispatcher("/jsp/admin/add-question.jsp").forward(request, response);

            } else if ("/admin/edit-question".equals(path)) {
                int id = Integer.parseInt(request.getParameter("id"));
                Question question = questionService.getQuestionById(id);
                if (question == null) {
                    response.sendRedirect(request.getContextPath() + "/admin/questions");
                    return;
                }
                request.setAttribute("question", question);
                request.setAttribute("subjects", questionService.getAllSubjects());
                request.getRequestDispatcher("/jsp/admin/edit-question.jsp").forward(request, response);

            } else if ("/admin/delete-question".equals(path)) {
                int id = Integer.parseInt(request.getParameter("id"));
                questionService.deleteQuestion(id);
                response.sendRedirect(request.getContextPath() + "/admin/questions?deleted=true");
            }
        } catch (Exception e) {
            response.sendRedirect(request.getContextPath() + "/admin/questions");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String path = request.getServletPath();

        try {
            if ("/admin/add-question".equals(path)) {
                Question q = extractQuestion(request);
                if (q != null) {
                    questionService.addQuestion(q);
                    response.sendRedirect(request.getContextPath() + "/admin/questions?added=true");
                } else {
                    request.setAttribute("error", "All fields are required.");
                    request.setAttribute("subjects", questionService.getAllSubjects());
                    request.getRequestDispatcher("/jsp/admin/add-question.jsp").forward(request, response);
                }

            } else if ("/admin/edit-question".equals(path)) {
                Question q = extractQuestion(request);
                String idParam = request.getParameter("id");
                if (q != null && idParam != null) {
                    q.setId(Integer.parseInt(idParam));
                    questionService.updateQuestion(q);
                    response.sendRedirect(request.getContextPath() + "/admin/questions?updated=true");
                } else {
                    response.sendRedirect(request.getContextPath() + "/admin/questions");
                }
            }
        } catch (Exception e) {
            response.sendRedirect(request.getContextPath() + "/admin/questions");
        }
    }

    private Question extractQuestion(HttpServletRequest request) {
        String subject = request.getParameter("subject");
        String question = request.getParameter("question");
        String optionA = request.getParameter("optionA");
        String optionB = request.getParameter("optionB");
        String optionC = request.getParameter("optionC");
        String optionD = request.getParameter("optionD");
        String correctAnswer = request.getParameter("correctAnswer");
        String marksParam = request.getParameter("marks");

        if (subject == null || subject.trim().isEmpty() || question == null || question.trim().isEmpty() ||
                optionA == null || optionA.trim().isEmpty() || optionB == null || optionB.trim().isEmpty() ||
                optionC == null || optionC.trim().isEmpty() || optionD == null || optionD.trim().isEmpty() ||
                correctAnswer == null || correctAnswer.trim().isEmpty() || marksParam == null || marksParam.trim().isEmpty()) {
            return null;
        }

        Question q = new Question();
        q.setSubject(subject.trim());
        q.setQuestion(question.trim());
        q.setOptionA(optionA.trim());
        q.setOptionB(optionB.trim());
        q.setOptionC(optionC.trim());
        q.setOptionD(optionD.trim());
        q.setCorrectAnswer(correctAnswer.trim().toUpperCase());
        q.setMarks(Integer.parseInt(marksParam.trim()));
        return q;
    }
}