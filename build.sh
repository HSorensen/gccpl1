#!/bin/sh

docker build -f _docker/dockerfile -t itsme/gccpl1 .
if [ $? -ne 0 ]; then
 echo "docker build failed. Check setup"; exit 8; 
fi

#docker run --rm --hostname gccpli -it -v $PWD/workdir:/workdir \
#  -v $PWD/src-antlr/src-parser/main.cpp:/src-antlr/src-parser/main.cpp \
#  -v $PWD/src-antlr/src-parser/Pl1Lexer.g4:/src-antlr/src-parser/Pl1Lexer.g4 \
#  -v $PWD/src-antlr/src-parser/Pl1Parser.g4:/src-antlr/src-parser/Pl1Parser.g4 \
#  -v $PWD/src-antlr/src-parser/CMakeLists.txt:/src-antlr/src-parser/CMakeLists.txt \
#  itsme/gccpl1x

  # -v $PWD/src-gcc:/src-gcc \
  # -v $PWD/src-gcc-gpli:/src-gcc/gcc/gpli \

docker run --rm --hostname gccpli -it -v $PWD/workdir:/workdir -v $PWD/src-gcc/gcc:/src-gcc/gcc -v $PWD/src-gcc-gpli:/src-gcc/gcc/gpli -v $PWD/src-gcc-tiny:/src-gcc/gcc/tiny itsme/gccpl1
