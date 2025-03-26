FROM maven:3.9-eclipse-temurin-21-alpine AS build
WORKDIR /app

# Copy the project files
COPY pom.xml .
COPY src ./src
COPY .mvn ./.mvn
COPY mvnw .
COPY mvnw.cmd .

# Make mvnw executable
RUN chmod +x ./mvnw

# Build the application
RUN ./mvnw clean package -DskipTests

# Runtime image
FROM eclipse-temurin:21-jre-alpine
WORKDIR /app

# Copy the built JAR file
COPY --from=build /app/target/codasimpledemo-0.0.1-SNAPSHOT.jar app.jar

# Run the application with the specified port
ENTRYPOINT ["java", "-Dserver.port=${SERVER_PORT:-8080}", "-jar", "app.jar"]
