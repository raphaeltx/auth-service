FROM gradle:8.3-jdk21-alpine AS build
WORKDIR /app

COPY . /app

RUN gradle build --no-daemon

FROM eclipse-temurin:21-jdk-alpine
WORKDIR /app
EXPOSE 3003

COPY --from=build /app/build/libs/*.jar app.jar

ENTRYPOINT ["sh", "-c", "java $JAVA_OPTS -jar app.jar"]