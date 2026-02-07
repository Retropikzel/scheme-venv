Tool to create Scheme virtual environments

## Installation

    make
    make install


## Usage

    scheme-venv chibi r7rs venv


First argument is Scheme, second is RnRS and third is path to directory. The
directory must not exist.

After the virtual environment is created you can activate is with:

    source venv/bin/activate


After activation you can install packages with either snow-chibi or akku and
they will be installed inside the virtual environment. To run your Scheme code
use either scheme-script or scheme-compile, executables.


R6RS:

    akku install chez-srfi
    scheme-script main.sps
    scheme-compile main.sps
    ./main

R7RS:

    snow-chibi install srfi.64
    scheme-script main.scm
    scheme-compile main.scm
    ./main


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
    - venv/scheme-compile
        - Environment variable VENV\_CSC\_ARGS is added to csc arguments
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
