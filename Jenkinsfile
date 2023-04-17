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
        //paste here
	stage('Execute the Terraform File') {
		steps {
			sh 'sudo chmod 600 mykey.pem'
			sh 'terraform init'
			sh 'terraform validate'
			sh 'terraform plan'
			sh 'terraform apply -auto-approve'
		}
	}
    }
}
