pipeline {
    agent any 
    environment {
        registry = "ukohae39/videocall"
        dockerImage = ''
        registryCredential = 'dockerhub_id'
    }
    stages {
        stage("Checkout") {
            steps {
                checkout([$class: 'GitSCM', branches: [[name: '*/main']], 
                extensions: [], 
                userRemoteConfigs: [[url: 'https://github.com/ukohae/video-call.git']]])
            }
        }
        stage('Building image') {
            steps{
                script {
                dockerImage = docker.build registry
                }
            }
        }
        stage('Uploading Image'){
            steps {
                script {
                    docker.withRegistry('', registryCredential) {
                        dockerImage.push()
                    }    
                }
            }
        }
    // Stopping Docker containers for cleaner Docker run
        stage('docker stop container') {
            steps {
                sh 'docker ps -f name=videocallContainer -q | xargs --no-run-if-empty docker container stop'
                sh 'docker container ls -a -fname=videocallContainer -q | xargs -r docker container rm'
            }
        }
    
    // Running Docker container, make sure port 8096 is opened in 
        stage('Docker Run') {
            steps{
                script {
                    dockerImage.run("-p 8096:5000 --rm --name videocallContainer")
                }
            }
        }
    }
}


// pipeline {
    
//     agent {
//         label 'master'
//     }
//     tools {
//         maven 'Maven3'
//     }
 
//     environment {
//         registry = "ukohae39/videocall"
//         dockerImage = ''
//         registryCredential = 'dockerhub_id'
//     }

//     stages {

//         stage("Checkout") {
//             steps {
//                 checkout([$class: 'GitSCM', branches: [[name: '*/main']], 
//                 extensions: [], 
//                 userRemoteConfigs: [[url: 'https://github.com/ukohae/video-call.git']]])
//             }
//         }

//         stage ('Build with Maven') {
//             steps {
//                 sh 'mvn clean install -f MyWebApp/pom.xml'
//             }
//         }

//         stage ('Code Quality') {
//             steps {
//                 withSonarQubeEnv('SonarQube') {
//                     sh 'mvn -f MyWebApp/pom.xml sonar:sonar'
//                 }
//             }
//         }

//         stage ('DEV Deploy') {
//             steps {
//                 echo "deploying to DEV Env "
//                 deploy adapters: [tomcat9(credentialsId: '2f66c67a-96fa-48c1-a247-4652d31b1625', 
//                 path: '', 
//                 url: 'http://ec2-52-15-224-16.us-east-2.compute.amazonaws.com:8080')], 
//                 contextPath: null, war: '**/*.war'
//             }
//         }

//         stage('Building image') {
//             steps{
//                 script {
//                 dockerImage = docker.build registry
//                 }
//             }
//         }

//         stage('Uploading Image'){
//             steps {
//                 script {
//                     docker.withRegistry('', registryCredential) {
//                         dockerImage.push()
//                     }    
//                 }
//             }
//         }

//     // Stopping Docker containers for cleaner Docker run
//         stage('docker stop container') {
//             steps {
//                 sh 'docker ps -f name=videocallContainer -q | xargs --no-run-if-empty docker container stop'
//                 sh 'docker container ls -a -fname=videocallContainer -q | xargs -r docker container rm'
//             }
//         }
    
//     // Running Docker container, make sure port 8096 is opened in 
//         stage('Docker Run') {
//             steps{
//                 script {
//                     dockerImage.run("-p 8096:5000 --rm --name videocallContainer")
//                 }
//             }
//         }
//     }
// }