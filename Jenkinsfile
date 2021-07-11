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
        echo '########INFO: Started Pipeline'
        checkout scm // Webhooks not recieved if removed
        echo 'Good checkin'
        // sh 'rm -rf dist || true'
        // sh 'rm buildLog-* || true'
        // sh 'rm AdminPanel-* || true'
        // sh 'npm install'
        // sh 'npm run build'
      }
    }
    stage('Test') {
      steps {
        echo 'testing'
        echo 'WARNING: Testing Warning'
        echo 'hello'
        // sh 'npm run test-ci > UnitTestResultsBuild-${BUILD_NUMBER}.txt || true'
        // sh 'npx prettier --write .'
      }
    }
    stage('Deliver') {
      steps {
        echo 'delivery'
        echo 'error in delivery'
        // sh 'npm run e2e > E2ETestResultsBuild-${BUILD_NUMBER}.txt'
        //sh './jenkins/scripts/deliver.sh'
        //input message: 'Finished using the web site? (Click "Proceed" to continue)'
        //sh './jenkins/scripts/kill.sh'
      }
    }
  }
  post {
    always {
      // sh 'wget -O buildLog-${BUILD_NUMBER}.log ${BUILD_URL}consoleText'
      // sh 'tar czf AdminPanel-${BUILD_NUMBER}.tar.gz dist UnitTestResultsBuild-${BUILD_NUMBER}.txt E2ETestResultsBuild-${BUILD_NUMBER}.txt'

      // rtBuildInfo (
      //   captureEnv: true,
      // )

      // rtUpload (
      //   serverId: SERVER_ID,
      //   spec: '''{
      //       "files": [
      //         {
      //           "pattern": "AdminPanel-*",
      //           "target": "agilegps-local/Artifacts/"
      //         }
      //         ]
      //   }''')
        script {
          workingDir = sh (script: 'pwd', returnStdout: true).trim() + "/ParsingRules"
          step([$class: 'LogParserPublisher', parsingRulesPath: workingDir, useProjectRule: false])

        }
        
    }

    // success {
    //     mail bcc: '', body: "<b>Build for </b><br>Project: ${env.JOB_NAME} <br>Build Number: ${env.BUILD_NUMBER} <br> URL de build: ${env.BUILD_URL}", cc: '', charset: 'UTF-8', from: '', mimeType: 'text/html', replyTo: '', subject: "Success CI: Project name -> ${env.JOB_NAME}", to: "mahmoud3341@gmail.com";

    //   }
    // failure {
    //     mail bcc: '', body: "<b>Build for </b><br>Project: ${env.JOB_NAME} <br>Build Number: ${env.BUILD_NUMBER} <br> URL de build: ${env.BUILD_URL}", cc: '', charset: 'UTF-8', from: '', mimeType: 'text/html', replyTo: '', subject: "ERROR CI: Project name -> ${env.JOB_NAME}", to: "mahmoud3341@gmail.com";
    //   }
  }
}
