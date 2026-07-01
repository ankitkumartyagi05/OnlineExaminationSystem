<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard | ExamPortal</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css" rel="stylesheet">
    <link href="css/style.css" rel="stylesheet">
    <link href="css/dashboard.css" rel="stylesheet">
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
                    <h6>${currentUser.fullName}</h6><small>Admin</small>
                </div>
            </div>
            <ul class="sidebar-menu">
                <li class="active"><a href="${pageContext.request.contextPath}/admin/dashboard"><i class="fas fa-tachometer-alt"></i> Dashboard</a></li>
                <li><a href="${pageContext.request.contextPath}/admin/users"><i class="fas fa-users-cog"></i> User Management</a></li>
                <li><a href="${pageContext.request.contextPath}/admin/analytics"><i class="fas fa-chart-pie"></i> Analytics</a></li>
                <li><a href="${pageContext.request.contextPath}/admin/reports"><i class="fas fa-file-export"></i> Reports</a></li>
                <li><a href="${pageContext.request.contextPath}/logout"><i class="fas fa-sign-out-alt"></i> Logout</a></li>
            </ul>
        </nav>

        <div class="dashboard-main">
            <header class="dashboard-topbar">
                <h4 class="page-title">Admin Dashboard</h4>
                <div class="topbar-user">
                    <div class="topbar-avatar">${currentUser.fullName.charAt(0)}</div>
                </div>
            </header>

            <div class="dashboard-content">
                <div class="welcome-banner glass-card mb-4">
                    <div>
                        <h3>System Overview 👨‍💼</h3>
                        <p>Monitor and manage your examination platform</p>
                    </div>
                    <div class="welcome-icon"><i class="fas fa-cog"></i></div>
                </div>

                <div class="row g-4 mb-4">
                    <div class="col-md-6 col-lg-2">
                        <div class="kpi-card glass-card">
                            <div class="kpi-icon kpi-blue"><i class="fas fa-users"></i></div>
                            <div class="kpi-info"><h3>${studentCount}</h3><p>Students</p></div>
                        </div>
                    </div>
                    <div class="col-md-6 col-lg-2">
                        <div class="kpi-card glass-card">
                            <div class="kpi-icon kpi-green"><i class="fas fa-chalkboard-teacher"></i></div>
                            <div class="kpi-info"><h3>${facultyCount}</h3><p>Faculty</p></div>
                        </div>
                    </div>
                    <div class="col-md-6 col-lg-2">
                        <div class="kpi-card glass-card">
                            <div class="kpi-icon kpi-purple"><i class="fas fa-file-alt"></i></div>
                            <div class="kpi-info"><h3>${examCount}</h3><p>Exams</p></div>
                        </div>
                    </div>
                    <div class="col-md-6 col-lg-2">
                        <div class="kpi-card glass-card">
                            <div class="kpi-icon kpi-cyan"><i class="fas fa-question-circle"></i></div>
                            <div class="kpi-info"><h3>${questionCount}</h3><p>Questions</p></div>
                        </div>
                    </div>
                    <div class="col-md-6 col-lg-2">
                        <div class="kpi-card glass-card">
                            <div class="kpi-icon kpi-yellow"><i class="fas fa-clipboard-check"></i></div>
                            <div class="kpi-info"><h3>${attemptCount}</h3><p>Attempts</p></div>
                        </div>
                    </div>
                    <div class="col-md-6 col-lg-2">
                        <div class="kpi-card glass-card">
                            <div class="kpi-icon kpi-red"><i class="fas fa-trophy"></i></div>
                            <div class="kpi-info"><h3>${passedCount}</h3><p>Passed</p></div>
                        </div>
                    </div>
                </div>

                <div class="row g-4">
                    <div class="col-lg-8">
                        <div class="chart-card glass-card">
                            <div class="chart-header"><h5><i class="fas fa-chart-line me-2"></i>Platform Statistics</h5></div>
                            <canvas id="adminChart" height="100"></canvas>
                        </div>
                    </div>
                    <div class="col-lg-4">
                        <div class="chart-card glass-card">
                            <div class="chart-header"><h5><i class="fas fa-chart-pie me-2"></i>User Distribution</h5></div>
                            <canvas id="userChart" height="180"></canvas>
                        </div>
                    </div>
                </div>

                <div class="chart-card glass-card mt-4">
                    <div class="chart-header"><h5><i class="fas fa-users me-2"></i>Recent Users</h5></div>
                    <div class="table-responsive">
                        <table class="table cyber-table">
                            <thead><tr><th>Name</th><th>Email</th><th>Role</th><th>Status</th></tr></thead>
                            <tbody>
                                <c:forEach var="u" items="${recentUsers}">
                                    <tr>
                                        <td>${u.fullName}</td>
                                        <td>${u.email}</td>
                                        <td><span class="badge bg-info">${u.role}</span></td>
                                        <td><span class="badge bg-${u.status == 'ACTIVE' ? 'success' : 'danger'}">${u.status}</span></td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/chart.js@4.4.0/dist/chart.umd.min.js"></script>
    <script>
        new Chart(document.getElementById('adminChart'), {
            type: 'bar',
            data: {
                labels: ['Students', 'Faculty', 'Exams', 'Questions', 'Attempts', 'Passed'],
                datasets: [{ label: 'Count', data: [${studentCount}, ${facultyCount}, ${examCount}, ${questionCount}, ${attemptCount}, ${passedCount}],
                    backgroundColor: ['#00d9ff','#00ff88','#a855f7','#22d3ee','#ffaa00','#ff4757'] }]
            },
            options: { responsive: true, plugins: { legend: { display: false } },
                scales: { x: { ticks: { color: '#888' }, grid: { color: 'rgba(255,255,255,0.05)' } },
                          y: { ticks: { color: '#888' }, grid: { color: 'rgba(255,255,255,0.05)' } } } }
        });
        new Chart(document.getElementById('userChart'), {
            type: 'doughnut',
            data: { labels: ['Students', 'Faculty'], 
                datasets: [{ data: [${studentCount}, ${facultyCount}], backgroundColor: ['#00d9ff', '#a855f7'] }] },
            options: { responsive: true, plugins: { legend: { position: 'bottom', labels: { color: '#ccc' } } } }
        });
    </script>
</body>
</html>