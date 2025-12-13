FROM openjdk:11-jre-slim

WORKDIR /app

COPY target/my-app-1.0-SNAPSHOT.jar /app/app.jar

ENTRYPOINT ["java", "-jar", "/app/app.jar"]