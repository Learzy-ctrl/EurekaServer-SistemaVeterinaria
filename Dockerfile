# Etapa 1: Construcción del proyecto con Maven
FROM maven:3.8.5-openjdk-17-slim AS build
WORKDIR /app

# Copiamos solo los archivos necesarios (aunque .dockerignore hace su parte)
COPY pom.xml .
COPY src ./src

# Ejecutamos el build del .jar
RUN mvn clean package -DskipTests

# Etapa 2: Imagen liviana con solo el JAR
FROM openjdk:17-jdk-slim
VOLUME /tmp

# Copiamos el .jar desde el build anterior
COPY --from=build /app/target/EurekaServer-0.0.1-SNAPSHOT.jar app.jar

# Punto de entrada
ENTRYPOINT ["java", "-jar", "/app.jar"]
