<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Register | ExamPortal</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Orbitron:wght@400;700;900&family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link href="css/style.css" rel="stylesheet">
</head>
<body class="auth-page">
    <canvas id="bg-canvas"></canvas>

    <div class="auth-container">
        <div class="auth-card glass-card auth-card-wide">
            <div class="auth-header">
                <a href="${pageContext.request.contextPath}/" class="auth-logo">
                    <i class="fas fa-graduation-cap"></i> Exam<span>Portal</span>
                </a>
                <h2>Create Account</h2>
                <p>Join ExamPortal to get started</p>
            </div>

            <c:if test="${not empty error}">
                <div class="alert alert-danger alert-custom">
                    <i class="fas fa-exclamation-circle me-2"></i>${error}
                </div>
            </c:if>

            <form action="${pageContext.request.contextPath}/register" method="post" class="auth-form">
                <!-- Role Selection -->
                <div class="form-group-custom">
                    <label><i class="fas fa-user-tag me-2"></i>I am a</label>
                    <div class="role-selector">
                        <input type="radio" name="role" id="roleStudent" value="STUDENT" 
                               ${role == 'STUDENT' ? 'checked' : 'checked'} onchange="toggleRoleFields()">
                        <label for="roleStudent" class="role-option">
                            <i class="fas fa-user-graduate"></i> Student
                        </label>
                        <input type="radio" name="role" id="roleFaculty" value="FACULTY"
                               ${role == 'FACULTY' ? 'checked' : ''} onchange="toggleRoleFields()">
                        <label for="roleFaculty" class="role-option">
                            <i class="fas fa-chalkboard-teacher"></i> Faculty
                        </label>
                    </div>
                </div>

                <div class="row">
                    <div class="col-md-6">
                        <div class="form-group-custom">
                            <label for="fullName"><i class="fas fa-user me-2"></i>Full Name</label>
                            <input type="text" class="form-control-custom" id="fullName" name="fullName" 
                                   value="${fullName}" placeholder="John Doe" required>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="form-group-custom">
                            <label for="email"><i class="fas fa-envelope me-2"></i>Email</label>
                            <input type="email" class="form-control-custom" id="email" name="email" 
                                   value="${email}" placeholder="you@example.com" required>
                        </div>
                    </div>
                </div>

                <div class="row">
                    <div class="col-md-6">
                        <div class="form-group-custom">
                            <label for="password"><i class="fas fa-lock me-2"></i>Password</label>
                            <input type="password" class="form-control-custom" id="password" name="password" 
                                   placeholder="Min 8 chars, Aa1@#" required>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="form-group-custom">
                            <label for="phone"><i class="fas fa-phone me-2"></i>Phone</label>
                            <input type="tel" class="form-control-custom" id="phone" name="phone" 
                                   value="${phone}" placeholder="9876543210">
                        </div>
                    </div>
                </div>

                <!-- Student Fields -->
                <div id="studentFields" class="role-fields">
                    <hr class="form-divider">
                    <h6 class="fields-title"><i class="fas fa-user-graduate me-2"></i>Student Information</h6>
                    <div class="row">
                        <div class="col-md-6">
                            <div class="form-group-custom">
                                <label for="rollNumber">Roll Number</label>
                                <input type="text" class="form-control-custom" id="rollNumber" name="rollNumber" 
                                       value="${rollNumber}" placeholder="CS2021001">
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="form-group-custom">
                                <label for="course">Course</label>
                                <input type="text" class="form-control-custom" id="course" name="course" 
                                       value="${course}" placeholder="B.Tech">
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-4">
                            <div class="form-group-custom">
                                <label for="branch">Branch</label>
                                <input type="text" class="form-control-custom" id="branch" name="branch" 
                                       value="${branch}" placeholder="Computer Science">
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div class="form-group-custom">
                                <label for="semester">Semester</label>
                                <input type="number" class="form-control-custom" id="semester" name="semester" 
                                       value="${semester}" min="1" max="8" placeholder="5">
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div class="form-group-custom">
                                <label for="yearOfAdmission">Admission Year</label>
                                <input type="number" class="form-control-custom" id="yearOfAdmission" name="yearOfAdmission" 
                                       value="${yearOfAdmission}" min="2010" max="2025" placeholder="2021">
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Faculty Fields -->
                <div id="facultyFields" class="role-fields" style="display:none;">
                    <hr class="form-divider">
                    <h6 class="fields-title"><i class="fas fa-chalkboard-teacher me-2"></i>Faculty Information</h6>
                    <div class="row">
                        <div class="col-md-6">
                            <div class="form-group-custom">
                                <label for="employeeId">Employee ID</label>
                                <input type="text" class="form-control-custom" id="employeeId" name="employeeId" 
                                       value="${employeeId}" placeholder="FAC001">
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="form-group-custom">
                                <label for="department">Department</label>
                                <input type="text" class="form-control-custom" id="department" name="department" 
                                       value="${department}" placeholder="Computer Science">
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-6">
                            <div class="form-group-custom">
                                <label for="designation">Designation</label>
                                <input type="text" class="form-control-custom" id="designation" name="designation" 
                                       value="${designation}" placeholder="Associate Professor">
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="form-group-custom">
                                <label for="specialization">Specialization</label>
                                <input type="text" class="form-control-custom" id="specialization" name="specialization" 
                                       value="${specialization}" placeholder="Data Structures">
                            </div>
                        </div>
                    </div>
                </div>

                <button type="submit" class="btn btn-cyber w-100 btn-lg mt-3">
                    <i class="fas fa-user-plus me-2"></i>Create Account
                </button>
            </form>

            <p class="auth-footer-text">
                Already have an account? <a href="${pageContext.request.contextPath}/login">Sign in here</a>
            </p>
        </div>
    </div>

    <script src="https://cdnjs.cloudflare.com/ajax/libs/three.js/r128/three.min.js"></script>
    <script src="js/three-bg.js"></script>
    <script>
        function toggleRoleFields() {
            const isStudent = document.getElementById('roleStudent').checked;
            document.getElementById('studentFields').style.display = isStudent ? 'block' : 'none';
            document.getElementById('facultyFields').style.display = isStudent ? 'none' : 'block';
        }
        toggleRoleFields();
    </script>
</body>
</html>