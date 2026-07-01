package com.examportal.controller;

import com.examportal.dao.ExamDAO;
import com.examportal.dao.StudentDAO;
import com.examportal.model.Exam;
import com.examportal.model.Student;
import com.examportal.model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

@WebServlet("/student/dashboard")
public class StudentServlet extends HttpServlet {
    private final ExamDAO examDAO = new ExamDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            List<Exam> exams = examDAO.findAllPublishedExams();
            req.setAttribute("exams", exams);
            req.getRequestDispatcher("/student/dashboard.jsp").forward(req, resp);
        } catch (SQLException e) {
            System.err.println("Database error in StudentServlet.doGet: " + e.getMessage());
            e.printStackTrace();
            req.setAttribute("error", "An internal database error occurred. Please contact the administrator.");
            req.getRequestDispatcher("/error.jsp").forward(req, resp);
        }
    }
}