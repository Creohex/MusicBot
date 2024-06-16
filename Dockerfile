FROM adoptopenjdk/maven-openjdk11:latest as builder
WORKDIR /app
COPY pom.xml .
COPY src ./src
RUN mvn clean package -DfinalName=musicbot

FROM openjdk:11
WORKDIR /app
COPY --from=builder /app/target/musicbot.jar /app
COPY ./config.conf /app

ENTRYPOINT ["java", "-Dconfig=./config.conf", "-Dnogui=true", "-jar", "musicbot.jar"]
