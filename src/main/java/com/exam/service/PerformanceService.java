// Placeholder
package com.exam.service;

import com.exam.dao.PerformanceDAO;
import com.exam.model.Performance;
import com.exam.model.Result;
import java.math.BigDecimal;
import java.sql.SQLException;
import java.util.List;

public class PerformanceService {
    private final PerformanceDAO performanceDAO = new PerformanceDAO();

    public void updatePerformance(Result result) throws SQLException {
        Performance p = new Performance();
        p.setCandidateId(result.getCandidateId());
        p.setSubject(result.getExamName());
        p.setHighestScore(result.getPercentage());
        performanceDAO.upsert(p);
    }

    public List<Performance> getCandidatePerformance(int candidateId) throws SQLException {
        return performanceDAO.findByCandidate(candidateId);
    }
}