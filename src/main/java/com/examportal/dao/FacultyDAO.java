package com.examportal.dao;

import com.examportal.model.Faculty;
import com.examportal.util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class FacultyDAO {

    public Long createFaculty(Faculty faculty) throws SQLException {
        String sql = "INSERT INTO faculty (user_id, employee_id, department, designation, specialization) " +
                     "VALUES (?, ?, ?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            ps.setLong(1, faculty.getUserId());
            ps.setString(2, faculty.getEmployeeId());
            ps.setString(3, faculty.getDepartment());
            ps.setString(4, faculty.getDesignation());
            ps.setString(5, faculty.getSpecialization());
            ps.executeUpdate();
            try (ResultSet rs = ps.getGeneratedKeys()) {
                if (rs.next()) return rs.getLong(1);
            }
        }
        return null;
    }

    public Faculty findByUserId(Long userId) throws SQLException {
        String sql = "SELECT f.*, u.email, u.full_name, u.phone, u.status " +
                     "FROM faculty f JOIN users u ON f.user_id = u.user_id " +
                     "WHERE f.user_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setLong(1, userId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) return mapResultSetToFaculty(rs);
            }
        }
        return null;
    }

    public Faculty findByFacultyId(Long facultyId) throws SQLException {
        String sql = "SELECT f.*, u.email, u.full_name, u.phone, u.status " +
                     "FROM faculty f JOIN users u ON f.user_id = u.user_id " +
                     "WHERE f.faculty_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setLong(1, facultyId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) return mapResultSetToFaculty(rs);
            }
        }
        return null;
    }

    public List<Faculty> findAllFaculty() throws SQLException {
        List<Faculty> facultyList = new ArrayList<>();
        String sql = "SELECT f.*, u.email, u.full_name, u.phone, u.status " +
                     "FROM faculty f JOIN users u ON f.user_id = u.user_id " +
                     "ORDER BY f.created_at DESC";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                facultyList.add(mapResultSetToFaculty(rs));
            }
        }
        return facultyList;
    }

    public boolean updateFaculty(Faculty faculty) throws SQLException {
        String sql = "UPDATE faculty SET employee_id = ?, department = ?, designation = ?, " +
                     "specialization = ? WHERE faculty_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, faculty.getEmployeeId());
            ps.setString(2, faculty.getDepartment());
            ps.setString(3, faculty.getDesignation());
            ps.setString(4, faculty.getSpecialization());
            ps.setLong(5, faculty.getFacultyId());
            return ps.executeUpdate() > 0;
        }
    }

    public boolean employeeIdExists(String employeeId) throws SQLException {
        String sql = "SELECT COUNT(*) FROM faculty WHERE employee_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, employeeId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) return rs.getInt(1) > 0;
            }
        }
        return false;
    }

    public int countAllFaculty() throws SQLException {
        String sql = "SELECT COUNT(*) FROM faculty f JOIN users u ON f.user_id = u.user_id " +
                     "WHERE u.status = 'ACTIVE'";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            if (rs.next()) return rs.getInt(1);
        }
        return 0;
    }

    private Faculty mapResultSetToFaculty(ResultSet rs) throws SQLException {
        Faculty faculty = new Faculty();
        faculty.setFacultyId(rs.getLong("faculty_id"));
        faculty.setUserId(rs.getLong("user_id"));
        faculty.setEmployeeId(rs.getString("employee_id"));
        faculty.setDepartment(rs.getString("department"));
        faculty.setDesignation(rs.getString("designation"));
        faculty.setSpecialization(rs.getString("specialization"));
        faculty.setEmail(rs.getString("email"));
        faculty.setFullName(rs.getString("full_name"));
        faculty.setPhone(rs.getString("phone"));
        faculty.setStatus(rs.getString("status"));
        Timestamp createdAt = rs.getTimestamp("created_at");
        if (createdAt != null) faculty.setCreatedAt(createdAt.toLocalDateTime());
        return faculty;
    }
}