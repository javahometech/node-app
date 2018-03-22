node(){
    stage('Checkout'){
        git url:'https://github.com/javahometech/node-app'
    }
    stage('Build Docker Image'){
        docker.withRegistry('https://docker.io','docker-hub-id'){
           def nodeApp =  docker.build('kammana/node-app:0.0.2')
           nodeApp.push()
        }
    }
}
