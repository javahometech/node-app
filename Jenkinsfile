node{
    def imgVersion = UUID.randomUUID().toString()
    def dockerImage = "kammana/nodeapp-6pm:${imgVersion}"
    stage('Source Checkout'){
        
        git 'https://github.com/javahometech/node-app'
    }
    
    
    stage('Build Docker Image'){
        sh "docker build -t ${dockerImage} ."
    }
    
    stage('Push DockerHub'){
		withCredentials([string(credentialsId: 'docker-hub', variable: 'dockerhubPwd')]) {
			sh "docker login -u kammana -p ${dockerhubPwd}"
		}
        
        sh "docker push ${dockerImage}"
    }
    
	stage('Dev Deploy'){
		def dockerRun = "docker run -d -p 8080:8080 --name nodeapp ${dockerImage}"
		sshagent(['dev-docker']) {
		    try{
				sh "ssh -o StrictHostKeyChecking=no ec2-user@13.127.166.0 docker rm -f nodeapp "
			}catch(e){
			
			
			}
			sh "ssh  ec2-user@13.127.166.0 ${dockerRun}"
		}
	}
}
