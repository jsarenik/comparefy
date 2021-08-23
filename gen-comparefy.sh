#!/bin/sh

a="/$0"; a=${a%/*}; a=${a:-.}; a=${a#/}/; BINDIR=$(cd "$a" || exit; pwd)
cd "$BINDIR" || exit

VARIANT=${1:-"comparefy"}
test -d html/$VARIANT || exit 1
printf "Generating inline $VARIANT.html... "
{
cat html/$VARIANT/00*
./mkcsv-inline-comparefy.sh
cat html/$VARIANT/99*
} | tee public/index.html > public/comparefy.html \
  && echo OK
