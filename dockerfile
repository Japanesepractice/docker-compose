FROM maven:3.8.3-openjdk-17 as maven_builder

RUN mvn clean install
RUN mv target/*.jar target/application.jar

FROM openjdk:17-jdk-alpine as builder
WORKDIR /app
COPY --from=maven_builder /app/target/application.jar ./
RUN java -Djarmode=layertools -jar application.jar extract

FROM openjdk:17-jdk-alpine

WORKDIR /app
COPY --from=builder /app/dependencies/ ./


ENTRYPOINT [ "java", "-jar", "application.jar" ]

FROM postgres

# Expose the port to the inner container communication network
EXPOSE 3100

#COPY target/classes/sql/query.sql /docker-entrypoint-initdb.d/


