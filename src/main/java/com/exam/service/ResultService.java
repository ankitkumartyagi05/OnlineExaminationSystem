// Placeholder
package com.exam.service;

import com.exam.dao.CandidateAnswerDAO;
import com.exam.dao.ResultDAO;
import com.exam.model.CandidateAnswer;
import com.exam.model.Question;
import com.exam.model.Result;
import com.exam.model.Test;
import java.math.BigDecimal;
import java.math.RoundingMode;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

public class ResultService {
    private final ResultDAO resultDAO = new ResultDAO();
    private final CandidateAnswerDAO answerDAO = new CandidateAnswerDAO();

    public Result evaluateAndSave(int candidateId, Test test, List<Question> questions, Map<Integer, String> answers) throws SQLException {
        List<CandidateAnswer> candidateAnswers = new ArrayList<>();
        int correct = 0;
        int wrong = 0;
        double marksObtained = 0;

        for (Question q : questions) {
            String selected = answers.getOrDefault(q.getId(), "");
            boolean isCorrect = q.getCorrectAnswer().equalsIgnoreCase(selected);
            if (isCorrect) {
                correct++;
                marksObtained += q.getMarks();
            } else if (!selected.isEmpty()) {
                wrong++;
            }
            candidateAnswers.add(new CandidateAnswer(candidateId, test.getId(), q.getId(), selected.isEmpty() ? null : selected, isCorrect));
        }

        answerDAO.insertBatch(candidateAnswers);

        double totalMarks = test.getTotalMarks();
        double percentage = totalMarks > 0 ? (marksObtained / totalMarks) * 100 : 0;
        String passFail = percentage >= test.getPassPercentage().doubleValue() ? "PASS" : "FAIL";

        Result result = new Result();
        result.setCandidateId(candidateId);
        result.setTestId(test.getId());
        result.setExamName(test.getTestName());
        result.setTotalQuestions(questions.size());
        result.setCorrectAnswers(correct);
        result.setWrongAnswers(wrong);
        result.setMarksObtained(BigDecimal.valueOf(marksObtained).setScale(2, RoundingMode.HALF_UP));
        result.setTotalMarks(BigDecimal.valueOf(totalMarks).setScale(2, RoundingMode.HALF_UP));
        result.setPercentage(BigDecimal.valueOf(percentage).setScale(2, RoundingMode.HALF_UP));
        result.setPassFail(passFail);

        resultDAO.insert(result);
        return result;
    }

    public Result getResult(int candidateId, int testId) throws SQLException {
        return resultDAO.findByCandidateAndTest(candidateId, testId);
    }

    public List<Result> getCandidateResults(int candidateId) throws SQLException {
        return resultDAO.findByCandidate(candidateId);
    }

    public List<Result> getAllResults() throws SQLException {
        return resultDAO.findAll();
    }

    public int getTotalResults() throws SQLException {
        return resultDAO.countAll();
    }
}