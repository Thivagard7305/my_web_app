pipeline {
  agent any

  environment {
    APP_DIR = "my_web_app"
    AZURE_RESOURCE_GROUP = "my-web-app-rg"
    AZURE_WEBAPP_NAME = "my-python-app"
    AZURE_CREDENTIALS_ID = "azure-sp-credential"
  }

  stages {
    stage('Clone Repository') {
      steps {
        git 'https://github.com/Thivagard7305/my_web_app.git'
      }
    }

    stage('Install Dependencies') {
      steps {
        sh "cd ${APP_DIR} && pip3 install -r requirements.txt"
      }
    }

    stage('Run Tests') {
      steps {
        sh "cd ${APP_DIR} && pytest test_app.py"
      }
    }

    stage('Package Application') {
      steps {
        sh "cd ${APP_DIR} && zip -r ../${APP_DIR}.zip ."
      }
    }

    stage('Deploy to Azure') {
      steps {
        script {
          azureWebAppPublish azureCredentialsId: "${AZURE_CREDENTIALS_ID}",
                             resourceGroup: "${AZURE_RESOURCE_GROUP}",
                             appName: "${AZURE_WEBAPP_NAME}",
                             filePath: "${APP_DIR}.zip"
        }
      }
    }
  }

  post {
    failure {
      echo "Build failed!"
    }
    success {
      echo "Successfully deployed to Azure!"
    }
  }
}