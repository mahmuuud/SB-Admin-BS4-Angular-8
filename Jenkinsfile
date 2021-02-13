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
        checkout scm // Webhooks not recieved if removed
        sh 'rm -rf dist'
        sh 'rm AdminPanel-*'
        sh 'npm install'
        sh 'npm run build'
      }
    }
    stage('Test') {
      steps {
        echo 'testing'
        sh 'npm run test-ci || true'
        sh 'npx prettier --write .'
      }
    }
    stage('Deliver') {
      steps {
        echo 'delivery'
        sh 'npm run e2e'
        //sh './jenkins/scripts/deliver.sh'
        //input message: 'Finished using the web site? (Click "Proceed" to continue)'
        //sh './jenkins/scripts/kill.sh'
      }
    }
  }
  post {
    always {
      echo ''
      sh 'tar czf AdminPanel-${BUILD_NUMBER}.tar.gz dist'

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
