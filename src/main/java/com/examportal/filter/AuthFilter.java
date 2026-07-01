package com.examportal.filter;

import jakarta.servlet.*;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.HashSet;
import java.util.Set;

// ── REMOVED @WebFilter("/*") — web.xml already maps this filter ──
public class AuthFilter implements Filter {

    private static final Set<String> PUBLIC_PATHS = new HashSet<>();

    static {
        PUBLIC_PATHS.add("/");
        PUBLIC_PATHS.add("/index.jsp");
        PUBLIC_PATHS.add("/login");
        PUBLIC_PATHS.add("/register");
        PUBLIC_PATHS.add("/login.jsp");
        PUBLIC_PATHS.add("/register.jsp");
        PUBLIC_PATHS.add("/error404.jsp");
        PUBLIC_PATHS.add("/error500.jsp");
        PUBLIC_PATHS.add("/css/");
        PUBLIC_PATHS.add("/js/");
        PUBLIC_PATHS.add("/images/");
        PUBLIC_PATHS.add("/fonts/");
        PUBLIC_PATHS.add("/assets/");
        PUBLIC_PATHS.add("/favicon.ico");
    }

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        System.out.println("[AuthFilter] Initialized");
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpServletResponse httpResponse = (HttpServletResponse) response;

        String contextPath = httpRequest.getContextPath();
        String requestURI = httpRequest.getRequestURI();
        String path = requestURI.substring(contextPath.length());

        // Allow public paths
        if (isPublicPath(path)) {
            chain.doFilter(request, response);
            return;
        }

        // Check session for protected paths
        HttpSession session = httpRequest.getSession(false);
        Object user = (session != null) ? session.getAttribute("loggedInUser") : null;

        if (user == null) {
            httpResponse.sendRedirect(contextPath + "/login");
            return;
        }

        // Role-based access
        String role = getUserRole(user);
        String lowerPath = path.toLowerCase();

        if (lowerPath.startsWith("/admin") && !"ADMIN".equalsIgnoreCase(role)) {
            httpResponse.sendRedirect(contextPath + "/login");
            return;
        }
        if (lowerPath.startsWith("/faculty") && !"FACULTY".equalsIgnoreCase(role)) {
            httpResponse.sendRedirect(contextPath + "/login");
            return;
        }
        if (lowerPath.startsWith("/student") && !"STUDENT".equalsIgnoreCase(role)) {
            httpResponse.sendRedirect(contextPath + "/login");
            return;
        }

        chain.doFilter(request, response);
    }

    private boolean isPublicPath(String path) {
        if (path == null || path.isEmpty()) return true;
        if (PUBLIC_PATHS.contains(path)) return true;

        for (String pp : PUBLIC_PATHS) {
            if (pp.endsWith("/") && path.startsWith(pp)) return true;
        }

        String lp = path.toLowerCase();
        if (lp.endsWith(".css") || lp.endsWith(".js") ||
            lp.endsWith(".png") || lp.endsWith(".jpg") || lp.endsWith(".jpeg") ||
            lp.endsWith(".gif") || lp.endsWith(".svg") || lp.endsWith(".ico") ||
            lp.endsWith(".woff") || lp.endsWith(".woff2") || lp.endsWith(".ttf") ||
            lp.endsWith(".eot") || lp.endsWith(".map") || lp.endsWith(".webp")) {
            return true;
        }

        return false;
    }

    private String getUserRole(Object user) {
        if (user == null) return null;
        try {
            java.lang.reflect.Method m = user.getClass().getMethod("getRole");
            Object r = m.invoke(user);
            return (r != null) ? r.toString() : null;
        } catch (Exception e) {
            return null;
        }
    }

    @Override
    public void destroy() {}
}
