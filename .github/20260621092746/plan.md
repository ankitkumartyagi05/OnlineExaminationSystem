# Upgrade Plan: OnlineExaminationSystem (20260621092746)

- **Generated**: 2026-06-21 09:27:46
- **HEAD Branch**: N/A (version control not available)
- **HEAD Commit ID**: N/A (version control not available)

## Available Tools

**JDKs**
- JDK 26.0.1: C:\Program Files\Java\jdk-26.0.1\bin (sufficient for Java 25 target)

**Build Tools**
- Maven: **<TO_BE_INSTALLED>** (no Maven detected in system PATH; Maven Wrapper not found; Maven 3.9.6+ recommended)

> Note: Maven installation or usage of Maven Wrapper is required. If Maven is installed but not in PATH, provide the full path during execution.

## Guidelines

- Target Java LTS: Java 25
- Maintain backward compatibility with Jakarta EE 10 APIs
- All dependencies are modern and support Java 25

> Note: You can add any specific guidelines or constraints for the upgrade process here if needed, bullet points are preferred.

## Options

- Working branch: appmod/java-upgrade-20260621092746 (version control not available; changes will remain uncommitted)
- Run tests before and after the upgrade: true

## Upgrade Goals

- **Java**: 17 → 25 (user requested latest LTS)

## Technology Stack

| Technology/Dependency | Current | Min Compatible | Why Incompatible |
|----------------------|---------|-----------------|-----------------|
| Java | 17 | 25 | User requested |
| Maven Compiler Plugin | 3.11.0 | 3.11.0 | 3.11.0+ supports Java 25; no change needed |
| Maven War Plugin | 3.4.0 | 3.4.0 | Fully compatible; no change needed |
| Jakarta Servlet API | 6.0.0 | 6.0.0 | Jakarta EE 10 supports Java 25; no change needed |
| Jakarta JSP API | 3.1.1 | 3.1.1 | Jakarta EE 10 supports Java 25; no change needed |
| Jakarta JSTL API | 3.0.0 | 3.0.0 | Jakarta EE 10 supports Java 25; no change needed |
| MySQL Connector Java | 8.0.33 | 8.0.33 | Supports Java 25; no change needed |
| JBCrypt | 0.4 | 0.4 | Pure Java library; fully compatible |
| Gson | 2.10.1 | 2.10.1 | Fully compatible with Java 25 |
| Apache Commons Lang | 3.13.0 | 3.13.0 | Fully compatible; no change needed |

## Derived Upgrades

None required. All dependencies are modern and compatible with Java 25. No intermediate versions needed.

## Impact Analysis

### Subsection: Dependency Changes

| File | Dependency | Current | Action | Target | Reason |
|------|-----------|---------|--------|--------|--------|
| pom.xml | maven.compiler.source | 17 | upgrade | 25 | User requested Java 25 target |
| pom.xml | maven.compiler.target | 17 | upgrade | 25 | User requested Java 25 target |
| pom.xml (maven-compiler-plugin) | source | 17 | upgrade | 25 | User requested Java 25 target |
| pom.xml (maven-compiler-plugin) | target | 17 | upgrade | 25 | User requested Java 25 target |

### Subsection: Source Code Changes

No source code changes required. All Java code (classes in `com.controller`, `com.dao`, `com.models`, `com.service`, `com.util`, and JSPs) is compatible with Java 25. The codebase does not use:
- Removed internal APIs (sun.misc.*, jdk.internal.*)
- Reflection-based access to restricted modules
- Deprecated APIs removed in Java 25

Verification step will compile all source files to confirm compatibility.

### Subsection: Configuration Changes

No configuration changes required. All `application.properties` and other resource files are compatible.

### Subsection: CI/CD Changes

The project does not currently include CI/CD pipelines (no Dockerfile, GitHub Actions, Azure Pipelines, etc. detected). If CI/CD is added in the future, ensure:
- Base image uses Java 25-compatible runtime
- Java version environment variables reference Java 25

### Subsection: Risks & Warnings

**Low risk upgrade** — This is a straightforward Java 17→25 bump with no framework or dependency changes required:
- All dependencies are modern and explicitly tested with Java 25
- No deprecated API usage or removal concerns
- No reflection-based internal API access detected
- Jakarta EE 10 is stable and fully supports Java 25
- Compilation and test execution should succeed without modifications

**No known risks or deferred work** — Proceed with confidence.

## Upgrade Steps

- **Step 1: Setup Environment**
  - **Rationale**: Ensure Java 25-compatible JDK is available for compilation
  - **Changes to Make**: Verify JDK 26.0.1 is available (already installed); if Maven is not in PATH, note the requirement for execution
  - **Verification**: `java -version` confirms Java 25+ available; Maven availability check

- **Step 2: Setup Baseline**
  - **Rationale**: Establish test pass rate and compilation status on Java 17 before upgrade for comparison
  - **Changes to Make**: Compile and run full test suite with current Java 17 configuration
  - **Verification**: Command: `mvn clean test-compile && mvn clean test` with Java 17. Expected: Compilation SUCCESS and all tests pass (baseline established)

- **Step 3: Upgrade Java Version in pom.xml**
  - **Rationale**: Update all Java version references in Maven configuration to target Java 25
  - **Changes to Make**: Update maven.compiler.source and maven.compiler.target properties from 17 to 25; update maven-compiler-plugin configuration source/target from 17 to 25 (reference all Dependency Changes from Impact Analysis)
  - **Verification**: Command: `mvn clean test-compile` with Java 25. Expected: Compilation SUCCESS (all source and test classes compile on Java 25)

- **Step 4: Final Validation**
  - **Rationale**: Verify all upgrade goals are met and all tests pass on Java 25
  - **Changes to Make**: None (verification only); fix any compilation errors or test failures if they occur
  - **Verification**: Command: `mvn clean test` with Java 25. Expected: Compilation SUCCESS and 100% test pass rate (or ≥baseline if some tests were pre-existing failures)

---

**Note**: Version control is not available in this workspace. All changes will remain uncommitted to the working directory. To preserve changes, manually commit to version control or save the upgraded `pom.xml`.
