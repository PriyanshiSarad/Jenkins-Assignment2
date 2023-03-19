pipeline{
	agent any
	tools{
        jdk "JAVA8"
        maven "MAVEN3.8"
	}
	stages{
		stage("Fetch Code from GitHub Repo"){
			steps{
				git url: 'https://github.com/PriyanshiSarad/Jenkins-Assignment2.git'
			}
		}
		stage("Build with Maven"){
			steps{
				sh 'mvn clean install'
			}
			post{
				success{
					echo "Now archiving the artifact"
					archiveArtifacts artifacts: '**/*.war'
				}
			}
		}
	} 
}