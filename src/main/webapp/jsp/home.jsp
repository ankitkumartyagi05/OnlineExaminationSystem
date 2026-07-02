<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>ExamPro - Online Examination System</title>
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
        <div class="orb orb-5"></div>
    </div>

    <%@ include file="header.jsp" %>

    <!-- HERO -->
    <section class="hero-section">
        <div class="container">
            <div class="row align-items-center">
                <div class="col-lg-7">
                    <div class="fade-in">
                        <span class="badge-gradient badge-subject mb-3 d-inline-block" style="font-size: 0.82rem; padding: 6px 16px;">
                            <i class="bi bi-lightning-charge-fill me-1"></i> Modern Assessment Platform
                        </span>
                        <h1 class="hero-title">
                            Take Your <span class="gradient-text">Exams</span><br>
                            To The <span class="gradient-text-secondary">Next Level</span>
                        </h1>
                        <p class="hero-subtitle">
                            Experience seamless online examinations with automated evaluation, instant results, and detailed performance analytics. No logins required.
                        </p>
                        <div class="hero-buttons">
                            <a href="${pageContext.request.contextPath}/register" class="btn-gradient">
                                <i class="bi bi-person-plus-fill"></i> Register Now
                            </a>
                            <a href="${pageContext.request.contextPath}/tests" class="btn-outline-glass">
                                <i class="bi bi-play-circle-fill"></i> Start Test
                            </a>
                        </div>
                    </div>
                </div>
                <div class="col-lg-5 d-none d-lg-block">
                    <div class="hero-visual">
                        <div class="hero-3d-card">
                            <i class="bi bi-pencil-square hero-icon-large"></i>
                            <div style="text-align: center;">
                                <div style="font-family: 'Space Grotesk'; font-weight: 600; font-size: 1.1rem; margin-bottom: 4px;">Live Examination</div>
                                <div style="color: var(--text-muted); font-size: 0.82rem;">MCQ Based Assessment</div>
                            </div>
                            <div class="hero-stat-mini">
                                <div class="number" data-count="${totalCandidates}">0</div>
                                <div class="label">Candidates</div>
                            </div>
                            <div style="display: flex; gap: 10px; width: 100%;">
                                <div class="hero-stat-mini">
                                    <div class="number" style="font-size: 1.2rem;" data-count="${totalQuestions}">0</div>
                                    <div class="label">Questions</div>
                                </div>
                                <div class="hero-stat-mini">
                                    <div class="number" style="font-size: 1.2rem;" data-count="${totalTests}">0</div>
                                    <div class="label">Tests</div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- STATS -->
    <section class="section-padding" style="padding-top: 0;">
        <div class="container">
            <div class="row g-4">
                <div class="col-lg-3 col-md-6">
                    <div class="glass-card stat-card stat-card-1 tilt-card reveal">
                        <div class="stat-icon"><i class="bi bi-people-fill"></i></div>
                        <div class="stat-number" data-count="${totalCandidates}">0</div>
                        <div class="stat-label">Candidates</div>
                    </div>
                </div>
                <div class="col-lg-3 col-md-6">
                    <div class="glass-card stat-card stat-card-2 tilt-card reveal">
                        <div class="stat-icon"><i class="bi bi-question-circle-fill"></i></div>
                        <div class="stat-number" data-count="${totalQuestions}">0</div>
                        <div class="stat-label">Questions</div>
                    </div>
                </div>
                <div class="col-lg-3 col-md-6">
                    <div class="glass-card stat-card stat-card-3 tilt-card reveal">
                        <div class="stat-icon"><i class="bi bi-journal-check"></i></div>
                        <div class="stat-number" data-count="${totalTests}">0</div>
                        <div class="stat-label">Active Tests</div>
                    </div>
                </div>
                <div class="col-lg-3 col-md-6">
                    <div class="glass-card stat-card stat-card-4 tilt-card reveal">
                        <div class="stat-icon"><i class="bi bi-trophy-fill"></i></div>
                        <div class="stat-number" data-count="${totalResults}">0</div>
                        <div class="stat-label">Results</div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- ABOUT -->
    <section class="section-padding" id="about">
        <div class="container">
            <div class="text-center mb-5 reveal">
                <h2 class="section-title">About <span class="gradient-text">The System</span></h2>
                <p class="section-subtitle mx-auto">
                    A comprehensive platform designed to make online examinations simple, fair, and insightful.
                </p>
            </div>
            <div class="row g-4 justify-content-center">
                <div class="col-lg-4 col-md-6">
                    <div class="glass-card p-4 h-100 tilt-card reveal">
                        <div style="width: 50px; height: 50px; border-radius: 12px; background: var(--gradient-primary); display: flex; align-items: center; justify-content: center; font-size: 1.3rem; margin-bottom: 16px;">
                            <i class="bi bi-speedometer2 text-white"></i>
                        </div>
                        <h5 style="font-family: 'Space Grotesk'; font-weight: 600; margin-bottom: 8px;">Instant Evaluation</h5>
                        <p style="color: var(--text-secondary); font-size: 0.9rem;">Answers are evaluated automatically the moment you submit. No waiting, no manual checking.</p>
                    </div>
                </div>
                <div class="col-lg-4 col-md-6">
                    <div class="glass-card p-4 h-100 tilt-card reveal">
                        <div style="width: 50px; height: 50px; border-radius: 12px; background: var(--gradient-secondary); display: flex; align-items: center; justify-content: center; font-size: 1.3rem; margin-bottom: 16px;">
                            <i class="bi bi-shield-check text-white"></i>
                        </div>
                        <h5 style="font-family: 'Space Grotesk'; font-weight: 600; margin-bottom: 8px;">Fair Assessment</h5>
                        <p style="color: var(--text-secondary); font-size: 0.9rem;">Random question order ensures every candidate gets a unique examination experience.</p>
                    </div>
                </div>
                <div class="col-lg-4 col-md-6">
                    <div class="glass-card p-4 h-100 tilt-card reveal">
                        <div style="width: 50px; height: 50px; border-radius: 12px; background: var(--gradient-accent); display: flex; align-items: center; justify-content: center; font-size: 1.3rem; margin-bottom: 16px;">
                            <i class="bi bi-bar-chart-line text-white"></i>
                        </div>
                        <h5 style="font-family: 'Space Grotesk'; font-weight: 600; margin-bottom: 8px;">Deep Analytics</h5>
                        <p style="color: var(--text-secondary); font-size: 0.9rem;">Track your performance across subjects with detailed charts and historical data.</p>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- FEATURES -->
    <section class="section-padding" id="features">
        <div class="container">
            <div class="text-center mb-5 reveal">
                <h2 class="section-title">Key <span class="gradient-text-secondary">Features</span></h2>
                <p class="section-subtitle mx-auto">Everything you need for a modern examination experience.</p>
            </div>
            <div class="row g-4">
                <div class="col-lg-3 col-md-6">
                    <div class="glass-card feature-card tilt-card reveal">
                        <div class="feature-icon" style="background: var(--gradient-primary);"><i class="bi bi-person-add text-white"></i></div>
                        <h5>Quick Registration</h5>
                        <p>Register in seconds with just your basic details. No passwords needed.</p>
                    </div>
                </div>
                <div class="col-lg-3 col-md-6">
                    <div class="glass-card feature-card tilt-card reveal">
                        <div class="feature-icon" style="background: var(--gradient-secondary);"><i class="bi bi-database-fill text-white"></i></div>
                        <h5>Question Bank</h5>
                        <p>Comprehensive question bank organized by subjects with easy management.</p>
                    </div>
                </div>
                <div class="col-lg-3 col-md-6">
                    <div class="glass-card feature-card tilt-card reveal">
                        <div class="feature-icon" style="background: var(--gradient-accent);"><i class="bi bi-clock-history text-white"></i></div>
                        <h5>Timed Tests</h5>
                        <p>Each test comes with a timer. Auto-submission when time runs out.</p>
                    </div>
                </div>
                <div class="col-lg-3 col-md-6">
                    <div class="glass-card feature-card tilt-card reveal">
                        <div class="feature-icon" style="background: var(--gradient-success);"><i class="bi bi-award-fill" style="color: #0a0a1a;"></i></div>
                        <h5>Instant Results</h5>
                        <p>Get your score, percentage, and pass/fail status immediately after submission.</p>
                    </div>
                </div>
                <div class="col-lg-3 col-md-6">
                    <div class="glass-card feature-card tilt-card reveal">
                        <div class="feature-icon" style="background: var(--gradient-warning);"><i class="bi bi-shuffle" style="color: #0a0a1a;"></i></div>
                        <h5>Random Order</h5>
                        <p>Questions are shuffled for every attempt ensuring fairness.</p>
                    </div>
                </div>
                <div class="col-lg-3 col-md-6">
                    <div class="glass-card feature-card tilt-card reveal">
                        <div class="feature-icon" style="background: var(--gradient-candy);"><i class="bi bi-graph-up-arrow text-white"></i></div>
                        <h5>Performance Tracking</h5>
                        <p>Visualize your progress with charts and subject-wise analytics.</p>
                    </div>
                </div>
                <div class="col-lg-3 col-md-6">
                    <div class="glass-card feature-card tilt-card reveal">
                        <div class="feature-icon" style="background: var(--gradient-danger);"><i class="bi bi-phone text-white"></i></div>
                        <h5>Fully Responsive</h5>
                        <p>Take exams on any device - desktop, tablet, or mobile.</p>
                    </div>
                </div>
                <div class="col-lg-3 col-md-6">
                    <div class="glass-card feature-card tilt-card reveal">
                        <div class="feature-icon" style="background: linear-gradient(135deg, #a8edea 0%, #fed6e3 100%);"><i class="bi bi-palette" style="color: #0a0a1a;"></i></div>
                        <h5>Beautiful UI</h5>
                        <p>Modern dark theme with glassmorphism and smooth animations.</p>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- CTA -->
    <section class="section-padding">
        <div class="container">
            <div class="glass-card-static text-center p-5 reveal" style="border-color: rgba(102, 126, 234, 0.2);">
                <h2 style="font-family: 'Space Grotesk'; font-weight: 700; font-size: 2rem; margin-bottom: 12px;">
                    Ready to <span class="gradient-text">Begin?</span>
                </h2>
                <p style="color: var(--text-secondary); max-width: 450px; margin: 0 auto 28px;">
                    Register now and take your first online examination. It's fast, easy, and completely free.
                </p>
                <div class="d-flex justify-content-center gap-3 flex-wrap">
                    <a href="${pageContext.request.contextPath}/register" class="btn-gradient">
                        <i class="bi bi-person-plus-fill"></i> Register Now
                    </a>
                    <a href="${pageContext.request.contextPath}/tests" class="btn-outline-glass">
                        <i class="bi bi-collection-fill"></i> Browse Tests
                    </a>
                </div>
            </div>
        </div>
    </section>

    <%@ include file="footer.jsp" %>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    <script src="${pageContext.request.contextPath}/js/main.js"></script>
    <style>
        .reveal { opacity: 0; transform: translateY(40px); transition: all 0.8s cubic-bezier(0.25, 0.46, 0.45, 0.94); }
        .reveal.revealed { opacity: 1; transform: translateY(0); }
    </style>
</body>
</html>