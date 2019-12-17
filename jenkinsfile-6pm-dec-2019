pipeline {
    agent any
    environment{
        DOCKER_TAG = getDockerTag()
    }
    stages{
        stage('Build Docker Image'){
            steps{
                sh "docker build . -t kammana/nodeapp:${DOCKER_TAG} "
            }
        }
        stage('DockerHub Push'){
            steps{
                withCredentials([string(credentialsId: 'docker-hub', variable: 'dockerHubPwd')]) {
                    sh "docker login -u kammana -p ${dockerHubPwd}"
                    sh "docker push kammana/nodeapp:${DOCKER_TAG}"
                }
            }
        }
        stage('Deploy to DevServer'){
            steps{
                sshagent (credentials: ['dev-server']) {
				    script{
					    sh returnStatus: true, script: 'ssh ec2-user@172.31.4.187 docker rm -f nodeapp'
						def runCmd = "docker run -d -p 8080:8080 --name=nodeapp kammana/nodeapp:${DOCKER_TAG}"
						sh "ssh -o StrictHostKeyChecking=no ec2-user@172.31.4.187 ${runCmd}"
					}
				}
            }
        }
    }
}

def getDockerTag(){
    def tag  = sh script: 'git rev-parse HEAD', returnStdout: true
    return tag
}
