<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Analytics | Admin</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="css/style.css" rel="stylesheet">
</head>
<body class="dashboard-body">
    <div class="container py-5">
        <h1 class="mb-4">Analytics</h1>
        <a class="btn btn-primary mb-4" href="${pageContext.request.contextPath}/admin/dashboard">Back to Dashboard</a>

        <div class="mb-4">
            <h3>Exam Statistics</h3>
            <pre>${examStats}</pre>
        </div>

        <div class="mb-4">
            <h3>Result Statistics</h3>
            <pre>${resultStats}</pre>
        </div>

        <h3>All Results</h3>
        <div class="table-responsive">
            <table class="table table-bordered">
                <thead><tr><th>Attempt</th><th>Student</th><th>Exam</th><th>Score</th><th>Status</th></tr></thead>
                <tbody>
                    <c:forEach var="result" items="${results}">
                        <tr>
                            <td>${result.attemptId}</td>
                            <td>${result.studentName}</td>
                            <td>${result.examTitle}</td>
                            <td>${result.score}</td>
                            <td>${result.status}</td>
                        </tr>
                    </c:forEach>
                    <c:if test="${empty results}">
                        <tr><td colspan="5" class="text-center">No results available.</td></tr>
                    </c:if>
                </tbody>
            </table>
        </div>
    </div>
</body>
</html>
