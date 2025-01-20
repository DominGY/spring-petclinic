pipeline{
  agent any
  // JVAV와 Maven Tool 등록
  tools {
    jdk 'JDK17'
    maven 'M3'
  }

  // Docker Hub 접속 정보(환경설정)
  environment {
    DOCKERHUB_CREDENTIALS = credentials('dockerCredential')
    AWS_CREDENTIALS = credentials('AWSCredential')
    //GIT_CREDENTIALS = credentials('gitCredential')
    REGION= 'ap-northeast-2'
  }

  stages {
    // GitHub에 가서 소스코드 가져오기
    stage('Git Clone') {
      steps {
        echo 'Git Clone'
        git url: 'https://github.com/DominGY/spring-petclinic.git',
          branch: 'main'
      }
    }
    //Maven 빌들 작업
    stage('Maven Build') {
      steps {
        echo 'Maven Build'
        sh 'mvn -Dmaven.test.failure.ignore=true clean package'
      }
    }
    //Docker Image 생성
    stage('Docker Image Build') {
      steps {
        echo 'Docker Image build'
        dir("${env.WORKSPACE}") {
          sh """
          docker build -t parkgt/spring-petclinic:$BUILD_NUMBER .
          docker tag parkgt/spring-petclinic:$BUILD_NUMBER parkgt/spring-petclinic:latest
          """
          
        }
      }
    }

    // DockerHub Login and Image Push
    stage('Docker Login') {
      steps {
        sh """
        echo $DOCKERHUB_CREDENTIALS_PSW | docker login -u $DOCKERHUB_CREDENTIALS_USR --password-stdin
        docker push parkgt/spring-petclinic:latest
        """
      }
    }
    //Docker Imagge 삭제
    stage('Remove Docker Image') {
      steps {
        sh """
        docker rmi parkgt/spring-petclinic:$BUILD_NUMBER
        docker rmi parkgt/spring-petclinic:latest
      }
    }

    
  }
}
