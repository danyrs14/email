# Usa una imagen base que tenga Maven y Java
FROM maven:3.8.4-openjdk-17-slim as build

# Copia el código fuente
WORKDIR /app
COPY . .

# Construye el proyecto usando Maven
RUN mvn clean package -DskipTests

# Usa una imagen base más ligera para la ejecución de la aplicación
FROM openjdk:17-slim

# Copia el archivo JAR construido desde la imagen anterior
COPY --from=build /app/target/email-1.0-SNAPSHOT.jar /usr/app/email-api.jar

# Expón el puerto en el que la aplicación se ejecutará
EXPOSE 8080

# Comando para ejecutar la aplicación Spring Boot
ENTRYPOINT ["java", "-jar", "/usr/app/email-api.jar"]
