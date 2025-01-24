# ---------------------- Stage 1 ------------------------------

# Main Base Image
FROM maven:3.8.3-openjdk-17 AS builder

# Create working directory for app
WORKDIR /app

# Copy the code into working directory
COPY . /app

# Run maven to build the jar file 
RUN mvn clean install -DskipTests=true

# ---------------------- Stage 2 -----------------------------

# Smaller Base Image
FROM openjdk:17-alpine

# Create working directory 
WORKDIR /app

# Copy the jar file from builder
COPY --from=builder /app/target/*.jar /app/target/bankapp.jar

# Expose the port
EXPOSE 8080

# Execute jar file 
ENTRYPOINT ["java","-jar","/app/target/bankapp.jar"]
