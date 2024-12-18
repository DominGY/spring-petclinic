pipeline{
  agent any
  // JVAV와 Maven Tool 등록
  tools {
    jdk 'jdk17'
    maven 'M3'
  }

  // Docker Hub 접속 정보(환경설정)
  environment {
    DOCKERHUB_CREDENTIALS = credentials('dockerCredentials')
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
          docker build -t parkgt/spring-petclinic:$BUILD_NUMBER .      
          docker tag parkgt/spring-petclinic:$BUILD_NUMBER parkgt/spring-petclinic:latest
          """                                                         
        }
      }
    }
    stage ('Docker Image Push') {
      steps {
        sh """
        echo $DOCKERHUB_CREDENTIALS_PSW | docker login -u $DOCKERHUB_CREDENTIALS_USR --password-stdin
        docker push parkgt/spring-petclinic:latest
        """
      }
    }
    stage ('Remove Docker Image') {
      steps {
        sh """
        docker rmi parkgt/spring-petclinic:$BUILD_NUMBER
        docker rmi parkgt/spring-petclinic:latest
        """
      }
    }
    stage ('Docker Container') {
      steps {
        sshPublisher(publishers: [sshPublisherDesc(configName: 'target',
        transfers: [sshTransfer(cleanRemote: false,
        excludes: '',
        execCommand: '''
        docker rm -f $(docker ps -aq)
        docker rmi $(docker images -q)
        docker run -d -p 80:8080 --name spring-petclinic parkgt/spring-petclinic:latest
        ''',
        execTimeout: 120000,
        flatten: false,
        makeEmptyDirs: false,
        noDefaultExcludes: false,
        patternSeparator: '[, ]+',
        remoteDirectory: '',
        remoteDirectorySDF: false,
        removePrefix: '',
        sourceFiles: '')],
        usePromotionTimestamp: false,
        useWorkspaceInPromotion: false,
        verbose: false)])
      }
    }
    
  }
}
