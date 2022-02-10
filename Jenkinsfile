pipeline {
    agent any
    environment{
        DOCKER_TAG = getDockerTag()
        #NEXUS_URL  = "172.31.34.232:8080"
        #IMAGE_URL_WITH_TAG = "${NEXUS_URL}/node-app:${DOCKER_TAG}"
    }
    stages{
        stage('Build Docker Image'){
            steps{
                sh "docker build . -t madakala/nodeapp:${Docker_TAG}"
            }
        }
        stage('DockerHub Push')
            steps{
                withCredentials([string(credentialsId: 'DOCKER_HUB_CREDENTIALS', variable: 'DOCKER_HUB_CREDENTIALS')]) {
                   sh "docker login -u madakala -p ${DOCKER_HUB_CREDENTIALS}"
				   sh "docker push madakala/nodeapp:${Docker_TAG}"
				}   
            }
		}
		stage('Deploy to k8s')
		  steps{
		      sh "chmod +changeTag.sh"
			  sh "./changeTag.sh ${Docker_TAG}"
			  sshagent(['kops-machine']){
			  sh "scp -o strictHostkeyChecking=no services.yml node-app-pod.yml ubuntu@3.227.231.250:/home/ubuntu/"
			   script{
			       try{
				      sh "ssh ubuntu@3.227.231.250  kubectl apply -f ."
	   				}catch(error){
					   sh "ssh ubuntu@3.227.231.250 kubectl create -f ."
					}   
                } 					
				
			}
    	}		
	}	
}	
}	
