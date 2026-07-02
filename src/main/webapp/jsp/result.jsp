<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Result - ExamPro</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/css/style.css" rel="stylesheet">
</head>
<body>
    <div class="bg-animated">
        <div class="orb orb-1"></div>
        <div class="orb orb-2"></div>
        <div class="orb orb-3"></div>
        <div class="orb orb-4"></div>
    </div>

    <%@ include file="header.jsp" %>

    <section style="padding: 140px 0 80px; min-height: 100vh;">
        <div class="container">
            <div class="row justify-content-center">
                <div class="col-lg-8">
                    <div class="text-center mb-4 fade-in">
                        <h1 style="font-family: 'Space Grotesk'; font-weight: 700; font-size: 2rem;">
                            Your <span class="gradient-text">Result</span>
                        </h1>
                    </div>

                    <!-- Main Result Card -->
                    <div class="glass-card-static result-card ${result.passFail == 'PASS' ? 'pass' : 'fail'} scale-in" style="padding: 50px 40px;">
                        <div class="result-icon">
                            <c:choose>
                                <c:when test="${result.passFail == 'PASS'}">
                                    <i class="bi bi-trophy-fill" style="color: #43e97b;"></i>
                                </c:when>
                                <c:otherwise>
                                    <i class="bi bi-emoji-frown" style="color: #ff6b6b;"></i>
                                </c:otherwise>
                            </c:choose>
                        </div>

                        <h2 style="font-family: 'Space Grotesk'; font-weight: 700; margin-bottom: 8px;">
                            ${result.passFail == 'PASS' ? 'Congratulations!' : 'Keep Trying!'}
                        </h2>
                        <p style="color: var(--text-secondary); margin-bottom: 24px;">
                            ${result.passFail == 'PASS' ? 'You have successfully passed the examination.' : 'You did not meet the passing criteria this time.'}
                        </p>

                        <div class="result-percentage ${result.passFail == 'PASS' ? 'pass' : 'fail'}">
                            ${result.percentage}%
                        </div>
                        <div style="margin-top: 8px;">
                            <span class="badge-gradient ${result.passFail == 'PASS' ? 'badge-pass' : 'badge-fail'}" style="font-size: 0.9rem; padding: 8px 24px;">
                                ${result.passFail}
                            </span>
                        </div>

                        <div class="progress-glass mt-4" style="max-width: 300px; margin-left: auto; margin-right: auto;">
                            <div class="progress-bar-gradient" id="resultProgress" style="width: 0%;
                                background: ${result.passFail == 'PASS' ? 'var(--gradient-success)' : 'var(--gradient-danger)'};">
                            </div>
                        </div>

                        <div class="result-stat-grid">
                            <div class="result-stat-item">
                                <div class="value" style="background: var(--gradient-primary); -webkit-background-clip: text; -webkit-text-fill-color: transparent; background-clip: text;">${result.totalQuestions}</div>
                                <div class="label">Total Questions</div>
                            </div>
                            <div class="result-stat-item">
                                <div class="value" style="background: var(--gradient-success); -webkit-background-clip: text; -webkit-text-fill-color: transparent; background-clip: text;">${result.correctAnswers}</div>
                                <div class="label">Correct</div>
                            </div>
                            <div class="result-stat-item">
                                <div class="value" style="background: var(--gradient-danger); -webkit-background-clip: text; -webkit-text-fill-color: transparent; background-clip: text;">${result.wrongAnswers}</div>
                                <div class="label">Wrong</div>
                            </div>
                            <div class="result-stat-item">
                                <div class="value" style="background: var(--gradient-accent); -webkit-background-clip: text; -webkit-text-fill-color: transparent; background-clip: text;">${result.marksObtained}/${result.totalMarks}</div>
                                <div class="label">Marks</div>
                            </div>
                        </div>
                    </div>

                    <!-- Details Card -->
                    <div class="glass-card-static p-4 mt-4 fade-in">
                        <h6 style="font-family: 'Space Grotesk'; font-weight: 600; margin-bottom: 16px; color: var(--text-secondary);">
                            <i class="bi bi-info-circle me-2"></i>Examination Details
                        </h6>
                        <div class="row g-3">
                            <div class="col-md-6">
                                <div style="display: flex; justify-content: space-between; padding: 10px 0; border-bottom: 1px solid rgba(255,255,255,0.04);">
                                    <span style="color: var(--text-muted); font-size: 0.88rem;">Candidate Name</span>
                                    <span style="font-weight: 500; font-size: 0.88rem;">${result.candidateName}</span>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div style="display: flex; justify-content: space-between; padding: 10px 0; border-bottom: 1px solid rgba(255,255,255,0.04);">
                                    <span style="color: var(--text-muted); font-size: 0.88rem;">Roll Number</span>
                                    <span style="font-weight: 500; font-size: 0.88rem;">${result.rollNumber}</span>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div style="display: flex; justify-content: space-between; padding: 10px 0; border-bottom: 1px solid rgba(255,255,255,0.04);">
                                    <span style="color: var(--text-muted); font-size: 0.88rem;">Exam Name</span>
                                    <span style="font-weight: 500; font-size: 0.88rem;">${result.examName}</span>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div style="display: flex; justify-content: space-between; padding: 10px 0; border-bottom: 1px solid rgba(255,255,255,0.04);">
                                    <span style="color: var(--text-muted); font-size: 0.88rem;">Unanswered</span>
                                    <span style="font-weight: 500; font-size: 0.88rem;">${result.totalQuestions - result.correctAnswers - result.wrongAnswers}</span>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Action Buttons -->
                    <div class="d-flex justify-content-center gap-3 mt-4 flex-wrap fade-in">
                        <a href="${pageContext.request.contextPath}/performance" class="btn-gradient">
                            <i class="bi bi-graph-up"></i> View Performance
                        </a>
                        <a href="${pageContext.request.contextPath}/tests" class="btn-outline-glass">
                            <i class="bi bi-collection"></i> More Tests
                        </a>
                        <a href="${pageContext.request.contextPath}/home" class="btn-outline-glass">
                            <i class="bi bi-house"></i> Home
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <%@ include file="footer.jsp" %>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    <script src="${pageContext.request.contextPath}/js/main.js"></script>
    <script>
        setTimeout(() => {
            const bar = document.getElementById('resultProgress');
            if (bar) bar.style.width = '${result.percentage}%';
        }, 300);
    </script>
</body>
</html>