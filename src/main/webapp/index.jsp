<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>ExamPortal | Online Examination & Assessment Management System</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css" rel="stylesheet">
    <link href="https://unpkg.com/aos@2.3.1/dist/aos.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Orbitron:wght@400;700;900&family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link href="css/style.css" rel="stylesheet">
    <style>
        body { overflow-x: hidden; }
        .cyber-nav { background: rgba(10, 25, 47, 0.95) !important; box-shadow: 0 2px 10px rgba(0, 255, 255, 0.1); }
        .btn-cyber { background: linear-gradient(135deg, #00d4ff, #0099ff); border: none; color: white; font-weight: 600; }
        .btn-cyber:hover { background: linear-gradient(135deg, #00b8e6, #0080dd); color: white; }
        .btn-cyber-outline { border: 2px solid #00d4ff; color: #00d4ff; background: transparent; }
        .btn-cyber-outline:hover { background: rgba(0, 212, 255, 0.1); color: #00d4ff; }
        .gradient-text { background: linear-gradient(135deg, #00d4ff, #0099ff); -webkit-background-clip: text; -webkit-text-fill-color: transparent; background-clip: text; }
        .glass-card { background: rgba(255, 255, 255, 0.08); backdrop-filter: blur(10px); border: 1px solid rgba(255, 255, 255, 0.15); border-radius: 12px; padding: 20px; }
    </style>
</head>
<body style="background: linear-gradient(135deg, #0a1930 0%, #1a2a4a 100%); color: #e0e0e0; font-family: 'Inter', sans-serif;">
    <!-- Navigation -->
    <nav class="navbar navbar-expand-lg fixed-top cyber-nav">
        <div class="container">
            <a class="navbar-brand" href="#" style="color: #00d4ff; font-weight: 700; font-size: 24px;">
                <i class="fas fa-graduation-cap me-2"></i>Exam<span style="color: #ffffff;">Portal</span>
            </a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navContent" style="border-color: #00d4ff;">
                <span class="navbar-toggler-icon" style="background-image: url('data:image/svg+xml;utf8,<svg xmlns=%22http://www.w3.org/2000/svg%22 viewBox=%220 0 30 30%22><path stroke=%2200d4ff%22 stroke-linecap=%22round%22 stroke-miterlimit=%2210%22 stroke-width=%222%22 d=%22M4 7h22M4 15h22M4 23h22%22/></svg>');"></span>
            </button>
            <div class="collapse navbar-collapse" id="navContent">
                <ul class="navbar-nav ms-auto align-items-lg-center">
                    <li class="nav-item"><a class="nav-link" href="#features" style="color: #e0e0e0;">Features</a></li>
                    <li class="nav-item"><a class="nav-link" href="#workflow" style="color: #e0e0e0;">Workflow</a></li>
                    <li class="nav-item"><a class="nav-link" href="#roles" style="color: #e0e0e0;">Roles</a></li>
                    <li class="nav-item ms-lg-3">
                        <a href="${pageContext.request.contextPath}/login" class="btn btn-cyber-outline me-2">Login</a>
                    </li>
                    <li class="nav-item">
                        <a href="${pageContext.request.contextPath}/register" class="btn btn-cyber">Get Started</a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>

    <!-- Hero Section -->
    <section style="min-height: 100vh; display: flex; align-items: center; padding-top: 80px;">
        <div class="container">
            <div class="row align-items-center">
                <div class="col-lg-7 mb-5 mb-lg-0">
                    <div class="glass-card mb-4" style="width: fit-content;">
                        <i class="fas fa-bolt" style="color: #00d4ff;"></i> Enterprise-Grade Assessment Platform
                    </div>
                    <h1 style="font-size: 3.5rem; font-weight: 900; line-height: 1.2; margin-bottom: 20px;">
                        Next-Gen <span class="gradient-text">Online Examination</span> 
                        & Assessment System
                    </h1>
                    <p style="font-size: 1.2rem; color: #b0b0b0; margin-bottom: 30px;">
                        Transform your assessment process with enterprise-grade security, real-time monitoring, and powerful analytics. Built for modern educational institutions.
                    </p>
                    <div style="display: flex; gap: 15px; flex-wrap: wrap;">
                        <a href="${pageContext.request.contextPath}/register" class="btn btn-cyber btn-lg">
                            <i class="fas fa-rocket me-2"></i>Start Free Trial
                        </a>
                        <a href="#features" class="btn btn-cyber-outline btn-lg">
                            <i class="fas fa-play-circle me-2"></i>Explore Features
                        </a>
                    </div>
                </div>
                <div class="col-lg-5">
                    <div style="background: rgba(0, 212, 255, 0.1); border-radius: 20px; padding: 40px; border: 2px solid rgba(0, 212, 255, 0.2);">
                        <div style="text-align: center;">
                            <i class="fas fa-chart-line" style="font-size: 4rem; color: #00d4ff; margin-bottom: 20px;"></i>
                            <h3 style="color: #00d4ff; margin-bottom: 10px;">Enterprise Platform</h3>
                            <p style="color: #b0b0b0;">Secure, Scalable, and Ready for Production</p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Features Section -->
    <section id="features" style="padding: 80px 0; background: rgba(26, 42, 74, 0.5);">
        <div class="container">
            <div style="text-align: center; margin-bottom: 60px;">
                <h2 style="font-size: 2.5rem; font-weight: 900; margin-bottom: 15px;">Powerful <span class="gradient-text">Features</span></h2>
                <p style="color: #b0b0b0; font-size: 1.1rem;">Everything you need for seamless examination management</p>
            </div>
            <div class="row g-4">
                <div class="col-md-6 col-lg-4">
                    <div class="glass-card" style="text-align: center; height: 100%;">
                        <div style="font-size: 3rem; color: #00d4ff; margin-bottom: 15px;"><i class="fas fa-question-circle"></i></div>
                        <h4 style="color: #ffffff; margin-bottom: 10px;">Smart Question Bank</h4>
                        <p style="color: #b0b0b0;">Create and manage thousands of MCQ questions with difficulty levels and negative marking.</p>
                    </div>
                </div>
                <div class="col-md-6 col-lg-4">
                    <div class="glass-card" style="text-align: center; height: 100%;">
                        <div style="font-size: 3rem; color: #00d4ff; margin-bottom: 15px;"><i class="fas fa-stopwatch"></i></div>
                        <h4 style="color: #ffffff; margin-bottom: 10px;">Timer-Based Exams</h4>
                        <p style="color: #b0b0b0;">Auto-submit exams with configurable timers and random question selection.</p>
                    </div>
                </div>
                <div class="col-md-6 col-lg-4">
                    <div class="glass-card" style="text-align: center; height: 100%;">
                        <div style="font-size: 3rem; color: #00d4ff; margin-bottom: 15px;"><i class="fas fa-bolt"></i></div>
                        <h4 style="color: #ffffff; margin-bottom: 10px;">Instant Evaluation</h4>
                        <p style="color: #b0b0b0;">Automated grading with instant results and detailed performance analytics.</p>
                    </div>
                </div>
                <div class="col-md-6 col-lg-4">
                    <div class="glass-card" style="text-align: center; height: 100%;">
                        <div style="font-size: 3rem; color: #00d4ff; margin-bottom: 15px;"><i class="fas fa-chart-pie"></i></div>
                        <h4 style="color: #ffffff; margin-bottom: 10px;">Advanced Analytics</h4>
                        <p style="color: #b0b0b0;">Subject-wise performance tracking and comprehensive dashboards for all roles.</p>
                    </div>
                </div>
                <div class="col-md-6 col-lg-4">
                    <div class="glass-card" style="text-align: center; height: 100%;">
                        <div style="font-size: 3rem; color: #00d4ff; margin-bottom: 15px;"><i class="fas fa-shield-alt"></i></div>
                        <h4 style="color: #ffffff; margin-bottom: 10px;">Enterprise Security</h4>
                        <p style="color: #b0b0b0;">BCrypt hashing, RBAC, SQL injection prevention, and session management.</p>
                    </div>
                </div>
                <div class="col-md-6 col-lg-4">
                    <div class="glass-card" style="text-align: center; height: 100%;">
                        <div style="font-size: 3rem; color: #00d4ff; margin-bottom: 15px;"><i class="fas fa-users-cog"></i></div>
                        <h4 style="color: #ffffff; margin-bottom: 10px;">Multi-Role System</h4>
                        <p style="color: #b0b0b0;">Dedicated interfaces for Admins, Faculty, and Students with role-specific features.</p>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Roles Section -->
    <section id="roles" style="padding: 80px 0;">
        <div class="container">
            <div style="text-align: center; margin-bottom: 60px;">
                <h2 style="font-size: 2.5rem; font-weight: 900; margin-bottom: 15px;">Built for <span class="gradient-text">Everyone</span></h2>
                <p style="color: #b0b0b0; font-size: 1.1rem;">Tailored experiences for each role</p>
            </div>
            <div class="row g-4">
                <div class="col-md-4">
                    <div class="glass-card" style="text-align: center; height: 100%;">
                        <div style="font-size: 3rem; color: #ff6b6b; margin-bottom: 15px;"><i class="fas fa-user-shield"></i></div>
                        <h4 style="color: #ffffff; margin-bottom: 15px;">Administrator</h4>
                        <p style="color: #b0b0b0; margin-bottom: 15px;">Full system control with user management, analytics dashboards, and activity logs.</p>
                        <ul style="list-style: none; padding: 0; text-align: left;">
                            <li style="color: #00d4ff; margin-bottom: 8px;"><i class="fas fa-check me-2"></i> User Management</li>
                            <li style="color: #00d4ff; margin-bottom: 8px;"><i class="fas fa-check me-2"></i> System Analytics</li>
                            <li style="color: #00d4ff; margin-bottom: 8px;"><i class="fas fa-check me-2"></i> Activity Monitoring</li>
                            <li style="color: #00d4ff;"><i class="fas fa-check me-2"></i> Report Generation</li>
                        </ul>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="glass-card" style="text-align: center; height: 100%;">
                        <div style="font-size: 3rem; color: #51cf66; margin-bottom: 15px;"><i class="fas fa-chalkboard-teacher"></i></div>
                        <h4 style="color: #ffffff; margin-bottom: 15px;">Faculty</h4>
                        <p style="color: #b0b0b0; margin-bottom: 15px;">Create exams, manage question banks, schedule tests, and track student performance.</p>
                        <ul style="list-style: none; padding: 0; text-align: left;">
                            <li style="color: #00d4ff; margin-bottom: 8px;"><i class="fas fa-check me-2"></i> Create & Schedule Exams</li>
                            <li style="color: #00d4ff; margin-bottom: 8px;"><i class="fas fa-check me-2"></i> Question Bank Mgmt</li>
                            <li style="color: #00d4ff; margin-bottom: 8px;"><i class="fas fa-check me-2"></i> Student Performance</li>
                            <li style="color: #00d4ff;"><i class="fas fa-check me-2"></i> Faculty Reports</li>
                        </ul>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="glass-card" style="text-align: center; height: 100%;">
                        <div style="font-size: 3rem; color: #ffd43b; margin-bottom: 15px;"><i class="fas fa-user-graduate"></i></div>
                        <h4 style="color: #ffffff; margin-bottom: 15px;">Student</h4>
                        <p style="color: #b0b0b0; margin-bottom: 15px;">Take timed exams, view instant results, track performance analytics, and download reports.</p>
                        <ul style="list-style: none; padding: 0; text-align: left;">
                            <li style="color: #00d4ff; margin-bottom: 8px;"><i class="fas fa-check me-2"></i> Take Online Exams</li>
                            <li style="color: #00d4ff; margin-bottom: 8px;"><i class="fas fa-check me-2"></i> Instant Results</li>
                            <li style="color: #00d4ff; margin-bottom: 8px;"><i class="fas fa-check me-2"></i> Performance Analytics</li>
                            <li style="color: #00d4ff;"><i class="fas fa-check me-2"></i> Download Reports</li>
                        </ul>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- CTA Section -->
    <section style="padding: 60px 0; background: rgba(0, 212, 255, 0.05); border-top: 2px solid rgba(0, 212, 255, 0.2); border-bottom: 2px solid rgba(0, 212, 255, 0.2);">
        <div class="container">
            <div class="glass-card text-center" style="padding: 50px;">
                <h2 style="font-size: 2.5rem; font-weight: 900; margin-bottom: 15px;">Ready to Transform Your <span class="gradient-text">Assessments?</span></h2>
                <p style="color: #b0b0b0; font-size: 1.1rem; margin-bottom: 30px;">Join thousands of institutions using ExamPortal for seamless examination management</p>
                <div style="display: flex; gap: 15px; justify-content: center; flex-wrap: wrap;">
                    <a href="${pageContext.request.contextPath}/register" class="btn btn-cyber btn-lg"><i class="fas fa-user-plus me-2"></i>Get Started Now</a>
                    <a href="${pageContext.request.contextPath}/login" class="btn btn-cyber-outline btn-lg"><i class="fas fa-sign-in-alt me-2"></i>Login</a>
                </div>
            </div>
        </div>
    </section>

    <!-- Footer -->
    <footer style="background: rgba(10, 25, 47, 0.95); padding: 50px 0; border-top: 1px solid rgba(0, 212, 255, 0.1);">
        <div class="container">
            <div class="row g-4 mb-4">
                <div class="col-lg-4">
                    <h5 style="color: #00d4ff; font-weight: 700; margin-bottom: 15px;"><i class="fas fa-graduation-cap me-2"></i>ExamPortal</h5>
                    <p style="color: #b0b0b0;">Enterprise-grade online examination and assessment management system built for modern educational institutions.</p>
                </div>
                <div class="col-lg-2 col-md-6">
                    <h6 style="color: #ffffff; font-weight: 700; margin-bottom: 15px;">Product</h6>
                    <ul style="list-style: none; padding: 0;">
                        <li><a href="#features" style="color: #b0b0b0; text-decoration: none;">Features</a></li>
                        <li><a href="#roles" style="color: #b0b0b0; text-decoration: none;">Roles</a></li>
                        <li><a href="${pageContext.request.contextPath}/register" style="color: #b0b0b0; text-decoration: none;">Get Started</a></li>
                    </ul>
                </div>
                <div class="col-lg-2 col-md-6">
                    <h6 style="color: #ffffff; font-weight: 700; margin-bottom: 15px;">Resources</h6>
                    <ul style="list-style: none; padding: 0;">
                        <li><a href="#" style="color: #b0b0b0; text-decoration: none;">Documentation</a></li>
                        <li><a href="#" style="color: #b0b0b0; text-decoration: none;">Support</a></li>
                        <li><a href="#" style="color: #b0b0b0; text-decoration: none;">FAQ</a></li>
                    </ul>
                </div>
                <div class="col-lg-4">
                    <h6 style="color: #ffffff; font-weight: 700; margin-bottom: 15px;">Stay Connected</h6>
                    <p style="color: #b0b0b0;">Follow us on social media for updates and announcements</p>
                </div>
            </div>
            <hr style="border-color: rgba(0, 212, 255, 0.1);">
            <div style="text-align: center; color: #b0b0b0; padding-top: 20px;">
                <p style="margin: 0;">&copy; 2025 ExamPortal. All rights reserved. Built with <i class="fas fa-heart" style="color: #ff6b6b;"></i> for Education</p>
            </div>
        </div>
    </footer>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        document.addEventListener('DOMContentLoaded', function() {
            console.log('ExamPortal loaded successfully at: ' + window.location.href);
        });
    </script>
</body>
</html>
