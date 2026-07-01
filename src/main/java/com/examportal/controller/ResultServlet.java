package com.examportal.controller;

import com.examportal.dao.ResultDAO;
import com.examportal.dao.StudentDAO;
import com.examportal.model.Student;
import com.examportal.model.User;
import com.examportal.util.SessionUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/result/*")
public class ResultServlet extends HttpServlet {

    private final ResultDAO resultDAO = new ResultDAO();
    private final StudentDAO studentDAO = new StudentDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        if (!SessionUtil.isLoggedIn(request)) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String pathInfo = request.getPathInfo();
        if (pathInfo != null && pathInfo.startsWith("/view/")) {
            viewResult(request, response);
        } else {
            response.sendError(HttpServletResponse.SC_NOT_FOUND);
        }
    }

    private void viewResult(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        try {
            Long attemptId = Long.parseLong(request.getPathInfo().substring("/view/".length()));
            com.examportal.model.Result result = resultDAO.findResultByAttemptId(attemptId);
            
            if (result == null) {
                request.setAttribute("error", "Result not found");
                request.getRequestDispatcher("/error.jsp").forward(request, response);
                return;
            }

            request.setAttribute("result", result);
            request.getRequestDispatcher("/student/result.jsp").forward(request, response);
        } catch (SQLException e) {
            System.err.println("Database error in ResultServlet.viewResult: " + e.getMessage());
            e.printStackTrace();
            request.setAttribute("error", "An internal database error occurred. Please contact the administrator.");
            request.getRequestDispatcher("/error.jsp").forward(request, response);
        } catch (Exception e) {
            System.err.println("Error in ResultServlet.viewResult: " + e.getMessage());
            e.printStackTrace();
            request.setAttribute("error", "Error: " + e.getMessage());
            request.getRequestDispatcher("/error.jsp").forward(request, response);
        }
    }
}