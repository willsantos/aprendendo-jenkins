def app_version = "16.7.1"
pipeline {
    agent any

    stages {
        stage('Build Image') {
            steps {
                script {
                    dockerapp = docker.build("wilsonsantosphx/jenkins-teste-dotnet:${app_version}", '-f ./Dockerfile ./') 
                }                
            }
        }

        stage('Push Image') {
            steps {
                script {
                    docker.withRegistry('https://registry.hub.docker.com', 'dockerhub') {
                        dockerapp.push('latest')
                        dockerapp.push("${app_version}")
                    }
                }
            }
        }
    }
      post{
            always
            {
                echo "========Sending Discord Notification========"
                discordSend description: "Jenkins Pipeline Build", 
                  result: currentBuild.currentResult, 
                  title: JOB_NAME, 
                  webhookURL: "${params.discord}",
                  enableArtifactsList: true
            }
        }
        
    }
