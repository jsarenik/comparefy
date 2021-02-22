# [price.bublina.eu.org](https://price.bublina.eu.org)
The most comprehensive all-time Bitcoin price history chart.

Originally from https://bitcoin.zorinaq.com/price/

Accessible via [Tor](https://torproject.org) from
http://yjeajli4dzdwm2lu32rkruj5safydu2utx22trkdszwulegookfvj3qd.onion/

## Requirements

 * [jq](https://stedolan.github.io/jq/)
 * coreutils and bash will do,
   but [busybox](https://busybox.net/) is enough
 * `update-ipfs.sh` script requires
   [dig](https://bind.isc.org/doc/arm/9.11/man.dig.html)
 * if used with IPSF, then [ipfs](https://dist.ipfs.io/#go-ipfs)
   needs to be installed and accessible in `PATH`.

## How it works

The script `./update.sh` generates a static `public/index.html`
file which resembles the original.

The script `./update-csv-inline.sh` is the latest addition.
It generates the `public/index.html` which is smaller compared
to the one generated using the original way.

To update IPFS, `./update-ipfs.sh` script can be used.

### IPFS deployment details

Just a note that current price.bublina.eu.org is implemented
thanks to Cloudflare's IPFS nodes, so the domain is `CNAME`d
to `cloudflare-ipfs.com` and the `TXT` record
`_dnslink.price.bublina.eu.org` is kept up to date by a cron job:

```
10 9 * * * $HOME/web/bitcoin.zorinaq.com/update-all.sh
```

The `node1`, `node2` and `node3` nodes are actually not Cloudflare,
they are my, slightly distributed nodes running IPFS daemon.
In `.ssh/config` they are set to real hostnames and it is easy to just
increment the counter. Anyone can set their own hosts running IPFS
daemon in SSH config file to match. Then set `update-ipfs.conf`
accordingly (if the number of your nodes varies).

Note that the `PATH` needs to be set properly so that both `jq`
and `ipfs` can be found.

On 2021-02-22 the Firewall → Tools → [_Bot Fight Mode_](https://www.cloudflare.com/products/bot-management)
feature of Cloudflare was turned off for domain bublina.eu.org.
