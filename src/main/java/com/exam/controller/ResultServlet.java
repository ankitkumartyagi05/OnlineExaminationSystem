// Placeholder
package com.exam.controller;

import com.exam.model.Candidate;
import com.exam.model.Result;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/result")
public class ResultServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        Candidate candidate = (Candidate) session.getAttribute("candidate");
        Result result = (Result) session.getAttribute("result");

        if (candidate == null || result == null) {
            response.sendRedirect(request.getContextPath() + "/tests");
            return;
        }

        request.setAttribute("result", result);
        request.getRequestDispatcher("/jsp/result.jsp").forward(request, response);
    }
}