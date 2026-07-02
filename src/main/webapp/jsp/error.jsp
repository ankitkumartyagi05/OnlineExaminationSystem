<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Error - ExamPro</title>
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
            <a class="navbar-brand" href="${pageContext.request.contextPath}/home">
                <i class="bi bi-mortarboard-fill me-2"></i>ExamPro
            </a>
        </div>
    </nav>

    <section style="padding: 140px 0 80px; min-height: 100vh; display: flex; align-items: center;">
        <div class="container">
            <div class="row justify-content-center">
                <div class="col-lg-6 text-center">
                    <div class="scale-in">
                        <div style="font-size: 8rem; line-height: 1; margin-bottom: 16px;">
                            <span class="gradient-text-secondary" style="font-family: 'Space Grotesk'; font-weight: 800;">Oops!</span>
                        </div>
                        <h2 style="font-family: 'Space Grotesk'; font-weight: 700; margin-bottom: 12px; color: var(--text-primary);">
                            Something Went Wrong
                        </h2>
                        <p style="color: var(--text-secondary); max-width: 400px; margin: 0 auto 32px; font-size: 0.95rem;">
                            We encountered an unexpected error. Please try again or return to the home page.
                        </p>
                        <div class="d-flex justify-content-center gap-3 flex-wrap">
                            <a href="${pageContext.request.contextPath}/home" class="btn-gradient">
                                <i class="bi bi-house-fill"></i> Go Home
                            </a>
                            <button onclick="history.back()" class="btn-outline-glass">
                                <i class="bi bi-arrow-left"></i> Go Back
                            </button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    <script src="${pageContext.request.contextPath}/js/main.js"></script>
</body>
</html>