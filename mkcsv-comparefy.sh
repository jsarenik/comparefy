#!/bin/sh

a="/$0"; a=${a%/*}; a=${a:-.}; a=${a#/}/; BINDIR=$(cd "$a" || exit; pwd)
cd "$BINDIR" || exit

#cat datapoints-eth | cut -d, -f1-2 > data2-tmp
cat datapoints | tr -d '[a-zA-Z"\[()\]' | cut -d, -f1-2 | cut -b2- \
  | join -a1 -t"," - datapoints-eth \
  | sed '/[0-9]\+-[0-9]\+-[0-9]\+, [0-9\.]\+$/s/$/,/'
