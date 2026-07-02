// Placeholder
package com.exam.dao;

import com.exam.model.Test;
import com.exam.util.DBUtil;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class TestDAO {

    public int insert(Test t) throws SQLException {
        String sql = "INSERT INTO tests (test_name, subject, total_questions, total_marks, duration_minutes, pass_percentage, status) VALUES (?, ?, ?, ?, ?, ?, ?)";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            ps.setString(1, t.getTestName());
            ps.setString(2, t.getSubject());
            ps.setInt(3, t.getTotalQuestions());
            ps.setInt(4, t.getTotalMarks());
            ps.setInt(5, t.getDurationMinutes());
            ps.setBigDecimal(6, t.getPassPercentage());
            ps.setString(7, t.getStatus());
            ps.executeUpdate();
            try (ResultSet rs = ps.getGeneratedKeys()) {
                if (rs.next()) return rs.getInt(1);
            }
        }
        return -1;
    }

    public boolean delete(int id) throws SQLException {
        String sql = "DELETE FROM tests WHERE id = ?";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        }
    }

    public boolean toggleStatus(int id) throws SQLException {
        String sql = "UPDATE tests SET status = CASE WHEN status = 'ACTIVE' THEN 'INACTIVE' ELSE 'ACTIVE' END WHERE id = ?";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        }
    }

    public Test findById(int id) throws SQLException {
        String sql = "SELECT * FROM tests WHERE id = ?";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) return mapRow(rs);
            }
        }
        return null;
    }

    public List<Test> findActive() throws SQLException {
        String sql = "SELECT * FROM tests WHERE status = 'ACTIVE' ORDER BY id DESC";
        List<Test> list = new ArrayList<>();
        try (Connection conn = DBUtil.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            while (rs.next()) list.add(mapRow(rs));
        }
        return list;
    }

    public List<Test> findAll() throws SQLException {
        String sql = "SELECT * FROM tests ORDER BY id DESC";
        List<Test> list = new ArrayList<>();
        try (Connection conn = DBUtil.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            while (rs.next()) list.add(mapRow(rs));
        }
        return list;
    }

    public int countActive() throws SQLException {
        String sql = "SELECT COUNT(*) FROM tests WHERE status = 'ACTIVE'";
        try (Connection conn = DBUtil.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            if (rs.next()) return rs.getInt(1);
        }
        return 0;
    }

    private Test mapRow(ResultSet rs) throws SQLException {
        Test t = new Test();
        t.setId(rs.getInt("id"));
        t.setTestName(rs.getString("test_name"));
        t.setSubject(rs.getString("subject"));
        t.setTotalQuestions(rs.getInt("total_questions"));
        t.setTotalMarks(rs.getInt("total_marks"));
        t.setDurationMinutes(rs.getInt("duration_minutes"));
        t.setPassPercentage(rs.getBigDecimal("pass_percentage"));
        t.setStatus(rs.getString("status"));
        t.setCreatedAt(rs.getTimestamp("created_at").toLocalDateTime());
        return t;
    }
}