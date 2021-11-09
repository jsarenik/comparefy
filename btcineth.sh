#!/bin/sh

type bc >/dev/null 2>&1 && BC=bc || {
  test -x $PWD/bc || {
    wget --quiet \
      https://bublina.eu.org/misc/bc
    chmod a+x bc
  }
  echo Using my bc
  BC="$PWD/bc"
}

ethstart=$(grep -vm1 "0.000001$" datapoints-eth | cut -d, -f1)
btcstart=$(grep -n "$ethstart" datapoints | cut -d: -f1)

cat datapoints-eth | grep -v "0.000001$" | ./mkcsv.sh > /tmp/eth-datapoints
cat datapoints | ./mkcsv.sh | sed -n "$btcstart,$ p" > /tmp/bitcoin-datapoints
{
echo "scale=8"
join -a1 -t"," /tmp/bitcoin-datapoints /tmp/eth-datapoints \
  | grep -Ev "^[0-9]{4}\-[0-9]{2}\-[0-9]{2},[0-9]+\.[0-9]+$" \
  | sed 's/^/print "/;s/\-[0-9][0-9],/&",/;s/\([0-9]\+\.[0-9]\+\),\([0-9]\+\.[0-9]\+\)/\1\/\2,"\n"/;s/,[0-9]\+\.[0-9]\+$/,/'
} | $BC
