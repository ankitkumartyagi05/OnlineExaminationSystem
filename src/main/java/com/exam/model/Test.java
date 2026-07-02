// Placeholder
package com.exam.model;

import java.math.BigDecimal;
import java.time.LocalDateTime;

public class Test {
    private int id;
    private String testName;
    private String subject;
    private int totalQuestions;
    private int totalMarks;
    private int durationMinutes;
    private BigDecimal passPercentage;
    private String status;
    private LocalDateTime createdAt;

    public Test() {}

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    public String getTestName() { return testName; }
    public void setTestName(String testName) { this.testName = testName; }
    public String getSubject() { return subject; }
    public void setSubject(String subject) { this.subject = subject; }
    public int getTotalQuestions() { return totalQuestions; }
    public void setTotalQuestions(int totalQuestions) { this.totalQuestions = totalQuestions; }
    public int getTotalMarks() { return totalMarks; }
    public void setTotalMarks(int totalMarks) { this.totalMarks = totalMarks; }
    public int getDurationMinutes() { return durationMinutes; }
    public void setDurationMinutes(int durationMinutes) { this.durationMinutes = durationMinutes; }
    public BigDecimal getPassPercentage() { return passPercentage; }
    public void setPassPercentage(BigDecimal passPercentage) { this.passPercentage = passPercentage; }
    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }
    public LocalDateTime getCreatedAt() { return createdAt; }
    public void setCreatedAt(LocalDateTime createdAt) { this.createdAt = createdAt; }
}