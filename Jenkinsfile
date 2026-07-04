pipeline {
    agent {
        kubernetes {
            yaml '''
apiVersion: v1
kind: Pod
metadata:
  labels:
    some-label: jenkins-agent
spec:
  containers:
  - name: kaniko
    image: gcr.io/kaniko-project/executor:v1.14.0-debug
    command:
    - sleep
    args:
    - 99d
    volumeMounts:
    - name: aws-secret
      mountPath: /root/.aws
  - name: git-tools
    image: alpine/git:2.43.0
    command:
    - sleep
    args:
    - 99d
  volumes:
  - name: aws-secret
    secret:
      secretName: aws-credentials
'''
        }
    }

    environment {
        AWS_REGION     = 'us-west-2'
        ECR_REGISTRY   = '079715688900.dkr.ecr.us-west-2.amazonaws.com'
        ECR_REPOSITORY = 'lesson-5-ecr'
        IMAGE_TAG      = "${BUILD_NUMBER}"
        GIT_REPO_URL   = 'github.com/your-username/your-repo-name.git'
    }

    stages {
        stage('Build and Push to ECR') {
            steps {
                container('kaniko') {
                    sh """
                    /kaniko/executor \
                        --context=dir://. \
                        --dockerfile=Dockerfile \
                        --destination=${ECR_REGISTRY}/${ECR_REPOSITORY}:${IMAGE_TAG} \
                        --destination=${ECR_REGISTRY}/${ECR_REPOSITORY}:latest
                    """
                }
            }
        }

        stage('Update Helm Chart Git Tag') {
            steps {
                container('git-tools') {
                    withCredentials([usernamePassword(credentialsId: 'github-token', passwordVariable: 'GIT_TOKEN', usernameVariable: 'GIT_USER')]) {
                        sh """
                        git config --global user.email "jenkins@ci-cd.local"
                        git config --global user.name "Jenkins Pipeline"

                        sed -i 'x/tag: .*/tag: "${IMAGE_TAG}"/' charts/django-app/values.yaml

                        git add charts/django-app/values.yaml
                        git commit -m "Automated image tag update to ${IMAGE_TAG} [skip ci]"

                        git push https://${GIT_USER}:${GIT_TOKEN}@${GIT_REPO_URL} main
                        """
                    }
                }
            }
        }
    }
}