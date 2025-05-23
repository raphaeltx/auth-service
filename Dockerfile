FROM maven:3.9-eclipse-temurin-21-alpine AS build
WORKDIR /app

COPY . /app

RUN mvn -f /app/pom.xml clean package

FROM eclipse-temurin:21-jdk-alpine
WORKDIR /app
EXPOSE 3003

COPY --from=build /app/target/*.jar app.jar

ENTRYPOINT ["sh", "-c", "java $JAVA_OPTS -jar app.jar"]