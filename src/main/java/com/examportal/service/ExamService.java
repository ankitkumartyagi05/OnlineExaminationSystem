package com.examportal.service;

import java.math.BigDecimal;
import java.sql.SQLException;
import java.time.LocalDateTime;
import java.util.Collections;
import java.util.List;

import com.examportal.dao.ExamDAO;
import com.examportal.dao.QuestionDAO;
import com.examportal.model.Exam;
import com.examportal.model.Question;

public class ExamService {

    private final ExamDAO examDAO = new ExamDAO();
    private final QuestionDAO questionDAO = new QuestionDAO();

    public Long createExam(Exam exam, List<Long> questionIds) throws SQLException, ExamServiceException {
        validateExam(exam);
        if (questionIds == null || questionIds.isEmpty()) {
            throw new ExamServiceException("At least one question must be selected for the exam");
        }

        List<Question> questions = new java.util.ArrayList<>();
        BigDecimal totalMarks = BigDecimal.ZERO;
        for (Long qId : questionIds) {
            Question q = questionDAO.findById(qId);
            if (q == null) {
                throw new ExamServiceException("Question not found: " + qId);
            }
            questions.add(q);
            totalMarks = totalMarks.add(q.getMarks());
        }

        exam.setTotalQuestions(questions.size());
        exam.setTotalMarks(totalMarks);
        exam.setQuestions(questions);
        exam.setStatus("PUBLISHED");
        exam.setCreatedAt(LocalDateTime.now());

        return examDAO.createExam(exam, questionIds);
    }

    public boolean updateExam(Exam exam) throws SQLException, ExamServiceException {
        validateExam(exam);
        return examDAO.updateExam(exam);
    }

    public boolean deleteExam(Long examId) throws SQLException {
        return examDAO.deleteExam(examId);
    }

    public Exam getExamById(Long examId) throws SQLException {
        Exam exam = examDAO.findById(examId);
        if (exam != null) {
            List<Question> questions = examDAO.getExamQuestions(examId);
            if (exam.getRandomizeQuestions() != null && exam.getRandomizeQuestions()) {
                Collections.shuffle(questions);
            }
            exam.setQuestions(questions);
        }
        return exam;
    }

    public List<Exam> getAllExams() throws SQLException {
        return examDAO.findAllExams();
    }

    public List<Exam> getExamsByCreator(Long creatorId) throws SQLException {
        return examDAO.findExamsByCreator(creatorId);
    }

    public List<Exam> getAvailableExamsForStudent() throws SQLException {
        return examDAO.findPublishedExams();
    }

    public boolean publishExam(Long examId) throws SQLException {
        return examDAO.updateStatus(examId, "PUBLISHED");
    }

    public boolean archiveExam(Long examId) throws SQLException {
        return examDAO.updateStatus(examId, "ARCHIVED");
    }

    public List<Question> getExamQuestions(Long examId) throws SQLException {
        return examDAO.getExamQuestions(examId);
    }

    private void validateExam(Exam exam) throws ExamServiceException {
        if (exam.getTitle() == null || exam.getTitle().trim().isEmpty()) {
            throw new ExamServiceException("Exam title is required");
        }
        if (exam.getCategoryId() == null) {
            throw new ExamServiceException("Category is required");
        }
        if (exam.getDurationMinutes() == null || exam.getDurationMinutes() <= 0) {
            throw new ExamServiceException("Duration must be a positive number");
        }
        if (exam.getStartTime() == null || exam.getEndTime() == null) {
            throw new ExamServiceException("Start and end times are required");
        }
        if (exam.getEndTime().isBefore(exam.getStartTime())) {
            throw new ExamServiceException("End time must be after start time");
        }
        if (exam.getPassPercentage() == null || 
            exam.getPassPercentage().compareTo(BigDecimal.ZERO) < 0 ||
            exam.getPassPercentage().compareTo(new BigDecimal("100")) > 0) {
            throw new ExamServiceException("Pass percentage must be between 0 and 100");
        }
    }

    public static class ExamServiceException extends Exception {
        public ExamServiceException(String message) {
            super(message);
        }
    }
}