FROM maven:3.8.6-jdk-8 as builder
WORKDIR /app
COPY pom.xml .
COPY src ./src
RUN mvn clean package -DfinalName=musicbot

FROM openjdk:8-jre
WORKDIR /app
COPY --from=builder /app/target/musicbot.jar /app
COPY ./config.conf /app

ENTRYPOINT ["java", "-Dconfig=./config.conf", "-Dnogui=true", "-jar", "musicbot.jar"]
