// Placeholder
package com.exam.dao;

import com.exam.model.Result;
import com.exam.util.DBUtil;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ResultDAO {

    public int insert(Result r) throws SQLException {
        String sql = "INSERT INTO results (candidate_id, test_id, exam_name, total_questions, correct_answers, wrong_answers, marks_obtained, total_marks, percentage, pass_fail) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            ps.setInt(1, r.getCandidateId());
            ps.setInt(2, r.getTestId());
            ps.setString(3, r.getExamName());
            ps.setInt(4, r.getTotalQuestions());
            ps.setInt(5, r.getCorrectAnswers());
            ps.setInt(6, r.getWrongAnswers());
            ps.setBigDecimal(7, r.getMarksObtained());
            ps.setBigDecimal(8, r.getTotalMarks());
            ps.setBigDecimal(9, r.getPercentage());
            ps.setString(10, r.getPassFail());
            ps.executeUpdate();
            try (ResultSet rs = ps.getGeneratedKeys()) {
                if (rs.next()) return rs.getInt(1);
            }
        }
        return -1;
    }

    public Result findByCandidateAndTest(int candidateId, int testId) throws SQLException {
        String sql = "SELECT r.*, c.name AS candidate_name, c.roll_number FROM results r JOIN candidates c ON r.candidate_id = c.id WHERE r.candidate_id = ? AND r.test_id = ?";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, candidateId);
            ps.setInt(2, testId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) return mapRow(rs);
            }
        }
        return null;
    }

    public List<Result> findByCandidate(int candidateId) throws SQLException {
        String sql = "SELECT r.*, c.name AS candidate_name, c.roll_number FROM results r JOIN candidates c ON r.candidate_id = c.id WHERE r.candidate_id = ? ORDER BY r.created_at DESC";
        List<Result> list = new ArrayList<>();
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, candidateId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) list.add(mapRow(rs));
            }
        }
        return list;
    }

    public List<Result> findAll() throws SQLException {
        String sql = "SELECT r.*, c.name AS candidate_name, c.roll_number FROM results r JOIN candidates c ON r.candidate_id = c.id ORDER BY r.created_at DESC";
        List<Result> list = new ArrayList<>();
        try (Connection conn = DBUtil.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            while (rs.next()) list.add(mapRow(rs));
        }
        return list;
    }

    public int countAll() throws SQLException {
        String sql = "SELECT COUNT(*) FROM results";
        try (Connection conn = DBUtil.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            if (rs.next()) return rs.getInt(1);
        }
        return 0;
    }

    private Result mapRow(ResultSet rs) throws SQLException {
        Result r = new Result();
        r.setId(rs.getInt("id"));
        r.setCandidateId(rs.getInt("candidate_id"));
        r.setTestId(rs.getInt("test_id"));
        r.setExamName(rs.getString("exam_name"));
        r.setTotalQuestions(rs.getInt("total_questions"));
        r.setCorrectAnswers(rs.getInt("correct_answers"));
        r.setWrongAnswers(rs.getInt("wrong_answers"));
        r.setMarksObtained(rs.getBigDecimal("marks_obtained"));
        r.setTotalMarks(rs.getBigDecimal("total_marks"));
        r.setPercentage(rs.getBigDecimal("percentage"));
        r.setPassFail(rs.getString("pass_fail"));
        r.setCreatedAt(rs.getTimestamp("created_at").toLocalDateTime());
        r.setCandidateName(rs.getString("candidate_name"));
        r.setRollNumber(rs.getString("roll_number"));
        return r;
    }
}