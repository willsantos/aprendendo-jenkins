def app_version = "16.8.1"
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

        stage("Start docker"){
            steps{
                script{
                    docker.image("wilsonsantosphx/jenkins-teste-dotnet:${app_version}").run("-p 8085:80 --name jenkins-teste-dotnet")
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
                  enableArtifactsList: true,
                  link: "https://hub.docker.com/repository/docker/wilsonsantosphx/jenkins-teste-dotnet/general"
            }
        }
        
    }
