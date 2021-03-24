pipeline {
   
   environment {
      imagename = "jenkins"
   }

   agent any

   tools {
      maven 'M3'
      jdk 'jdk-9.0.4'
      
   }

   stages {
      stage("Checkout Code") {
         steps {
            checkout scm
         }
      }
      stage("Initialize"){
         steps {
            sh '''
            echo "PATH = ${PATH}"
            echo "M2_HOME = ${M2_HOME}"
            echo "M3_HOME = ${M3_HOME}"
            '''
         }
      }
      stage("JUnit Test") {
         steps {
            sh "'${M2_HOME}/bin/mvn' clean test"
         }
      }
      stage("Integration Test") {
         steps {
         sh "'${mvnHome}/bin/mvn' integration-test"
         }
      }
      stage("Perfromance Test") {
         steps {
            sh "'${mvnHome}/bin/mvn' verify"
         }
      }
      stage("Docker Build and Tag") {
         steps {
            sh "docker build -t pranaycirruslabs/calculator"
            sh "docker tag calculator pranaycirruslabs/calculator:$BUILD_NUMBER"
         }
      }
      stage("Docker Push") {
         steps {
            withDockerRegistry(credentialsId: 'pranaycirruslabs-docker', url: 'pranaycirruslabs/calculator') {
               sh "docker push pranaycirruslabs/calculator:$BUILD_NUMBER"
            }
         }
      }
      stage("Deploy") {
         steps {
            timeout(time: 10, unit: 'MINUTES') {
           input message: 'Deploy this web app to production ?'
         }
      }
      }

   }
}