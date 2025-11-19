# Sinc — Social interaction & knowledge platform

Sinc is a web platform designed to foster social interaction and to enable the access, exchange and creation of knowledge. This repository contains a Java-based web application with the client-side frontend (HTML/CSS/JavaScript) and server-side sources. The project is packaged as a standard web application and is suitable to be served from a Java servlet container or run from a local development server.

Live demo
---------
https://jboliveira-pt.github.io/sinc

Repository overview
-------------------
Top-level files and directories (as present in the repository):
- README.md          — this file
- index.html         — frontend entry / client-side UI
- style.css          — main stylesheet
- WEB-INF/           — standard Java webapp descriptor directory (web.xml, libs, etc.)
- src/               — Java source code (server-side application)
- inspectionProfiles/— IDE/analysis configuration
- target/            — build output (artifacts produced by the build tool)
- wrapper/           — build wrapper (if using a build wrapper like Gradle Wrapper)
- others/            — miscellaneous assets

Primary technologies
--------------------
- Java — server-side application code (core backend logic and web endpoints)
- HTML, CSS, JavaScript — static frontend assets and client-side UI
- Dockerfile — optional containerization (if present)
- Build tools commonly used: Maven or Gradle (project layout indicates a standard Java webapp)

Architecture & behavior
-----------------------
- Server-side: Java web application that exposes HTTP endpoints and serves the frontend. The presence of a WEB-INF directory implies a standard servlet-based structure (WAR-style deployment). The src/ directory contains the Java implementation of business logic, controllers/servlets and utilities.
- Client-side: index.html and style.css deliver the user interface, enhanced by JavaScript for interactivity.
- Build / packaging: artifacts appear under target/ after a build. The project can be packaged as a WAR/JAR depending on your build configuration and deployed to a servlet container (Apache Tomcat, Jetty) or run as a standalone Spring Boot-style application (if applicable).

How to run locally
------------------
1. Clone the repository:
   git clone https://github.com/JBOliveira-pt/sinc.git
   cd sinc

2. Common run options (choose the one that matches your project setup):

   A — If the project uses Maven (WAR or Spring Boot):
   - Build:
     mvn clean package
   - Deploy WAR:
     - Deploy the produced WAR from target/ to your servlet container (Tomcat, WildFly, etc.)
   - Or run in-place:
     mvn spring-boot:run   (if Spring Boot is used)
     mvn jetty:run         (if a Jetty plugin is configured)

   B — If the project uses Gradle:
   - Build:
     ./gradlew build
   - Run:
     ./gradlew bootRun     (if Spring Boot) or follow project-specific instructions

   C — Run inside Docker (if a Dockerfile is present):
   - Build image:
     docker build -t sinc:latest .
   - Run container:
     docker run -p 8080:8080 sinc:latest

3. Open the application in a browser:
   - For local servlet container: http://localhost:8080/<context-path>/
   - For a Spring Boot app: http://localhost:8080/

Notes:
- If index.html is a pure static client that fetches APIs from the backend, ensure backend endpoints are running and CORS is configured appropriately.
- The repository contains a target/ directory that indicates previous builds; you can remove it if needed (git clean) and rebuild from source.

Project structure (recommended improvements to keep organized)
------------------------------------------------------------
- src/main/java/         — Java application code
- src/main/resources/    — configuration and resources
- src/main/webapp/       — HTML/JS/CSS and WEB-INF (for WAR-style projects)
- target/                — build output (ignored in source control)
- Dockerfile             — optional container image build
- .github/workflows/     — CI (GitHub Actions) configuration (recommended)

Development notes
-----------------
- Keep the Java package layout and web.xml (if present) consistent with servlet standards.
- Validate that static assets referenced in index.html (script and stylesheet paths) match the structure under src/main/webapp.
- Use environment-specific configuration (profiles) for database or external service endpoints.
- If the project grows, consider modularizing into separate backend and frontend modules and adding an automated CI pipeline.

Suggested enhancements
----------------------
- Add an explicit build tool configuration if missing (pom.xml for Maven or build.gradle for Gradle) and document the required Java version.
- Provide a Dockerfile (or improve it) to allow reproducible containerized deployments.
- Add automated tests (unit and integration) for core backend logic and endpoints.
- Add a simple CI configuration (GitHub Actions) to build and run tests on pull requests.
- Add a LICENSE file to clarify reuse and contributor expectations.
- Add an API README or OpenAPI/Swagger documentation for backend endpoints.

Security & privacy
------------------
- Secure endpoints with authentication & authorization if sensitive user data is stored or exchanged.
- Validate and sanitize user inputs to prevent injection attacks.
- If third-party services or analytics are used, disclose them and ensure compliance with privacy regulations.

Contributing
------------
Contributions are welcome. Suggested workflow:
1. Fork the repository.
2. Create a feature branch: git checkout -b feat/your-change
3. Implement changes and add tests when applicable.
4. Commit and push your branch, then open a Pull Request.

License
-------
- No license file is present in the repository. Add a LICENSE (for example MIT, Apache-2.0) to allow others to reuse and contribute under clear terms.

Contact
-------
Repository owner: JBOliveira-pt
Project homepage: https://jboliveira-pt.github.io/sinc
For technical questions or to propose changes, open an issue or a pull request on the repository.
