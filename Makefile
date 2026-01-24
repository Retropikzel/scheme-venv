PREFIX=/usr/local

all: build

build:
	@echo "No build step, just install"

install:
	mkdir -p ${PREFIX}/bin
	install scheme-venv ${PREFIX}/bin/scheme-venv

uninstall:
	-rm ${PREFIX}/bin/scheme-venv
