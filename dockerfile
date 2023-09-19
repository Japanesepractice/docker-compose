FROM openjdk:17-jdk-alpine
FROM postgres

# Expose the port to the inner container communication network
EXPOSE 3100

COPY target/japanesepractice-0.0.1-SNAPSHOT.jar app-1.0.0.jar

COPY target/classes/sql/query.sql /docker-entrypoint-initdb.d/

ENTRYPOINT [ "java", "-jar", "app-1.0.0.jar" ]
