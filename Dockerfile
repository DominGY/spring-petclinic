FROM openjdk:17-oracle                             //dockerhub에 부러올 이미지가 있어야함
ARG JAR_FILE_PATH=./target/*.jar                   //ARG는 변수지정  현재 디렉터리는 workspace
COPY ${JAR_FILE_PATH} spring-petclinic.jar         //변수를 작성할때는 ${}안에 작성
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "spring-petclinic.jar"]
