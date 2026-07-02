// Placeholder
package com.exam.model;

import java.math.BigDecimal;
import java.time.LocalDateTime;

public class Performance {
    private int id;
    private int candidateId;
    private String subject;
    private int attempts;
    private BigDecimal highestScore;
    private BigDecimal averageScore;
    private LocalDateTime lastAttemptDate;

    public Performance() {}

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    public int getCandidateId() { return candidateId; }
    public void setCandidateId(int candidateId) { this.candidateId = candidateId; }
    public String getSubject() { return subject; }
    public void setSubject(String subject) { this.subject = subject; }
    public int getAttempts() { return attempts; }
    public void setAttempts(int attempts) { this.attempts = attempts; }
    public BigDecimal getHighestScore() { return highestScore; }
    public void setHighestScore(BigDecimal highestScore) { this.highestScore = highestScore; }
    public BigDecimal getAverageScore() { return averageScore; }
    public void setAverageScore(BigDecimal averageScore) { this.averageScore = averageScore; }
    public LocalDateTime getLastAttemptDate() { return lastAttemptDate; }
    public void setLastAttemptDate(LocalDateTime lastAttemptDate) { this.lastAttemptDate = lastAttemptDate; }
}