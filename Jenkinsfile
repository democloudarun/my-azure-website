pipeline {
    agent any
    environment {
        GH_REGISTRY = "ghcr.io/democloudarun"
    }
    stages {
        stage('Push to GHCR') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'GITHUB_CREDENTIALS', usernameVariable: 'USER', passwordVariable: 'PAT')]) {
                    sh 'echo "$PAT" | docker login ghcr.io -u "$USER" --password-stdin'
                    sh "docker build -t ${GH_REGISTRY}/my-azure-website:latest ."
                    sh "docker push ${GH_REGISTRY}/my-azure-website:latest"
                }
            }
        }
        stage('Deploy Infrastructure') {
            steps {
                withCredentials([azureServicePrincipal('AZURE_Auth_ID')]) {
            sh '''
                export ARM_CLIENT_ID=$AZURE_CLIENT_ID
                export ARM_CLIENT_SECRET=$AZURE_CLIENT_SECRET
                export ARM_TENANT_ID=$AZURE_TENANT_ID
                export ARM_SUBSCRIPTION_ID=$AZURE_SUBSCRIPTION_ID
                terraform init
                terraform apply -auto-approve
                '''
                }
            }
        }
    }
}
