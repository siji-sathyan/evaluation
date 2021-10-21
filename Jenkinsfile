
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
                git branch: 'main', url: 'https://github.com/siji-sathyan/evaluation.git'
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
                archiveArtifacts artifacts: 'target**/*.war', followSymlinks: false      
            }
        }      
        stage('Build the image') { 
            steps { 
                script {        
                    docker.withTool('docker') {
                        docker.withRegistry('https://artifactory.dagility.com', 'siji-registry'){
                            docker.build(registry + "evaluation:latest").push()
                        }
                    }
                } 
            }
         } 
        stage('deploy'){
            steps{
                sshagent(['deploy-user']) {
                    sh "scp -o StrictHostKeyChecking=no /home/jenkins/agent/workspace/siji-training/Maven-Assessment/target/evaluation.war ec2-user@3.238.185.140:/opt/apache-tomcat-8.5.71/webapps"      
            }
          }
        }
    }
}
