PREFIX=/usr/local
SCHEME=chibi
RNRS=r7rs
DOCKERTAG=scheme-venv-test-${SCHEME}

all: build

build:
	@echo "No build step, just install"

init-testvenv:
	./scheme-venv ${SCHEME} ${RNRS} testvenv

test-script: init-testvenv
	@if [ "${RNRS}" = "r6rs" ]; then ./testvenv/bin/akku install chez-srfi; fi
	@if [ "${RNRS}" = "r6rs" ]; then ./testvenv/bin/scheme-script test.sps; fi
	@if [ "${RNRS}" = "r7rs" ]; then ./testvenv/bin/snow-chibi install --always-yes retropikzel.hello; fi
	@if [ "${RNRS}" = "r7rs" ]; then ./testvenv/bin/scheme-script test.scm; fi

test-compile: init-testvenv
	@if [ "${RNRS}" = "r6rs" ]; then ./testvenv/bin/akku install chez-srfi; fi
	@if [ "${RNRS}" = "r6rs" ]; then ./testvenv/bin/scheme-compile test.sps && ./test; fi
	@if [ "${RNRS}" = "r7rs" ]; then ./testvenv/bin/snow-chibi install --always-yes retropikzel.hello; fi
	@if [ "${RNRS}" = "r7rs" ]; then ./testvenv/bin/scheme-compile test.scm && ./test; fi

build-docker-image:
	docker build -f Dockerfile.test --tag=${DOCKERTAG}

test-script-docker: build-docker-image
	docker run -v ${PWD}:${PWD} -w ${PWD} ${DOCKERTAG} sh -c "make SCHEME=${SCHEME} RNRS=${RNRS} test-script"

test-compile-docker: build-docker-image
	docker run -v ${PWD}:${PWD} -w ${PWD} ${DOCKERTAG} sh -c "make SCHEME=${SCHEME} RNRS=${RNRS} test-compile"

install:
	@mkdir -p ${PREFIX}/bin
	@install scheme-venv ${PREFIX}/bin/scheme-venv

uninstall:
	@-rm ${PREFIX}/bin/scheme-venv

clean:
	rm -rf testvenv
