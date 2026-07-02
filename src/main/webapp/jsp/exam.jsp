<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Examination - ExamPro</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/css/style.css" rel="stylesheet">
</head>
<body style="background: var(--bg-primary);">

    <nav class="navbar navbar-glass fixed-top" style="padding: 0.6rem 0;">
        <div class="container-fluid px-3">
            <span class="navbar-brand" style="font-size: 1.1rem;">
                <i class="bi bi-pencil-square me-2"></i>${examTest.testName}
            </span>
            <div class="d-flex align-center gap-3">
                <span style="color: var(--text-muted); font-size: 0.85rem; display: none;" class="d-md-inline">
                    <i class="bi bi-person me-1"></i>${sessionScope.candidate.name}
                </span>
                <div class="d-flex align-center gap-2">
                    <i class="bi bi-clock-fill" style="color: var(--text-muted);"></i>
                    <span id="timerDisplay" class="timer-display">00:00</span>
                </div>
            </div>
        </div>
    </nav>

    <input type="hidden" id="examDuration" value="${examTest.durationMinutes}">

    <div style="padding: 90px 16px 40px; min-height: 100vh;">
        <div class="exam-container">
            <!-- Exam Header -->
            <div class="exam-header">
                <div class="d-flex justify-between align-center flex-wrap gap-2">
                    <div>
                        <span class="badge-gradient badge-subject mb-1 d-inline-block">${examTest.subject}</span>
                        <div style="font-size: 0.85rem; color: var(--text-muted);">
                            Question <strong style="color: var(--text-primary);" id="currentQNum">1</strong> of <strong style="color: var(--text-primary);">${examTest.totalQuestions}</strong>
                        </div>
                    </div>
                    <div class="d-flex align-center gap-2">
                        <span style="font-size: 0.82rem; color: var(--text-muted);">
                            <i class="bi bi-check-circle-fill me-1" style="color: #43e97b;"></i>
                            <span id="answeredCount">0</span> answered
                        </span>
                        <button class="btn-danger-gradient btn-xs" onclick="confirmSubmit()" style="border: none; cursor: pointer; padding: 6px 16px; border-radius: 8px; font-weight: 600; font-size: 0.82rem; display: inline-flex; align-items: center; gap: 4px;">
                            <i class="bi bi-flag-fill"></i> Submit
                        </button>
                    </div>
                </div>

                <!-- Progress -->
                <div class="progress-glass mt-3">
                    <div class="progress-bar-gradient" id="examProgress" style="width: 0%;"></div>
                </div>
            </div>

            <!-- Question Navigation Grid -->
            <div class="glass-card-static p-3 mb-4">
                <div class="question-nav-grid" id="questionNavGrid">
                    <c:forEach var="q" items="${examQuestions}" varStatus="status">
                        <button class="question-nav-btn ${status.index == 0 ? 'current' : ''}" data-qid="${q.id}" data-index="${status.index}" onclick="showQuestion(${status.index})">
                            ${status.index + 1}
                        </button>
                    </c:forEach>
                </div>
            </div>

            <!-- Question Form -->
            <form id="examForm" action="${pageContext.request.contextPath}/submit-exam" method="post">

                <c:forEach var="q" items="${examQuestions}" varStatus="status">
                    <div class="question-panel ${status.index == 0 ? 'active' : ''}" data-qid="${q.id}" data-index="${status.index}">
                        <div class="glass-card-static p-4 p-md-5">
                            <div class="d-flex justify-between align-start mb-4 flex-wrap gap-2">
                                <div style="flex: 1;">
                                    <span style="color: var(--text-muted); font-size: 0.82rem; text-transform: uppercase; letter-spacing: 1px;">Question ${status.index + 1}</span>
                                    <h5 style="font-family: 'Space Grotesk'; font-weight: 600; font-size: 1.15rem; margin-top: 6px; line-height: 1.5; color: var(--text-primary);">
                                        ${q.question}
                                    </h5>
                                </div>
                                <span class="badge-gradient badge-subject" style="flex-shrink: 0;">${q.marks} mark${q.marks > 1 ? 's' : ''}</span>
                            </div>

                            <div class="divider"></div>

                            <div class="mt-4">
                                <button type="button" class="option-btn" data-option="A" onclick="selectOption(${q.id}, 'A')">
                                    <span class="option-label">A</span>
                                    <span>${q.optionA}</span>
                                </button>
                                <button type="button" class="option-btn" data-option="B" onclick="selectOption(${q.id}, 'B')">
                                    <span class="option-label">B</span>
                                    <span>${q.optionB}</span>
                                </button>
                                <button type="button" class="option-btn" data-option="C" onclick="selectOption(${q.id}, 'C')">
                                    <span class="option-label">C</span>
                                    <span>${q.optionC}</span>
                                </button>
                                <button type="button" class="option-btn" data-option="D" onclick="selectOption(${q.id}, 'D')">
                                    <span class="option-label">D</span>
                                    <span>${q.optionD}</span>
                                </button>
                            </div>

                            <div class="divider mt-4"></div>

                            <div class="d-flex justify-between align-center mt-3">
                                <button type="button" class="btn-outline-glass btn-sm" id="prevBtn" onclick="showQuestion(${status.index - 1})" ${status.index == 0 ? 'disabled style="opacity:0.3;pointer-events:none;"' : ''}>
                                    <i class="bi bi-arrow-left"></i> Previous
                                </button>
                                <button type="button" class="btn-gradient btn-sm" id="nextBtn" onclick="${status.index == examQuestions.size() - 1 ? 'confirmSubmit()' : 'showQuestion(' + (status.index + 1) + ')'}">
                                    ${status.index == examQuestions.size() - 1 ? '<i class="bi bi-flag-fill me-1"></i>Finish' : 'Next <i class="bi bi-arrow-right ms-1"></i>'}
                                </button>
                            </div>
                        </div>
                    </div>
                </c:forEach>

            </form>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    <script src="${pageContext.request.contextPath}/js/exam.js"></script>
    <script>
        function updateNavButtons() {
            const prevBtn = document.querySelector('.question-panel.active #prevBtn');
            const nextBtn = document.querySelector('.question-panel.active #nextBtn');
            if (prevBtn) {
                if (currentQuestion === 0) {
                    prevBtn.disabled = true;
                    prevBtn.style.opacity = '0.3';
                    prevBtn.style.pointerEvents = 'none';
                } else {
                    prevBtn.disabled = false;
                    prevBtn.style.opacity = '1';
                    prevBtn.style.pointerEvents = 'auto';
                    prevBtn.setAttribute('onclick', 'showQuestion(' + (currentQuestion - 1) + ')');
                }
            }
            if (nextBtn) {
                if (currentQuestion === totalQuestions - 1) {
                    nextBtn.innerHTML = '<i class="bi bi-flag-fill me-1"></i>Finish';
                    nextBtn.setAttribute('onclick', 'confirmSubmit()');
                } else {
                    nextBtn.innerHTML = 'Next <i class="bi bi-arrow-right ms-1"></i>';
                    nextBtn.setAttribute('onclick', 'showQuestion(' + (currentQuestion + 1) + ')');
                }
            }
            document.getElementById('currentQNum').textContent = currentQuestion + 1;
            document.getElementById('answeredCount').textContent = Object.keys(answers).length;
            const progress = (Object.keys(answers).length / totalQuestions) * 100;
            document.getElementById('examProgress').style.width = progress + '%';
        }
    </script>
</body>
</html>