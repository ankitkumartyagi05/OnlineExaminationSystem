package com.examportal.dao;

import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import com.examportal.model.Result;
import com.examportal.util.DBConnection;

public class ResultDAO {

    public Long createAttempt(Long examId, Long studentId) throws SQLException {
        String sql = "INSERT INTO exam_attempts (exam_id, student_id, start_time, status) VALUES (?, ?, NOW(), 'IN_PROGRESS')";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            ps.setLong(1, examId);
            ps.setLong(2, studentId);
            ps.executeUpdate();
            try (ResultSet rs = ps.getGeneratedKeys()) {
                if (rs.next()) return rs.getLong(1);
            }
        }
        return null;
    }

    public void saveStudentAnswer(Long attemptId, Long questionId, String selectedOption, boolean isCorrect, BigDecimal marksAwarded) throws SQLException {
        String sql = "INSERT INTO student_answers (attempt_id, question_id, selected_option, is_correct, marks_awarded) VALUES (?, ?, ?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setLong(1, attemptId);
            ps.setLong(2, questionId);
            ps.setString(3, selectedOption);
            ps.setBoolean(4, isCorrect);
            ps.setBigDecimal(5, marksAwarded);
            ps.executeUpdate();
        }
    }

    public void submitAttempt(Long attemptId, String status) throws SQLException {
        String sql = "UPDATE exam_attempts SET end_time = NOW(), status = ? WHERE attempt_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, status);
            ps.setLong(2, attemptId);
            ps.executeUpdate();
        }
    }

    public Long createResult(Result result) throws SQLException {
        String sql = "INSERT INTO results (attempt_id, exam_id, student_id, total_questions, correct_answers, wrong_answers, unattempted, marks_obtained, total_marks, percentage, is_passed) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            ps.setLong(1, result.getAttemptId());
            ps.setLong(2, result.getExamId());
            ps.setLong(3, result.getStudentId());
            ps.setInt(4, result.getTotalQuestions());
            ps.setInt(5, result.getCorrectAnswers());
            ps.setInt(6, result.getWrongAnswers());
            ps.setInt(7, result.getUnattempted());
            ps.setBigDecimal(8, result.getMarksObtained());
            ps.setBigDecimal(9, result.getTotalMarks());
            ps.setBigDecimal(10, result.getPercentage());
            ps.setBoolean(11, result.getIsPassed());
            ps.executeUpdate();
            try (ResultSet rs = ps.getGeneratedKeys()) {
                if (rs.next()) return rs.getLong(1);
            }
        }
        return null;
    }

    public boolean hasAttempted(Long examId, Long studentId) throws SQLException {
        String sql = "SELECT COUNT(*) FROM exam_attempts WHERE exam_id = ? AND student_id = ? AND status IN ('SUBMITTED', 'AUTO_SUBMITTED')";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setLong(1, examId);
            ps.setLong(2, studentId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) return rs.getInt(1) > 0;
            }
        }
        return false;
    }

    public Result findResultByAttemptId(Long attemptId) throws SQLException {
        String sql = "SELECT r.*, e.title as exam_title, u.full_name as student_name, s.roll_number, c.name as category_name " +
                     "FROM results r " +
                     "JOIN exams e ON r.exam_id = e.exam_id " +
                     "JOIN students s ON r.student_id = s.student_id " +
                     "JOIN users u ON s.user_id = u.user_id " +
                     "LEFT JOIN categories c ON e.category_id = c.category_id " +
                     "WHERE r.attempt_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setLong(1, attemptId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapRowToResult(rs);
                }
            }
        }
        return null;
    }

    public int countTotalAttempts() throws SQLException {
        String sql = "SELECT COUNT(*) FROM exam_attempts";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            if (rs.next()) return rs.getInt(1);
        }
        return 0;
    }

    public int countPassedStudents() throws SQLException {
        String sql = "SELECT COUNT(*) FROM results WHERE is_passed = TRUE";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            if (rs.next()) return rs.getInt(1);
        }
        return 0;
    }

    public java.util.List<Result> findAllResults() throws SQLException {
        java.util.List<Result> results = new java.util.ArrayList<>();
        String sql = "SELECT r.*, e.title as exam_title, u.full_name as student_name, s.roll_number, c.name as category_name " +
                     "FROM results r " +
                     "JOIN exams e ON r.exam_id = e.exam_id " +
                     "JOIN students s ON r.student_id = s.student_id " +
                     "JOIN users u ON s.user_id = u.user_id " +
                     "LEFT JOIN categories c ON e.category_id = c.category_id " +
                     "ORDER BY r.result_id DESC";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                results.add(mapRowToResult(rs));
            }
        }
        return results;
    }

    public java.util.Map<String, Object> getExamStatistics() throws SQLException {
        java.util.Map<String, Object> stats = new java.util.HashMap<>();
        String sql = "SELECT COUNT(*) as total_exams, SUM(total_questions) as total_questions, SUM(marks_obtained) as total_marks_obtained FROM results";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                stats.put("totalExams", rs.getInt("total_exams"));
                stats.put("totalQuestions", rs.getInt("total_questions"));
                stats.put("totalMarksObtained", rs.getBigDecimal("total_marks_obtained"));
            }
        }
        return stats;
    }

    public java.util.Map<String, Object> getOverallResultStatistics() throws SQLException {
        java.util.Map<String, Object> stats = new java.util.HashMap<>();
        String sql = "SELECT AVG(percentage) as avg_percentage, SUM(CASE WHEN is_passed = TRUE THEN 1 ELSE 0 END) as passed_count, SUM(CASE WHEN is_passed = FALSE THEN 1 ELSE 0 END) as failed_count FROM results";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                stats.put("averagePercentage", rs.getBigDecimal("avg_percentage"));
                stats.put("passedCount", rs.getInt("passed_count"));
                stats.put("failedCount", rs.getInt("failed_count"));
            }
        }
        return stats;
    }

    private Result mapRowToResult(ResultSet rs) throws SQLException {
        Result result = new Result();
        result.setResultId(rs.getLong("result_id"));
        result.setAttemptId(rs.getLong("attempt_id"));
        result.setExamId(rs.getLong("exam_id"));
        result.setStudentId(rs.getLong("student_id"));
        result.setTotalQuestions(rs.getInt("total_questions"));
        result.setCorrectAnswers(rs.getInt("correct_answers"));
        result.setWrongAnswers(rs.getInt("wrong_answers"));
        result.setUnattempted(rs.getInt("unattempted"));
        result.setMarksObtained(rs.getBigDecimal("marks_obtained"));
        result.setTotalMarks(rs.getBigDecimal("total_marks"));
        result.setPercentage(rs.getBigDecimal("percentage"));
        result.setIsPassed(rs.getBoolean("is_passed"));
        result.setExamTitle(rs.getString("exam_title"));
        result.setStudentName(rs.getString("student_name"));
        result.setRollNumber(rs.getString("roll_number"));
        result.setCategoryName(rs.getString("category_name"));
        java.sql.Timestamp evalDate = rs.getTimestamp("evaluation_date");
        if (evalDate != null) result.setEvaluationDate(evalDate.toLocalDateTime());
        return result;
    }
}
