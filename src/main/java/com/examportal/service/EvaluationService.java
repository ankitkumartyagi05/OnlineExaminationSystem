package com.examportal.service;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import com.examportal.dao.ExamDAO;
import com.examportal.dao.ResultDAO;
import com.examportal.model.Exam;
import com.examportal.model.Question;
import com.examportal.model.Result;

public class EvaluationService {

    private final ExamDAO examDAO = new ExamDAO();
    private final ResultDAO resultDAO = new ResultDAO();

    public Long startExam(Long examId, Long studentId) throws SQLException, Exception {
        if (resultDAO.hasAttempted(examId, studentId)) {
            throw new Exception("You have already attempted this exam.");
        }
        return resultDAO.createAttempt(examId, studentId);
    }

    public Result submitExam(Long attemptId, Long examId, Long studentId, Map<Long, String> answers) throws SQLException, Exception {
        Exam exam = examDAO.findById(examId);
        List<Question> questions = exam.getQuestions();

        int correct = 0, wrong = 0, unattempted = 0;
        BigDecimal marksObtained = BigDecimal.ZERO;
        BigDecimal negativeMark = exam.getNegativeMarking() ? exam.getNegativeMarksPerQuestion() : BigDecimal.ZERO;

        for (Question q : questions) {
            String selectedOption = answers.get(q.getQuestionId());
            if (selectedOption == null || selectedOption.isEmpty()) {
                unattempted++;
            } else {
                boolean isCorrect = selectedOption.equals(q.getCorrectAnswer());
                BigDecimal marksAwarded;
                if (isCorrect) {
                    correct++;
                    marksAwarded = q.getMarks();
                } else {
                    wrong++;
                    marksAwarded = negativeMark.negate();
                }
                marksObtained = marksObtained.add(marksAwarded);
                resultDAO.saveStudentAnswer(attemptId, q.getQuestionId(), selectedOption, isCorrect, marksAwarded);
            }
        }

        if (marksObtained.compareTo(BigDecimal.ZERO) < 0) marksObtained = BigDecimal.ZERO;
        
        BigDecimal percentage = marksObtained.multiply(new BigDecimal("100"))
                .divide(exam.getTotalMarks(), 2, RoundingMode.HALF_UP);
        boolean isPassed = percentage.compareTo(exam.getPassPercentage()) >= 0;

        Result result = new Result();
        result.setAttemptId(attemptId);
        result.setExamId(examId);
        result.setStudentId(studentId);
        result.setTotalQuestions(questions.size());
        result.setCorrectAnswers(correct);
        result.setWrongAnswers(wrong);
        result.setUnattempted(unattempted);
        result.setMarksObtained(marksObtained);
        result.setTotalMarks(exam.getTotalMarks());
        result.setPercentage(percentage);
        result.setIsPassed(isPassed);

        resultDAO.createResult(result);
        resultDAO.submitAttempt(attemptId, "SUBMITTED");

        return result;
    }
}