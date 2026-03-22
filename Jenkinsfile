pipeline {
    agent any

    environment {
        DOCKERHUB_REPO = 'your-dockerhub-username/mean-stack-app'
        BACKEND_IMAGE = "${DOCKERHUB_REPO}-backend"
        FRONTEND_IMAGE = "${DOCKERHUB_REPO}-frontend"
        VM_HOST = 'your-vm-ip-or-hostname'
        VM_USER = 'ubuntu'  // or your VM user
    }

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Build Backend Image') {
            steps {
                dir('backend') {
                    script {
                        def imageTag = "${env.BUILD_NUMBER}"
                        docker.build("${BACKEND_IMAGE}:${imageTag}")
                        docker.build("${BACKEND_IMAGE}:latest")
                    }
                }
            }
        }

        stage('Build Frontend Image') {
            steps {
                dir('frontend') {
                    script {
                        def imageTag = "${env.BUILD_NUMBER}"
                        docker.build("${FRONTEND_IMAGE}:${imageTag}")
                        docker.build("${FRONTEND_IMAGE}:latest")
                    }
                }
            }
        }

        stage('Push Images to Docker Hub') {
            steps {
                script {
                    docker.withRegistry('https://index.docker.io/v1/', 'dockerhub-credentials') {
                        def imageTag = "${env.BUILD_NUMBER}"

                        // Push backend images
                        docker.image("${BACKEND_IMAGE}:${imageTag}").push()
                        docker.image("${BACKEND_IMAGE}:latest").push()

                        // Push frontend images
                        docker.image("${FRONTEND_IMAGE}:${imageTag}").push()
                        docker.image("${FRONTEND_IMAGE}:latest").push()
                    }
                }
            }
        }

        stage('Deploy to VM') {
            steps {
                script {
                    sshagent(['vm-ssh-credentials']) {
                        sh """
                            ssh -o StrictHostKeyChecking=no ${VM_USER}@${VM_HOST} << EOF
                                cd /path/to/your/project
                                docker compose pull
                                docker compose up -d
                                docker system prune -f
                            EOF
                        """
                    }
                }
            }
        }
    }

    post {
        always {
            sh 'docker system prune -f'
        }
        success {
            echo 'Pipeline succeeded!'
        }
        failure {
            echo 'Pipeline failed!'
        }
    }
}