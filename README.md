# [cfy.anyone.eu.org](https://cfy.anyone.eu.org)
The most comprehensive all-time Ethereum price history chart.

Forked from
[price.bublina.eu.org](https://github.com/jsarenik/price.bublina.eu.org)
so that everyone can ask themselves some questions. Think for yourself.

## Requirements

 * [jq](https://stedolan.github.io/jq/)
 * coreutils and bash will do,
   but [busybox](https://busybox.net/) is enough

## How it works

The script `./update-datapoints.sh` updates `datapoints` for
Bitcoin (used on Compare For Yourself chart). `./update-datapoints-eth.sh`
does the same for Ether and should be run before anything else
in order to use the current data.


`./gen-inline.sh` generates a static `public/index.html`
file which contains all the space-efficient CSV values
inside itself.

`./gen-hafuch.sh` generates the reversed chart which shows
how much BTC can be bought by USD.
