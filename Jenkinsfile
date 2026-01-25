pipeline {
    agent {
        docker {
            image 'debian'
            label 'docker-x86_64'
            args '--user=root --privileged -v /var/run/docker.sock:/var/run/docker.sock'
        }
    }

    options {
        disableConcurrentBuilds()
        buildDiscarder(logRotator(numToKeepStr: '10', artifactNumToKeepStr: '10'))
    }

    parameters {
        string(name: 'R6RS_SCHEMES', defaultValue: 'capyscheme chezscheme guile ikarus ironscheme larceny loko mosh racket sagittarius ypsilon', description: '')
        string(name: 'R7RS_SCHEMES', defaultValue: 'capyscheme chibi chicken cyclone foment gambit gauche guile kawa larceny loko meevax mosh mit-scheme racket sagittarius skint stklos tr7 ypsilon', description: '')
    }

    stages {
        stage('Init') {
            steps {
                sh "apt-get update && apt-get install -y make docker.io"
            }
        }
        stage('R6RS') {
            steps {
                script {
                    params.R6RS_SCHEMES.split().each { SCHEME ->
                        stage("${SCHEME}") {
                            catchError(buildResult: 'SUCCESS', stageResult: 'FAILURE') {
                                sh "make SCHEME=${SCHEME} test-r6rs-docker"
                            }
                        }
                    }
                }
            }
        }
        stage('R7RS') {
            steps {
                script {
                    params.R7RS_SCHEMES.split().each { SCHEME ->
                        stage("${SCHEME}") {
                            catchError(buildResult: 'SUCCESS', stageResult: 'FAILURE') {
                                sh "make SCHEME=${SCHEME} test-r7rs-docker"
                            }
                        }
                    }
                }
            }
        }
    }
}
