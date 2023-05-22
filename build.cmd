@echo off
REM Create Docker image for gccpli compiler
REM 
set IMAGENAME=itsme/gccpl1y

REM Check src-gcc is properly updated
if not exist "src-gcc\gcc\" (
  echo "Missing src-gcc/gcc submodule folder. Maybe update the submodule:"
  echo "git config pull.rebase false"
  echo "git submodule init"
  echo "git submodule update --progress"
  exit /b 8
)

docker build -f _docker/dockerfile -t  %IMAGENAME% .
IF %ERRORLEVEL% NEQ 0 (
 echo "docker build failed. Check setup"; 
 exit /b 8; 
)

::#docker run --rm --hostname gccpli -it -v $PWD/workdir:/workdir \
::#  -v $PWD/src-antlr/src-parser/main.cpp:/src-antlr/src-parser/main.cpp \
::#  -v $PWD/src-antlr/src-parser/Pl1Lexer.g4:/src-antlr/src-parser/Pl1Lexer.g4 \
::#  -v $PWD/src-antlr/src-parser/Pl1Parser.g4:/src-antlr/src-parser/Pl1Parser.g4 \
::#  -v $PWD/src-antlr/src-parser/CMakeLists.txt:/src-antlr/src-parser/CMakeLists.txt \
::#  itsme/gccpl1x

::  # -v $PWD/src-gcc:/src-gcc \
::  # -v $PWD/src-gcc-gpli:/src-gcc/gcc/gpli 

::full=""

::if [ "$full" -eq "" ]; then
docker run --rm --hostname gccpli -it -v %CD%\workdir:/workdir -v %CD%\src-gcc-gpli:/src-gcc/gcc/gpli %IMAGENAME%
::else
::docker run --rm --hostname gccpli -it -v $PWD/workdir:/workdir \
::  -v $PWD/src-antlr/src-parser/cmake:/src-antlr/src-parser/cmake \
::  -v $PWD/src-antlr/src-parser/CMakeLists.txt:/src-antlr/src-parser/CMakeLists.txt \
::  -v $PWD/src-antlr/src-parser/main.cpp:/src-antlr/src-parser/main.cpp \
::  -v $PWD/src-antlr/src-parser/Pl1Lexer.g4:/src-antlr/src-parser/Pl1Lexer.g4 \
::  -v $PWD/src-antlr/src-parser/Pl1Parser.g4:/src-antlr/src-parser/Pl1Parser.g4 \
::  -v $PWD/src-antlr/src-parser/src-tests:/src-antlr/src-parser/src-tests \
::  -v $PWD/src-gcc/gcc:/src-gcc/gcc \
::  -v $PWD/src-gcc-gpli:/src-gcc/gcc/gpli \
::  -v $PWD/src-gcc-tiny:/src-gcc/gcc/tiny \
::  $IMAGENAME
::fi