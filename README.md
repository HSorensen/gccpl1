# PL/I Compiler Project
GCC Frontend for the PL1 language

## Quick Steps to getting Started

- git clone https://github.com/HSorensen/gccpl1 gccpl1
- git .. submodules ...
- build all ...


## Project Structure

The gcc pl/I compiler consists of a number of depending projects.

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
|— antlr-tool
    |— gitmodule  https://github.com/HSorensen/antlr4 branch lexerinclude
    |— Build system: maven
|— antlr-pl1-parser
    |— gitmodule https://github.com/HSorensen/gccpl1 (rename to antlr-pl1-parser??)
    |— Build system: cmake, make
|— gcc-project
    |— gitmodule https://github.com/HSorensen/gcc branch tbd
    |— Build system: configure, make
```

# Project Setup

## Initial setup

If you checkout the repository from github this step is not needed since the submodule definition is already committed.

- Add gcc github repository as submodule

```shell
git submodule add https://github.com/HSorensen/gcc.git src-gcc
```