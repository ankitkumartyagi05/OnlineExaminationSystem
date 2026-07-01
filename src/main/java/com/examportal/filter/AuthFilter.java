package com.examportal.filter;

import com.examportal.util.SessionUtil;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebFilter("/*")
public class AuthFilter implements Filter {

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse res = (HttpServletResponse) response;

        String path = req.getRequestURI().substring(req.getContextPath().length());

        // Allow public resources
        if (path.equals("/") ||
            path.equals("/index.jsp") ||
            path.equals("/login") ||
            path.equals("/auth") ||
            path.equals("/register") ||
            path.startsWith("/css/") ||
            path.startsWith("/js/") ||
            path.startsWith("/images/") ||
            path.equals("/error.jsp")) {

            chain.doFilter(request, response);
            return;
        }

        boolean isLoggedIn = SessionUtil.isLoggedIn(req);

        HttpSession session = req.getSession(false);

        // Redirect to login if not logged in
        if (!isLoggedIn) {
            if (path.startsWith("/student") ||
                path.startsWith("/faculty") ||
                path.startsWith("/admin") ||
                path.startsWith("/exam")) {

                res.sendRedirect(req.getContextPath() + "/login");
                return;
            }

            chain.doFilter(request, response);
            return;
        }

        // Role-Based Access Control (RBAC)
        String role = session != null ? (String) session.getAttribute("role") : null;

        if (path.startsWith("/admin") && !"ADMIN".equals(role)) {
            res.sendError(HttpServletResponse.SC_FORBIDDEN, "Access Denied");
            return;
        }

        if (path.startsWith("/faculty") && !"FACULTY".equals(role)) {
            res.sendError(HttpServletResponse.SC_FORBIDDEN, "Access Denied");
            return;
        }

        if (path.startsWith("/student") && !"STUDENT".equals(role)) {
            res.sendError(HttpServletResponse.SC_FORBIDDEN, "Access Denied");
            return;
        }

        chain.doFilter(request, response);
    }
}