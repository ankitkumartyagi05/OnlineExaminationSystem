// Placeholder
package com.exam.service;

import com.exam.dao.TestDAO;
import com.exam.model.Test;
import java.sql.SQLException;
import java.util.List;

public class TestService {
    private final TestDAO testDAO = new TestDAO();

    public int createTest(Test t) throws SQLException {
        return testDAO.insert(t);
    }

    public boolean deleteTest(int id) throws SQLException {
        return testDAO.delete(id);
    }

    public boolean toggleTestStatus(int id) throws SQLException {
        return testDAO.toggleStatus(id);
    }

    public Test getTestById(int id) throws SQLException {
        return testDAO.findById(id);
    }

    public List<Test> getActiveTests() throws SQLException {
        return testDAO.findActive();
    }

    public List<Test> getAllTests() throws SQLException {
        return testDAO.findAll();
    }

    public int getActiveTestCount() throws SQLException {
        return testDAO.countActive();
    }
}