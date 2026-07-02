// Placeholder
package com.exam.service;

import com.exam.dao.QuestionDAO;
import com.exam.model.Question;
import java.sql.SQLException;
import java.util.List;

public class QuestionService {
    private final QuestionDAO questionDAO = new QuestionDAO();

    public int addQuestion(Question q) throws SQLException {
        return questionDAO.insert(q);
    }

    public boolean updateQuestion(Question q) throws SQLException {
        return questionDAO.update(q);
    }

    public boolean deleteQuestion(int id) throws SQLException {
        return questionDAO.delete(id);
    }

    public Question getQuestionById(int id) throws SQLException {
        return questionDAO.findById(id);
    }

    public List<Question> getAllQuestions() throws SQLException {
        return questionDAO.findAll();
    }

    public List<Question> getQuestionsBySubject(String subject) throws SQLException {
        return questionDAO.findBySubject(subject);
    }

    public List<Question> getRandomQuestions(String subject, int limit) throws SQLException {
        return questionDAO.findRandomBySubject(subject, limit);
    }

    public List<Question> searchQuestions(String keyword) throws SQLException {
        return questionDAO.search(keyword);
    }

    public int getQuestionCountBySubject(String subject) throws SQLException {
        return questionDAO.countBySubject(subject);
    }

    public int getTotalQuestions() throws SQLException {
        return questionDAO.countAll();
    }

    public List<String> getAllSubjects() throws SQLException {
        return questionDAO.findAllSubjects();
    }
}