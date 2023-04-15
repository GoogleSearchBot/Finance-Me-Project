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
    }
}
