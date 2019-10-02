pipeline {
    agent any
    stages{
        stage('Build Docker Image'){
            steps{
                script{
                    def tag = latestCommitHash()
                    sh "docker build -t kammana/nodeapp:${tag} ."
                }
                
            }

        }
    }
}

def latestCommitHash(){
    def commit =  sh returnStdout: true, script: 'git rev-parse HEAD'
    return commit
}