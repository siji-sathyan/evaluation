
FROM openjdk:8
ADD target/assessment.war assessment.war
COPY target/assessment.war assessment:0.0.1.war
COPY pom.xml pom.xml
EXPOSE 80
