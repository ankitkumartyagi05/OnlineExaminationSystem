<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Faculty Dashboard | ExamPortal</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/css/style.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/css/dashboard.css" rel="stylesheet">
</head>
<body class="dashboard-body">
    <div class="dashboard-wrapper">
        <nav class="dashboard-sidebar">
            <div class="sidebar-header">
                <a href="${pageContext.request.contextPath}/" class="sidebar-logo">
                    <i class="fas fa-graduation-cap"></i> Exam<span>Portal</span>
                </a>
            </div>
            <div class="sidebar-user">
                <div class="sidebar-avatar">${currentUser.fullName.charAt(0)}</div>
                <div class="sidebar-user-info">
                    <h6>${currentUser.fullName}</h6><small>Faculty</small>
                </div>
            </div>
            <ul class="sidebar-menu">
                <li class="active"><a href="${pageContext.request.contextPath}/faculty/dashboard"><i class="fas fa-tachometer-alt"></i> Dashboard</a></li>
                <li><a href="${pageContext.request.contextPath}/faculty/createExam"><i class="fas fa-plus-circle"></i> Create Exam</a></li>
                <li><a href="${pageContext.request.contextPath}/faculty/manageExam"><i class="fas fa-edit"></i> Manage Exams</a></li>
                <li><a href="${pageContext.request.contextPath}/faculty/questionBank"><i class="fas fa-question-circle"></i> Question Bank</a></li>
                <li><a href="${pageContext.request.contextPath}/faculty/reports"><i class="fas fa-chart-bar"></i> Reports</a></li>
                <li><a href="${pageContext.request.contextPath}/logout"><i class="fas fa-sign-out-alt"></i> Logout</a></li>
            </ul>
        </nav>

        <div class="dashboard-main">
            <header class="dashboard-topbar">
                <h4 class="page-title">Faculty Dashboard</h4>
                <div class="topbar-user">
                    <div class="topbar-avatar">${currentUser.fullName.charAt(0)}</div>
                </div>
            </header>

            <div class="dashboard-content">
                <div class="welcome-banner glass-card mb-4">
                    <div>
                        <h3>Welcome, ${currentUser.fullName}! 👨‍🏫</h3>
                        <p>${faculty.designation} - ${faculty.department}</p>
                    </div>
                    <div class="welcome-icon"><i class="fas fa-chalkboard-teacher"></i></div>
                </div>

                <div class="row g-4 mb-4">
                    <div class="col-md-3">
                        <div class="kpi-card glass-card">
                            <div class="kpi-icon kpi-blue"><i class="fas fa-file-alt"></i></div>
                            <div class="kpi-info">
                                <h3>${exams.size()}</h3><p>Total Exams</p>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-3">
                        <div class="kpi-card glass-card">
                            <div class="kpi-icon kpi-green"><i class="fas fa-question-circle"></i></div>
                            <div class="kpi-info">
                                <h3>${questions.size()}</h3><p>Questions Created</p>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-3">
                        <div class="kpi-card glass-card">
                            <div class="kpi-icon kpi-purple"><i class="fas fa-users"></i></div>
                            <div class="kpi-info">
                                <h3>0</h3><p>Total Attempts</p>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-3">
                        <div class="kpi-card glass-card">
                            <div class="kpi-icon kpi-cyan"><i class="fas fa-percentage"></i></div>
                            <div class="kpi-info">
                                <h3>0%</h3><p>Avg Pass Rate</p>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="row g-4">
                    <div class="col-lg-7">
                        <div class="chart-card glass-card">
                            <div class="chart-header">
                                <h5><i class="fas fa-file-alt me-2"></i>Recent Exams</h5>
                                <a href="${pageContext.request.contextPath}/faculty/manageExam" class="btn btn-sm btn-cyber-outline">View All</a>
                            </div>
                            <div class="table-responsive">
                                <table class="table cyber-table">
                                    <thead>
                                        <tr><th>Title</th><th>Questions</th><th>Marks</th><th>Status</th></tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach var="exam" items="${exams}" end="4">
                                            <tr>
                                                <td>${exam.title}</td>
                                                <td>${exam.totalQuestions}</td>
                                                <td>${exam.totalMarks}</td>
                                                <td><span class="badge bg-${exam.status == 'PUBLISHED' ? 'success' : 'warning'}">${exam.status}</span></td>
                                            </tr>
                                        </c:forEach>
                                        <c:if test="${empty exams}"><tr><td colspan="4" class="text-center py-3">No exams created yet.</td></tr></c:if>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-5">
                        <div class="chart-card glass-card">
                            <div class="chart-header">
                                <h5><i class="fas fa-bolt me-2"></i>Quick Actions</h5>
                            </div>
                            <a href="${pageContext.request.contextPath}/faculty/createExam" class="action-card glass-card d-flex">
                                <i class="fas fa-plus-circle action-icon"></i>
                                <div><h5>Create Exam</h5><p>Schedule a new exam</p></div>
                            </a>
                            <a href="${pageContext.request.contextPath}/faculty/questionBank" class="action-card glass-card d-flex">
                                <i class="fas fa-question-circle action-icon"></i>
                                <div><h5>Add Questions</h5><p>Build your question bank</p></div>
                            </a>
                            <a href="${pageContext.request.contextPath}/faculty/reports" class="action-card glass-card d-flex">
                                <i class="fas fa-chart-bar action-icon"></i>
                                <div><h5>View Reports</h5><p>Student performance</p></div>
                            </a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>