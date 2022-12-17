pipeline {
	agent any
	stages {
		stage("deploy") {
			steps {
              			sshagent(['kubernetes']) {
                    			sh '''
                    			ssh -o StrictHostKeyChecking=no vagrant@192.168.56.10
                    			helmfile sync
                    			'''
                		}
			}
		}
	}
}
