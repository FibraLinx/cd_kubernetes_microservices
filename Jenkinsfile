pipeline {
	agent any
	stages {
		stage("deploy") {
			steps{
        			sshagent(credentials : ['k8s']) {
            			sh 'ssh -o StrictHostKeyChecking=no vagrant@192.168.56.10 helmfile apply'
                		}
			}
		}
	}
}
