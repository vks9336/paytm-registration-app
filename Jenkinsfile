pipeline {
    agent any

    environment {
        DOCKER_HUB_CREDENTIALS = credentials('dockerhub-creds') // Jenkins credentials ID
        DOCKER_IMAGE = "yourdockerhubusername/paytm-registration"
    }

    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/your-repo/paytm-registration-app.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    sh 'docker build -t $DOCKER_IMAGE:$BUILD_NUMBER .'
                }
            }
        }

        stage('Login to DockerHub') {
            steps {
                script {
                    sh "echo $DOCKER_HUB_CREDENTIALS_PSW | docker login -u $DOCKER_HUB_CREDENTIALS_USR --password-stdin"
                }
            }
        }

        stage('Push to DockerHub') {
            steps {
                script {
                    sh 'docker push $DOCKER_IMAGE:$BUILD_NUMBER'
                    sh 'docker tag $DOCKER_IMAGE:$BUILD_NUMBER $DOCKER_IMAGE:latest'
                    sh 'docker push $DOCKER_IMAGE:latest'
                }
            }
        }

        stage('Deploy on Local Docker') {
            steps {
                script {
                    sh 'docker rm -f paytm-registration || true'
                    sh 'docker run -d --name paytm-registration -p 8080:80 $DOCKER_IMAGE:latest'
                }
            }
        }
    }

    post {
        always {
            echo "Pipeline finished."
        }
    }
}

