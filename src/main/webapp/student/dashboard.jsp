<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Student Dashboard | ExamPortal</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link href="css/style.css" rel="stylesheet">
    <link href="css/dashboard.css" rel="stylesheet">
</head>
<body class="dashboard-body">
    <div class="dashboard-wrapper">
        <!-- Sidebar -->
        <nav class="dashboard-sidebar" id="sidebar">
            <div class="sidebar-header">
                <a href="${pageContext.request.contextPath}/" class="sidebar-logo">
                    <i class="fas fa-graduation-cap"></i> Exam<span>Portal</span>
                </a>
            </div>
            <div class="sidebar-user">
                <div class="sidebar-avatar">${currentUser.fullName.charAt(0)}</div>
                <div class="sidebar-user-info">
                    <h6>${currentUser.fullName}</h6>
                    <small>Student</small>
                </div>
            </div>
            <ul class="sidebar-menu">
                <li class="active"><a href="${pageContext.request.contextPath}/student/dashboard"><i class="fas fa-tachometer-alt"></i> Dashboard</a></li>
                <li><a href="${pageContext.request.contextPath}/student/exams"><i class="fas fa-file-alt"></i> Available Exams</a></li>
                <li><a href="${pageContext.request.contextPath}/student/results"><i class="fas fa-poll"></i> My Results</a></li>
                <li><a href="${pageContext.request.contextPath}/student/analytics"><i class="fas fa-chart-line"></i> Analytics</a></li>
                <li><a href="${pageContext.request.contextPath}/student/profile"><i class="fas fa-user"></i> Profile</a></li>
                <li><a href="${pageContext.request.contextPath}/logout"><i class="fas fa-sign-out-alt"></i> Logout</a></li>
            </ul>
        </nav>

        <!-- Main Content -->
        <div class="dashboard-main">
            <!-- Top Bar -->
            <header class="dashboard-topbar">
                <button class="btn-toggle-sidebar" onclick="toggleSidebar()">
                    <i class="fas fa-bars"></i>
                </button>
                <h4 class="page-title">Dashboard</h4>
                <div class="topbar-actions">
                    <button class="btn-icon"><i class="fas fa-bell"></i><span class="badge-dot"></span></button>
                    <div class="topbar-user">
                        <div class="topbar-avatar">${currentUser.fullName.charAt(0)}</div>
                        <div class="d-none d-md-block">
                            <h6>${currentUser.fullName}</h6>
                            <small>${student.rollNumber}</small>
                        </div>
                    </div>
                </div>
            </header>

            <!-- Content -->
            <div class="dashboard-content">
                <!-- Welcome Banner -->
                <div class="welcome-banner glass-card mb-4">
                    <div>
                        <h3>Welcome back, ${currentUser.fullName}! 👋</h3>
                        <p>You have taken ${resultCount} exams so far. Keep up the great work!</p>
                    </div>
                    <div class="welcome-icon"><i class="fas fa-user-graduate"></i></div>
                </div>

                <!-- KPI Cards -->
                <div class="row g-4 mb-4">
                    <div class="col-md-6 col-lg-3">
                        <div class="kpi-card glass-card">
                            <div class="kpi-icon kpi-blue"><i class="fas fa-file-alt"></i></div>
                            <div class="kpi-info">
                                <h3>${examCount}</h3>
                                <p>Available Exams</p>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-6 col-lg-3">
                        <div class="kpi-card glass-card">
                            <div class="kpi-icon kpi-green"><i class="fas fa-check-circle"></i></div>
                            <div class="kpi-info">
                                <h3>${resultCount}</h3>
                                <p>Exams Completed</p>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-6 col-lg-3">
                        <div class="kpi-card glass-card">
                            <div class="kpi-icon kpi-purple"><i class="fas fa-percentage"></i></div>
                            <div class="kpi-info">
                                <h3>${student.course}</h3>
                                <p>Course</p>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-6 col-lg-3">
                        <div class="kpi-card glass-card">
                            <div class="kpi-icon kpi-cyan"><i class="fas fa-book"></i></div>
                            <div class="kpi-info">
                                <h3>Sem ${student.semester}</h3>
                                <p>Current Semester</p>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Charts Row -->
                <div class="row g-4 mb-4">
                    <div class="col-lg-8">
                        <div class="chart-card glass-card">
                            <div class="chart-header">
                                <h5><i class="fas fa-chart-line me-2"></i>Performance Overview</h5>
                            </div>
                            <canvas id="performanceChart" height="100"></canvas>
                        </div>
                    </div>
                    <div class="col-lg-4">
                        <div class="chart-card glass-card">
                            <div class="chart-header">
                                <h5><i class="fas fa-chart-pie me-2"></i>Score Distribution</h5>
                            </div>
                            <canvas id="scoreChart" height="180"></canvas>
                        </div>
                    </div>
                </div>

                <!-- Quick Actions -->
                <div class="row g-4">
                    <div class="col-md-4">
                        <a href="${pageContext.request.contextPath}/student/exams" class="action-card glass-card">
                            <i class="fas fa-file-alt action-icon"></i>
                            <h5>Take Exam</h5>
                            <p>View available exams</p>
                        </a>
                    </div>
                    <div class="col-md-4">
                        <a href="${pageContext.request.contextPath}/student/results" class="action-card glass-card">
                            <i class="fas fa-poll action-icon"></i>
                            <h5>View Results</h5>
                            <p>Check your scores</p>
                        </a>
                    </div>
                    <div class="col-md-4">
                        <a href="${pageContext.request.contextPath}/student/analytics" class="action-card glass-card">
                            <i class="fas fa-chart-line action-icon"></i>
                            <h5>Analytics</h5>
                            <p>Track your progress</p>
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/gsap/3.12.2/gsap.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/chart.js@4.4.0/dist/chart.umd.min.js"></script>
    <script src="js/dashboard.js"></script>
    <script>
        // Performance Chart
        new Chart(document.getElementById('performanceChart'), {
            type: 'line',
            data: {
                labels: ['Exam 1', 'Exam 2', 'Exam 3', 'Exam 4', 'Exam 5'],
                datasets: [{
                    label: 'Score %',
                    data: [65, 72, 80, 75, 88],
                    borderColor: '#00d9ff',
                    backgroundColor: 'rgba(0, 217, 255, 0.1)',
                    fill: true,
                    tension: 0.4
                }]
            },
            options: { responsive: true, plugins: { legend: { labels: { color: '#fff' } } },
                scales: { x: { ticks: { color: '#888' }, grid: { color: 'rgba(255,255,255,0.05)' } },
                          y: { ticks: { color: '#888' }, grid: { color: 'rgba(255,255,255,0.05)' } } } }
        });

        // Score Distribution
        new Chart(document.getElementById('scoreChart'), {
            type: 'doughnut',
            data: {
                labels: ['Excellent (80+)', 'Good (60-79)', 'Average (40-59)', 'Below 40'],
                datasets: [{
                    data: [3, 2, 1, 0],
                    backgroundColor: ['#00ff88', '#00d9ff', '#ffaa00', '#ff4757']
                }]
            },
            options: { responsive: true, plugins: { legend: { position: 'bottom', labels: { color: '#ccc', padding: 10, font: { size: 11 } } } } }
        });
    </script>
</body>
</html>