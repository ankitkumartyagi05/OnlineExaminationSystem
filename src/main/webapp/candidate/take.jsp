<%@ page import="java.util.List" %>
<%@ page import="com.examportal.model.Question" %>
<%@ page import="com.examportal.model.TestItem" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<% TestItem test = (TestItem) request.getAttribute("test"); List<Question> questions = (List<Question>) request.getAttribute("questions"); %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><%= test != null ? test.getTestName() : "Take Test" %></title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body { background: linear-gradient(135deg, #07111f, #15253f); color: #f3f6ff; font-family: Arial, sans-serif; }
        .glass { background: rgba(255,255,255,0.1); backdrop-filter: blur(16px); border: 1px solid rgba(255,255,255,0.15); border-radius: 20px; box-shadow: 0 12px 35px rgba(0,0,0,0.25); }
        .option-card { border: 1px solid rgba(255,255,255,0.16); padding: 10px 12px; border-radius: 10px; margin-bottom: 10px; }
    </style>
</head>
<body>
<div class="container py-5">
    <div class="glass p-4 p-lg-5">
        <h2 class="mb-3"><%= test != null ? test.getTestName() : "Test" %></h2>
        <p class="text-light-emphasis">Duration: <%= test != null ? test.getDurationMinutes() : 0 %> minutes</p>
        <form method="post" action="${pageContext.request.contextPath}/candidate">
            <input type="hidden" name="action" value="submit-test" />
            <input type="hidden" name="testId" value="<%= test != null ? test.getTestId() : 0 %>" />
            <input type="hidden" name="testName" value="<%= test != null ? test.getTestName() : "" %>" />
            <% if (questions != null) { for (int i = 0; i < questions.size(); i++) { Question question = questions.get(i); %>
            <div class="card bg-dark text-light mb-4">
                <div class="card-body">
                    <h6 class="card-title"><%= (i + 1) + ". " + question.getQuestionText() %></h6>
                    <div class="mt-3">
                        <div class="option-card"><label><input type="radio" name="answer_<%= question.getQuestionId() %>" value="A"> <%= question.getOptionA() %></label></div>
                        <div class="option-card"><label><input type="radio" name="answer_<%= question.getQuestionId() %>" value="B"> <%= question.getOptionB() %></label></div>
                        <div class="option-card"><label><input type="radio" name="answer_<%= question.getQuestionId() %>" value="C"> <%= question.getOptionC() %></label></div>
                        <div class="option-card"><label><input type="radio" name="answer_<%= question.getQuestionId() %>" value="D"> <%= question.getOptionD() %></label></div>
                    </div>
                </div>
            </div>
            <% } } %>
            <button type="submit" class="btn btn-primary btn-lg">Submit Test</button>
        </form>
    </div>
</div>
</body>
</html>
