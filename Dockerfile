FROM ubuntu:22.04

COPY F-STAR_* /tmp/
ENV FSTAR_HOME=/root/.opam/default
ENV OCAMLPATH=${FSTAR_HOME}/bin
RUN apt-get update && \
    apt-get install -y opam ocaml python2.7 libgmp-dev && \
    opam init -y --disable-sandboxing && \
    opam install -v -y --no-self-upgrade fstar.$(cat /tmp/F-STAR_VERSION) && \
    opam clean -a -y && \
    cd /root/.opam/default && \
    mv bin/fstar.exe bin/fstar && \
    apt-get remove -y opam && \
    apt-get autoremove -y && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*
ENV PATH=${OCAMLPATH}:${PATH}
