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
      // 가져온 소스코드 빌드
      
    }
    stage('Docker Image') {
      // Docker image를 만듦
    }
    stage('Docker Image Push') {
      // Docker image를 올린다.
    }
    stage ('SSH Publish') {
      
    }
  }
}
