ARG SCHEME=chibi
FROM debian:bookworm-slim
RUN apt-get update && apt-get install -y \
    build-essential git wget ca-certificates guile-3.0 guile-3.0-dev libcurl4
ENV CONFIG=--prefix=/root/.local
WORKDIR /build
RUN wget https://gitlab.com/-/project/6808260/uploads/819fd1f988c6af5e7df0dfa70aa3d3fe/akku-1.1.0.tar.gz && tar -xf akku-1.1.0.tar.gz && mv akku-1.1.0 akku
WORKDIR /build/akku
ENV PATH=/root/.local/bin:${PATH}
RUN ./configure ${CONFIG}
RUN make
RUN make install
WORKDIR /build
RUN wget https://ftp.gnu.org/gnu/make/make-4.4.tar.gz && tar -xf make-4.4.tar.gz
WORKDIR /build/make-4.4
RUN ./configure ${CONFIG}
RUN make
run make install
WORKDIR /build
RUN git clone https://github.com/ashinn/chibi-scheme.git --depth=1
WORKDIR /build/chibi-scheme
RUN make PREFIX=/root/.local
RUN make PREFIX=/root/.local install
WORKDIR /workdir
COPY scheme-venv /root/.local/bin/scheme-venv

