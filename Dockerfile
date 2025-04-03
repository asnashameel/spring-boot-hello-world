# Use official Maven image as the base image for building the application

FROM maven:3.8.6-eclipse-temurin-17 AS build

# Set working directory inside the container

WORKDIR /app

# Copy the project files into the container

COPY . .

# Build the application using Maven

RUN mvn clean package -DskipTests

# Use a lightweight JDK runtime for running the application

FROM eclipse-temurin:17-jdk

# Set working directory for runtime container

WORKDIR /app

# Copy the built JAR from the previous stage

COPY --from=build /app/target/*.jar app.jar

# Expose the application port

EXPOSE 8080

# Run the Spring Boot application

ENTRYPOINT ["java", "-jar", "app.jar"]


