package com.examportal.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

import com.examportal.model.Exam;
import com.examportal.model.Question;
import com.examportal.util.DBConnection;

public class ExamDAO {

    private final QuestionDAO questionDAO = new QuestionDAO();

    public Long createExam(Exam exam, List<Long> questionIds) throws SQLException {
        String examSql = "INSERT INTO exams (title, description, category_id, created_by, total_questions, total_marks, duration_minutes, pass_percentage, negative_marking, negative_marks_per_question, randomize_questions, status, start_time, end_time, created_at) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        try (Connection conn = DBConnection.getConnection()) {
            conn.setAutoCommit(false);
            try {
                Long examId = null;
                try (PreparedStatement ps = conn.prepareStatement(examSql, Statement.RETURN_GENERATED_KEYS)) {
                    ps.setString(1, exam.getTitle());
                    ps.setString(2, exam.getDescription());
                    ps.setLong(3, exam.getCategoryId());
                    ps.setLong(4, exam.getCreatedBy() != null ? exam.getCreatedBy() : 0L);
                    ps.setInt(5, questionIds.size());
                    ps.setBigDecimal(6, exam.getTotalMarks());
                    ps.setInt(7, exam.getDurationMinutes());
                    ps.setBigDecimal(8, exam.getPassPercentage());
                    ps.setBoolean(9, exam.getNegativeMarking() != null ? exam.getNegativeMarking() : false);
                    ps.setBigDecimal(10, exam.getNegativeMarksPerQuestion());
                    ps.setBoolean(11, exam.getRandomizeQuestions() != null ? exam.getRandomizeQuestions() : false);
                    ps.setString(12, exam.getStatus() != null ? exam.getStatus() : "DRAFT");
                    ps.setTimestamp(13, exam.getStartTime() != null ? Timestamp.valueOf(exam.getStartTime()) : null);
                    ps.setTimestamp(14, exam.getEndTime() != null ? Timestamp.valueOf(exam.getEndTime()) : null);
                    ps.setTimestamp(15, exam.getCreatedAt() != null ? Timestamp.valueOf(exam.getCreatedAt()) : Timestamp.valueOf(java.time.LocalDateTime.now()));
                    ps.executeUpdate();

                    try (ResultSet rs = ps.getGeneratedKeys()) {
                        if (rs.next()) examId = rs.getLong(1);
                    }
                }

                if (examId != null) {
                    String eqSql = "INSERT INTO exam_questions (exam_id, question_id) VALUES (?, ?)";
                    try (PreparedStatement eqPs = conn.prepareStatement(eqSql)) {
                        for (Long qId : questionIds) {
                            eqPs.setLong(1, examId);
                            eqPs.setLong(2, qId);
                            eqPs.addBatch();
                        }
                        eqPs.executeBatch();
                    }
                }
                conn.commit();
                return examId;
            } catch (SQLException e) {
                conn.rollback();
                throw e;
            } finally {
                try {
                    conn.setAutoCommit(true);
                } catch (SQLException ex) {
                    // Ignore exception on resetting auto-commit during close
                }
            }
        }
    }

    public boolean updateExam(Exam exam) throws SQLException {
        String sql = "UPDATE exams SET title = ?, description = ?, category_id = ?, total_questions = ?, total_marks = ?, duration_minutes = ?, pass_percentage = ?, negative_marking = ?, negative_marks_per_question = ?, randomize_questions = ?, status = ?, start_time = ?, end_time = ? WHERE exam_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, exam.getTitle());
            ps.setString(2, exam.getDescription());
            ps.setLong(3, exam.getCategoryId());
            ps.setInt(4, exam.getTotalQuestions() != null ? exam.getTotalQuestions() : 0);
            ps.setBigDecimal(5, exam.getTotalMarks());
            ps.setInt(6, exam.getDurationMinutes() != null ? exam.getDurationMinutes() : 0);
            ps.setBigDecimal(7, exam.getPassPercentage());
            ps.setBoolean(8, exam.getNegativeMarking() != null ? exam.getNegativeMarking() : false);
            ps.setBigDecimal(9, exam.getNegativeMarksPerQuestion());
            ps.setBoolean(10, exam.getRandomizeQuestions() != null ? exam.getRandomizeQuestions() : false);
            ps.setString(11, exam.getStatus());
            ps.setTimestamp(12, exam.getStartTime() != null ? Timestamp.valueOf(exam.getStartTime()) : null);
            ps.setTimestamp(13, exam.getEndTime() != null ? Timestamp.valueOf(exam.getEndTime()) : null);
            ps.setLong(14, exam.getExamId());
            return ps.executeUpdate() > 0;
        }
    }

    public boolean deleteExam(Long examId) throws SQLException {
        String sql = "DELETE FROM exams WHERE exam_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setLong(1, examId);
            return ps.executeUpdate() > 0;
        }
    }

    public List<Question> getExamQuestions(Long examId) throws SQLException {
        return questionDAO.findQuestionsByExamId(examId);
    }

    public List<Exam> findAllExams() throws SQLException {
        List<Exam> exams = new ArrayList<>();
        String sql = "SELECT e.*, c.name as category_name FROM exams e JOIN categories c ON e.category_id = c.category_id ORDER BY e.created_at DESC";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                exams.add(mapRowToExam(rs));
            }
        }
        return exams;
    }

    public List<Exam> findExamsByCreator(Long creatorId) throws SQLException {
        List<Exam> exams = new ArrayList<>();
        String sql = "SELECT e.*, c.name as category_name FROM exams e JOIN categories c ON e.category_id = c.category_id WHERE e.created_by = ? ORDER BY e.created_at DESC";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setLong(1, creatorId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    exams.add(mapRowToExam(rs));
                }
            }
        }
        return exams;
    }

    public List<Exam> findAllPublishedExams() throws SQLException {
        List<Exam> exams = new ArrayList<>();
        String sql = "SELECT e.*, c.name as category_name FROM exams e JOIN categories c ON e.category_id = c.category_id WHERE e.status = 'PUBLISHED' ORDER BY e.created_at DESC";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                exams.add(mapRowToExam(rs));
            }
        }
        return exams;
    }

    public List<Exam> findPublishedExams() throws SQLException {
        return findAllPublishedExams();
    }

    public boolean updateStatus(Long examId, String status) throws SQLException {
        String sql = "UPDATE exams SET status = ? WHERE exam_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, status);
            ps.setLong(2, examId);
            return ps.executeUpdate() > 0;
        }
    }

    public int countAllExams() throws SQLException {
        String sql = "SELECT COUNT(*) FROM exams";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            if (rs.next()) return rs.getInt(1);
        }
        return 0;
    }

    public Exam findById(Long examId) throws SQLException {
        String sql = "SELECT e.*, c.name as category_name FROM exams e JOIN categories c ON e.category_id = c.category_id WHERE e.exam_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setLong(1, examId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    Exam exam = mapRowToExam(rs);
                    exam.setQuestions(questionDAO.findQuestionsByExamId(examId));
                    return exam;
                }
            }
        }
        return null;
    }

    private Exam mapRowToExam(ResultSet rs) throws SQLException {
        Exam exam = new Exam();
        exam.setExamId(rs.getLong("exam_id"));
        exam.setTitle(rs.getString("title"));
        exam.setDescription(rs.getString("description"));
        exam.setCategoryId(rs.getLong("category_id"));
        exam.setCategoryName(rs.getString("category_name"));
        exam.setTotalQuestions(rs.getInt("total_questions"));
        exam.setTotalMarks(rs.getBigDecimal("total_marks"));
        exam.setDurationMinutes(rs.getInt("duration_minutes"));
        exam.setPassPercentage(rs.getBigDecimal("pass_percentage"));
        exam.setNegativeMarking(rs.getBoolean("negative_marking"));
        exam.setNegativeMarksPerQuestion(rs.getBigDecimal("negative_marks_per_question"));
        exam.setRandomizeQuestions(rs.getBoolean("randomize_questions"));
        exam.setStatus(rs.getString("status"));
        return exam;
    }
}