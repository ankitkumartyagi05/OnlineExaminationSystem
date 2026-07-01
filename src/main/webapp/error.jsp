<%@ page contentType="text/html;charset=UTF-8" language="java" isErrorPage="true" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Error | ExamPortal</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css" rel="stylesheet">
    <link href="css/style.css" rel="stylesheet">
</head>
<body class="auth-page">
    <canvas id="bg-canvas"></canvas>
    <div class="auth-container text-center">
        <div class="glass-card" style="padding: 3rem;">
            <i class="fas fa-exclamation-triangle" style="font-size: 4rem; color: var(--neon-yellow);"></i>
            <h1 class="mt-3" style="font-family: 'Orbitron', sans-serif;">Oops!</h1>
            <p class="text-muted">Something went wrong.</p>
            <c:if test="${not empty pageContext.exception}">
                <p class="text-danger small">${pageContext.exception.message}</p>
            </c:if>
            <c:if test="${not empty error}">
                <p class="text-danger">${error}</p>
            </c:if>
            <a href="${pageContext.request.contextPath}/" class="btn btn-cyber mt-3">
                <i class="fas fa-home me-2"></i>Go Home
            </a>
        </div>
    </div>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/three.js/r128/three.min.js"></script>
    <script src="js/three-bg.js"></script>
</body>
</html>
