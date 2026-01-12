pipeline {
    agent any
    environment {
        GH_REGISTRY = "ghcr.io/your-github-username"
    }
    stages {
        stage('Push to GHCR') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'github-registry-creds', usernameVariable: 'USER', passwordVariable: 'PAT')]) {
                    sh "echo $PAT | docker login ghcr.io -u $USER --password-stdin"
                    sh "docker build -t ${GH_REGISTRY}/my-azure-website:latest ."
                    sh "docker push ${GH_REGISTRY}/my-azure-website:latest"
                }
            }
        }
        stage('Deploy Infrastructure') {
            steps {
                sh "terraform init"
                sh "terraform apply -auto-approve"
            }
        }
    }
}
