<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Register - ExamPro</title>
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
                <div class="col-lg-7 col-xl-6">
                    <div class="text-center mb-4 fade-in">
                        <h1 style="font-family: 'Space Grotesk'; font-weight: 700; font-size: 2rem; margin-bottom: 8px;">
                            <span class="gradient-text">Candidate</span> Registration
                        </h1>
                        <p style="color: var(--text-secondary); font-size: 0.95rem;">Fill in your details to get started. No password required.</p>
                    </div>

                    <c:if test="${not empty error}">
                        <div class="alert-glass error mb-4 fade-in">
                            <i class="bi bi-exclamation-circle-fill"></i>
                            <span>${error}</span>
                        </div>
                    </c:if>

                    <div class="glass-card-static p-4 p-md-5 fade-in">
                        <form action="${pageContext.request.contextPath}/register" method="post" id="registerForm" novalidate>
                            <div class="row g-3">
                                <div class="col-md-6">
                                    <label class="form-label-glass">
                                        <i class="bi bi-person me-1"></i>Full Name <span style="color: #ff6b6b;">*</span>
                                    </label>
                                    <input type="text" name="name" class="form-control-glass" placeholder="Enter your full name" required value="${param.name}">
                                </div>
                                <div class="col-md-6">
                                    <label class="form-label-glass">
                                        <i class="bi bi-hash me-1"></i>Roll Number <span style="color: #ff6b6b;">*</span>
                                    </label>
                                    <input type="text" name="rollNumber" class="form-control-glass" placeholder="e.g. 2024CS001" required value="${param.rollNumber}">
                                </div>
                                <div class="col-md-6">
                                    <label class="form-label-glass">
                                        <i class="bi bi-envelope me-1"></i>Email <span style="color: #ff6b6b;">*</span>
                                    </label>
                                    <input type="email" name="email" class="form-control-glass" placeholder="your@email.com" required value="${param.email}">
                                </div>
                                <div class="col-md-6">
                                    <label class="form-label-glass">
                                        <i class="bi bi-phone me-1"></i>Mobile Number <span style="color: #ff6b6b;">*</span>
                                    </label>
                                    <input type="tel" name="mobile" class="form-control-glass" placeholder="10-digit mobile number" required value="${param.mobile}">
                                </div>
                                <div class="col-md-6">
                                    <label class="form-label-glass">
                                        <i class="bi bi-building me-1"></i>College <span style="color: #ff6b6b;">*</span>
                                    </label>
                                    <input type="text" name="college" class="form-control-glass" placeholder="Your college name" required value="${param.college}">
                                </div>
                                <div class="col-md-6">
                                    <label class="form-label-glass">
                                        <i class="bi bi-book me-1"></i>Course <span style="color: #ff6b6b;">*</span>
                                    </label>
                                    <select name="course" class="form-control-glass" required>
                                        <option value="" disabled selected>Select your course</option>
                                        <option value="B.Tech CSE" ${param.course == 'B.Tech CSE' ? 'selected' : ''}>B.Tech CSE</option>
                                        <option value="B.Tech IT" ${param.course == 'B.Tech IT' ? 'selected' : ''}>B.Tech IT</option>
                                        <option value="B.Tech ECE" ${param.course == 'B.Tech ECE' ? 'selected' : ''}>B.Tech ECE</option>
                                        <option value="B.Tech EE" ${param.course == 'B.Tech EE' ? 'selected' : ''}>B.Tech EE</option>
                                        <option value="B.Tech ME" ${param.course == 'B.Tech ME' ? 'selected' : ''}>B.Tech ME</option>
                                        <option value="B.Tech CE" ${param.course == 'B.Tech CE' ? 'selected' : ''}>B.Tech CE</option>
                                        <option value="M.Tech CSE" ${param.course == 'M.Tech CSE' ? 'selected' : ''}>M.Tech CSE</option>
                                        <option value="MCA" ${param.course == 'MCA' ? 'selected' : ''}>MCA</option>
                                        <option value="MSc CS" ${param.course == 'MSc CS' ? 'selected' : ''}>MSc Computer Science</option>
                                        <option value="BCA" ${param.course == 'BCA' ? 'selected' : ''}>BCA</option>
                                        <option value="BSc CS" ${param.course == 'BSc CS' ? 'selected' : ''}>BSc Computer Science</option>
                                        <option value="Other" ${param.course == 'Other' ? 'selected' : ''}>Other</option>
                                    </select>
                                </div>
                                <div class="col-12 mt-4">
                                    <button type="submit" class="btn-gradient w-100 justify-content-center" style="padding: 14px;">
                                        <i class="bi bi-arrow-right-circle-fill"></i> Register & Continue
                                    </button>
                                </div>
                            </div>
                        </form>
                    </div>

                    <div class="text-center mt-3" style="color: var(--text-muted); font-size: 0.85rem;">
                        <i class="bi bi-info-circle me-1"></i> Your data is used only for examination purposes.
                    </div>
                </div>
            </div>
        </div>
    </section>

    <%@ include file="footer.jsp" %>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    <script src="${pageContext.request.contextPath}/js/main.js"></script>
    <script>
        document.getElementById('registerForm').addEventListener('submit', function(e) {
            const form = this;
            const inputs = form.querySelectorAll('[required]');
            let valid = true;
            inputs.forEach(input => {
                if (!input.value.trim()) {
                    valid = false;
                    input.style.borderColor = '#ff6b6b';
                    input.addEventListener('input', function() {
                        this.style.borderColor = '';
                    }, { once: true });
                }
            });
            if (!valid) {
                e.preventDefault();
                showToast('Please fill in all required fields.', 'error');
            }
        });
    </script>
</body>
</html>