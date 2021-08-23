#!/bin/sh

a="/$0"; a=${a%/*}; a=${a:-.}; a=${a#/}/; BINDIR=$(cd "$a" || exit; pwd)
cd "$BINDIR" || exit

VARIANT=${1:-"yearly"}
test -d html/$VARIANT || exit 1
printf "Generating inline $VARIANT.html... "
{
cat html/$VARIANT/00*
"./gen-datapoints-$VARIANT.sh" | ./mkcsv-inline.sh
cat html/$VARIANT/99*
} > public/$VARIANT.html \
  && echo OK
