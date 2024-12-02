pipeline{
  agent any
  // JVAV와 Maven Tool 등록
  tools {
    jdk 'jdk17'
    maven 'M3'
  }

  stages {
    // Github에서 Jenkins로 소스코드 복제
    stage('Git Clone'){
      steps {
        git url: 'https://github.com/DominGY/spring-petclinic.git', branch: 'main'
      }
    }
    stage('Maven Build') {
      steps {
        sh 'mvn -Dmaven.test.failure.ignore=true clean package'
      }
    }
    stage('Docker Image') {
      steps {
        dir("${env.WORKSPACE}") {                     //env는 환경변수를 뜻함. WORKSPACE를 말한다.
          sh """ 
          docker build -t pktgt/spring-petclinic:$BUILD_NUMBER .      //-t 도커계정/이미지이름:version .
          docker tag pktgt/spring-petclinic:$BUILD_NUMBER pktgt/spring-petclinic:latest
          """                                                         //$BUILD_NUMBER : jenkins안에서 빌드 번호를 붙여줌
        }
      }
    }
    
  }
}
