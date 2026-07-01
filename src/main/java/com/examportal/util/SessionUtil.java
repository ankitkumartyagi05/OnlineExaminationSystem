package com.examportal.util;

import com.examportal.model.User;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

public class SessionUtil {

    public static final String USER_SESSION_KEY = "currentUser";
    public static final String STUDENT_SESSION_KEY = "currentStudent";
    public static final String FACULTY_SESSION_KEY = "currentFaculty";
    public static final String ADMIN_SESSION_KEY = "currentAdmin";

    public static void createUserSession(HttpServletRequest request, User user) {
        HttpSession session = request.getSession(true);
        session.setAttribute(USER_SESSION_KEY, user);
        session.setAttribute("user", user); // legacy alias
        session.setAttribute("role", user.getRole());
        session.setAttribute("userId", user.getUserId());
        session.setMaxInactiveInterval(30 * 60); // 30 minutes
    }

    public static User getCurrentUser(HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        if (session == null) return null;
        return (User) session.getAttribute(USER_SESSION_KEY);
    }

    public static boolean isLoggedIn(HttpServletRequest request) {
        return getCurrentUser(request) != null;
    }

    public static boolean hasRole(HttpServletRequest request, String role) {
        User user = getCurrentUser(request);
        return user != null && role.equals(user.getRole());
    }

    public static void destroySession(HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        if (session != null) {
            session.invalidate();
        }
    }

    public static Long getCurrentUserId(HttpServletRequest request) {
        User user = getCurrentUser(request);
        return user != null ? user.getUserId() : null;
    }

    public static String getCurrentUserRole(HttpServletRequest request) {
        User user = getCurrentUser(request);
        return user != null ? user.getRole() : null;
    }

    public static void setAttribute(HttpServletRequest request, String key, Object value) {
        HttpSession session = request.getSession(true);
        session.setAttribute(key, value);
    }

    public static Object getAttribute(HttpServletRequest request, String key) {
        HttpSession session = request.getSession(false);
        if (session == null) return null;
        return session.getAttribute(key);
    }

    public static void removeAttribute(HttpServletRequest request, String key) {
        HttpSession session = request.getSession(false);
        if (session != null) {
            session.removeAttribute(key);
        }
    }
}