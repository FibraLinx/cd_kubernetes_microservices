pipeline {
	agent any
	stages {
		stage("deploy") {
			steps {
				script {
					sh 'helmfile sync'
				}
			}
		}
	}
}
