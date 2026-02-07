VERSION=1.0.0
DEB=scheme-venv-${VERSION}.deb
PREFIX=/usr/local
SCHEME=chibi
RNRS=r7rs
DOCKERTAG=scheme-venv-test-${SCHEME}

all: build

build:
	@echo "No build step, just install"

init-venv:
	./scheme-venv ${SCHEME} ${RNRS} venv

test-script: init-venv
	@if [ "${RNRS}" = "r6rs" ]; then ./venv/bin/akku install chez-srfi; fi
	@if [ "${RNRS}" = "r6rs" ]; then ./venv/bin/scheme-script test.sps; fi
	@if [ "${RNRS}" = "r7rs" ]; then ./venv/bin/snow-chibi install --always-yes retropikzel.hello; fi
	@if [ "${RNRS}" = "r7rs" ]; then ./venv/bin/scheme-script test.scm; fi

test-compile: init-venv
	@if [ "${RNRS}" = "r6rs" ]; then ./venv/bin/akku install chez-srfi; fi
	@if [ "${RNRS}" = "r6rs" ]; then ./venv/bin/scheme-compile test.sps && ./test; fi
	@if [ "${RNRS}" = "r7rs" ]; then ./venv/bin/snow-chibi install --always-yes retropikzel.hello; fi
	@if [ "${RNRS}" = "r7rs" ]; then ./venv/bin/scheme-compile test.scm && ./test; fi

build-docker-image:
	docker build -f Dockerfile.test --tag=${DOCKERTAG}

test-script-docker: build-docker-image
	docker run -v ${PWD}:${PWD} -w ${PWD} ${DOCKERTAG} sh -c "make SCHEME=${SCHEME} RNRS=${RNRS} test-script"

test-compile-docker: build-docker-image
	docker run -v ${PWD}:${PWD} -w ${PWD} ${DOCKERTAG} sh -c "make SCHEME=${SCHEME} RNRS=${RNRS} test-compile"

deb:
	mkdir -p deb/usr/local/bin
	cp scheme-venv deb/usr/local/bin/
	mkdir -p deb/DEBIAN
	printf "Package: scheme-venv\nArchitecture: amd64\nVersion: ${VERSION}\nSection: misc\nMaintainer: Retropikzel <retropikzel@iki.fi>\nDescription: Tool to create Scheme virtual environments\n" \
		> deb/DEBIAN/control
	dpkg-deb -b deb
	cp deb.deb scheme-venv-latest.deb
	mv deb.deb scheme-venv-${VERSION}.deb

install:
	@mkdir -p ${PREFIX}/bin
	@install scheme-venv ${PREFIX}/bin/scheme-venv

uninstall:
	@-rm ${PREFIX}/bin/scheme-venv

clean:
	rm -rf venv
