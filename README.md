# 🎓 Online Examination & Assessment Management System

## 🚀 Smart Web-Based Examination Platform

### 🌍 Live Deployments

| Platform | URL |
|----------|-----|
| 🚀 Render | https://onlineexaminationsystem-ftie.onrender.com/ |
| 🚄 Railway | https://onlineexaminationsystem-production-f1ca.up.railway.app/ |

### 📂 GitHub Repository

https://github.com/ankitkumartyagi05/OnlineExaminationSystem

---

## 📖 Overview

A Java-based Online Examination & Assessment Management System developed using Java, JSP, Servlets, JDBC, MySQL and Maven.

## ✨ Key Features

- 👤 Candidate Registration
- 📚 Question Bank Management
- 📝 Online Test Management
- ⚡ Automated Evaluation
- 📊 Result Generation
- 📈 Performance Analysis

## 🛠 Tech Stack

- Java 21
- JSP
- Servlets
- JDBC
- MySQL
- Maven
- HTML5
- CSS3
- JavaScript
- Bootstrap 5

## 🔄 Workflow

Home → Candidate Registration → Available Tests → Start Test → Submit Test → Automated Evaluation → Result Generation → Performance Analysis

## 🚀 Build

```bash
git clone https://github.com/ankitkumartyagi05/OnlineExaminationSystem.git
cd OnlineExaminationSystem
mvn clean package
```

### Initialize the database

Use environment variables or `src/main/resources/db.properties` to configure your database connection. For a local MySQL instance:

```powershell
$env:DB_INIT_URL = "jdbc:mysql://localhost:3306/?allowMultiQueries=true"
$env:DB_URL = "jdbc:mysql://localhost:3306/online_examination"
$env:DB_USERNAME = "root"
$env:DB_PASSWORD = ""
mvn -q -DskipTests exec:java
```

For Aiven MySQL, supply your Aiven host, username, and password:

```powershell
$env:DB_INIT_URL = "jdbc:mysql://<your-host>:<port>/?allowMultiQueries=true"
$env:DB_URL = "jdbc:mysql://<your-host>:<port>/online_examination"
$env:DB_USERNAME = "avnadmin"
$env:DB_PASSWORD = "<your-password>"
mvn -q -DskipTests exec:java
```

Deploy the generated ROOT.war on Apache Tomcat 10.

## 👨‍💻 Developer

**Ankit Kumar Tyagi**

⭐ Star the repository if you found it useful.
