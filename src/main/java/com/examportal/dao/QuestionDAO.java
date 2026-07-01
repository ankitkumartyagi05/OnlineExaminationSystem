package com.examportal.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import com.examportal.model.Question;
import com.examportal.util.DBConnection;

public class QuestionDAO {

    public List<Question> findQuestionsByExamId(Long examId) throws SQLException {
        List<Question> questions = new ArrayList<>();
        String sql = "SELECT q.* FROM exam_questions eq JOIN questions q ON eq.question_id = q.question_id WHERE eq.exam_id = ? AND q.is_active = TRUE";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setLong(1, examId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    questions.add(mapRowToQuestion(rs));
                }
            }
        }
        return questions;
    }

    public Long createQuestion(Question q) throws SQLException {
        String sql = "INSERT INTO questions (category_id, created_by, question_text, option_a, option_b, option_c, option_d, correct_answer, marks, negative_marks, difficulty_level, is_active) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            ps.setLong(1, q.getCategoryId());
            ps.setLong(2, q.getCreatedBy() != null ? q.getCreatedBy() : 0L);
            ps.setString(3, q.getQuestionText());
            ps.setString(4, q.getOptionA());
            ps.setString(5, q.getOptionB());
            ps.setString(6, q.getOptionC());
            ps.setString(7, q.getOptionD());
            ps.setString(8, q.getCorrectAnswer());
            ps.setBigDecimal(9, q.getMarks());
            ps.setBigDecimal(10, q.getNegativeMarks());
            ps.setString(11, q.getDifficultyLevel());
            ps.setBoolean(12, q.getIsActive() != null ? q.getIsActive() : true);
            ps.executeUpdate();
            try (ResultSet rs = ps.getGeneratedKeys()) {
                if (rs.next()) return rs.getLong(1);
            }
        }
        return null;
    }

    public Long findCategoryIdByName(String categoryName) throws SQLException {
        String sql = "SELECT category_id FROM categories WHERE name = ? LIMIT 1";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, categoryName);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getLong("category_id");
                }
            }
        }
        return null;
    }

    public List<Question> findByCreator(Long creatorId) throws SQLException {
        List<Question> questions = new ArrayList<>();
        String sql = "SELECT * FROM questions WHERE created_by = ? AND is_active = TRUE ORDER BY question_id DESC";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setLong(1, creatorId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    questions.add(mapRowToQuestion(rs));
                }
            }
        }
        return questions;
    }

    public List<String> findAllCategories() throws SQLException {
        List<String> categories = new ArrayList<>();
        String sql = "SELECT name FROM categories ORDER BY name";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                categories.add(rs.getString("name"));
            }
        }
        return categories;
    }

    public Question findById(Long questionId) throws SQLException {
        String sql = "SELECT * FROM questions WHERE question_id = ? AND is_active = TRUE";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setLong(1, questionId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapRowToQuestion(rs);
                }
            }
        }
        return null;
    }

    public int countAllQuestions() throws SQLException {
        String sql = "SELECT COUNT(*) FROM questions WHERE is_active = TRUE";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            if (rs.next()) return rs.getInt(1);
        }
        return 0;
    }

    public boolean updateQuestion(Question q) throws SQLException {
        String sql = "UPDATE questions SET category_id = ?, question_text = ?, option_a = ?, option_b = ?, option_c = ?, option_d = ?, correct_answer = ?, marks = ?, negative_marks = ?, difficulty_level = ?, is_active = ? WHERE question_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setLong(1, q.getCategoryId());
            ps.setString(2, q.getQuestionText());
            ps.setString(3, q.getOptionA());
            ps.setString(4, q.getOptionB());
            ps.setString(5, q.getOptionC());
            ps.setString(6, q.getOptionD());
            ps.setString(7, q.getCorrectAnswer());
            ps.setBigDecimal(8, q.getMarks());
            ps.setBigDecimal(9, q.getNegativeMarks());
            ps.setString(10, q.getDifficultyLevel());
            ps.setBoolean(11, q.getIsActive() != null ? q.getIsActive() : true);
            ps.setLong(12, q.getQuestionId());
            return ps.executeUpdate() > 0;
        }
    }

    public boolean deleteQuestion(Long questionId) throws SQLException {
        String sql = "UPDATE questions SET is_active = FALSE WHERE question_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setLong(1, questionId);
            return ps.executeUpdate() > 0;
        }
    }

    private Question mapRowToQuestion(ResultSet rs) throws SQLException {
        Question q = new Question();
        q.setQuestionId(rs.getLong("question_id"));
        q.setCategoryId(rs.getLong("category_id"));
        q.setCreatedBy(rs.getLong("created_by"));
        q.setQuestionText(rs.getString("question_text"));
        q.setOptionA(rs.getString("option_a"));
        q.setOptionB(rs.getString("option_b"));
        q.setOptionC(rs.getString("option_c"));
        q.setOptionD(rs.getString("option_d"));
        q.setCorrectAnswer(rs.getString("correct_answer"));
        q.setMarks(rs.getBigDecimal("marks"));
        q.setNegativeMarks(rs.getBigDecimal("negative_marks"));
        q.setDifficultyLevel(rs.getString("difficulty_level"));
        q.setIsActive(rs.getBoolean("is_active"));
        return q;
    }
}