#!/bin/sh
DOCKER_IMAGE=$1
DOCKER_RUN="docker run --rm -i -v $(pwd):/local -w /local ${DOCKER_IMAGE}"

CMD="fstar --codegen OCaml --odir out --extract HelloWorld HelloWorld.fst 1>&2 && \
    ocamlfind opt -package fstarlib -linkpkg -thread -o out/HelloWorld out/HelloWorld.ml 1>&2 && \
    out/HelloWorld && \
    rm -rf out"
RESULT="$(${DOCKER_RUN} sh -c "${CMD}")"
echo "${RESULT}"
if [ "${RESULT}" = "Hello, world!" ]
then
    echo "PASSED"
else
    echo "FAILED"
    exit 1
fi
