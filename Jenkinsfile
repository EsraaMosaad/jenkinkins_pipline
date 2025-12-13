pipeline {
    agent any 
    tools {
        maven 'Maven 3' 
    }

    environment {
        // Replace 'your-docker-credentials' with the ID of the credentials you created in Jenkins
        DOCKERHUB_CREDENTIALS = credentials('docker-hub-creds')
        // Update the image name to match your Docker Hub username
        APP_NAME = "esraaabdelrazek012/check-service-feasibility"
    }

    stages { 
        stage('SCM Checkout') {
            steps {
                // 'checkout scm' automatically checks out the code from the repository defined in the Jenkins job
                checkout scm
            }
        }
        
        stage('Build Application') {
            steps {
                // Compile the Java code and package it using Maven
                // We skip tests for speed in this example, but you can remove -DskipTests to run them
                sh 'mvn clean install -DskipTests'
            }
        }
        
        stage('Build Docker Image') {
            steps {  
                // Build the Docker image using the Dockerfile in the current directory
                sh 'docker build -t $APP_NAME:latest .'
            }
        }
        
       stage('Scan Docker Image') {
            steps {
                // Run Trivy using Docker image
                // We mount the docker socket so Trivy can see the image we just built
                sh "docker run --rm -v /var/run/docker.sock:/var/run/docker.sock aquasec/trivy image $APP_NAME:latest"
            }
        }
    }
}