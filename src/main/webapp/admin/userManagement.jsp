<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>User Management | Admin</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="css/style.css" rel="stylesheet">
</head>
<body class="dashboard-body">
    <div class="container py-5">
        <h1 class="mb-4">User Management</h1>
        <a class="btn btn-primary mb-4" href="${pageContext.request.contextPath}/admin/dashboard">Back to Dashboard</a>

        <h3>Users</h3>
        <div class="table-responsive mb-4">
            <table class="table table-bordered">
                <thead><tr><th>ID</th><th>Name</th><th>Email</th><th>Role</th><th>Status</th></tr></thead>
                <tbody>
                    <c:forEach var="user" items="${users}">
                        <tr>
                            <td>${user.userId}</td>
                            <td>${user.fullName}</td>
                            <td>${user.email}</td>
                            <td>${user.role}</td>
                            <td>${user.status}</td>
                        </tr>
                    </c:forEach>
                    <c:if test="${empty users}">
                        <tr><td colspan="5" class="text-center">No users found.</td></tr>
                    </c:if>
                </tbody>
            </table>
        </div>

        <h3>Students</h3>
        <div class="table-responsive mb-4">
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
                        <tr><td colspan="4" class="text-center">No students found.</td></tr>
                    </c:if>
                </tbody>
            </table>
        </div>

        <h3>Faculty</h3>
        <div class="table-responsive">
            <table class="table table-bordered">
                <thead><tr><th>ID</th><th>Name</th><th>Department</th><th>Email</th></tr></thead>
                <tbody>
                    <c:forEach var="faculty" items="${faculty}">
                        <tr>
                            <td>${faculty.facultyId}</td>
                            <td>${faculty.fullName}</td>
                            <td>${faculty.department}</td>
                            <td>${faculty.email}</td>
                        </tr>
                    </c:forEach>
                    <c:if test="${empty faculty}">
                        <tr><td colspan="4" class="text-center">No faculty records found.</td></tr>
                    </c:if>
                </tbody>
            </table>
        </div>
    </div>
</body>
</html>
