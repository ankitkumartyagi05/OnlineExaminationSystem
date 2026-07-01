package com.examportal.dao;

import com.examportal.model.Student;
import com.examportal.util.DBConnection;

import java.sql.*;

public class StudentDAO {

    public Long createStudent(Student student) throws SQLException {
        String sql = "INSERT INTO students (user_id, roll_number, course, semester) VALUES (?, ?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            ps.setLong(1, student.getUserId());
            ps.setString(2, student.getRollNumber());
            ps.setString(3, student.getCourse());
            ps.setObject(4, student.getSemester(), Types.INTEGER);
            ps.executeUpdate();
            try (ResultSet rs = ps.getGeneratedKeys()) {
                if (rs.next()) return rs.getLong(1);
            }
        }
        return null;
    }

    public Student findByUserId(Long userId) throws SQLException {
        String sql = "SELECT * FROM students WHERE user_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setLong(1, userId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    Student s = new Student();
                    s.setStudentId(rs.getLong("student_id"));
                    s.setUserId(rs.getLong("user_id"));
                    s.setRollNumber(rs.getString("roll_number"));
                    s.setCourse(rs.getString("course"));
                    s.setSemester(rs.getInt("semester"));
                    return s;
                }
            }
        }
        return null;
    }

    public int countAllStudents() throws SQLException {
        String sql = "SELECT COUNT(*) FROM students";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            if (rs.next()) return rs.getInt(1);
        }
        return 0;
    }

    public java.util.List<Student> findAllStudents() throws SQLException {
        java.util.List<Student> students = new java.util.ArrayList<>();
        String sql = "SELECT * FROM students ORDER BY student_id DESC";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Student s = new Student();
                s.setStudentId(rs.getLong("student_id"));
                s.setUserId(rs.getLong("user_id"));
                s.setRollNumber(rs.getString("roll_number"));
                s.setCourse(rs.getString("course"));
                s.setSemester(rs.getInt("semester"));
                students.add(s);
            }
        }
        return students;
    }
}