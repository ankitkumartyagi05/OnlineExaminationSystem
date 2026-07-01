package com.examportal.listener;

import com.examportal.util.DBConnection;
import jakarta.servlet.ServletContextEvent;
import jakarta.servlet.ServletContextListener;
import jakarta.servlet.annotation.WebListener;

import java.io.BufferedReader;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.nio.charset.StandardCharsets;
import java.sql.Connection;
import java.sql.DatabaseMetaData;
import java.sql.ResultSet;
import java.sql.Statement;

@WebListener
public class DatabaseInitializer implements ServletContextListener {

    @Override
    public void contextInitialized(ServletContextEvent sce) {
        System.out.println("DatabaseInitializer: Checking database tables status...");
        try (Connection conn = DBConnection.getConnection()) {
            if (tablesExist(conn)) {
                System.out.println("DatabaseInitializer: Database tables already exist. Skipping initialization.");
            } else {
                System.out.println("DatabaseInitializer: Tables not found. Executing schema.sql...");
                executeSqlScript(conn, "schema.sql");
                System.out.println("DatabaseInitializer: schema.sql executed successfully.");

                System.out.println("DatabaseInitializer: Executing sample-data.sql...");
                executeSqlScript(conn, "sql/sample-data.sql");
                System.out.println("DatabaseInitializer: sample-data.sql executed successfully.");
            }
        } catch (Exception e) {
            System.err.println("DatabaseInitializer ERROR: Failed to auto-initialize the database.");
            e.printStackTrace();
        }
    }

    private boolean tablesExist(Connection conn) {
        try {
            DatabaseMetaData dbm = conn.getMetaData();
            // Check lowercase table name
            try (ResultSet rs = dbm.getTables(null, null, "users", null)) {
                if (rs.next()) return true;
            }
            // Check uppercase table name
            try (ResultSet rs = dbm.getTables(null, null, "USERS", null)) {
                if (rs.next()) return true;
            }
            // Fallback: check query execution
            try (Statement stmt = conn.createStatement()) {
                stmt.executeQuery("SELECT 1 FROM users LIMIT 1").close();
                return true;
            }
        } catch (Exception e) {
            return false;
        }
    }

    private void executeSqlScript(Connection conn, String resourcePath) throws Exception {
        try (InputStream in = DatabaseInitializer.class.getClassLoader().getResourceAsStream(resourcePath)) {
            if (in == null) {
                throw new java.io.FileNotFoundException("SQL resource file not found on classpath: " + resourcePath);
            }
            try (BufferedReader reader = new BufferedReader(new InputStreamReader(in, StandardCharsets.UTF_8))) {
                StringBuilder sb = new StringBuilder();
                String line;
                try (Statement stmt = conn.createStatement()) {
                    while ((line = reader.readLine()) != null) {
                        String trimmed = line.trim();
                        if (trimmed.isEmpty() || trimmed.startsWith("--") || trimmed.startsWith("#")) {
                            continue;
                        }
                        sb.append(line).append("\n");
                        if (trimmed.endsWith(";")) {
                            String sql = sb.toString().trim();
                            if (sql.endsWith(";")) {
                                sql = sql.substring(0, sql.length() - 1);
                            }
                            if (!sql.isEmpty()) {
                                stmt.execute(sql);
                            }
                            sb.setLength(0);
                        }
                    }
                    // Execute any remaining statements
                    String remaining = sb.toString().trim();
                    if (!remaining.isEmpty()) {
                        if (remaining.endsWith(";")) {
                            remaining = remaining.substring(0, remaining.length() - 1);
                        }
                        stmt.execute(remaining);
                    }
                }
            }
        }
    }

    @Override
    public void contextDestroyed(ServletContextEvent sce) {
        // Nothing to clean up
    }
}
