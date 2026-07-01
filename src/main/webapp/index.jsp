<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Online Examination System</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body { background: linear-gradient(135deg, #07111f, #15253f); color: #f3f6ff; font-family: Arial, sans-serif; }
        .glass { background: rgba(255,255,255,0.1); backdrop-filter: blur(18px); border: 1px solid rgba(255,255,255,0.15); border-radius: 20px; box-shadow: 0 12px 35px rgba(0,0,0,0.25); }
        .hero { padding: 5rem 0; }
        .btn-cyber { background: linear-gradient(135deg, #4f7cff, #7a5cff); color: white; border: none; }
        .btn-cyber:hover { color: white; opacity: 0.95; }
    </style>
</head>
<body>
<div class="container hero">
    <div class="row align-items-center">
        <div class="col-lg-7">
            <h1 class="display-5 fw-bold mb-3">Online Examination & Assessment Management System</h1>
            <p class="lead text-light-emphasis mb-4">A streamlined portal for candidate registration, online testing, automatic evaluation, result generation, and performance insights.</p>
            <div class="d-flex flex-wrap gap-3">
                <a href="${pageContext.request.contextPath}/candidate/register" class="btn btn-cyber btn-lg">Candidate Registration</a>
                <a href="${pageContext.request.contextPath}/candidate/tests" class="btn btn-outline-light btn-lg">Start Test</a>
                <a href="${pageContext.request.contextPath}/candidate/results" class="btn btn-outline-light btn-lg">View Results</a>
            </div>
        </div>
        <div class="col-lg-5 mt-4 mt-lg-0">
            <div class="glass p-4">
                <h4 class="mb-3">About System</h4>
                <p class="mb-0">The platform supports question bank management, secure timed assessments, instant grading, result reporting, and candidate-wise performance analysis using a lightweight MySQL-backed architecture.</p>
            </div>
        </div>
    </div>
</div>
</body>
</html>
