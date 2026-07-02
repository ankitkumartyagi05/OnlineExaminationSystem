// Placeholder
package com.exam.dao;

import com.exam.model.Performance;
import com.exam.util.DBUtil;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class PerformanceDAO {

    public boolean upsert(Performance p) throws SQLException {
        String sql = "INSERT INTO performance (candidate_id, subject, attempts, highest_score, average_score, last_attempt_date) " +
                "VALUES (?, ?, ?, ?, ?, NOW()) " +
                "ON DUPLICATE KEY UPDATE attempts = attempts + 1, " +
                "highest_score = GREATEST(highest_score, ?), " +
                "average_score = (average_score * attempts + ?) / (attempts + 1), " +
                "attempts = attempts + 1, " +
                "last_attempt_date = NOW()";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, p.getCandidateId());
            ps.setString(2, p.getSubject());
            ps.setInt(3, 1);
            ps.setBigDecimal(4, p.getHighestScore());
            ps.setBigDecimal(5, p.getHighestScore());
            ps.setBigDecimal(6, p.getHighestScore());
            return ps.executeUpdate() > 0;
        }
    }

    public List<Performance> findByCandidate(int candidateId) throws SQLException {
        String sql = "SELECT * FROM performance WHERE candidate_id = ? ORDER BY subject";
        List<Performance> list = new ArrayList<>();
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, candidateId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) list.add(mapRow(rs));
            }
        }
        return list;
    }

    private Performance mapRow(ResultSet rs) throws SQLException {
        Performance p = new Performance();
        p.setId(rs.getInt("id"));
        p.setCandidateId(rs.getInt("candidate_id"));
        p.setSubject(rs.getString("subject"));
        p.setAttempts(rs.getInt("attempts"));
        p.setHighestScore(rs.getBigDecimal("highest_score"));
        p.setAverageScore(rs.getBigDecimal("average_score"));
        Timestamp ts = rs.getTimestamp("last_attempt_date");
        if (ts != null) p.setLastAttemptDate(ts.toLocalDateTime());
        return p;
    }
}