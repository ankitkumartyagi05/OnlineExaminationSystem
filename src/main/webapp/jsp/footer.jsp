<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<footer class="footer-glass" style="position: relative;">
    <div class="container">
        <div class="row g-4">
            <div class="col-lg-4 col-md-6">
                <div class="footer-brand mb-3">
                    <i class="bi bi-mortarboard-fill me-2"></i>ExamPro
                </div>
                <p style="color: var(--text-muted); font-size: 0.88rem; max-width: 280px;">
                    A modern online examination platform for conducting tests, evaluating answers, and analyzing performance.
                </p>
            </div>
            <div class="col-lg-2 col-md-6">
                <h6 style="color: var(--text-secondary); font-size: 0.85rem; text-transform: uppercase; letter-spacing: 1px; margin-bottom: 16px;">Quick Links</h6>
                <div class="d-flex flex-column gap-2">
                    <a class="footer-link" href="${pageContext.request.contextPath}/home">Home</a>
                    <a class="footer-link" href="${pageContext.request.contextPath}/tests">Tests</a>
                    <a class="footer-link" href="${pageContext.request.contextPath}/register">Register</a>
                </div>
            </div>
            <div class="col-lg-2 col-md-6">
                <h6 style="color: var(--text-secondary); font-size: 0.85rem; text-transform: uppercase; letter-spacing: 1px; margin-bottom: 16px;">Admin</h6>
                <div class="d-flex flex-column gap-2">
                    <a class="footer-link" href="${pageContext.request.contextPath}/admin">Dashboard</a>
                    <a class="footer-link" href="${pageContext.request.contextPath}/admin/questions">Questions</a>
                    <a class="footer-link" href="${pageContext.request.contextPath}/admin/tests">Manage Tests</a>
                </div>
            </div>
            <div class="col-lg-4 col-md-6">
                <h6 style="color: var(--text-secondary); font-size: 0.85rem; text-transform: uppercase; letter-spacing: 1px; margin-bottom: 16px;">Technology</h6>
                <div class="d-flex flex-wrap gap-2">
                    <span class="badge-gradient badge-subject">Java 21</span>
                    <span class="badge-gradient badge-subject">JSP</span>
                    <span class="badge-gradient badge-subject">Servlets</span>
                    <span class="badge-gradient badge-subject">MySQL</span>
                    <span class="badge-gradient badge-subject">Bootstrap 5</span>
                    <span class="badge-gradient badge-subject">Maven</span>
                </div>
            </div>
        </div>
        <div class="divider" style="margin: 24px 0 16px;"></div>
        <div class="text-center" style="color: var(--text-muted); font-size: 0.82rem;">
            &copy; 2025 ExamPro - Online Examination System. All rights reserved.
        </div>
    </div>
</footer>