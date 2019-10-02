pipeline {
    agent any
    stages{
        stage('Build Docker Image'){
            steps{
                script{
                    def tag = latestCommitHash()
                    sh "docker build . -t kammana/nodeapp:${tag} "
                }
                
            }

        }
        stage('Push DockerHub'){
            steps{
                withCredentials([string(credentialsId: 'docker-hub', variable: 'dockerHubPwd')]) {
                    sh "docker login -u kammana -p ${dockerHubPwd}"
                    script{
                        def tag = latestCommitHash()
                        sh "docker push kammana/nodeapp:${tag}"
                    }
                }
            }
        }
    }
}

def latestCommitHash(){
    def commit =  sh returnStdout: true, script: 'git rev-parse HEAD'
    return commit
}