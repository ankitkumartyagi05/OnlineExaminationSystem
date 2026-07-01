package com.examportal.filter;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.HashSet;
import java.util.Set;

@WebFilter("/*")
public class AuthFilter implements Filter {

    // ── Public paths that do NOT require login ──
    private static final Set<String> PUBLIC_PATHS = new HashSet<>();

    static {
        // Pages
        PUBLIC_PATHS.add("/");
        PUBLIC_PATHS.add("/index.jsp");
        PUBLIC_PATHS.add("/login");
        PUBLIC_PATHS.add("/register");
        PUBLIC_PATHS.add("/login.jsp");
        PUBLIC_PATHS.add("/register.jsp");
        PUBLIC_PATHS.add("/error404.jsp");
        PUBLIC_PATHS.add("/error500.jsp");

        // Static resources (CSS, JS, images, fonts, icons)
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
        // Strip context path to get the relative path
        String path = requestURI.substring(contextPath.length());

        // ── Step 1: Allow all public paths ──
        if (isPublicPath(path)) {
            chain.doFilter(request, response);
            return;
        }

        // ── Step 2: For protected paths, check session ──
        HttpSession session = httpRequest.getSession(false);
        Object user = (session != null) ? session.getAttribute("loggedInUser") : null;

        if (user == null) {
            // Not logged in → redirect to login
            System.out.println("[AuthFilter] No session for protected path: " + path + " → redirecting to login");
            httpResponse.sendRedirect(contextPath + "/login");
            return;
        }

        // ── Step 3: Role-based access control ──
        String role = getUserRole(user);
        String normalizedPath = path.toLowerCase();

        if (normalizedPath.startsWith("/admin") && !"ADMIN".equalsIgnoreCase(role)) {
            System.out.println("[AuthFilter] Non-admin accessing /admin: " + role);
            httpResponse.sendRedirect(contextPath + "/login");
            return;
        }

        if (normalizedPath.startsWith("/faculty") && !"FACULTY".equalsIgnoreCase(role)) {
            System.out.println("[AuthFilter] Non-faculty accessing /faculty: " + role);
            httpResponse.sendRedirect(contextPath + "/login");
            return;
        }

        if (normalizedPath.startsWith("/student") && !"STUDENT".equalsIgnoreCase(role)) {
            System.out.println("[AuthFilter] Non-student accessing /student: " + role);
            httpResponse.sendRedirect(contextPath + "/login");
            return;
        }

        // ── Step 4: Passed all checks → continue ──
        chain.doFilter(request, response);
    }

    /**
     * Check if the path is public (no login required).
     * Supports exact matches and prefix matches (ending with /).
     */
    private boolean isPublicPath(String path) {
        if (path == null || path.isEmpty()) {
            return true;
        }

        // Exact match
        if (PUBLIC_PATHS.contains(path)) {
            return true;
        }

        // Prefix match (for static resources like /css/, /js/, etc.)
        for (String publicPath : PUBLIC_PATHS) {
            if (publicPath.endsWith("/") && path.startsWith(publicPath)) {
                return true;
            }
        }

        // Allow common static file extensions anywhere
        String lowerPath = path.toLowerCase();
        if (lowerPath.endsWith(".css") || lowerPath.endsWith(".js") ||
            lowerPath.endsWith(".png") || lowerPath.endsWith(".jpg") ||
            lowerPath.endsWith(".jpeg") || lowerPath.endsWith(".gif") ||
            lowerPath.endsWith(".svg") || lowerPath.endsWith(".ico") ||
            lowerPath.endsWith(".woff") || lowerPath.endsWith(".woff2") ||
            lowerPath.endsWith(".ttf") || lowerPath.endsWith(".eot") ||
            lowerPath.endsWith(".map") || lowerPath.endsWith(".webp")) {
            return true;
        }

        return false;
    }

    /**
     * Safely get the role string from whatever object is stored in session.
     * Uses reflection so it works regardless of the exact User class structure.
     */
    private String getUserRole(Object user) {
        if (user == null) return null;
        try {
            java.lang.reflect.Method getRole = user.getClass().getMethod("getRole");
            Object result = getRole.invoke(user);
            return (result != null) ? result.toString() : null;
        } catch (Exception e) {
            System.err.println("[AuthFilter] Could not get role from user object: " + e.getMessage());
            return null;
        }
    }

    @Override
    public void destroy() {
        System.out.println("[AuthFilter] Destroyed");
    }
}
