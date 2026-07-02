<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Instructions - ExamPro</title>
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
            <div class="row justify-content-center">
                <div class="col-lg-8">
                    <div class="page-header text-center fade-in">
                        <h1>Exam <span class="gradient-text">Instructions</span></h1>
                        <p>Read carefully before starting the examination.</p>
                    </div>

                    <div class="glass-card-static p-4 p-md-5 mb-4 fade-in">
                        <div class="d-flex justify-between align-center mb-4 flex-wrap gap-2">
                            <div>
                                <span class="badge-gradient badge-subject mb-2 d-inline-block">${test.subject}</span>
                                <h4 style="font-family: 'Space Grotesk'; font-weight: 600; margin-bottom: 0;">${test.testName}</h4>
                            </div>
                            <div style="text-align: right;">
                                <div style="color: var(--text-muted); font-size: 0.8rem; text-transform: uppercase; letter-spacing: 1px;">Duration</div>
                                <div style="font-family: 'Space Grotesk'; font-weight: 700; font-size: 1.5rem; background: var(--gradient-accent); -webkit-background-clip: text; -webkit-text-fill-color: transparent; background-clip: text;">
                                    ${test.durationMinutes} min
                                </div>
                            </div>
                        </div>

                        <div class="divider"></div>

                        <ul class="instruction-list mt-3">
                            <li>
                                <span class="inst-icon" style="background: rgba(102, 126, 234, 0.15); color: #667eea;"><i class="bi bi-1-circle-fill"></i></span>
                                <span>This exam contains <strong style="color: var(--text-primary);">${test.totalQuestions} questions</strong> with a total of <strong style="color: var(--text-primary);">${test.totalMarks} marks</strong>.</span>
                            </li>
                            <li>
                                <span class="inst-icon" style="background: rgba(245, 87, 108, 0.15); color: #f5576c;"><i class="bi bi-2-circle-fill"></i></span>
                                <span>Each question carries <strong style="color: var(--text-primary);">${test.totalMarks / test.totalQuestions} mark(s)</strong>. There is no negative marking.</span>
                            </li>
                            <li>
                                <span class="inst-icon" style="background: rgba(79, 172, 254, 0.15); color: #4facfe;"><i class="bi bi-3-circle-fill"></i></span>
                                <span>Questions are presented in <strong style="color: var(--text-primary);">random order</strong> for every candidate.</span>
                            </li>
                            <li>
                                <span class="inst-icon" style="background: rgba(67, 233, 123, 0.15); color: #43e97b;"><i class="bi bi-4-circle-fill"></i></span>
                                <span>You must score at least <strong style="color: var(--text-primary);">${test.passPercentage}%</strong> to pass the examination.</span>
                            </li>
                            <li>
                                <span class="inst-icon" style="background: rgba(253, 160, 133, 0.15); color: #fda085;"><i class="bi bi-5-circle-fill"></i></span>
                                <span>The timer will start as soon as you click "Start Exam". The exam will <strong style="color: var(--text-primary);">auto-submit</strong> when the timer reaches zero.</span>
                            </li>
                            <li>
                                <span class="inst-icon" style="background: rgba(161, 140, 209, 0.15); color: #a18cd1;"><i class="bi bi-6-circle-fill"></i></span>
                                <span>You can navigate between questions using the <strong style="color: var(--text-primary);">Previous/Next</strong> buttons or the question navigation grid.</span>
                            </li>
                            <li>
                                <span class="inst-icon" style="background: rgba(255, 107, 107, 0.15); color: #ff6b6b;"><i class="bi bi-7-circle-fill"></i></span>
                                <span>You can <strong style="color: var(--text-primary);">change your answer</strong> before final submission.</span>
                            </li>
                            <li>
                                <span class="inst-icon" style="background: rgba(0, 242, 254, 0.15); color: #00f2fe;"><i class="bi bi-8-circle-fill"></i></span>
                                <span><strong style="color: var(--text-primary);">Only one submission</strong> is allowed. Once submitted, you cannot retake this exam.</span>
                            </li>
                            <li>
                                <span class="inst-icon" style="background: rgba(246, 211, 101, 0.15); color: #f6d365;"><i class="bi bi-9-circle-fill"></i></span>
                                <span>Do <strong style="color: var(--text-primary);">NOT refresh</strong> the page or close the browser during the exam.</span>
                            </li>
                            <li>
                                <span class="inst-icon" style="background: rgba(67, 233, 123, 0.15); color: #43e97b;"><i class="bi bi-check-circle-fill"></i></span>
                                <span>Results will be displayed <strong style="color: var(--text-primary);">immediately</strong> after submission with detailed performance breakdown.</span>
                            </li>
                        </ul>
                    </div>

                    <div class="d-flex justify-content-center gap-3 fade-in">
                        <a href="${pageContext.request.contextPath}/tests" class="btn-outline-glass">
                            <i class="bi bi-arrow-left"></i> Go Back
                        </a>
                        <a href="${pageContext.request.contextPath}/start-exam?testId=${test.id}" class="btn-success-gradient" style="padding: 12px 40px; font-size: 1.05rem; text-decoration: none; display: inline-flex; align-items: center; gap: 8px; border-radius: 10px; font-weight: 600; cursor: pointer; transition: all 0.4s cubic-bezier(0.25, 0.46, 0.45, 0.94); border: none;">
                            <i class="bi bi-play-fill"></i> Start Exam
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <%@ include file="footer.jsp" %>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    <script src="${pageContext.request.contextPath}/js/main.js"></script>
</body>
</html>