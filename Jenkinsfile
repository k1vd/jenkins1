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
          docker.withRegistry('https://registry-1.docker.io/v2/', registryCredential) {
      dockerImage.push()
          }
        }

      }
    }

    stage('Deploying React.js container to Kubernetes') {
      steps {
        kubectl apply -f deployment.yaml
        kubectl apply -f service.yaml
        }

      }
    }

  }
  environment {
    dockerimagename = 'athapa1/react-app'
    dockerImage = ''
  }
}
