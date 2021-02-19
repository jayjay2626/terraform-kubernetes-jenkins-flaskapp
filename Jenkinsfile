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
    }
}