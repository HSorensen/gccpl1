#!/bin/sh

GCCPLIBIN=../../run/usr/local/share/antlr4-demo

for  f in *.pl1; do

  echo $f 
  echo "$f" >&2
  $GCCPLIBIN $f

  rc=$@

done;

