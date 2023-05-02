pipeline {
    agent any

    stages {
        stage('Build Image') {
            steps {
                script {
                    dockerapp = docker.build("wilsonsantosphx/jenkins-teste-dotnet:${env.BUILD_ID}", '-f ./Dockerfile ./') 
                }                
            }
        }

        stage('Push Image') {
            steps {
                script {
                    docker.withRegistry('https://registry.hub.docker.comm', 'dockerhub') {
                        dockerapp.push('latest')
                        dockerapp.push("${env.BUILD_ID}")
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

        
    }
