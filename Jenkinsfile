pipeline {
  
  agent any
  stages {
    stage('Checkout Source') {
      steps {
        git 'https://github.com/k1vd/jenkins1.git'
      }
    }

    stage('Build image') {
      steps {
        script {
          dockerImage = docker.build dockerimagename
        }

      }
    }

    stage('Pushing Image') {
      environment {
        registryCredential = 'dockerhub-credential'
      }
      steps {
        script {
          docker.withRegistry('https://registry-1.docker.io/v2/', 'dockerhub-credential') {
      dockerImage.push()
          }
        }

      }
    }

    stage('Deploying React.js container to Kubernetes') {
      steps {
        script {
          kubernetesDeploy(configs: "deployment.yaml", "service.yaml")
        }

      }
    }

  }
  environment {
    dockerimagename = 'at/react-app'
    dockerImage = ''
  }
}
