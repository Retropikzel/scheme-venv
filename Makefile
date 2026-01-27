PREFIX=/usr/local
SCHEME=chibi
RNRS=r7rs
DOCKER_IMG=scheme-venv-test-${SCHEME}

all: build

build:
	@echo "No build step, just install"

testvenv:
	./scheme-venv ${SCHEME} ${RNRS} testvenv

test-script: testvenv
	@if [ "${RNRS}" = "r6rs" ]; then ./testvenv/bin/akku install chez-srfi; fi
	@if [ "${RNRS}" = "r6rs" ]; then ./testvenv/bin/scheme-script test.sps; fi
	@if [ "${RNRS}" = "r7rs" ]; then ./testvenv/bin/snow-chibi install --always-yes retropikzel.hello; fi
	@if [ "${RNRS}" = "r7rs" ]; then ./testvenv/bin/scheme-script test.scm; fi

test-compile: testvenv
	@if [ "${RNRS}" = "r6rs" ]; then ./testvenv/bin/akku install chez-srfi; fi
	@if [ "${RNRS}" = "r6rs" ]; then ./testvenv/bin/scheme-compile test.sps && ./test; fi
	@if [ "${RNRS}" = "r7rs" ]; then ./testvenv/bin/snow-chibi install --always-yes retropikzel.hello; fi
	@if [ "${RNRS}" = "r7rs" ]; then ./testvenv/bin/scheme-compile test.scm && ./test; fi

build-test-docker-image:
	docker build --build-arg SCHEME=${SCHEME} --build-arg RNRS=${RNRS} -f Dockerfile.test --tag=${DOCKER_IMG} .

test-script-docker: build-test-docker-image
	docker run ${DOCKER_IMG} bash -c "make SCHEME=${SCHEME} RNRS=${RNRS} test-script"

test-compile-docker: build-test-docker-image
	@docker run ${DOCKER_IMG} bash -c "make SCHEME=${SCHEME} RNRS=${RNRS} test-compile"

install:
	@mkdir -p ${PREFIX}/bin
	@install scheme-venv ${PREFIX}/bin/scheme-venv

uninstall:
	@-rm ${PREFIX}/bin/scheme-venv

clean:
	rm -rf testvenv
