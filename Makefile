PREFIX=/usr/local
SCHEME=chibi
RNRS=r7rs

all: build

build:
	@echo "No build step, just install"

test:
	rm -rf testvenv/ \
		&& ./scheme-venv ${SCHEME} ${RNRS} testvenv \
		&& ./testvenv/bin/snow-chibi install retropikzel.hello \
		&& ./testvenv/bin/akku install akku-r7rs \
		&& ./testvenv/bin/scheme-script test.scm

test-docker:
	docker build --build-arg SCHEME=${SCHEME} -f Dockerfile.test --tag=scheme-venv-test-${SCHEME} .
	docker run -t scheme-venv-test-${SCHEME} bash -c "make SCHEME=${SCHEME} RNRS=${RNRS} test"

install:
	mkdir -p ${PREFIX}/bin
	install scheme-venv ${PREFIX}/bin/scheme-venv

uninstall:
	-rm ${PREFIX}/bin/scheme-venv
