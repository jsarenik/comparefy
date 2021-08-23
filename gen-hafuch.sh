#!/bin/sh

a="/$0"; a=${a%/*}; a=${a:-.}; a=${a#/}/; BINDIR=$(cd "$a" || exit; pwd)
cd "$BINDIR" || exit

printf "Generating inline hafuch.html... "
{
cat html/hafuch/00*
cat datapoints-eth | ./hafuch.sh
cat html/hafuch/99*
} > public/hafuch.html \
  && echo OK
