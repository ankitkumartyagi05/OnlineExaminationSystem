package com.examportal.util;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.nio.charset.StandardCharsets;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.Properties;

public class DBConnection {
    private static final Properties props = new Properties();
    private static final Properties envOverrides = new Properties();

    static {
        loadEnvironmentOverrides();
        loadProperties();
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            throw new ExceptionInInitializerError(e);
        }
    }

    private static void loadEnvironmentOverrides() {
        Path envPath = Paths.get(".env");
        if (!Files.exists(envPath)) {
            return;
        }
        try (BufferedReader reader = Files.newBufferedReader(envPath, StandardCharsets.UTF_8)) {
            String line;
            while ((line = reader.readLine()) != null) {
                String trimmed = line.trim();
                if (trimmed.isEmpty() || trimmed.startsWith("#")) {
                    continue;
                }
                int separator = trimmed.indexOf('=');
                if (separator <= 0) {
                    continue;
                }
                String key = trimmed.substring(0, separator).trim();
                String value = trimmed.substring(separator + 1).trim();
                envOverrides.setProperty(key, stripQuotes(value));
            }
        } catch (IOException e) {
            System.err.println("Could not read .env file: " + e.getMessage());
        }
    }

    private static void loadProperties() {
        try (InputStream input = DBConnection.class.getClassLoader().getResourceAsStream("db.properties")) {
            if (input != null) {
                props.load(input);
            }
        } catch (IOException e) {
            throw new ExceptionInInitializerError(e);
        }
    }

    public static Connection getConnection() throws SQLException {
        return DriverManager.getConnection(resolveUrl(), resolveUser(), resolvePassword());
    }

    private static String resolveUrl() {
        String envUrl = getEnv("JDBC_URL");
        if (!envUrl.isEmpty()) {
            return envUrl;
        }

        String mysqlHost = getEnv("MYSQLHOST");
        String mysqlPort = getEnv("MYSQLPORT");
        String mysqlDatabase = getEnv("MYSQL_DATABASE");
        if (!mysqlHost.isEmpty() && !mysqlPort.isEmpty() && !mysqlDatabase.isEmpty()) {
            return "jdbc:mysql://" + mysqlHost + ":" + mysqlPort + "/" + mysqlDatabase + "?useSSL=true&allowPublicKeyRetrieval=true&serverTimezone=UTC&characterEncoding=UTF-8&connectTimeout=15000&socketTimeout=60000";
        }

        String propUrl = resolvePropertyValue(props.getProperty("db.url"));
        if (!propUrl.isEmpty()) {
            return propUrl;
        }

        return "jdbc:mysql://localhost:3306/exam_portal?useSSL=false&allowPublicKeyRetrieval=true&serverTimezone=UTC&characterEncoding=UTF-8&connectTimeout=15000&socketTimeout=60000";
    }

    private static String resolveUser() {
        String envUser = getEnv("DB_USER");
        if (!envUser.isEmpty()) {
            return envUser;
        }
        String railwayUser = getEnv("MYSQLUSER");
        if (!railwayUser.isEmpty()) {
            return railwayUser;
        }
        return resolvePropertyValue(props.getProperty("db.username"));
    }

    private static String resolvePassword() {
        String envPass = getEnv("DB_PASSWORD");
        if (!envPass.isEmpty()) {
            return envPass;
        }
        String railwayPass = getEnv("MYSQLPASSWORD");
        if (!railwayPass.isEmpty()) {
            return railwayPass;
        }
        return resolvePropertyValue(props.getProperty("db.password"));
    }

    private static String resolvePropertyValue(String value) {
        if (value == null) {
            return "";
        }
        String resolved = value.trim();
        int start = resolved.indexOf("${");
        while (start >= 0) {
            int end = resolved.indexOf('}', start + 2);
            if (end < 0) {
                break;
            }
            String key = resolved.substring(start + 2, end);
            String envValue = getEnv(key);
            resolved = resolved.substring(0, start) + envValue + resolved.substring(end + 1);
            start = resolved.indexOf("${");
        }
        return resolved;
    }

    private static String getEnv(String key) {
        String value = trim(System.getenv(key));
        if (!value.isEmpty()) {
            return value;
        }
        return trim(envOverrides.getProperty(key));
    }

    private static String stripQuotes(String value) {
        String trimmed = value == null ? "" : value.trim();
        if (trimmed.length() >= 2 && ((trimmed.startsWith("\"") && trimmed.endsWith("\"")) || (trimmed.startsWith("'") && trimmed.endsWith("'")))) {
            return trimmed.substring(1, trimmed.length() - 1);
        }
        return trimmed;
    }

    private static String trim(String value) {
        return value == null ? "" : value.trim();
    }
}
