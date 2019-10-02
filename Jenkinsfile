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
                        sh """
                            sh "docker push kammana/nodeapp:${tag}"
                            sh "chmod +x changeTag.sh"
                            sh "./changeTag.sh ${tag}"
                        """
                    }
                }
            }
        }
        stage('Deploy - Kubernetes'){
            steps{
                sshagent(['kops-k8s']) {
                    sh """ 
                        
                       scp -o StrictHostKeyChecking=no services.yml node-app-pod.yml ec2-user@52.66.70.61:/home/ec2-user/
                       ssh ec2-user@52.66.70.61 kubectl create -f node-app-pod.yml
                       ssh ec2-user@52.66.70.61 kubectl create -f services.yml
                    """
                }
            }
        }
    }
}

def latestCommitHash(){
    def commit =  sh returnStdout: true, script: 'git rev-parse HEAD'
    return commit
}