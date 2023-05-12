# minimum required CMAKE version
CMAKE_MINIMUM_REQUIRED(VERSION 3.7 FATAL_ERROR)
set( CMAKE_BUILD_TYPE Debug )
set(THREADS_PREFER_PTHREAD_FLAG ON)
find_package(Threads REQUIRED)


list(APPEND CMAKE_MODULE_PATH ${CMAKE_CURRENT_SOURCE_DIR}/cmake)

# compiler must be 17
set(CMAKE_CXX_STANDARD 17)

# required if linking to static library
add_definitions(-DANTLR4CPP_STATIC)

# using /MD flag for antlr4_runtime (for Visual C++ compilers only)
set(ANTLR4_WITH_STATIC_CRT OFF)

# Specify the version of the antlr4 library needed for this project.
# By default the latest version of antlr4 will be used.  You can specify a
# specific, stable version by setting a repository tag value or a link
# to a zip file containing the libary source.
# set(ANTLR4_TAG 4.10.1)
# set(ANTLR4_ZIP_REPOSITORY https://github.com/antlr/antlr4/archive/refs/tags/4.10.1.zip)

# add external build for antlrcpp
include(ExternalAntlr4Cpp)
# add antrl4cpp artifacts to project environment
include_directories(${ANTLR4_INCLUDE_DIRS})

# set variable pointing to the antlr tool that supports C++
# this is not required if the jar file can be found under PATH environment
# set(ANTLR_EXECUTABLE /home/user/antlr-4.10.1-complete.jar)
# set(ANTLR_EXECUTABLE /usr/local/lib/antlr4-4.10.2-SNAPSHOT-complete.jar)
set(ANTLR_EXECUTABLE /usr/local/lib/antlr4-4.12.1-SNAPSHOT-complete.jar)
# add macros to generate ANTLR Cpp code from grammar
find_package(ANTLR REQUIRED)

# Call macro to add lexer and grammar to your build dependencies.
antlr_target(GnuPl1Lexer Pl1Lexer.g4 LEXER
             PACKAGE antlrcpptest)
antlr_target(GnuPl1Parser Pl1Parser.g4 PARSER
             PACKAGE antlrcpptest
             DEPENDS_ANTLR GnuPl1Lexer
             COMPILE_FLAGS -lib ${ANTLR_GnuPl1Lexer_OUTPUT_DIR})

# include generated files in project environment
include_directories(${ANTLR_GnuPl1Lexer_OUTPUT_DIR})
include_directories(${ANTLR_GnuPl1Parser_OUTPUT_DIR})

# add generated grammar to gpli binary target
add_executable(gpli main.cpp
               ${ANTLR_GnuPl1Lexer_CXX_OUTPUTS}
               ${ANTLR_GnuPl1Parser_CXX_OUTPUTS})
set_property(TARGET gpli PROPERTY COMPILE_OPTIONS "-pthread")
target_link_libraries(gpli antlr4_static pthread )
# To avoid runtime error (https://stackoverflow.com/questions/19463602/compiling-multithread-code-with-g)
#    and   -       -     (https://stackoverflow.com/questions/51584960/stdcall-once-throws-stdsystem-error-unknown-error-1)
target_link_options(gpli PUBLIC "-Wl,--no-as-needed")
#target_link_libraries(gpli antlr4_static PUBLIC Threads::Threads)
install(TARGETS gpli RUNTIME)


# -----------------------
# Create libglibantlr.so
# -----------------------


add_library(gpliantlr 
               ${ANTLR_GnuPl1Lexer_CXX_OUTPUTS}
               ${ANTLR_GnuPl1Parser_CXX_OUTPUTS}
)

target_link_libraries(gpliantlr antlr4_static)

# Headers
# Note dest is /usr/local/include/antlr/src/
install( 
   DIRECTORY ${ANTLR4_INCLUDE_DIRS} DESTINATION include/antlr FILES_MATCHING PATTERN "*.h"
    )
# Note dest is /usr/local/include/antlr/Pl1Parser/
install( 
   DIRECTORY ${ANTLR_GnuPl1Parser_OUTPUT_DIR} DESTINATION include/antlr FILES_MATCHING PATTERN "Pl1Parser.h"
    )
# Note dest is /usr/local/include/antlr/Pl1Lexer/
install( 
   DIRECTORY ${ANTLR_GnuPl1Lexer_OUTPUT_DIR} DESTINATION include/antlr FILES_MATCHING PATTERN "Pl1Lexer.h"
    )

install(TARGETS gpliantlr
   LIBRARY
)

