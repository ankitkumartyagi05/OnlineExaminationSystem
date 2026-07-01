package com.examportal.listener;

import com.examportal.util.DBConnection;
import jakarta.servlet.ServletContextEvent;
import jakarta.servlet.ServletContextListener;
import jakarta.servlet.annotation.WebListener;

import java.sql.Connection;
import java.sql.Statement;
import java.io.InputStream;
import java.nio.charset.StandardCharsets;

@WebListener
public class DatabaseInitializer implements ServletContextListener {
    @Override
    public void contextInitialized(ServletContextEvent sce) {
        try (Connection conn = DBConnection.getConnection(); Statement stmt = conn.createStatement()) {
            InputStream input = getClass().getClassLoader().getResourceAsStream("schema.sql");
            if (input == null) {
                return;
            }
            String sql = new String(input.readAllBytes(), StandardCharsets.UTF_8);
            for (String segment : sql.split(";")) {
                String cleaned = segment.trim();
                if (!cleaned.isEmpty()) {
                    stmt.execute(cleaned);
                }
            }
            System.out.println("DatabaseInitializer: schema initialized");
        } catch (Exception e) {
            System.err.println("DatabaseInitializer failed: " + e.getMessage());
        }
    }
}
