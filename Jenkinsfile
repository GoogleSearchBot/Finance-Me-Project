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
    }
}
