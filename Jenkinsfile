pipeline{
	agent any
	tools{
        jdk "JAVA8"
        maven "MAVEN3.8"
	}
	environment{
		IMAGE_NAME = '050570190265.dkr.ecr.us-east-1.amazonaws.com/artifact'
		REGISTRY_URL = "https://050570190265.dkr.ecr.us-east-1.amazonaws.com"
		REGISTRY_CREDENTIALS = "ecr:us-east-1:awsCredentials"
	}
	stages{
		stage("Fetch Code from GitHub Repo"){
			steps{
				git branch: 'master', url: 'https://github.com/PriyanshiSarad/Jenkins-Assignment2.git'
			}
		}
		stage("Checkstyle code analysis with Maven"){
	         steps{
	             sh 'mvn checkstyle:checkstyle'
	         }
	     }
		stage("Code Analyssis with Sonarqube"){
			environment{
					scannerHome = tool 'SONAR4.7'
			}
			steps{
				withSonarQubeEnv('sonar') {
					sh '''
					${scannerHome}/bin/sonar-scanner \
					-Dsonar.projectKey=Project \
					-Dsonar.projectName=Project \
					-Dsonar.projectVersion=1.0 \
					-Dsonar.sources=webapp/src/ '''
               }
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
		stage("Build Docker Image"){
			steps{
				script{
					dockerImage = docker.build( IMAGE_NAME + ":${BUILD_ID}")
				}
			}
		}
		stage("Publish Image to ECR"){
			steps{
				script{
					docker.withRegistry( REGISTRY_URL, REGISTRY_CREDENTIALS ) {
                       dockerImage.push("$BUILD_NUMBER")
                       dockerImage.push("latest")
                    }
				}
			}
		}
	} 
}