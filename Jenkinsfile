pipeline{
    agent any
    tools {
        terraform 'terraform'
    }
    stages {
        stage('SCM Checkout'){
            steps {
                // remove folder if already exist
                sh 'rm -rf terraform-kubernetes-jenkins-flaskapp'

                // clone the repository from github
                sh 'git clone https://github.com/jayjay2626/terraform-kubernetes-jenkins-flaskapp.git'
            }
        }
        
        stage('Delete and Restart Kind Cluster'){
            steps {
                // Delete kind cluster if already exist
                sh 'kind delete cluster --name terraform-flaskapp'
                // Create Kind Cluster
                sh 'kind create cluster --name terraform-flaskapp --config kind-config.yaml'
            }
        }

        stage('Terraform Init'){
            steps {
                // Initialize terraform with all the required plugin
                sh 'terraform init'
            }
        }

        stage('Terraform Apply'){
            steps {
                // Applying terraform 
                sh 'terraform apply --auto-approve'
            }
        }
        
        stage('Cluster Info'){
            steps {
                // Cluster info
                sh 'kind get clusters'
            }
        }

	stage('Pods Info'){
            steps {
                // Deployment info
                sh 'kubectl get all --all-namespaces'
            }
        }

    }
}
