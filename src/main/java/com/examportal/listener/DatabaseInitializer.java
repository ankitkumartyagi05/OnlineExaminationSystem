package com.examportal.listener;

import jakarta.servlet.ServletContextEvent;
import jakarta.servlet.ServletContextListener;
import jakarta.servlet.annotation.WebListener;
import java.sql.Connection;
import java.sql.Statement;

@WebListener
public class DatabaseInitializer implements ServletContextListener {

    @Override
    public void contextInitialized(ServletContextEvent sce) {
        System.out.println("[DatabaseInitializer] Starting database initialization...");

        try {
            // Test the connection first
            Connection conn = null;
            try {
                conn = com.examportal.util.DBConnection.getConnection();
                if (conn == null) {
                    System.err.println("[DatabaseInitializer] getConnection() returned null — skipping init");
                    return;
                }
                if (!conn.isValid(5)) {
                    System.err.println("[DatabaseInitializer] Connection is not valid — skipping init");
                    return;
                }

                System.out.println("[DatabaseInitializer] Database connection established successfully");

                // Run your table creation SQL here
                // Example:
                // try (Statement stmt = conn.createStatement()) {
                //     stmt.executeUpdate("CREATE TABLE IF NOT EXISTS users (...)");
                //     stmt.executeUpdate("CREATE TABLE IF NOT EXISTS exams (...)");
                //     // ... more tables
                //     System.out.println("[DatabaseInitializer] Tables verified/created");
                // }

            } finally {
                if (conn != null) {
                    try { conn.close(); } catch (Exception ignored) {}
                }
            }

            System.out.println("[DatabaseInitializer] Database initialization complete");

        } catch (Exception e) {
            // ── DO NOT throw — that would crash the entire app ──
            // Just log and let the app start anyway
            System.err.println("[DatabaseInitializer] Database init failed (app will still start): " + e.getMessage());
            e.printStackTrace();
        }
    }

    @Override
    public void contextDestroyed(ServletContextEvent sce) {
        System.out.println("[DatabaseInitializer] Application shutting down");
    }
}
