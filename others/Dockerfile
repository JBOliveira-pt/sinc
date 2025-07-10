# Etapa 1: imagem com Maven para compilar o projeto
FROM maven:3.9-eclipse-temurin-21 AS build
WORKDIR /app
COPY . .
RUN mvn clean package spring-boot:repackage

# Etapa 2: imagem leve só com Java para rodar o JAR
FROM eclipse-temurin:21-jre
WORKDIR /app
COPY --from=build /app/target/base-0.0.1-SNAPSHOT.jar app.jar
ENTRYPOINT ["java", "-jar", "app.jar"]
