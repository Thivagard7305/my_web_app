pipeline {
  agent any

  environment {
    APP_DIR = "my-web-app"
  }

  stages {
    stage('Clone Repository') {
      steps {
        git 'https://github.com/Thivagard7305/my_web_app.git'
      }
    }

    stage('Install Dependencies') {
      steps {
        sh 'pip3 install -r requirements.txt'
      }
    }

    stage('Run Tests') {
      steps {
        sh 'pytest test_app.py'
      }
    }

    stage('Deploy to GCP') {
      steps {
        withCredentials([sshUserPrivateKey(credentialsId: 'gcp-ssh-key', keyFileVariable: 'SSH_KEY')]) {
          sh '''
            chmod +x deploy.sh
            ./deploy.sh
          '''
        }
      }
    }
  }

  post {
    failure {
      echo "Build failed!"
    }
    success {
      echo "Successfully deployed!"
    }
  }
}
