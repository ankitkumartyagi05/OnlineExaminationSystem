package com.examportal.dao;

import com.examportal.model.Question;
import com.examportal.model.TestItem;
import com.examportal.util.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class TestDao {
    public List<TestItem> findAllTests() throws SQLException {
        List<TestItem> tests = new ArrayList<>();
        String sql = "SELECT * FROM tests ORDER BY test_id DESC";
        try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                tests.add(new TestItem(rs.getInt("test_id"), rs.getString("test_name"), rs.getString("subject"), rs.getInt("duration_minutes"), rs.getInt("total_questions")));
            }
        }
        return tests;
    }

    public List<Question> findQuestionsForTest(int testId) throws SQLException {
        List<Question> questions = new ArrayList<>();
        String sql = "SELECT q.* FROM questions q JOIN test_questions tq ON q.question_id = tq.question_id WHERE tq.test_id = ? ORDER BY tq.id";
        try (Connection conn = DBConnection.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, testId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    questions.add(new Question(rs.getInt("question_id"), rs.getString("subject"), rs.getString("question_text"), rs.getString("option_a"), rs.getString("option_b"), rs.getString("option_c"), rs.getString("option_d"), rs.getString("correct_answer"), rs.getInt("marks")));
                }
            }
        }
        return questions;
    }
}
