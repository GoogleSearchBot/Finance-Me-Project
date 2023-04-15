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
        stage('Cloning Repo') {
            steps {
                git branch: 'main', url: 'https://github.com/MinimalKushal/Finance-Me-Project'
            }
        }
    }
}
