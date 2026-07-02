// Placeholder
package com.exam.dao;

import com.exam.model.CandidateAnswer;
import com.exam.util.DBUtil;
import java.sql.*;
import java.util.List;

public class CandidateAnswerDAO {

    public void insertBatch(List<CandidateAnswer> answers) throws SQLException {
        String sql = "INSERT INTO candidate_answers (candidate_id, test_id, question_id, selected_answer, is_correct) VALUES (?, ?, ?, ?, ?)";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            for (CandidateAnswer a : answers) {
                ps.setInt(1, a.getCandidateId());
                ps.setInt(2, a.getTestId());
                ps.setInt(3, a.getQuestionId());
                ps.setString(4, a.getSelectedAnswer());
                ps.setBoolean(5, a.isCorrect());
                ps.addBatch();
            }
            ps.executeBatch();
        }
    }
}