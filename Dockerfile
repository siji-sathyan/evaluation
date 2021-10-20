
FROM openjdk:8
ADD target/evaluation.war evaluation.war
COPY target/evaluation.war evaluation:0.0.1.war
COPY pom.xml pom.xml
EXPOSE 80
