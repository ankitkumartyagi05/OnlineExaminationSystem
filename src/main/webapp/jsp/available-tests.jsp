<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Available Tests - ExamPro</title>
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

    <%@ include file="header.jsp" %>

    <section style="padding: 140px 0 80px; min-height: 100vh;">
        <div class="container">
            <div class="page-header fade-in">
                <h1><span class="gradient-text">Available</span> Tests</h1>
                <p>Choose an examination to begin your assessment.</p>
            </div>

            <c:choose>
                <c:when test="${empty tests}">
                    <div class="empty-state glass-card-static fade-in">
                        <div class="empty-icon"><i class="bi bi-journal-x"></i></div>
                        <h4 style="color: var(--text-secondary); margin-bottom: 8px;">No Tests Available</h4>
                        <p style="color: var(--text-muted);">There are no active tests at the moment. Please check back later.</p>
                        <a href="${pageContext.request.contextPath}/home" class="btn-gradient btn-sm mt-3">
                            <i class="bi bi-house"></i> Go Home
                        </a>
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="row g-4">
                        <c:forEach var="test" items="${tests}" varStatus="status">
                            <div class="col-lg-4 col-md-6">
                                <div class="glass-card h-100 tilt-card slide-up stagger-${status.index % 6 + 1}" style="padding: 0; overflow: hidden;">
                                    <div style="height: 4px; background: var(--gradient-primary);"></div>
                                    <div style="padding: 28px;">
                                        <div class="d-flex justify-between align-center mb-3">
                                            <span class="badge-gradient badge-subject">
                                                <i class="bi bi-tag me-1"></i>${test.subject}
                                            </span>
                                            <span class="badge-gradient badge-active">
                                                <i class="bi bi-circle-fill me-1" style="font-size: 0.5rem;"></i>Active
                                            </span>
                                        </div>

                                        <h5 style="font-family: 'Space Grotesk'; font-weight: 600; font-size: 1.15rem; margin-bottom: 16px; line-height: 1.4;">
                                            ${test.testName}
                                        </h5>

                                        <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 12px; margin-bottom: 20px;">
                                            <div style="background: rgba(255,255,255,0.03); padding: 12px; border-radius: 10px; text-align: center;">
                                                <div style="font-family: 'Space Grotesk'; font-weight: 700; font-size: 1.3rem; background: var(--gradient-primary); -webkit-background-clip: text; -webkit-text-fill-color: transparent; background-clip: text;">
                                                    ${test.totalQuestions}
                                                </div>
                                                <div style="color: var(--text-muted); font-size: 0.72rem; text-transform: uppercase; letter-spacing: 1px;">Questions</div>
                                            </div>
                                            <div style="background: rgba(255,255,255,0.03); padding: 12px; border-radius: 10px; text-align: center;">
                                                <div style="font-family: 'Space Grotesk'; font-weight: 700; font-size: 1.3rem; background: var(--gradient-accent); -webkit-background-clip: text; -webkit-text-fill-color: transparent; background-clip: text;">
                                                    ${test.durationMinutes}
                                                </div>
                                                <div style="color: var(--text-muted); font-size: 0.72rem; text-transform: uppercase; letter-spacing: 1px;">Minutes</div>
                                            </div>
                                            <div style="background: rgba(255,255,255,0.03); padding: 12px; border-radius: 10px; text-align: center;">
                                                <div style="font-family: 'Space Grotesk'; font-weight: 700; font-size: 1.3rem; background: var(--gradient-success); -webkit-background-clip: text; -webkit-text-fill-color: transparent; background-clip: text;">
                                                    ${test.totalMarks}
                                                </div>
                                                <div style="color: var(--text-muted); font-size: 0.72rem; text-transform: uppercase; letter-spacing: 1px;">Marks</div>
                                            </div>
                                            <div style="background: rgba(255,255,255,0.03); padding: 12px; border-radius: 10px; text-align: center;">
                                                <div style="font-family: 'Space Grotesk'; font-weight: 700; font-size: 1.3rem; background: var(--gradient-warning); -webkit-background-clip: text; -webkit-text-fill-color: transparent; background-clip: text;">
                                                    ${test.passPercentage}%
                                                </div>
                                                <div style="color: var(--text-muted); font-size: 0.72rem; text-transform: uppercase; letter-spacing: 1px;">Pass</div>
                                            </div>
                                        </div>

                                        <a href="${pageContext.request.contextPath}/instructions?testId=${test.id}" class="btn-gradient w-100 justify-content-center btn-sm" style="padding: 12px;">
                                            <i class="bi bi-play-circle-fill"></i> View Instructions
                                        </a>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </section>

    <%@ include file="footer.jsp" %>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    <script src="${pageContext.request.contextPath}/js/main.js"></script>
    <style>
        .slide-up { opacity: 0; transform: translateY(40px); animation: slideUp 0.6s ease-out forwards; }
        @keyframes slideUp { to { opacity: 1; transform: translateY(0); } }
    </style>
</body>
</html>