#!/bin/sh

#GCCPLIBIN=../../run/usr/local/share/antlr4-demo
#GCCPLIBIN=../../buildfolder/demo
GCCPLIBIN=gpli

for  f in *.pl1; do

  echo $f 
  $GCCPLIBIN $f

  rc=$?
  echo "$f: $rc" >&2

done;

