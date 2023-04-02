#!/bin/sh

docker build -f _docker/dockerfile -t itsme/gccpl1x .

docker run --rm --hostname gccpli -it -v $PWD/workdir:/workdir itsme/gccpl1x