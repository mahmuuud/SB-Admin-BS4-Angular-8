pipeline {
  agent any
  environment {
    CI = 'true'
  }
  triggers {
    githubPush()
  }
  stages {
    stage('Build') {
      steps {
        sh 'npm install'
      }
    }
    stage('Test') {
      steps {
        sh 'npm test'
        //sh 'npx prettier --write .'
      }
    }
    stage('Deliver') {
      steps {
        echo 'delivery'
        //sh './jenkins/scripts/deliver.sh'
        //input message: 'Finished using the web site? (Click "Proceed" to continue)'
        //sh './jenkins/scripts/kill.sh'
      }
    }
  }
  post {
    always {
      sh 'tar czf AdminPanel-${BUILD_NUMBER}.tar.gz node_modules package.json package-lock.json'

      rtBuildInfo (
        captureEnv: true,
      )

      rtUpload (
        serverId: SERVER_ID,
        spec: '''{
            "files": [
              {
                "pattern": "AdminPanel-*",
                "target": "agilegps-local/Artifacts/"
              }
              ]
        }''',
)
    }

    success {
        mail bcc: '', body: "<b>Build for </b><br>Project: ${env.JOB_NAME} <br>Build Number: ${env.BUILD_NUMBER} <br> URL de build: ${env.BUILD_URL}", cc: '', charset: 'UTF-8', from: '', mimeType: 'text/html', replyTo: '', subject: "Success CI: Project name -> ${env.JOB_NAME}", to: "mahmoud3341@gmail.com";

      }
    failure {
        mail bcc: '', body: "<b>Build for </b><br>Project: ${env.JOB_NAME} <br>Build Number: ${env.BUILD_NUMBER} <br> URL de build: ${env.BUILD_URL}", cc: '', charset: 'UTF-8', from: '', mimeType: 'text/html', replyTo: '', subject: "ERROR CI: Project name -> ${env.JOB_NAME}", to: "mahmoud3341@gmail.com";
      }
  }
}
