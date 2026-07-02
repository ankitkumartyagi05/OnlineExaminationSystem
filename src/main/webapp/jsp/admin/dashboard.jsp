<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard - ExamPro</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/css/style.css" rel="stylesheet">
</head>
<body>
    <div class="bg-animated">
        <div class="orb orb-1"></div>
        <div class="orb orb-2"></div>
        <div class="orb orb-3"></div>
    </div>

    <nav class="navbar navbar-glass fixed-top" style="padding: 0.8rem 0;">
        <div class="container">
            <a class="navbar-brand" href="${pageContext.request.contextPath}/admin">
                <i class="bi bi-gear-fill me-2"></i>Admin Panel
            </a>
            <a href="${pageContext.request.contextPath}/home" class="btn-outline-glass btn-xs">
                <i class="bi bi-box-arrow-left"></i> Back to Site
            </a>
        </div>
    </nav>

    <section style="padding: 120px 0 80px; min-height: 100vh;">
        <div class="container">
            <div class="page-header fade-in">
                <h1><span class="gradient-text">Admin</span> Dashboard</h1>
                <p>Manage questions, tests, and view results.</p>
            </div>

            <!-- Stats -->
            <div class="row g-4 mb-4">
                <div class="col-lg-3 col-md-6">
                    <a href="${pageContext.request.contextPath}/admin/questions" style="text-decoration: none;">
                        <div class="glass-card stat-card stat-card-2 tilt-card fade-in">
                            <div class="stat-icon"><i class="bi bi-question-circle-fill"></i></div>
                            <div class="stat-number" data-count="${totalQuestions}">0</div>
                            <div class="stat-label">Questions</div>
                        </div>
                    </a>
                </div>
                <div class="col-lg-3 col-md-6">
                    <a href="${pageContext.request.contextPath}/admin/tests" style="text-decoration: none;">
                        <div class="glass-card stat-card stat-card-3 tilt-card fade-in">
                            <div class="stat-icon"><i class="bi bi-journal-check"></i></div>
                            <div class="stat-number" data-count="${totalTests}">0</div>
                            <div class="stat-label">Active Tests</div>
                        </div>
                    </a>
                </div>
                <div class="col-lg-3 col-md-6">
                    <div class="glass-card stat-card stat-card-1 tilt-card fade-in">
                        <div class="stat-icon"><i class="bi bi-people-fill"></i></div>
                        <div class="stat-number" data-count="${totalCandidates}">0</div>
                        <div class="stat-label">Candidates</div>
                    </div>
                </div>
                <div class="col-lg-3 col-md-6">
                    <div class="glass-card stat-card stat-card-4 tilt-card fade-in">
                        <div class="stat-icon"><i class="bi bi-trophy-fill"></i></div>
                        <div class="stat-number" data-count="${totalResults}">0</div>
                        <div class="stat-label">Results</div>
                    </div>
                </div>
            </div>

            <!-- Quick Actions -->
            <div class="row g-4 mb-4">
                <div class="col-lg-6">
                    <div class="glass-card-static p-4 fade-in">
                        <h6 style="font-family: 'Space Grotesk'; font-weight: 600; margin-bottom: 20px; color: var(--text-secondary);">
                            <i class="bi bi-lightning-fill me-2"></i>Quick Actions
                        </h6>
                        <div class="d-flex flex-wrap gap-2">
                            <a href="${pageContext.request.contextPath}/admin/add-question" class="btn-gradient btn-sm">
                                <i class="bi bi-plus-circle"></i> Add Question
                            </a>
                            <a href="${pageContext.request.contextPath}/admin/add-test" class="btn-accent-gradient btn-sm" style="padding: 8px 18px; font-size: 0.85rem; border-radius: 10px; font-weight: 600; text-decoration: none; display: inline-flex; align-items: center; gap: 6px; border: none; color: white; cursor: pointer; transition: all 0.4s;">
                                <i class="bi bi-plus-circle"></i> Create Test
                            </a>
                            <a href="${pageContext.request.contextPath}/admin/questions" class="btn-outline-glass btn-sm">
                                <i class="bi bi-search"></i> Manage Questions
                            </a>
                            <a href="${pageContext.request.contextPath}/admin/tests" class="btn-outline-glass btn-sm">
                                <i class="bi bi-sliders"></i> Manage Tests
                            </a>
                        </div>
                    </div>
                </div>
                <div class="col-lg-6">
                    <div class="glass-card-static p-4 fade-in">
                        <h6 style="font-family: 'Space Grotesk'; font-weight: 600; margin-bottom: 16px; color: var(--text-secondary);">
                            <i class="bi bi-tags-fill me-2"></i>Subjects
                        </h6>
                        <c:choose>
                            <c:when test="${not empty subjects}">
                                <div class="d-flex flex-wrap gap-2">
                                    <c:forEach var="sub" items="${subjects}">
                                        <span class="badge-gradient badge-subject">${sub}</span>
                                    </c:forEach>
                                </div>
                            </c:when>
                            <c:otherwise>
                                <p style="color: var(--text-muted); font-size: 0.9rem;">No subjects found. Add questions to create subjects.</p>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
            </div>

            <!-- Recent Results -->
            <div class="glass-card-static p-4 fade-in">
                <div class="d-flex justify-between align-center mb-3">
                    <h6 style="font-family: 'Space Grotesk'; font-weight: 600; color: var(--text-secondary); margin-bottom: 0;">
                        <i class="bi bi-clock-history me-2"></i>Recent Results
                    </h6>
                    <span style="color: var(--text-muted); font-size: 0.82rem;">Last ${recentResults.size()} entries</span>
                </div>
                <c:choose>
                    <c:when test="${not empty recentResults}">
                        <div style="overflow-x: auto;">
                            <table class="table-glass">
                                <thead>
                                    <tr>
                                        <th>Candidate</th>
                                        <th>Roll No</th>
                                        <th>Exam</th>
                                        <th>Score</th>
                                        <th>Percentage</th>
                                        <th>Status</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="r" items="${recentResults}">
                                        <tr>
                                            <td style="font-weight: 500; color: var(--text-primary);">${r.candidateName}</td>
                                            <td>${r.rollNumber}</td>
                                            <td>${r.examName}</td>
                                            <td style="font-weight: 600; color: var(--text-primary);">${r.marksObtained}/${r.totalMarks}</td>
                                            <td style="font-weight: 700; color: var(--text-primary);">${r.percentage}%</td>
                                            <td><span class="badge-gradient ${r.passFail == 'PASS' ? 'badge-pass' : 'badge-fail'}">${r.passFail}</span></td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="empty-state" style="padding: 40px;">
                            <p style="color: var(--text-muted);">No results yet.</p>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </section>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    <script src="${pageContext.request.contextPath}/js/main.js"></script>
</body>
</html>