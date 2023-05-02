pipeline {
    agent any

    stages {
        stage('Build Image') {
            steps {
                script {
                    dockerapp = docker.build("wilsonsantosphx/jenkins-teste-dotnet:${env.BUILD_ID}", '-f ./src/Dockerfile ./src') 
                }                
            }
        }

        stage('Push Image') {
            steps {
                script {
                    docker.withRegistry('https://registry.hub.docker.com', 'dockerhub') {
                        dockerapp.push('latest')
                        dockerapp.push("${env.BUILD_ID}")
                    }
                }
            }
        }

        stage("Send Discord Notification"){
            steps{
                script{
                    echo "========Sending Discord Notification========"
                    discordSend description: "Jenkins Pipeline Build", result: currentBuild.currentResult, title: JOB_NAME, webhookURL: "https://discord.com/api/webhooks/1101853279895441428/wFdaBn6UzuB4ppg3-k46iGtrhugTj4hPL6pDsRXJraCw7ljrPlDoh0w2j-dkLhDGE5zk"
                }
            }
           
        }
    }

        
    }
}