Tool to create Scheme virtual environments

## Installation

    make
    make install


## Usage

    scheme-venv chibi r7rs venv

Note that scheme-venv does not install snow-chibi, akku or any Scheme
implementations. You have to install them yourself into your system.

### bin/activate

First argument is Scheme, second is RnRS and third is path to directory. The
directory must not exist.

After the virtual environment is created you can activate is with:

    source venv/bin/activate


After activation you can install packages with either snow-chibi or akku and
they will be installed inside the virtual environment.

### bin/snow-chibi

Install R7RS package from [snow-fort.org](https://snow-fort.org).

### bin/akku

Install R6RS package from [akkuscm.org](https://akkuscm.org).

### bin/scheme-script

Run Scheme script.

### bin/scheme-compile

Compile Scheme code to executable.

### etc/Dockerfile

Dockerfile used in docker image building. If you need to add something you
can for example do:

    echo "RUN apt-get install make" >> venv/etc/Dockerfile
    cp Makefile venv/
    echo "COPY Makefile ." >> venv/etc/Dockerfile

### bin/docker-build

Build docker venvs docker image. Run this before docker-run or docker-repl.

### bin/docker-run

Run command inside venv inside docker.

### bin/docker-repl

Run scheme repl inside venv inside docker.

## Supported impelmentations and notes

### R6RS

- Capyscheme
- Chezscheme
- Guile
- Ikarus
- Ironscheme
- Larceny
- Loko
- Mosh
- Racket
- Sagittarius
- Ypsilon

### R7RS

- Capyscheme
- Chibi
- Chicken
    - Before compilation the directory is changed to be venv/lib so libraries will be found
    - venv/include
        - added into include paths
    - venv/lib
        - added into library paths
    - venv/bin/scheme-compile
        - Environment variable VENV_CSC_ARGS is added to csc arguments
- Cyclone
- Foment
- Gambit
- Gauche
- Guile
- Kawa
- Larceny
- Loko
- Meevax
- MIT-Scheme
- Mosh
- Racket
- Sagittarius
- Skint
- STklos
- tr7
- Ypsilon
