<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<nav class="navbar navbar-expand-lg navbar-glass fixed-top">
    <div class="container">
        <a class="navbar-brand" href="${pageContext.request.contextPath}/home">
            <i class="bi bi-mortarboard-fill me-2"></i>ExamPro
        </a>
        <button class="navbar-toggler border-0" type="button" data-bs-toggle="collapse" data-bs-target="#navContent" style="color: #a0a0b8;">
            <i class="bi bi-list fs-4"></i>
        </button>
        <div class="collapse navbar-collapse" id="navContent">
            <ul class="navbar-nav ms-auto align-items-lg-center gap-1">
                <li class="nav-item">
                    <a class="nav-link ${param.currentPage == 'home' ? 'active' : ''}" href="${pageContext.request.contextPath}/home">
                        <i class="bi bi-house-door me-1"></i>Home
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link ${param.currentPage == 'tests' ? 'active' : ''}" href="${pageContext.request.contextPath}/tests">
                        <i class="bi bi-collection me-1"></i>Tests
                    </a>
                </li>
                <c:if test="${not empty sessionScope.candidate}">
                    <li class="nav-item">
                        <a class="nav-link ${param.currentPage == 'performance' ? 'active' : ''}" href="${pageContext.request.contextPath}/performance">
                            <i class="bi bi-graph-up me-1"></i>Performance
                        </a>
                    </li>
                </c:if>
                <li class="nav-item">
                    <a class="nav-link ${param.currentPage == 'admin' ? 'active' : ''}" href="${pageContext.request.contextPath}/admin">
                        <i class="bi bi-gear me-1"></i>Admin
                    </a>
                </li>
                <c:if test="${empty sessionScope.candidate}">
                    <li class="nav-item ms-lg-2">
                        <a class="btn-gradient btn-sm" href="${pageContext.request.contextPath}/register">
                            <i class="bi bi-person-plus me-1"></i>Register
                        </a>
                    </li>
                </c:if>
            </ul>
        </div>
    </div>
</nav>