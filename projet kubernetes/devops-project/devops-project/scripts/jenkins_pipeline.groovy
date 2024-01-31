# jenkins_pipeline.groovy
pipeline {
    agent any

    stages {
        stage('Build') {
            steps {
                sh 'make build'
            }
        }

        stage('Test') {
            steps {
                sh 'make test'
            }
        }

        stage('Deploy') {
            when {
                branch 'master'
            }
            steps {
                sh 'make deploy'
            }
        }
    }

    post {
        always {
            junit 'reports/**/*.xml'
            archiveArtifacts 'build/dist/*.zip'
            notifyBuild('success')
        }
        failure {
            notifyBuild('failure')
        }
    }
}

def notifyBuild(status) {
    // code to send notifications
}