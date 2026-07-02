<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Performance Analysis - ExamPro</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/css/style.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/chart.js@4.4.1/dist/chart.umd.min.js"></script>
</head>
<body>
    <div class="bg-animated">
        <div class="orb orb-1"></div>
        <div class="orb orb-2"></div>
        <div class="orb orb-3"></div>
    </div>

    <%@ include file="header.jsp" %>

    <section style="padding: 140px 0 80px; min-height: 100vh;">
        <div class="container">
            <div class="page-header fade-in">
                <h1><span class="gradient-text">Performance</span> Analysis</h1>
                <p>Detailed breakdown of your examination performance.</p>
            </div>

            <!-- Summary Cards -->
            <c:if test="${not empty results}">
                <div class="row g-4 mb-4">
                    <div class="col-lg-3 col-md-6">
                        <div class="glass-card stat-card stat-card-1 tilt-card fade-in">
                            <div class="stat-icon"><i class="bi bi-journal-check"></i></div>
                            <div class="stat-number">${results.size()}</div>
                            <div class="stat-label">Total Attempts</div>
                        </div>
                    </div>
                    <div class="col-lg-3 col-md-6">
                        <div class="glass-card stat-card stat-card-3 tilt-card fade-in">
                            <div class="stat-icon"><i class="bi bi-trophy-fill"></i></div>
                            <div class="stat-number">
                                <c:set var="maxPerc" value="0" />
                                <c:forEach var="r" items="${results}">
                                    <c:if test="${r.percentage > maxPerc}"><c:set var="maxPerc" value="${r.percentage}" /></c:if>
                                </c:forEach>
                                ${maxPerc}%
                            </div>
                            <div class="stat-label">Highest Score</div>
                        </div>
                    </div>
                    <div class="col-lg-3 col-md-6">
                        <div class="glass-card stat-card stat-card-2 tilt-card fade-in">
                            <div class="stat-icon"><i class="bi bi-bar-chart-fill"></i></div>
                            <div class="stat-number">
                                <c:set var="totalPerc" value="0" />
                                <c:forEach var="r" items="${results}"><c:set var="totalPerc" value="${totalPerc + r.percentage}" /></c:forEach>
                                ${totalPerc / results.size()}%
                            </div>
                            <div class="stat-label">Average Score</div>
                        </div>
                    </div>
                    <div class="col-lg-3 col-md-6">
                        <div class="glass-card stat-card stat-card-4 tilt-card fade-in">
                            <div class="stat-icon"><i class="bi bi-check-circle-fill"></i></div>
                            <div class="stat-number">
                                <c:set var="passCount" value="0" />
                                <c:forEach var="r" items="${results}">
                                    <c:if test="${r.passFail == 'PASS'}"><c:set var="passCount" value="${passCount + 1}" /></c:if>
                                </c:forEach>
                                ${passCount}
                            </div>
                            <div class="stat-label">Exams Passed</div>
                        </div>
                    </div>
                </div>

                <!-- Charts Row -->
                <div class="row g-4 mb-4">
                    <div class="col-lg-6">
                        <div class="glass-card-static p-4 fade-in">
                            <h6 style="font-family: 'Space Grotesk'; font-weight: 600; margin-bottom: 20px; color: var(--text-secondary);">
                                <i class="bi bi-bar-chart-line me-2"></i>Score History
                            </h6>
                            <div class="chart-container">
                                <canvas id="historyChart"></canvas>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-6">
                        <div class="glass-card-static p-4 fade-in">
                            <h6 style="font-family: 'Space Grotesk'; font-weight: 600; margin-bottom: 20px; color: var(--text-secondary);">
                                <i class="bi bi-pie-chart-fill me-2"></i>Subject-wise Performance
                            </h6>
                            <div class="chart-container">
                                <canvas id="subjectChart"></canvas>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Subject-wise Performance Table -->
                <c:if test="${not empty performances}">
                    <div class="glass-card-static p-4 mb-4 fade-in">
                        <h6 style="font-family: 'Space Grotesk'; font-weight: 600; margin-bottom: 20px; color: var(--text-secondary);">
                            <i class="bi bi-grid-3x3-gap me-2"></i>Subject-wise Breakdown
                        </h6>
                        <div style="overflow-x: auto;">
                            <table class="table-glass">
                                <thead>
                                    <tr>
                                        <th>Subject</th>
                                        <th>Attempts</th>
                                        <th>Highest Score</th>
                                        <th>Average Score</th>
                                        <th>Performance</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="p" items="${performances}">
                                        <tr>
                                            <td><span class="badge-gradient badge-subject">${p.subject}</span></td>
                                            <td>${p.attempts}</td>
                                            <td style="font-weight: 600; color: var(--text-primary);">${p.highestScore}%</td>
                                            <td style="font-weight: 600; color: var(--text-primary);">${p.averageScore}%</td>
                                            <td style="min-width: 150px;">
                                                <div class="progress-glass" style="height: 8px;">
                                                    <div class="progress-bar-gradient" style="width: ${p.highestScore}%;
                                                        background: ${p.highestScore >= 40 ? 'var(--gradient-success)' : 'var(--gradient-danger)'};">
                                                    </div>
                                                </div>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </c:if>

                <!-- Previous Attempts -->
                <div class="glass-card-static p-4 fade-in">
                    <h6 style="font-family: 'Space Grotesk'; font-weight: 600; margin-bottom: 20px; color: var(--text-secondary);">
                        <i class="bi bi-clock-history me-2"></i>Previous Attempts
                    </h6>
                    <div style="overflow-x: auto;">
                        <table class="table-glass">
                            <thead>
                                <tr>
                                    <th>#</th>
                                    <th>Exam Name</th>
                                    <th>Total Qs</th>
                                    <th>Correct</th>
                                    <th>Wrong</th>
                                    <th>Marks</th>
                                    <th>Percentage</th>
                                    <th>Status</th>
                                    <th>Date</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="r" items="${results}" varStatus="status">
                                    <tr>
                                        <td style="font-weight: 600; color: var(--text-primary);">${status.index + 1}</td>
                                        <td style="font-weight: 500; color: var(--text-primary);">${r.examName}</td>
                                        <td>${r.totalQuestions}</td>
                                        <td style="color: #43e97b; font-weight: 600;">${r.correctAnswers}</td>
                                        <td style="color: #ff6b6b; font-weight: 600;">${r.wrongAnswers}</td>
                                        <td style="font-weight: 600; color: var(--text-primary);">${r.marksObtained}/${r.totalMarks}</td>
                                        <td style="font-weight: 700; color: var(--text-primary);">${r.percentage}%</td>
                                        <td><span class="badge-gradient ${r.passFail == 'PASS' ? 'badge-pass' : 'badge-fail'}">${r.passFail}</span></td>
                                        <td style="color: var(--text-muted); font-size: 0.82rem;">${r.createdAt.toLocalDate()}</td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </div>
            </c:if>

            <c:if test="${empty results}">
                <div class="empty-state glass-card-static fade-in">
                    <div class="empty-icon"><i class="bi bi-graph-up-arrow"></i></div>
                    <h4 style="color: var(--text-secondary); margin-bottom: 8px;">No Performance Data</h4>
                    <p style="color: var(--text-muted);">Complete an examination to see your performance analysis here.</p>
                    <a href="${pageContext.request.contextPath}/tests" class="btn-gradient btn-sm mt-3">
                        <i class="bi bi-play-circle"></i> Take a Test
                    </a>
                </div>
            </c:if>
        </div>
    </section>

    <%@ include file="footer.jsp" %>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    <script src="${pageContext.request.contextPath}/js/main.js"></script>
    <script>
        const chartDefaults = {
            color: '#a0a0b8',
            borderColor: 'rgba(255,255,255,0.06)',
            font: { family: "'Inter', sans-serif" }
        };
        Chart.defaults.color = chartDefaults.color;
        Chart.defaults.borderColor = chartDefaults.borderColor;
        Chart.defaults.font.family = chartDefaults.font.family;

        // History Chart
        const historyLabels = ${historyLabels};
        const historyData = ${historyData};
        if (historyLabels.length > 0) {
            new Chart(document.getElementById('historyChart'), {
                type: 'bar',
                data: {
                    labels: historyLabels,
                    datasets: [{
                        label: 'Score %',
                        data: historyData,
                        backgroundColor: historyData.map(v => v >= 40 ? 'rgba(67, 233, 123, 0.6)' : 'rgba(255, 107, 107, 0.6)'),
                        borderColor: historyData.map(v => v >= 40 ? '#43e97b' : '#ff6b6b'),
                        borderWidth: 2,
                        borderRadius: 8,
                        borderSkipped: false
                    }]
                },
                options: {
                    responsive: true,
                    maintainAspectRatio: false,
                    plugins: {
                        legend: { display: false },
                        tooltip: {
                            backgroundColor: 'rgba(15, 15, 42, 0.95)',
                            borderColor: 'rgba(255,255,255,0.1)',
                            borderWidth: 1,
                            cornerRadius: 10,
                            padding: 12,
                            titleFont: { weight: '600' },
                            callbacks: {
                                label: function(ctx) { return ctx.parsed.y + '%'; }
                            }
                        }
                    },
                    scales: {
                        y: {
                            beginAtZero: true,
                            max: 100,
                            grid: { color: 'rgba(255,255,255,0.04)' },
                            ticks: { callback: v => v + '%' }
                        },
                        x: {
                            grid: { display: false }
                        }
                    }
                }
            });
        }

        // Subject Chart
        const subjectLabels = ${subjectsJson};
        const highestScores = ${highestJson};
        const avgScores = ${averageJson};
        if (subjectLabels.length > 0) {
            new Chart(document.getElementById('subjectChart'), {
                type: 'radar',
                data: {
                    labels: subjectLabels,
                    datasets: [
                        {
                            label: 'Highest',
                            data: highestScores,
                            backgroundColor: 'rgba(102, 126, 234, 0.2)',
                            borderColor: '#667eea',
                            borderWidth: 2,
                            pointBackgroundColor: '#667eea',
                            pointBorderColor: '#667eea',
                            pointRadius: 4
                        },
                        {
                            label: 'Average',
                            data: avgScores,
                            backgroundColor: 'rgba(0, 242, 254, 0.2)',
                            borderColor: '#00f2fe',
                            borderWidth: 2,
                            pointBackgroundColor: '#00f2fe',
                            pointBorderColor: '#00f2fe',
                            pointRadius: 4
                        }
                    ]
                },
                options: {
                    responsive: true,
                    maintainAspectRatio: false,
                    plugins: {
                        legend: {
                            position: 'bottom',
                            labels: { usePointStyle: true, padding: 20 }
                        },
                        tooltip: {
                            backgroundColor: 'rgba(15, 15, 42, 0.95)',
                            borderColor: 'rgba(255,255,255,0.1)',
                            borderWidth: 1,
                            cornerRadius: 10,
                            padding: 12,
                            callbacks: {
                                label: function(ctx) { return ctx.dataset.label + ': ' + ctx.parsed.r + '%'; }
                            }
                        }
                    },
                    scales: {
                        r: {
                            beginAtZero: true,
                            max: 100,
                            grid: { color: 'rgba(255,255,255,0.06)' },
                            angleLines: { color: 'rgba(255,255,255,0.06)' },
                            pointLabels: { font: { size: 12, weight: '500' }, color: '#a0a0b8' },
                            ticks: { display: false, stepSize: 20 }
                        }
                    }
                }
            });
        }
    </script>
</body>
</html>