pipeline {
    agent any

    stages {
        stage('Version Check') {
            steps {
                sh 'git --version'
                sh 'mvn --version'
                sh 'ansible --version'
                sh 'terraform version'
            }
        }
        stage('Repo Cloning') {
            steps {
               git branch: 'main', url: 'https://github.com/MinimalKushal/Finance-Me-Project.git'
            }
        }
        stage('Packaging repo') {
            steps {
               sh 'mvn clean package'
            }
        }
        stage('Publish HTML reports') {
	     steps {
		    publishHTML([allowMissing: false, alwaysLinkToLastBuild: false, keepAll: false, reportDir: '', reportFiles: 'index.html', reportName: 'HTML Report', reportTitles: '', useWrapperFileDirectly: true])
            }
        }
	stage('Build Docker Image') {
		steps {
			sh 'docker build -t minimalkushal/financeme .'	
		}
	}
	stage('Push image to Docker Hub') {
	     steps {
		withCredentials([usernamePassword(credentialsId: 'docker-hub', passwordVariable: 'dockerhubpass', usernameVariable: 'dockerhubuser')]) {
			sh "docker login -u ${env.dockerhubuser} -p ${env.dockerhubpass}"
			sh 'docker push minimalkushal/financeme'
		}
	     }
	}
    }
}
