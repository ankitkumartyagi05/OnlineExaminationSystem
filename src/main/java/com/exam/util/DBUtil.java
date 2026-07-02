package com.exam.util;

import java.io.IOException;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.Properties;

public class DBUtil {

    private static final String DEFAULT_URL = "jdbc:mysql://localhost:3306/online_examination";
    private static final String DEFAULT_USERNAME = "root";
    private static final String DEFAULT_PASSWORD = "";

    private static final String URL;
    private static final String USERNAME;
    private static final String PASSWORD;

    static {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            throw new RuntimeException("MySQL JDBC Driver not found", e);
        }

        Properties props = new Properties();
        try (InputStream in = DBUtil.class.getClassLoader().getResourceAsStream("db.properties")) {
            if (in != null) {
                props.load(in);
            }
        } catch (IOException e) {
            System.err.println("Warning: Could not load db.properties: " + e.getMessage());
        }

        URL = System.getenv().getOrDefault("DB_URL", props.getProperty("DB_URL", DEFAULT_URL));
        USERNAME = System.getenv().getOrDefault("DB_USERNAME", props.getProperty("DB_USERNAME", DEFAULT_USERNAME));
        PASSWORD = System.getenv().getOrDefault("DB_PASSWORD", props.getProperty("DB_PASSWORD", DEFAULT_PASSWORD));
    }

    public static Connection getConnection() throws SQLException {
        return DriverManager.getConnection(URL, USERNAME, PASSWORD);
    }

    public static void close(Connection conn) {
        if (conn != null) {
            try {
                conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
}