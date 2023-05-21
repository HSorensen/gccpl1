# PL/I Compiler Project
GCC Frontend for the PL1 language

Inspired by [Think In Geek's Tiny](https://thinkingeek.com/gcc-tiny/)

## Quick Steps to getting Started

- ```git clone --recurse-submodules  https://github.com/HSorensen/gccpl1 gccpl1```
- ```sh build.sh```

If you cloned the gccpl1 project without the ```---recurse-submodules``` option, do this:

- ```git submodule init```
- ```git submodule update --progress```
- ```sh build.sh```

## Project Structure

The gcc pl/1 compiler consists of a number of depending projects.

- Antlr Tool project
    - https://github.com/antlr/antlr4
- Antlr Tool extension for handling include
    - https://github.com/HSorensen/antlr4
- Antlr C++ runtime for lexer, parser, tree walkers
    - https://github.com/HSorensen/gccpl1
- GCC Source code project with gpli compiler
    - https://github.com/HSorensen/gcc


Creation of the gpli compiler will be following along with the Tiny gcc frontend by Roger Ferrer Ibáñez 

[Read more about Tiny frontend](docs/README.md)

Project GIT Module Structure

Gcc-pl1-compiler-project
```
gccpl1
|— git repo https://github.com/HSorensen/gccpl1 
|— src-antlr-tool (tbd)
    |— gitmodule  https://github.com/HSorensen/antlr4 branch lexerinclude
    |— Build system: maven
|— gcc project
    |— gitmodule https://github.com/HSorensen/gcc branch tbd
    |— Build system: configure, make
```

Project folder structure
```
gccpl1
|— _docker
|- docs
|— src-antlr
|— src-gcc
|- src-gcc-gpli
|- src-gcc-tiny
```

## Project compilation

The gpli compiler is built using docker.

To start the build 
```
sh build.sh
```

**Note:** This build can take several hours, so grab one of your favorite brewerages, or even better go get some fresh air.

Once the docker image is built, you can start the image and mount the ```src-gcc-gpli``` folder onto ```/src-gcc/gcc/gpli``` this way you can change the compiler outside the docker image while keeping the already built gcc project.

For example:

```
docker run --rm --hostname gccpli -it -v $PWD/workdir:/workdir -v $PWD/src-gcc/gcc:/src-gcc/gcc -v $PWD/src-gcc-gpli:/src-gcc/gcc/gpli -v $PWD/src-gcc-tiny:/src-gcc/gcc/tiny itsme/gccpl1
```
Note: In this example the gcc, gpli and tiny folders are also mounted.

# Project Setup

## Initial setup

If you checkout the repository from github this step is not needed since the submodule definition is already committed.

- Add gcc github repository as submodule

```shell
git submodule add https://github.com/HSorensen/gcc.git src-gcc
```