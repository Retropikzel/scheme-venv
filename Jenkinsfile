pipeline {
    agent {
        docker {
            image 'alpine'
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
                sh "apk add make docker tree"
            }
        }
        stage('R6RS script') {
            steps {
                script {
                    params.R6RS_SCHEMES.split().each { SCHEME ->
                        stage("${SCHEME}") {
                            catchError(buildResult: 'SUCCESS', stageResult: 'FAILURE') {
                                sh "make SCHEME=${SCHEME} RNRS=r6rs test-script-docker | grep 'scheme-venv-script-test-success-Hello' || exit 1"
                            }
                        }
                    }
                }
            }
        }
        stage('R6RS compile') {
            steps {
                script {
                    params.R6RS_SCHEMES.split().each { SCHEME ->
                        stage("${SCHEME}") {
                            catchError(buildResult: 'SUCCESS', stageResult: 'FAILURE') {
                                sh "make SCHEME=${SCHEME} RNRS=r6rs test-compile-docker | grep 'scheme-venv-compile-test-success-Hello' || exit 1"
                            }
                        }
                    }
                }
            }
        }
        stage('R7RS script') {
            steps {
                script {
                    params.R7RS_SCHEMES.split().each { SCHEME ->
                        stage("${SCHEME}") {
                            catchError(buildResult: 'SUCCESS', stageResult: 'FAILURE') {
                                sh "make SCHEME=${SCHEME} RNRS=r7rs test-script-docker | grep 'scheme-venv-script-test-success-Hello' || exit 1"
                            }
                        }
                    }
                }
            }
        }
        stage('R7RS compile') {
            steps {
                script {
                    params.R7RS_SCHEMES.split().each { SCHEME ->
                        stage("${SCHEME}") {
                            catchError(buildResult: 'SUCCESS', stageResult: 'FAILURE') {
                                sh "make SCHEME=${SCHEME} RNRS=r7rs test-compile-docker | grep 'scheme-venv-compile-test-success-Hello' || exit 1"
                            }
                        }
                    }
                }
            }
        }
    }
}
