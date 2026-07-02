<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Manage Questions - ExamPro</title>
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
            <a href="${pageContext.request.contextPath}/admin" class="btn-outline-glass btn-xs">
                <i class="bi bi-box-arrow-left"></i> Dashboard
            </a>
        </div>
    </nav>

    <section style="padding: 120px 0 80px; min-height: 100vh;">
        <div class="container">
            <div class="d-flex justify-between align-center flex-wrap gap-3 mb-4 fade-in">
                <div>
                    <h1 style="font-family: 'Space Grotesk'; font-weight: 700; font-size: 1.6rem;">
                        <span class="gradient-text">Question</span> Bank
                    </h1>
                    <p style="color: var(--text-secondary); font-size: 0.9rem; margin-bottom: 0;">${questions.size()} question(s) found</p>
                </div>
                <a href="${pageContext.request.contextPath}/admin/add-question" class="btn-gradient btn-sm">
                    <i class="bi bi-plus-circle-fill"></i> Add Question
                </a>
            </div>

            <!-- Search -->
            <div class="glass-card-static p-3 mb-4 fade-in">
                <form action="${pageContext.request.contextPath}/admin/questions" method="get" class="d-flex gap-2">
                    <div style="flex: 1;">
                        <input type="text" name="search" class="form-control-glass" placeholder="Search by subject or question text..." value="${search}">
                    </div>
                    <button type="submit" class="btn-gradient btn-sm" style="flex-shrink: 0;">
                        <i class="bi bi-search"></i> Search
                    </button>
                    <c:if test="${not empty search}">
                        <a href="${pageContext.request.contextPath}/admin/questions" class="btn-outline-glass btn-sm" style="flex-shrink: 0;">
                            <i class="bi bi-x-lg"></i> Clear
                        </a>
                    </c:if>
                </form>
            </div>

            <!-- Success/Error Messages -->
            <c:if test="${param.added == 'true'}">
                <div class="alert-glass success mb-3 fade-in">
                    <i class="bi bi-check-circle-fill"></i>
                    <span>Question added successfully!</span>
                </div>
            </c:if>
            <c:if test="${param.updated == 'true'}">
                <div class="alert-glass success mb-3 fade-in">
                    <i class="bi bi-check-circle-fill"></i>
                    <span>Question updated successfully!</span>
                </div>
            </c:if>
            <c:if test="${param.deleted == 'true'}">
                <div class="alert-glass success mb-3 fade-in">
                    <i class="bi bi-check-circle-fill"></i>
                    <span>Question deleted successfully!</span>
                </div>
            </c:if>

            <!-- Questions Table -->
            <c:choose>
                <c:when test="${not empty questions}">
                    <div class="glass-card-static p-3 fade-in" style="overflow-x: auto;">
                        <table class="table-glass">
                            <thead>
                                <tr>
                                    <th style="width: 40px;">#</th>
                                    <th>Subject</th>
                                    <th>Question</th>
                                    <th>Answer</th>
                                    <th>Marks</th>
                                    <th style="width: 140px;">Actions</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="q" items="${questions}" varStatus="status">
                                    <tr>
                                        <td style="font-weight: 600; color: var(--text-primary);">${status.index + 1}</td>
                                        <td><span class="badge-gradient badge-subject">${q.subject}</span></td>
                                        <td style="max-width: 300px; overflow: hidden; text-overflow: ellipsis; white-space: nowrap; color: var(--text-primary); font-weight: 500;">${q.question}</td>
                                        <td>
                                            <span style="background: rgba(67, 233, 123, 0.15); color: #43e97b; padding: 4px 10px; border-radius: 6px; font-weight: 700; font-size: 0.85rem;">
                                                ${q.correctAnswer}
                                            </span>
                                        </td>
                                        <td style="font-weight: 600;">${q.marks}</td>
                                        <td>
                                            <div class="d-flex gap-2">
                                                <a href="${pageContext.request.contextPath}/admin/edit-question?id=${q.id}" class="btn-outline-glass btn-xs" title="Edit">
                                                    <i class="bi bi-pencil-square"></i>
                                                </a>
                                                <a href="${pageContext.request.contextPath}/admin/delete-question?id=${q.id}" class="btn-danger-gradient btn-xs" style="padding: 5px 12px; font-size: 0.8rem; border-radius: 8px; font-weight: 600; text-decoration: none; display: inline-flex; align-items: center; gap: 4px; border: none; color: white; cursor: pointer;" onclick="return confirm('Delete this question? This cannot be undone.')" title="Delete">
                                                    <i class="bi bi-trash3"></i>
                                                </a>
                                            </div>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="empty-state glass-card-static fade-in">
                        <div class="empty-icon"><i class="bi bi-question-circle"></i></div>
                        <h4 style="color: var(--text-secondary); margin-bottom: 8px;">No Questions Found</h4>
                        <p style="color: var(--text-muted);">
                            <c:choose>
                                <c:when test="${not empty search}">No questions match "${search}". Try a different search.</c:when>
                                <c:otherwise>Start by adding questions to the bank.</c:otherwise>
                            </c:choose>
                        </p>
                        <a href="${pageContext.request.contextPath}/admin/add-question" class="btn-gradient btn-sm mt-3">
                            <i class="bi bi-plus-circle"></i> Add First Question
                        </a>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </section>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    <script src="${pageContext.request.contextPath}/js/main.js"></script>
</body>
</html>