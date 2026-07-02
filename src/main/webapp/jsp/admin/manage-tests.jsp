<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Manage Tests - ExamPro</title>
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
            <a href="${pageContext.request.contextPath}/admin" class="btn-outline-glass btn-xs">
                <i class="bi bi-box-arrow-left"></i> Dashboard
            </a>
        </div>
    </nav>

    <section style="padding: 120px 0 80px; min-height: 100vh;">
        <div class="container">
            <div class="d-flex justify-between align-center flex-wrap gap-3 mb-4 fade-in">
                <div>
                    <h1 style="font-family: 'Space Grotesk'; font-weight: 700; font-size: 1.6rem;">
                        <span class="gradient-text">Manage</span> Tests
                    </h1>
                    <p style="color: var(--text-secondary); font-size: 0.9rem; margin-bottom: 0;">${tests.size()} test(s) configured</p>
                </div>
                <a href="${pageContext.request.contextPath}/admin/add-test" class="btn-gradient btn-sm">
                    <i class="bi bi-plus-circle-fill"></i> Create Test
                </a>
            </div>

            <c:if test="${param.added == 'true'}">
                <div class="alert-glass success mb-3 fade-in">
                    <i class="bi bi-check-circle-fill"></i>
                    <span>Test created successfully!</span>
                </div>
            </c:if>
            <c:if test="${param.deleted == 'true'}">
                <div class="alert-glass success mb-3 fade-in">
                    <i class="bi bi-check-circle-fill"></i>
                    <span>Test deleted successfully!</span>
                </div>
            </c:if>
            <c:if test="${param.toggled == 'true'}">
                <div class="alert-glass info mb-3 fade-in">
                    <i class="bi bi-info-circle-fill"></i>
                    <span>Test status updated!</span>
                </div>
            </c:if>

            <c:choose>
                <c:when test="${not empty tests}">
                    <div class="row g-4">
                        <c:forEach var="test" items="${tests}" varStatus="status">
                            <div class="col-lg-6">
                                <div class="glass-card h-100 slide-up" style="padding: 0; overflow: hidden;">
                                    <div style="height: 4px; background: ${test.status == 'ACTIVE' ? 'var(--gradient-success)' : 'var(--gradient-danger)'};"></div>
                                    <div style="padding: 24px;">
                                        <div class="d-flex justify-between align-start mb-3">
                                            <div>
                                                <span class="badge-gradient ${test.status == 'ACTIVE' ? 'badge-active' : 'badge-inactive'}">
                                                    <i class="bi bi-circle-fill me-1" style="font-size: 0.4rem;"></i>${test.status}
                                                </span>
                                                <h5 style="font-family: 'Space Grotesk'; font-weight: 600; margin-top: 8px; font-size: 1.05rem; line-height: 1.4;">
                                                    ${test.testName}
                                                </h5>
                                            </div>
                                            <span class="badge-gradient badge-subject">${test.subject}</span>
                                        </div>

                                        <div style="display: grid; grid-template-columns: repeat(4, 1fr); gap: 8px; margin-bottom: 20px;">
                                            <div style="background: rgba(255,255,255,0.03); padding: 10px; border-radius: 8px; text-align: center;">
                                                <div style="font-weight: 700; font-size: 1.1rem; color: var(--text-primary);">${test.totalQuestions}</div>
                                                <div style="color: var(--text-muted); font-size: 0.65rem; text-transform: uppercase; letter-spacing: 0.5px;">Qs</div>
                                            </div>
                                            <div style="background: rgba(255,255,255,0.03); padding: 10px; border-radius: 8px; text-align: center;">
                                                <div style="font-weight: 700; font-size: 1.1rem; color: var(--text-primary);">${test.totalMarks}</div>
                                                <div style="color: var(--text-muted); font-size: 0.65rem; text-transform: uppercase; letter-spacing: 0.5px;">Marks</div>
                                            </div>
                                            <div style="background: rgba(255,255,255,0.03); padding: 10px; border-radius: 8px; text-align: center;">
                                                <div style="font-weight: 700; font-size: 1.1rem; color: var(--text-primary);">${test.durationMinutes}</div>
                                                <div style="color: var(--text-muted); font-size: 0.65rem; text-transform: uppercase; letter-spacing: 0.5px;">Min</div>
                                            </div>
                                            <div style="background: rgba(255,255,255,0.03); padding: 10px; border-radius: 8px; text-align: center;">
                                                <div style="font-weight: 700; font-size: 1.1rem; color: var(--text-primary);">${test.passPercentage}%</div>
                                                <div style="color: var(--text-muted); font-size: 0.65rem; text-transform: uppercase; letter-spacing: 0.5px;">Pass</div>
                                            </div>
                                        </div>

                                        <div class="d-flex gap-2">
                                            <a href="${pageContext.request.contextPath}/admin/toggle-test?id=${test.id}" class="btn-outline-glass btn-xs" style="flex: 1; justify-content: center;">
                                                <i class="bi bi-${test.status == 'ACTIVE' ? 'pause' : 'play'}-circle"></i>
                                                ${test.status == 'ACTIVE' ? 'Deactivate' : 'Activate'}
                                            </a>
                                            <a href="${pageContext.request.contextPath}/admin/delete-test?id=${test.id}" class="btn-danger-gradient btn-xs" style="padding: 5px 14px; font-size: 0.8rem; border-radius: 8px; font-weight: 600; text-decoration: none; display: inline-flex; align-items: center; gap: 4px; border: none; color: white; cursor: pointer;" onclick="return confirm('Delete this test? This cannot be undone.')">
                                                <i class="bi bi-trash3"></i> Delete
                                            </a>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="empty-state glass-card-static fade-in">
                        <div class="empty-icon"><i class="bi bi-journal-x"></i></div>
                        <h4 style="color: var(--text-secondary); margin-bottom: 8px;">No Tests Configured</h4>
                        <p style="color: var(--text-muted);">Create your first test to get started.</p>
                        <a href="${pageContext.request.contextPath}/admin/add-test" class="btn-gradient btn-sm mt-3">
                            <i class="bi bi-plus-circle"></i> Create First Test
                        </a>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </section>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.min.js"></script>
    <script src="${pageContext.request.contextPath}/js/main.js"></script>
    <style>
        .slide-up { opacity: 0; transform: translateY(40px); animation: slideUp 0.6s ease-out forwards; }
        @keyframes slideUp { to { opacity: 1; transform: translateY(0); } }
    </style>
</body>
</html>