#!/bin/sh

type bc >/dev/null 2>&1 && BC=bc || {
  test -x $PWD/usr/bin/bc || {
    wget --quiet \
      http://mirrors.kernel.org/ubuntu/pool/main/b/bc/bc_1.07.1-2build1_amd64.deb
    ar x bc_*.deb
    tar xf data.tar.xz ./usr/bin/bc
  }
  echo Using my bc
  BC="$PWD/usr/bin/bc"
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
