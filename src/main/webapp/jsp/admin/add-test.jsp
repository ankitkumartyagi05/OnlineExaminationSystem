<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Create Test - ExamPro</title>
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
            <a href="${pageContext.request.contextPath}/admin/tests" class="btn-outline-glass btn-xs">
                <i class="bi bi-arrow-left"></i> Back to Tests
            </a>
        </div>
    </nav>

    <section style="padding: 120px 0 80px; min-height: 100vh;">
        <div class="container">
            <div class="row justify-content-center">
                <div class="col-lg-7 col-xl-6">
                    <div class="page-header text-center fade-in">
                        <h1><span class="gradient-text">Create</span> Test</h1>
                        <p>Configure a new examination.</p>
                    </div>

                    <c:if test="${not empty error}">
                        <div class="alert-glass error mb-4 fade-in">
                            <i class="bi bi-exclamation-circle-fill"></i>
                            <span>${error}</span>
                        </div>
                    </c:if>

                    <div class="glass-card-static p-4 p-md-5 fade-in">
                        <form action="${pageContext.request.contextPath}/admin/add-test" method="post" id="testForm" novalidate>
                            <div class="row g-3">
                                <div class="col-12">
                                    <label class="form-label-glass"><i class="bi bi-type-h1 me-1"></i>Test Name <span style="color: #ff6b6b;">*</span></label>
                                    <input type="text" name="testName" class="form-control-glass" placeholder="e.g. Java Fundamentals Assessment" required value="${param.testName}">
                                </div>
                                <div class="col-12">
                                    <label class="form-label-glass"><i class="bi bi-tag me-1"></i>Subject <span style="color: #ff6b6b;">*</span></label>
                                    <select name="subject" class="form-control-glass" required id="subjectSelect">
                                        <option value="" disabled selected>Select a subject</option>
                                        <c:forEach var="sub" items="${subjects}">
                                            <option value="${sub}" ${param.subject == sub ? 'selected' : ''}>${sub}</option>
                                        </c:forEach>
                                    </select>
                                    <div id="subjectInfo" style="color: var(--text-muted); font-size: 0.8rem; margin-top: 6px;"></div>
                                </div>
                                <div class="col-md-6">
                                    <label class="form-label-glass"><i class="bi bi-list-ol me-1"></i>Total Questions <span style="color: #ff6b6b;">*</span></label>
                                    <input type="number" name="totalQuestions" class="form-control-glass" placeholder="e.g. 10" min="1" max="100" required value="${param.totalQuestions}" id="totalQsInput">
                                    <div id="qsWarning" style="color: #fda085; font-size: 0.8rem; margin-top: 6px; display: none;"></div>
                                </div>
                                <div class="col-md-6">
                                    <label class="form-label-glass"><i class="bi bi-clock me-1"></i>Duration (Minutes) <span style="color: #ff6b6b;">*</span></label>
                                    <input type="number" name="durationMinutes" class="form-control-glass" placeholder="e.g. 15" min="1" max="300" required value="${param.durationMinutes}">
                                </div>
                                <div class="col-md-6">
                                    <label class="form-label-glass"><i class="bi bi-percent me-1"></i>Pass Percentage</label>
                                    <input type="number" name="passPercentage" class="form-control-glass" placeholder="40" min="0" max="100" step="0.01" value="${empty param.passPercentage ? '40' : param.passPercentage}">
                                </div>
                                <div class="col-12 mt-4">
                                    <div class="d-flex gap-3">
                                        <button type="submit" class="btn-gradient" style="flex: 1; justify-content: center;">
                                            <i class="bi bi-plus-circle-fill"></i> Create Test
                                        </button>
                                        <a href="${pageContext.request.contextPath}/admin/tests" class="btn-outline-glass" style="justify-content: center;">
                                            Cancel
                                        </a>
                                    </div>
                                </div>
                            </div>
                        </form>
                    </div>

                    <div class="alert-glass info mt-3 fade-in">
                        <i class="bi bi-info-circle-fill"></i>
                        <span>Questions will be randomly selected from the chosen subject. Make sure enough questions exist.</span>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    <script src="${pageContext.request.contextPath}/js/main.js"></script>
    <script>
        const subjectCounts = {};
        <c:forEach var="entry" items="${subjectCounts}">
            subjectCounts['${entry.key}'] = ${entry.value};
        </c:forEach>

        document.getElementById('testForm').addEventListener('submit', function(e) {
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

        document.getElementById('totalQsInput').addEventListener('input', function() {
            const subject = document.getElementById('subjectSelect').value;
            const qs = parseInt(this.value) || 0;
            const warning = document.getElementById('qsWarning');
            if (subject && subjectCounts[subject] !== undefined && qs > subjectCounts[subject]) {
                warning.textContent = 'Warning: Only ' + subjectCounts[subject] + ' questions available for this subject.';
                warning.style.display = 'block';
            } else {
                warning.style.display = 'none';
            }
        });
    </script>
</body>
</html>