node{
    def DOCKER_HUB_ID = 'kammana'
    def IMAGE_NAME = "nodeapp"
    def IMAGE_VERSION = '0.0.1'
    
    stage('SCM Checkout'){
        
        git branch: 'master', 
            credentialsId: 'github', 
            url: 'https://github.com/javahometech/node-app'
    }
    
    stage('Build Docker Image'){
        sh "docker build -t ${DOCKER_HUB_ID}/${IMAGE_NAME}:${IMAGE_VERSION} ."
        
    }
    
    stage('Push To Private Registry'){
        
        withCredentials([string(credentialsId: 'docker-hub', variable: 'docker_hub_pwd')]) {
             sh "docker login -u kammana -p ${docker_hub_pwd}"
             sh "docker push ${DOCKER_HUB_ID}/${IMAGE_NAME}:${IMAGE_VERSION}"
        }
    }
    stage('docker dev'){
        sshagent(['docker-dev']) {
          try{
              sh "ssh -o StrictHostKeyChecking=no ec2-user@172.31.28.58 docker rm -f ${IMAGE_NAME}"
          }catch(err){
              
          }      
          def docker_run = "docker run -d -p 80:8080 --name ${IMAGE_NAME} ${DOCKER_HUB_ID}/${IMAGE_NAME}:${IMAGE_VERSION} "
          sh "ssh -o StrictHostKeyChecking=no ec2-user@172.31.28.58 ${docker_run}"

        }
    }
    
}
