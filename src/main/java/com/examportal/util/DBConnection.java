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
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (Exception e) {
            System.err.println("Database initialization failed during class loading: " + e.getMessage());
            throw new RuntimeException("Database initialization failed: " + e.getMessage(), e);
        }
    }

    public static Connection getConnection() throws SQLException {

        // ── Priority 1: Explicit JDBC_* env vars (your original approach) ──
        String envUrl  = System.getenv("JDBC_URL");
        String envUser = System.getenv("DB_USER");
        String envPass = System.getenv("DB_PASSWORD");

        // ── Priority 2: Railway MySQL standard env vars ──
        // Railway auto-sets these on the database service.
        // You MUST add them as Variable References on your APP service in Railway.
        String railwayHost     = System.getenv("MYSQLHOST");
        String railwayPort     = System.getenv("MYSQLPORT");
        String railwayUser     = System.getenv("MYSQLUSER");
        String railwayPassword = System.getenv("MYSQLPASSWORD");
        String railwayDatabase = System.getenv("MYSQL_DATABASE");

        // ── Priority 3: Fall back to db.properties (local dev) ──

        String url;
        String user;
        String pass;

        // Decide which source to use
        if (envUrl != null && !envUrl.trim().isEmpty()) {
            // Source 1: Explicit JDBC_URL
            url  = envUrl;
            user = (envUser != null && !envUser.trim().isEmpty()) ? envUser : "";
            pass = (envPass != null && !envPass.trim().isEmpty()) ? envPass : "";
            System.out.println("[DBConnection] Using JDBC_URL env var");
        } else if (railwayHost != null && !railwayHost.trim().isEmpty()) {
            // Source 2: Railway MySQL env vars — build JDBC URL from pieces
            String port = (railwayPort != null && !railwayPort.trim().isEmpty()) ? railwayPort : "3306";
            String db   = (railwayDatabase != null && !railwayDatabase.trim().isEmpty()) ? railwayDatabase : "railway";
            url  = "jdbc:mysql://" + railwayHost + ":" + port + "/" + db + "?useSSL=false&allowPublicKeyRetrieval=true&serverTimezone=UTC";
            user = (railwayUser != null) ? railwayUser : "root";
            pass = (railwayPassword != null) ? railwayPassword : "";
            System.out.println("[DBConnection] Using Railway MYSQLHOST env var → " + url);
        } else {
            // Source 3: db.properties (local development)
            url  = props.getProperty("db.url");
            user = props.getProperty("db.username");
            pass = props.getProperty("db.password");
            System.out.println("[DBConnection] Using db.properties → " + url);
        }

        if (url == null || url.trim().isEmpty()) {
            throw new SQLException("No database URL configured. Set JDBC_URL or MYSQLHOST env vars, or configure db.properties.");
        }

        Properties connProps = new Properties();
        if (user != null) connProps.setProperty("user", user);
        if (pass != null) connProps.setProperty("password", pass);

        // Detect if remote (Railway public URL) vs local/internal
        boolean isRemote = url.contains("railway.app") || url.contains("public");
        connProps.setProperty("useSSL", isRemote ? "true" : "false");
        if (isRemote) {
            connProps.setProperty("requireSSL", "true");
            connProps.setProperty("enabledTLSProtocols", "TLSv1.2,TLSv1.3");
        }
        connProps.setProperty("connectTimeout", "15000");
        connProps.setProperty("socketTimeout", "60000");
        connProps.setProperty("autoReconnect", "true");
        connProps.setProperty("serverTimezone", "UTC");
        connProps.setProperty("allowPublicKeyRetrieval", "true");

        try {
            Connection conn = DriverManager.getConnection(url, connProps);
            System.out.println("[DBConnection] Connection established successfully");
            return conn;
        } catch (SQLException e) {
            System.err.println("[DBConnection] Failed to connect: " + e.getMessage());
            System.err.println("[DBConnection] URL used: " + url.replace(pass != null ? pass : "", "***"));
            throw e;
        }
    }
}
