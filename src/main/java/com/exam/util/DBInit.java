package com.exam.util;

import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.Statement;
import java.util.Properties;

public class DBInit {
    public static void main(String[] args) {
        Properties props = loadProperties();
        String url = System.getenv().getOrDefault("DB_INIT_URL",
                props.getProperty("DB_INIT_URL", props.getProperty("DB_URL", "jdbc:mysql://localhost:3306/?allowMultiQueries=true")));
        String user = System.getenv().getOrDefault("DB_USERNAME", props.getProperty("DB_USERNAME", "root"));
        String pass = System.getenv().getOrDefault("DB_PASSWORD", props.getProperty("DB_PASSWORD", ""));

        System.out.println("Connecting to MySQL to initialize database...");
        try (Connection conn = createConnection(url, user, pass)) {
            System.out.println("Connected successfully!");

            try (Statement stmt = conn.createStatement()) {
                System.out.println("Creating online_examination database if not exists...");
                stmt.execute("CREATE DATABASE IF NOT EXISTS online_examination CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci");
                stmt.execute("USE online_examination");
            }

            System.out.println("Reading schema.sql...");
            StringBuilder sb = new StringBuilder();
            try (BufferedReader reader = new BufferedReader(new FileReader("schema.sql"))) {
                String line;
                while ((line = reader.readLine()) != null) {
                    if (line.trim().startsWith("--") || line.trim().startsWith("#")) {
                        continue;
                    }
                    sb.append(line).append("\n");
                }
            }

            String[] queries = sb.toString().split(";");
            System.out.println("Executing schema.sql statements (" + queries.length + " statements)...");
            try (Statement stmt = conn.createStatement()) {
                for (String query : queries) {
                    if (query.trim().isEmpty()) {
                        continue;
                    }
                    try {
                        stmt.execute(query.trim());
                    } catch (Exception ex) {
                        System.err.println("Warning/Info executing statement: " + ex.getMessage());
                    }
                }
            }
            System.out.println("Database online_examination successfully initialized.");

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    private static Connection createConnection(String url, String user, String pass) throws Exception {
        Class.forName("com.mysql.cj.jdbc.Driver");
        return DriverManager.getConnection(url, user, pass);
    }

    private static Properties loadProperties() {
        Properties props = new Properties();
        try (InputStream in = DBInit.class.getClassLoader().getResourceAsStream("db.properties")) {
            if (in != null) {
                props.load(in);
            }
        } catch (IOException e) {
            System.err.println("Warning: Could not load db.properties: " + e.getMessage());
        }
        return props;
    }
}
