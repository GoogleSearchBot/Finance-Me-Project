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
        //paste here
	stage('Execute the Terraform File') {
		steps {
			sh 'terraform init'
			sh 'terraform validate'
			sh 'terraform plan'
			sh 'terraform apply -auto-approve'
		}
	}
    }
}
