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
        dir("${env.WORKSPACE}") {                     
          sh """ 
          docker build -t pktgt/spring-petclinic:$BUILD_NUMBER .      
          docker tag pktgt/spring-petclinic:$BUILD_NUMBER pktgt/spring-petclinic:latest
          """                                                         
        }
      }
    }
    
  }
}
