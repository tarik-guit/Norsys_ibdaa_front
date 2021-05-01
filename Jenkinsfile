def dockerRepoUrl = "192.168.1.145"
def dockerImageName = "ibdaa-front"
def dockerImageTag = "${dockerRepoUrl}/ibdaa/${dockerImageName}:latest"
def dockerContainerName = "ibdaa-front"
def dockerContainerPort = "10080:80"

pipeline {
	 agent any
		 stages {
              stage('Initialize') {
				   steps {
					sh ("rm -rf node_modules")
				   	sh("npm install")
				   }
			  }
// 			  stage('Lint rules') {
// 				   steps {
// 				   	sh("npm run lint")
// 				   }
// 			  }
			  // stage('Test') {
				//    steps {
				//     sh("npm run test --watch=false")
				//    }
			  // }
              stage('Build') {
				   steps {
				    sh("npm run build -- --prod")
				   }
			  }
			  stage('Docker Build and Tag') {
				   steps {
				    sh("docker build -f docker/Dockerfile -t ${dockerImageName} .")
				   }
			  }
			  stage('Push') {
				   environment {
				    DOCKER = credentials("sinaf-docker-registry")
				   }
				   steps {
				    sh("docker tag ${dockerImageName} ${dockerImageTag}")
				    sh("docker login -u $DOCKER_USR -p $DOCKER_PSW ${dockerRepoUrl}")

				    sh("docker push ${dockerImageTag}")
				   }
			  }
			  stage('Run docker container') {
				   steps {
				    sh("chmod u+x deploy.sh")
				    sh "(./deploy.sh ${dockerContainerName} ${dockerImageTag} ${dockerContainerPort})"
				   }
		      }
	 }

}
