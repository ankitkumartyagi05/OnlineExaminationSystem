package com.examportal.util;

import java.io.InputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.Properties;

public class DBConnection {
    private static final Properties props = new Properties();

    static {
        try (InputStream input = DBConnection.class.getClassLoader().getResourceAsStream("db.properties")) {
            if (input != null) {
                props.load(input);
            }
            // Load the driver explicitly to avoid compatibility issues in some containers
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (Exception e) {
            // Keep stdout clean of credentials, but print the error message
            System.err.println("Database initialization failed during class loading: " + e.getMessage());
            throw new RuntimeException("Database initialization failed: " + e.getMessage(), e);
        }
    }

    public static Connection getConnection() throws SQLException {
        String envUrl = System.getenv("JDBC_URL");
        String envUser = System.getenv("DB_USER");
        String envPass = System.getenv("DB_PASSWORD");

        String url = (envUrl != null && !envUrl.trim().isEmpty()) ? envUrl : props.getProperty("db.url");
        String user = (envUser != null && !envUser.trim().isEmpty()) ? envUser : props.getProperty("db.username");
        String pass = (envPass != null && !envPass.trim().isEmpty()) ? envPass : props.getProperty("db.password");

        Properties connProps = new Properties();
        if (user != null) {
            connProps.setProperty("user", user);
        }
        if (pass != null) {
            connProps.setProperty("password", pass);
        }

        // Connection properties to support SSL, timeouts, reconnection, and prevent warnings.
        boolean isLocal = (envUrl == null || envUrl.trim().isEmpty());
        connProps.setProperty("useSSL", isLocal ? "false" : "true");
        if (!isLocal) {
            connProps.setProperty("requireSSL", "true");
            connProps.setProperty("enabledTLSProtocols", "TLSv1.2,TLSv1.3");
        }
        connProps.setProperty("connectTimeout", "15000"); // 15 seconds connection timeout
        connProps.setProperty("socketTimeout", "60000");   // 60 seconds socket timeout
        connProps.setProperty("autoReconnect", "true");
        connProps.setProperty("serverTimezone", "UTC");
        connProps.setProperty("allowPublicKeyRetrieval", "true");

        try {
            return DriverManager.getConnection(url, connProps);
        } catch (SQLException e) {
            System.err.println("Failed to obtain database connection: " + e.getMessage());
            throw e;
        }
    }
}