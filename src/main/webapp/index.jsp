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
</head>
<body>
    <!-- Three.js Background Canvas -->
    <canvas id="bg-canvas"></canvas>

    <!-- Navigation -->
    <nav class="navbar navbar-expand-lg fixed-top cyber-nav" id="mainNav">
        <div class="container">
            <a class="navbar-brand" href="#">
                <i class="fas fa-graduation-cap me-2"></i>Exam<span>Portal</span>
            </a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navContent">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navContent">
                <ul class="navbar-nav ms-auto align-items-lg-center">
                    <li class="nav-item"><a class="nav-link" href="#features">Features</a></li>
                    <li class="nav-item"><a class="nav-link" href="#workflow">Workflow</a></li>
                    <li class="nav-item"><a class="nav-link" href="#roles">Roles</a></li>
                    <li class="nav-item"><a class="nav-link" href="#testimonials">Testimonials</a></li>
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
    <section class="hero-section" id="hero">
        <div class="container">
            <div class="row align-items-center min-vh-100">
                <div class="col-lg-7" data-aos="fade-right">
                    <div class="hero-badge mb-4">
                        <i class="fas fa-bolt"></i> Enterprise-Grade Assessment Platform
                    </div>
                    <h1 class="hero-title">
                        Next-Gen <span class="gradient-text">Online Examination</span> 
                        & Assessment System
                    </h1>
                    <p class="hero-subtitle">
                        Transform your assessment process with AI-powered analytics, 
                        real-time monitoring, and enterprise-grade security. Built for 
                        modern educational institutions.
                    </p>
                    <div class="hero-actions mt-4">
                        <a href="${pageContext.request.contextPath}/register" class="btn btn-cyber btn-lg me-3">
                            <i class="fas fa-rocket me-2"></i>Start Free Trial
                        </a>
                        <a href="#features" class="btn btn-cyber-outline btn-lg">
                            <i class="fas fa-play-circle me-2"></i>Explore Features
                        </a>
                    </div>
                    <div class="hero-stats mt-5">
                        <div class="stat-item">
                            <h3 class="stat-number" data-target="50000">0</h3>
                            <p>Students Assessed</p>
                        </div>
                        <div class="stat-item">
                            <h3 class="stat-number" data-target="500">0</h3>
                            <p>Institutions</p>
                        </div>
                        <div class="stat-item">
                            <h3 class="stat-number" data-target="100000">0</h3>
                            <p>Exams Conducted</p>
                        </div>
                        <div class="stat-item">
                            <h3 class="stat-number" data-target="99" data-suffix="%">0</h3>
                            <p>Uptime</p>
                        </div>
                    </div>
                </div>
                <div class="col-lg-5" data-aos="fade-left">
                    <div class="hero-visual">
                        <div class="floating-card card-1">
                            <i class="fas fa-clock text-cyan"></i>
                            <div>
                                <h6>Timer Active</h6>
                                <p>29:45 remaining</p>
                            </div>
                        </div>
                        <div class="floating-card card-2">
                            <i class="fas fa-check-circle text-success"></i>
                            <div>
                                <h6>Auto-Graded</h6>
                                <p>Instant results</p>
                            </div>
                        </div>
                        <div class="floating-card card-3">
                            <i class="fas fa-chart-line text-purple"></i>
                            <div>
                                <h6>Analytics</h6>
                                <p>Real-time insights</p>
                            </div>
                        </div>
                        <div class="hero-orb"></div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Features Section -->
    <section class="features-section py-5" id="features">
        <div class="container py-5">
            <div class="text-center mb-5" data-aos="fade-up">
                <h2 class="section-title">Powerful <span class="gradient-text">Features</span></h2>
                <p class="section-subtitle">Everything you need for seamless examination management</p>
            </div>
            <div class="row g-4">
                <div class="col-md-6 col-lg-4" data-aos="fade-up" data-aos-delay="0">
                    <div class="feature-card glass-card">
                        <div class="feature-icon"><i class="fas fa-question-circle"></i></div>
                        <h4>Smart Question Bank</h4>
                        <p>Create, categorize, and manage thousands of MCQ questions with difficulty levels and negative marking support.</p>
                    </div>
                </div>
                <div class="col-md-6 col-lg-4" data-aos="fade-up" data-aos-delay="100">
                    <div class="feature-card glass-card">
                        <div class="feature-icon"><i class="fas fa-stopwatch"></i></div>
                        <h4>Timer-Based Exams</h4>
                        <p>Auto-submit exams with configurable timers. Support for random question selection and question navigation.</p>
                    </div>
                </div>
                <div class="col-md-6 col-lg-4" data-aos="fade-up" data-aos-delay="200">
                    <div class="feature-card glass-card">
                        <div class="feature-icon"><i class="fas fa-bolt"></i></div>
                        <h4>Instant Evaluation</h4>
                        <p>Automated grading with instant results, detailed answer analysis, and performance analytics.</p>
                    </div>
                </div>
                <div class="col-md-6 col-lg-4" data-aos="fade-up" data-aos-delay="300">
                    <div class="feature-card glass-card">
                        <div class="feature-icon"><i class="fas fa-chart-pie"></i></div>
                        <h4>Advanced Analytics</h4>
                        <p>Subject-wise performance, student rankings, pass rates, and comprehensive dashboards for all roles.</p>
                    </div>
                </div>
                <div class="col-md-6 col-lg-4" data-aos="fade-up" data-aos-delay="400">
                    <div class="feature-card glass-card">
                        <div class="feature-icon"><i class="fas fa-shield-alt"></i></div>
                        <h4>Enterprise Security</h4>
                        <p>BCrypt password hashing, role-based access control, SQL injection prevention, and session management.</p>
                    </div>
                </div>
                <div class="col-md-6 col-lg-4" data-aos="fade-up" data-aos-delay="500">
                    <div class="feature-card glass-card">
                        <div class="feature-icon"><i class="fas fa-users-cog"></i></div>
                        <h4>Multi-Role System</h4>
                        <p>Dedicated interfaces for Admins, Faculty, and Students with role-specific features and permissions.</p>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Workflow Timeline -->
    <section class="workflow-section py-5" id="workflow">
        <div class="container py-5">
            <div class="text-center mb-5" data-aos="fade-up">
                <h2 class="section-title">How It <span class="gradient-text">Works</span></h2>
                <p class="section-subtitle">A streamlined workflow from creation to results</p>
            </div>
            <div class="timeline">
                <div class="timeline-item" data-aos="fade-right">
                    <div class="timeline-dot"><i class="fas fa-user-plus"></i></div>
                    <div class="timeline-content glass-card">
                        <h4>Register & Login</h4>
                        <p>Admins, Faculty, and Students register with role-specific profiles and secure authentication.</p>
                    </div>
                </div>
                <div class="timeline-item" data-aos="fade-left">
                    <div class="timeline-dot"><i class="fas fa-edit"></i></div>
                    <div class="timeline-content glass-card">
                        <h4>Create Question Bank</h4>
                        <p>Faculty builds a comprehensive question bank categorized by subject, difficulty, and marks.</p>
                    </div>
                </div>
                <div class="timeline-item" data-aos="fade-right">
                    <div class="timeline-dot"><i class="fas fa-file-alt"></i></div>
                    <div class="timeline-content glass-card">
                        <h4>Schedule Exams</h4>
                        <p>Create exams with configurable timers, negative marking, randomization, and pass criteria.</p>
                    </div>
                </div>
                <div class="timeline-item" data-aos="fade-left">
                    <div class="timeline-dot"><i class="fas fa-desktop"></i></div>
                    <div class="timeline-content glass-card">
                        <h4>Take Exam</h4>
                        <p>Students attempt exams with real-time timers, question navigation, and auto-submit on timeout.</p>
                    </div>
                </div>
                <div class="timeline-item" data-aos="fade-right">
                    <div class="timeline-dot"><i class="fas fa-poll"></i></div>
                    <div class="timeline-content glass-card">
                        <h4>Instant Results & Analytics</h4>
                        <p>Automated evaluation generates instant results with detailed analytics and downloadable reports.</p>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Roles Section -->
    <section class="roles-section py-5" id="roles">
        <div class="container py-5">
            <div class="text-center mb-5" data-aos="fade-up">
                <h2 class="section-title">Built for <span class="gradient-text">Everyone</span></h2>
                <p class="section-subtitle">Tailored experiences for each role</p>
            </div>
            <div class="row g-4">
                <div class="col-md-4" data-aos="zoom-in" data-aos-delay="0">
                    <div class="role-card glass-card text-center">
                        <div class="role-icon admin-icon"><i class="fas fa-user-shield"></i></div>
                        <h4>Administrator</h4>
                        <p>Full system control with user management, analytics dashboards, system reports, and activity logs.</p>
                        <ul class="role-features">
                            <li><i class="fas fa-check"></i> User Management</li>
                            <li><i class="fas fa-check"></i> System Analytics</li>
                            <li><i class="fas fa-check"></i> Activity Monitoring</li>
                            <li><i class="fas fa-check"></i> Report Generation</li>
                        </ul>
                    </div>
                </div>
                <div class="col-md-4" data-aos="zoom-in" data-aos-delay="100">
                    <div class="role-card glass-card text-center">
                        <div class="role-icon faculty-icon"><i class="fas fa-chalkboard-teacher"></i></div>
                        <h4>Faculty</h4>
                        <p>Create exams, manage question banks, schedule tests, and track student performance with analytics.</p>
                        <ul class="role-features">
                            <li><i class="fas fa-check"></i> Create & Schedule Exams</li>
                            <li><i class="fas fa-check"></i> Question Bank Management</li>
                            <li><i class="fas fa-check"></i> Student Performance</li>
                            <li><i class="fas fa-check"></i> Faculty Reports</li>
                        </ul>
                    </div>
                </div>
                <div class="col-md-4" data-aos="zoom-in" data-aos-delay="200">
                    <div class="role-card glass-card text-center">
                        <div class="role-icon student-icon"><i class="fas fa-user-graduate"></i></div>
                        <h4>Student</h4>
                        <p>Take timed exams, view instant results, track performance analytics, and download reports.</p>
                        <ul class="role-features">
                            <li><i class="fas fa-check"></i> Take Online Exams</li>
                            <li><i class="fas fa-check"></i> Instant Results</li>
                            <li><i class="fas fa-check"></i> Performance Analytics</li>
                            <li><i class="fas fa-check"></i> Download Reports</li>
                        </ul>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Testimonials -->
    <section class="testimonials-section py-5" id="testimonials">
        <div class="container py-5">
            <div class="text-center mb-5" data-aos="fade-up">
                <h2 class="section-title">What Our <span class="gradient-text">Users Say</span></h2>
            </div>
            <div class="row g-4">
                <div class="col-md-4" data-aos="fade-up" data-aos-delay="0">
                    <div class="testimonial-card glass-card">
                        <div class="stars"><i class="fas fa-star"></i><i class="fas fa-star"></i><i class="fas fa-star"></i><i class="fas fa-star"></i><i class="fas fa-star"></i></div>
                        <p>"ExamPortal has revolutionized our assessment process. The instant evaluation and analytics save us countless hours every semester."</p>
                        <div class="testimonial-author">
                            <div class="author-avatar">DK</div>
                            <div><h6>Dr. Kumar Reddy</h6><small>Dean of Engineering</small></div>
                        </div>
                    </div>
                </div>
                <div class="col-md-4" data-aos="fade-up" data-aos-delay="100">
                    <div class="testimonial-card glass-card">
                        <div class="stars"><i class="fas fa-star"></i><i class="fas fa-star"></i><i class="fas fa-star"></i><i class="fas fa-star"></i><i class="fas fa-star"></i></div>
                        <p>"The question bank feature is incredibly powerful. I can create and manage hundreds of questions with ease and randomize them for each exam."</p>
                        <div class="testimonial-author">
                            <div class="author-avatar">PS</div>
                            <div><h6>Prof. Priya Sharma</h6><small>Computer Science Faculty</small></div>
                        </div>
                    </div>
                </div>
                <div class="col-md-4" data-aos="fade-up" data-aos-delay="200">
                    <div class="testimonial-card glass-card">
                        <div class="stars"><i class="fas fa-star"></i><i class="fas fa-star"></i><i class="fas fa-star"></i><i class="fas fa-star"></i><i class="fas fa-star"></i></div>
                        <p>"The exam interface is clean and intuitive. The timer and question navigation make taking online exams stress-free and efficient."</p>
                        <div class="testimonial-author">
                            <div class="author-avatar">JD</div>
                            <div><h6>John Doe</h6><small>Final Year Student</small></div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- CTA Section -->
    <section class="cta-section py-5">
        <div class="container py-5">
            <div class="cta-content glass-card text-center" data-aos="zoom-in">
                <h2 class="mb-3">Ready to Transform Your <span class="gradient-text">Assessments?</span></h2>
                <p class="mb-4">Join thousands of institutions using ExamPortal for seamless examination management</p>
                <a href="${pageContext.request.contextPath}/register" class="btn btn-cyber btn-lg me-3"><i class="fas fa-user-plus me-2"></i>Get Started Now</a>
                <a href="${pageContext.request.contextPath}/login" class="btn btn-cyber-outline btn-lg"><i class="fas fa-sign-in-alt me-2"></i>Login</a>
            </div>
        </div>
    </section>

    <!-- Footer -->
    <footer class="cyber-footer py-5">
        <div class="container">
            <div class="row g-4">
                <div class="col-lg-4">
                    <h5 class="footer-brand"><i class="fas fa-graduation-cap me-2"></i>ExamPortal</h5>
                    <p>Enterprise-grade online examination and assessment management system built for modern educational institutions.</p>
                    <div class="social-links mt-3">
                        <a href="#"><i class="fab fa-twitter"></i></a>
                        <a href="#"><i class="fab fa-linkedin"></i></a>
                        <a href="#"><i class="fab fa-github"></i></a>
                        <a href="#"><i class="fab fa-youtube"></i></a>
                    </div>
                </div>
                <div class="col-lg-2 col-md-6">
                    <h6>Product</h6>
                    <ul class="footer-links">
                        <li><a href="#features">Features</a></li>
                        <li><a href="#workflow">Workflow</a></li>
                        <li><a href="#roles">Roles</a></li>
                        <li><a href="${pageContext.request.contextPath}/register">Get Started</a></li>
                    </ul>
                </div>
                <div class="col-lg-2 col-md-6">
                    <h6>Resources</h6>
                    <ul class="footer-links">
                        <li><a href="#">Documentation</a></li>
                        <li><a href="#">API Reference</a></li>
                        <li><a href="#">Support</a></li>
                        <li><a href="#">FAQ</a></li>
                    </ul>
                </div>
                <div class="col-lg-4">
                    <h6>Stay Updated</h6>
                    <p>Subscribe for the latest updates and features</p>
                    <div class="newsletter-form">
                        <input type="email" placeholder="Enter your email" class="form-control">
                        <button class="btn btn-cyber mt-2 w-100">Subscribe</button>
                    </div>
                </div>
            </div>
            <hr class="footer-divider">
            <div class="text-center">
                <p class="mb-0">&copy; 2025 ExamPortal. All rights reserved. Built with <i class="fas fa-heart text-danger"></i> by L&T College Connect</p>
            </div>
        </div>
    </footer>

    <!-- Scripts -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/gsap/3.12.2/gsap.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/gsap/3.12.2/ScrollTrigger.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/three.js/r128/three.min.js"></script>
    <script src="https://unpkg.com/aos@2.3.1/dist/aos.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/chart.js@4.4.0/dist/chart.umd.min.js"></script>
    <script src="js/three-bg.js"></script>
    <script src="js/main.js"></script>
</body>
</html>