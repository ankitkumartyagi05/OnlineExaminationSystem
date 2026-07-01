<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.examportal.model.Exam" %>
<%@ page import="com.examportal.model.Question" %>
<%@ page import="java.util.List" %>
<%
    Exam exam = (Exam) request.getAttribute("exam");
    List<Question> questions = exam.getQuestions();
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><%= exam.getTitle() %> | ExamPortal</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css" rel="stylesheet">
    <link href="css/style.css" rel="stylesheet">
</head>
<body class="exam-body">
    <div class="exam-header">
        <h4><%= exam.getTitle() %></h4>
        <div class="timer" id="timer"><i class="fas fa-clock me-2"></i><span id="time"><%= exam.getDurationMinutes() %>:00</span></div>
    </div>

    <div class="container mt-4">
        <form action="${pageContext.request.contextPath}/exam/submit" method="post" id="examForm">
            <input type="hidden" name="examId" value="<%= exam.getExamId() %>">
            
            <% for(int i=0; i<questions.size(); i++) { 
                Question q = questions.get(i); %>
                <div class="glass-card question-card" id="q<%= i+1 %>">
                    <h5><span class="badge bg-primary">Q<%= i+1 %></span> <%= q.getQuestionText() %></h5>
                    <div class="mt-3">
                        <div class="form-check option-item">
                            <input class="form-check-input" type="radio" name="q_<%= q.getQuestionId() %>" value="A" id="a_<%= q.getQuestionId() %>">
                            <label class="form-check-label" for="a_<%= q.getQuestionId() %>">A. <%= q.getOptionA() %></label>
                        </div>
                        <div class="form-check option-item">
                            <input class="form-check-input" type="radio" name="q_<%= q.getQuestionId() %>" value="B" id="b_<%= q.getQuestionId() %>">
                            <label class="form-check-label" for="b_<%= q.getQuestionId() %>">B. <%= q.getOptionB() %></label>
                        </div>
                        <div class="form-check option-item">
                            <input class="form-check-input" type="radio" name="q_<%= q.getQuestionId() %>" value="C" id="c_<%= q.getQuestionId() %>">
                            <label class="form-check-label" for="c_<%= q.getQuestionId() %>">C. <%= q.getOptionC() %></label>
                        </div>
                        <div class="form-check option-item">
                            <input class="form-check-input" type="radio" name="q_<%= q.getQuestionId() %>" value="D" id="d_<%= q.getQuestionId() %>">
                            <label class="form-check-label" for="d_<%= q.getQuestionId() %>">D. <%= q.getOptionD() %></label>
                        </div>
                    </div>
                </div>
            <% } %>
            
            <button type="submit" class="btn btn-success btn-lg w-100 mb-5">Submit Exam</button>
        </form>
    </div>

    <script>
        const duration = <%= exam.getDurationMinutes() %>;
        let timeLeft = duration * 60;
        const timerElement = document.getElementById('time');
        
        const timerInterval = setInterval(() => {
            timeLeft--;
            const m = Math.floor(timeLeft / 60);
            const s = timeLeft % 60;
            timerElement.textContent = `${m}:${s.toString().padStart(2, '0')}`;
            
            if (timeLeft <= 0) {
                clearInterval(timerInterval);
                alert('Time is up! Submitting exam automatically.');
                document.getElementById('examForm').submit();
            }
        }, 1000);
    </script>
</body>
</html>