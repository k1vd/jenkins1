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
          docker.withRegistry( '', registryCredential ) {
            #dockerImage.push("latest")
            bat "docker push IMAGE_NAME:latest"
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
