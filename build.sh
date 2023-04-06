#!/bin/sh

docker build -f _docker/dockerfile -t itsme/gccpl1x .

docker run --rm --hostname gccpli -it -v $PWD/workdir:/workdir \
  -v $PWD/src-antlr/src-parser/main.cpp:/src-antlr/src-parser/main.cpp \
  -v $PWD/src-antlr/src-parser/Pl1Lexer.g4:/src-antlr/src-parser/Pl1Lexer.g4 \
  -v $PWD/src-antlr/src-parser/Pl1Parser.g4:/src-antlr/src-parser/Pl1Parser.g4 \
  itsme/gccpl1x