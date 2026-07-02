// Placeholder
package com.exam.service;

import com.exam.dao.CandidateDAO;
import com.exam.model.Candidate;
import java.sql.SQLException;

public class CandidateService {
    private final CandidateDAO candidateDAO = new CandidateDAO();

    public int register(Candidate candidate) throws SQLException {
        if (candidateDAO.findByRollNumber(candidate.getRollNumber()) != null) {
            return -1;
        }
        return candidateDAO.insert(candidate);
    }

    public Candidate findById(int id) throws SQLException {
        return candidateDAO.findById(id);
    }

    public Candidate findByRollNumber(String rollNumber) throws SQLException {
        return candidateDAO.findByRollNumber(rollNumber);
    }

    public int getTotalCandidates() throws SQLException {
        return candidateDAO.countAll();
    }
}