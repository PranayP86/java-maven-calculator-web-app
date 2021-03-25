pipeline {
   
   agent {
      label 'dedicated-slave'
   }

   

   stages {
      stage("Checkout Code") {
         steps {
            checkout scm
         }
      }
      stage("Initialize"){
         steps {
            script {
               def dockerHome = tool 'docker'
               env.PATH = "${dockerHome}/bin:${env.PATH}"
            }

            sh '''
            echo "PATH = ${PATH}"
            echo "M2_HOME = ${M2_HOME}"
            whoami

            '''
         }
      }
   /*   stage("JUnit Test") {
         steps {
          sh "'${M2_HOME}/bin/mvn' clean test"
         }
      }
      stage("Integration Test") {
         steps {
         sh "'${M2_HOME}/bin/mvn' integration-test"
         }
      }
      stage("Perfromance Test") {
         steps {
            sh "'${M2_HOME}/bin/mvn' verify"
         }
      }
      */
      stage("Docker Build and Tag") {
         steps {
            sh "docker ps"
            sh "docker build -t pranaycirruslabs/calculator ."
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