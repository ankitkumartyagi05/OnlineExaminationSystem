// Placeholder
package com.exam.model;

public class CandidateAnswer {
    private int id;
    private int candidateId;
    private int testId;
    private int questionId;
    private String selectedAnswer;
    private boolean correct;

    public CandidateAnswer() {}

    public CandidateAnswer(int candidateId, int testId, int questionId, String selectedAnswer, boolean correct) {
        this.candidateId = candidateId;
        this.testId = testId;
        this.questionId = questionId;
        this.selectedAnswer = selectedAnswer;
        this.correct = correct;
    }

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    public int getCandidateId() { return candidateId; }
    public void setCandidateId(int candidateId) { this.candidateId = candidateId; }
    public int getTestId() { return testId; }
    public void setTestId(int testId) { this.testId = testId; }
    public int getQuestionId() { return questionId; }
    public void setQuestionId(int questionId) { this.questionId = questionId; }
    public String getSelectedAnswer() { return selectedAnswer; }
    public void setSelectedAnswer(String selectedAnswer) { this.selectedAnswer = selectedAnswer; }
    public boolean isCorrect() { return correct; }
    public void setCorrect(boolean correct) { this.correct = correct; }
}