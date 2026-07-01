<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.examportal.model.Result" %>
<%
    Result result = (Result) request.getAttribute("result");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Result | ExamPortal</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="css/style.css" rel="stylesheet">
</head>
<body class="auth-body">
    <canvas id="bg-canvas"></canvas>
    <div class="auth-container">
        <div class="glass-card auth-card text-center">
            <h2>Exam Result</h2>
            <div class="my-4">
                <h1 style="font-size: 4rem; color: <%= result.getIsPassed() ? "#00ff88" : "#ff4757" %>;">
                    <%= result.getPercentage() %>%
                </h1>
                <h4 class="<%= result.getIsPassed() ? "text-success" : "text-danger" %>">
                    <%= result.getIsPassed() ? "PASSED" : "FAILED" %>
                </h4>
            </div>
            <div class="row text-center mb-4">
                <div class="col-4">
                    <h5 class="text-success"><%= result.getCorrectAnswers() %></h5>
                    <small>Correct</small>
                </div>
                <div class="col-4">
                    <h5 class="text-danger"><%= result.getWrongAnswers() %></h5>
                    <small>Wrong</small>
                </div>
                <div class="col-4">
                    <h5 class="text-warning"><%= result.getUnattempted() %></h5>
                    <small>Skipped</small>
                </div>
            </div>
            <a href="${pageContext.request.contextPath}/student/dashboard" class="btn btn-cyber w-100">Back to Dashboard</a>
        </div>
    </div>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/three.js/r128/three.min.js"></script>
    <script src="js/three-bg.js"></script>
</body>
</html>