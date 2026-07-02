// Placeholder
package com.exam.dao;

import com.exam.model.Candidate;
import com.exam.util.DBUtil;
import java.sql.*;

public class CandidateDAO {

    public int insert(Candidate candidate) throws SQLException {
        String sql = "INSERT INTO candidates (name, roll_number, email, mobile, college, course) VALUES (?, ?, ?, ?, ?, ?)";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            ps.setString(1, candidate.getName());
            ps.setString(2, candidate.getRollNumber());
            ps.setString(3, candidate.getEmail());
            ps.setString(4, candidate.getMobile());
            ps.setString(5, candidate.getCollege());
            ps.setString(6, candidate.getCourse());
            ps.executeUpdate();
            try (ResultSet rs = ps.getGeneratedKeys()) {
                if (rs.next()) return rs.getInt(1);
            }
        }
        return -1;
    }

    public Candidate findById(int id) throws SQLException {
        String sql = "SELECT * FROM candidates WHERE id = ?";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) return mapRow(rs);
            }
        }
        return null;
    }

    public Candidate findByRollNumber(String rollNumber) throws SQLException {
        String sql = "SELECT * FROM candidates WHERE roll_number = ?";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, rollNumber);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) return mapRow(rs);
            }
        }
        return null;
    }

    public int countAll() throws SQLException {
        String sql = "SELECT COUNT(*) FROM candidates";
        try (Connection conn = DBUtil.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            if (rs.next()) return rs.getInt(1);
        }
        return 0;
    }

    private Candidate mapRow(ResultSet rs) throws SQLException {
        Candidate c = new Candidate();
        c.setId(rs.getInt("id"));
        c.setName(rs.getString("name"));
        c.setRollNumber(rs.getString("roll_number"));
        c.setEmail(rs.getString("email"));
        c.setMobile(rs.getString("mobile"));
        c.setCollege(rs.getString("college"));
        c.setCourse(rs.getString("course"));
        c.setCreatedAt(rs.getTimestamp("created_at").toLocalDateTime());
        return c;
    }
}