PREFIX=/usr/local
SCHEME=chibi
RNRS=r7rs

all: build

build:
	@echo "No build step, just install"

test:
	rm -rf testvenv/ && ./scheme-venv ${SCHEME} ${RNRS} testvenv && ./testvenv/bin/snow-chibi install retropikzel.hello && ./testvenv/bin/scheme-script test.scm

build-docker-test-image:
	docker build --build-arg SCHEME=${SCHEME} -f Dockerfile.test --tag=scheme-venv-test .

test-docker: build-docker-test-image
	docker run -it -t scheme-venv-test bash -c "make SCHEME=${SCHEME} RNRS=${RNRS} test"

install:
	mkdir -p ${PREFIX}/bin
	install scheme-venv ${PREFIX}/bin/scheme-venv

uninstall:
	-rm ${PREFIX}/bin/scheme-venv
