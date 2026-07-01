# Stage 1: Build the WAR file using Maven
FROM maven:3.9-eclipse-temurin-21 AS build
WORKDIR /app
COPY pom.xml .
COPY src ./src
RUN mvn clean package -DskipTests

# Stage 2: Run Tomcat 10 with JDK 21
FROM tomcat:10.1-jdk21

# Remove default Tomcat webapps for clean deployment
RUN rm -rf /usr/local/tomcat/webapps/*

# Copy the built WAR as ROOT.war to deploy at root context
COPY --from=build /app/target/ROOT.war /usr/local/tomcat/webapps/ROOT.war

EXPOSE 8080

# Set port dynamically from environment variable
CMD ["sh", "-c", "sed -i \"s/port=\\\"8080\\\"/port=\\\"${PORT:-8080}\\\"/g\" /usr/local/tomcat/conf/server.xml && catalina.sh run"]
