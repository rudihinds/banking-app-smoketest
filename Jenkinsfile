def github_id = 'CHANGEME'

def namespace = github_id.toLowerCase()
def git_repository = "https://github.com/${github_id}/banking-app-smoketest"
def app_url = "http://${namespace}-app.apps.prod.training.armakuni.co.uk"

def label = "build-${UUID.randomUUID().toString()}"
def build_pod_template = """
kind: Pod
metadata:
  name: build-pod
spec:
  containers:
  - name: python-test
    image:  sepractices/pg-python:0.1.0
    tty: true
"""

podTemplate(name: "${namespace}-smoketest-build", label: label, yaml: build_pod_template) {
  node(label) {
    git git_repository

    stage('Smoke Test') {
        container(name: 'python-test', shell: '/bin/sh') {
            sh 'pipenv install --dev'
            sh "URL=${app_url} pipenv run behave"
        }
    }
  }
}
