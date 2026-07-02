<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Edit Question - ExamPro</title>
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
            <a href="${pageContext.request.contextPath}/admin/questions" class="btn-outline-glass btn-xs">
                <i class="bi bi-arrow-left"></i> Back to Questions
            </a>
        </div>
    </nav>

    <section style="padding: 120px 0 80px; min-height: 100vh;">
        <div class="container">
            <div class="row justify-content-center">
                <div class="col-lg-9">
                    <div class="page-header fade-in">
                        <h1><span class="gradient-text">Edit</span> Question #${question.id}</h1>
                        <p>Modify the question details below.</p>
                    </div>

                    <div class="glass-card-static p-4 p-md-5 fade-in">
                        <form action="${pageContext.request.contextPath}/admin/edit-question?id=${question.id}" method="post" id="editForm" novalidate>
                            <div class="row g-3">
                                <div class="col-md-6">
                                    <label class="form-label-glass"><i class="bi bi-tag me-1"></i>Subject <span style="color: #ff6b6b;">*</span></label>
                                    <input type="text" name="subject" list="subjectList" class="form-control-glass" required value="${question.subject}">
                                    <datalist id="subjectList">
                                        <c:forEach var="sub" items="${subjects}">
                                            <option value="${sub}">
                                        </c:forEach>
                                    </datalist>
                                </div>
                                <div class="col-md-6">
                                    <label class="form-label-glass"><i class="bi bi-star me-1"></i>Marks <span style="color: #ff6b6b;">*</span></label>
                                    <input type="number" name="marks" class="form-control-glass" min="1" max="100" required value="${question.marks}">
                                </div>
                                <div class="col-12">
                                    <label class="form-label-glass"><i class="bi bi-chat-left-text me-1"></i>Question <span style="color: #ff6b6b;">*</span></label>
                                    <textarea name="question" class="form-control-glass" rows="3" required style="resize: vertical;">${question.question}</textarea>
                                </div>

                                <div class="col-12"><div class="divider"></div></div>
                                <div class="col-12">
                                    <h6 style="color: var(--text-secondary); font-size: 0.88rem; font-weight: 600;">
                                        <i class="bi bi-list-ol me-1"></i> Answer Options
                                    </h6>
                                </div>

                                <div class="col-md-6">
                                    <label class="form-label-glass">Option A <span style="color: #ff6b6b;">*</span></label>
                                    <input type="text" name="optionA" class="form-control-glass" required value="${question.optionA}">
                                </div>
                                <div class="col-md-6">
                                    <label class="form-label-glass">Option B <span style="color: #ff6b6b;">*</span></label>
                                    <input type="text" name="optionB" class="form-control-glass" required value="${question.optionB}">
                                </div>
                                <div class="col-md-6">
                                    <label class="form-label-glass">Option C <span style="color: #ff6b6b;">*</span></label>
                                    <input type="text" name="optionC" class="form-control-glass" required value="${question.optionC}">
                                </div>
                                <div class="col-md-6">
                                    <label class="form-label-glass">Option D <span style="color: #ff6b6b;">*</span></label>
                                    <input type="text" name="optionD" class="form-control-glass" required value="${question.optionD}">
                                </div>

                                <div class="col-12"><div class="divider"></div></div>

                                <div class="col-md-6">
                                    <label class="form-label-glass"><i class="bi bi-check-circle me-1"></i>Correct Answer <span style="color: #ff6b6b;">*</span></label>
                                    <select name="correctAnswer" class="form-control-glass" required>
                                        <option value="A" ${question.correctAnswer == 'A' ? 'selected' : ''}>A</option>
                                        <option value="B" ${question.correctAnswer == 'B' ? 'selected' : ''}>B</option>
                                        <option value="C" ${question.correctAnswer == 'C' ? 'selected' : ''}>C</option>
                                        <option value="D" ${question.correctAnswer == 'D' ? 'selected' : ''}>D</option>
                                    </select>
                                </div>

                                <div class="col-12 mt-4">
                                    <div class="d-flex gap-3">
                                        <button type="submit" class="btn-gradient" style="flex: 1; justify-content: center;">
                                            <i class="bi bi-check-circle-fill"></i> Update Question
                                        </button>
                                        <a href="${pageContext.request.contextPath}/admin/questions" class="btn-outline-glass" style="justify-content: center;">
                                            Cancel
                                        </a>
                                    </div>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    <script src="${pageContext.request.contextPath}/js/main.js"></script>
    <script>
        document.getElementById('editForm').addEventListener('submit', function(e) {
            let valid = true;
            this.querySelectorAll('[required]').forEach(input => {
                if (!input.value.trim()) {
                    valid = false;
                    input.style.borderColor = '#ff6b6b';
                    input.addEventListener('input', function() { this.style.borderColor = ''; }, { once: true });
                }
            });
            if (!valid) { e.preventDefault(); showToast('Please fill in all required fields.', 'error'); }
        });
    </script>
</body>
</html>