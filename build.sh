#!/bin/sh
IMAGENAME=itsme/gccpl1y

# Check src-gcc is properly updated
if [ ! -d "src-gcc/gcc" ]; then
  echo "Missing src-gcc/gcc submodule folder. Maybe update the submodule:"
  echo "git config pull.rebase false"
  echo "git submodule init"
  echo "git submodule update --progress"
  exit 8;
fi

docker build -f _docker/dockerfile -t $IMAGENAME .
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
  # -v $PWD/src-gcc-gpli:/src-gcc/gcc/gpli 

full=""

if [ "$full" -eq "" ]; then
docker run --rm --hostname gccpli -it -v $PWD/workdir:/workdir -v $PWD/src-gcc-gpli:/src-gcc/gcc/gpli itsme/gccpl1y
else
docker run --rm --hostname gccpli -it -v $PWD/workdir:/workdir \
  -v $PWD/src-antlr/src-parser/cmake:/src-antlr/src-parser/cmake \
  -v $PWD/src-antlr/src-parser/CMakeLists.txt:/src-antlr/src-parser/CMakeLists.txt \
  -v $PWD/src-antlr/src-parser/main.cpp:/src-antlr/src-parser/main.cpp \
  -v $PWD/src-antlr/src-parser/Pl1Lexer.g4:/src-antlr/src-parser/Pl1Lexer.g4 \
  -v $PWD/src-antlr/src-parser/Pl1Parser.g4:/src-antlr/src-parser/Pl1Parser.g4 \
  -v $PWD/src-antlr/src-parser/src-tests:/src-antlr/src-parser/src-tests \
  -v $PWD/src-gcc/gcc:/src-gcc/gcc \
  -v $PWD/src-gcc-gpli:/src-gcc/gcc/gpli \
  -v $PWD/src-gcc-tiny:/src-gcc/gcc/tiny \
  $IMAGENAME
fi