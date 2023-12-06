pipeline {
  
  agent any
  stages {
    stage('Checkout Source') {
      steps {
        git branch:branchName, url:'https://github.com/k1vd/jenkins1.git'
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
        registryCredential = 'dockerhub-credentials'
      }
      steps {
        script {
          docker.withRegistry('https://registry-1.docker.io/v2/', registryCredential) {
      dockerImage.push()
          }
        }

      }
    }

    stage('Deploying application container to Kubernetes') {
      steps {
        if (Boolean.valueOf(env.UNIX)) {
            sh 'kubectl apply -f deployment.yaml'
            sh 'kubectl apply -f service.yaml'
        }
        else {
            bat 'kubectl apply -f deployment.yaml'
            bat 'kubectl apply -f service.yaml'
        }
      }
    }

  }
  environment {
    dockerimagename = 'athapa1/angular-app'
    dockerImage = ''
    branchName = "${env.GIT_BRANCH.split('/').size() == 1 ? env.GIT_BRANCH.split('/')[-1] : env.GIT_BRANCH.split('/')[1..-1].join('/')}"
    env.UNIX = isUnix()
  }
}
