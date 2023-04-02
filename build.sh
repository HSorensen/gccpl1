#!/bin/sh

docker build -f _docker/dockerfile -t itsme/gccpl1x .

docker run --rm --hostname gccpli -it -v $PWD/workdir:/workdir -v $PWD/src-antlr/src-parser/main.cpp:/src-antlr/src-parser/main.cpp itsme/gccpl1x