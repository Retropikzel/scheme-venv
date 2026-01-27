PREFIX=/usr/local
SCHEME=chibi
DOCKER_IMG=scheme-venv-test-${SCHEME}

all: build

build:
	@echo "No build step, just install"

test-r6rs-script:
	@echo "Starting test Scheme: ${SCHEME}, RNRS: R6RS"
	@rm -rf testvenv/ \
		&& ./scheme-venv ${SCHEME} r6rs testvenv \
		&& ./testvenv/bin/akku install chez-srfi \
		&& ./testvenv/bin/scheme-script test.sps

test-r6rs-compile:
	@echo "Starting test Scheme: ${SCHEME}, RNRS: R6RS"
	@rm -rf testvenv/ \
		&& ./scheme-venv ${SCHEME} r6rs testvenv \
		&& ./testvenv/bin/akku install chez-srfi \
		&& ./testvenv/bin/scheme-compile compile-test.sps \
		&& ./compile-test

test-r7rs-script:
	@echo "Starting test Scheme: ${SCHEME}, RNRS: R7RS"
	@rm -rf testvenv/ \
		&& ./scheme-venv ${SCHEME} r7rs testvenv \
		&& ./testvenv/bin/snow-chibi install --always-yes retropikzel.hello \
		&& ./testvenv/bin/scheme-script test.scm

test-r7rs-compile:
	@echo "Starting test Scheme: ${SCHEME}, RNRS: R7RS"
	@rm -rf testvenv/ \
		&& ./scheme-venv ${SCHEME} r7rs testvenv \
		&& ./testvenv/bin/snow-chibi install --always-yes retropikzel.hello \
		&& ./testvenv/bin/scheme-compile compile-test.scm \
		&& ./compile-test

build-test-docker-image:
	docker build --build-arg IMG=${SCHEME}:head -f Dockerfile.test --tag=${DOCKER_IMG} .

test-r6rs-script-docker: build-test-docker-image
	@docker run ${DOCKER_IMG} bash -c "make SCHEME=${SCHEME} test-r6rs-script"

test-r6rs-compile-docker: build-test-docker-image
	@docker run ${DOCKER_IMG} bash -c "make SCHEME=${SCHEME} test-r6rs-compile"

test-r7rs-script-docker: build-test-docker-image
	@docker run ${DOCKER_IMG} bash -c "make SCHEME=${SCHEME} test-r7rs-script"

test-r7rs-compile-docker: build-test-docker-image
	@docker run ${DOCKER_IMG} bash -c "make SCHEME=${SCHEME} test-r7rs-compile"

install:
	@mkdir -p ${PREFIX}/bin
	@install scheme-venv ${PREFIX}/bin/scheme-venv

uninstall:
	@-rm ${PREFIX}/bin/scheme-venv
