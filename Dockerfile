FROM openjdk:11.0.1-jre-slim-sid

CMD ["/usr/bin/java", "-jar", "/app/app.jar"]

# Add the service itself
ARG JAR_FILE=demo-0.0.1-SNAPSHOT.jar
COPY target/${JAR_FILE} /app/app.jar
