<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Reports | Admin</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="css/style.css" rel="stylesheet">
</head>
<body class="dashboard-body">
    <div class="container py-5">
        <h1 class="mb-4">Reports</h1>
        <a class="btn btn-primary mb-4" href="${pageContext.request.contextPath}/admin/dashboard">Back to Dashboard</a>

        <h3>Exams</h3>
        <div class="table-responsive mb-4">
            <table class="table table-bordered">
                <thead><tr><th>ID</th><th>Title</th><th>Duration</th><th>Category</th></tr></thead>
                <tbody>
                    <c:forEach var="exam" items="${exams}">
                        <tr>
                            <td>${exam.examId}</td>
                            <td>${exam.title}</td>
                            <td>${exam.durationMinutes}</td>
                            <td>${exam.categoryName}</td>
                        </tr>
                    </c:forEach>
                    <c:if test="${empty exams}">
                        <tr><td colspan="4" class="text-center">No exams found.</td></tr>
                    </c:if>
                </tbody>
            </table>
        </div>

        <h3>Results</h3>
        <div class="table-responsive mb-4">
            <table class="table table-bordered">
                <thead><tr><th>Attempt</th><th>Student</th><th>Score</th><th>Status</th></tr></thead>
                <tbody>
                    <c:forEach var="result" items="${results}">
                        <tr>
                            <td>${result.attemptId}</td>
                            <td>${result.studentName}</td>
                            <td>${result.score}</td>
                            <td>${result.status}</td>
                        </tr>
                    </c:forEach>
                    <c:if test="${empty results}">
                        <tr><td colspan="4" class="text-center">No results found.</td></tr>
                    </c:if>
                </tbody>
            </table>
        </div>

        <h3>Students</h3>
        <div class="table-responsive">
            <table class="table table-bordered">
                <thead><tr><th>ID</th><th>Name</th><th>Roll</th><th>Course</th></tr></thead>
                <tbody>
                    <c:forEach var="student" items="${students}">
                        <tr>
                            <td>${student.studentId}</td>
                            <td>${student.fullName}</td>
                            <td>${student.rollNumber}</td>
                            <td>${student.course}</td>
                        </tr>
                    </c:forEach>
                    <c:if test="${empty students}">
                        <tr><td colspan="4" class="text-center">No students available.</td></tr>
                    </c:if>
                </tbody>
            </table>
        </div>
    </div>
</body>
</html>
