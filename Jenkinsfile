pipeline {
  agent {
    node{
      label 'worstation'
    }
  }

  parameters {
    choice(name: 'env', choices: ['dev', 'prod'], description: 'Pick environment')
  }

  stages {
    stage('Terraform INIT') {
      steps {
        sh 'terraform init -backend-config=env-${env}/state.tfvars'
      }
    }
    stage('Terraform APPLY') {
      steps {
        sh 'terraform apply -auto-approve -var-file=env-${env}/main.tfvars'
      }
    }
  }
  post {
    always {
      cleanWs()
    }
  }
}