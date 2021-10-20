
pipeline {
    agent {label 'agent'}
    tools{
        maven 'maven'
    }
    environment {
        CI = 'true'
        registry = 'docker-services-training/siji-evaluation/'
        }
    stages {
        stage('git clone') {
            steps {
                git branch: 'main', url: 'https://github.com/siji-sathyan/samplemaven.git'
            }    
        }
        stage('clean-install') {
            steps {
                sh 'mvn clean install'
            }
        }
        stage('Sonarqube analysis') {
            steps {
                script {
                    withSonarQubeEnv('sonar'){
                        sh 'ls'
                        sh 'mvn sonar:sonar -DskipTests'
                     }
                 }
            }
        }
        stage('package') {
            steps {
                sh 'mvn package'
                archiveArtifacts artifacts: 'target/*.war', followSymlinks: false      
            }
        }      
        stage('Build the image') { 
            steps { 
                script {        
                    docker.withTool('docker') {
                        docker.withRegistry('https://artifactory.dagility.com', 'siji-registry'){
                            docker.build(registry + "samplemaven:latest").push()
                        }
                    }
                } 
            }
         }     
    }
}
