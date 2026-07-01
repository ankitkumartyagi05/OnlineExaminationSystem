<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isErrorPage="true"%>
<%
    // Redirect 404s to login instead of showing Tomcat's ugly error page
    response.sendRedirect(request.getContextPath() + "/login");
%>
