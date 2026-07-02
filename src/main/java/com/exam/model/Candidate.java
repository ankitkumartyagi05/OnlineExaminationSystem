// Placeholder
package com.exam.model;

import java.time.LocalDateTime;

public class Candidate {
    private int id;
    private String name;
    private String rollNumber;
    private String email;
    private String mobile;
    private String college;
    private String course;
    private LocalDateTime createdAt;

    public Candidate() {}

    public Candidate(String name, String rollNumber, String email, String mobile, String college, String course) {
        this.name = name;
        this.rollNumber = rollNumber;
        this.email = email;
        this.mobile = mobile;
        this.college = college;
        this.course = course;
    }

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    public String getName() { return name; }
    public void setName(String name) { this.name = name; }
    public String getRollNumber() { return rollNumber; }
    public void setRollNumber(String rollNumber) { this.rollNumber = rollNumber; }
    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }
    public String getMobile() { return mobile; }
    public void setMobile(String mobile) { this.mobile = mobile; }
    public String getCollege() { return college; }
    public void setCollege(String college) { this.college = college; }
    public String getCourse() { return course; }
    public void setCourse(String course) { this.course = course; }
    public LocalDateTime getCreatedAt() { return createdAt; }
    public void setCreatedAt(LocalDateTime createdAt) { this.createdAt = createdAt; }
}