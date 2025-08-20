pipeline {
    agent any
    options {
        ansiColor('xterm')
    }
    environment {
        DOCKER_IMAGE = 'itguruanil/paytm-registration'
        DOCKER_HUB_CREDENTIALS = credentials('dockerhub-creds')
    }
    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/aniljain19723/demo.git'
            }
        }
        stage('Build Docker Image') {
            steps {
                sh "docker build -t ${DOCKER_IMAGE}:${BUILD_NUMBER} ."
            }
        }
        stage('Login to DockerHub') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'dockerhub-creds', usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {
                    sh "echo $DOCKER_PASS | docker login -u $DOCKER_USER --password-stdin"
                }
            }
        }
        stage('Push to DockerHub') {
            steps {
                sh "docker push ${DOCKER_IMAGE}:${BUILD_NUMBER}"
                sh "docker tag ${DOCKER_IMAGE}:${BUILD_NUMBER} ${DOCKER_IMAGE}:latest"
                sh "docker push ${DOCKER_IMAGE}:latest"
            }
        }
        stage('Deploy Locally') {
            steps {
                sh """
                docker rm -f paytm-registration || true
                docker run -d -p 8081:80 --name paytm-registration ${DOCKER_IMAGE}:latest
                """
            }
        }
    }
}

