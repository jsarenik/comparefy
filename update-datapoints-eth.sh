#!/bin/sh

a="/$0"; a=${a%/*}; a=${a:-.}; a=${a#/}/; BINDIR=$(cd $a; pwd)
cd $BINDIR
last=$(tail -1 datapoints-eth | grep -Eo '[0-9]+\-[0-9]{2}\-[0-9]{2}')
start=2015-08-09
cont=$(date -d "$last + 1 day" +%Y-%m-%d)
today=$(date +%Y-%m-%d)
TMP=$(mktemp)

test "$last" = "$today" && exit

fresh() {
cat > datapoints-eth << EOF
2015-07-30, 0.000001
2015-08-08, 0.000001
EOF
}

wget -q -O - "https://production.api.coindesk.com/v2/price/values/ETH?start_date=${start}T00:00&end_date=${today}T00:00&ohlc=false" > $TMP

echo "Updating datapoints-eth..."
index=0
{ jq -r '.data.entries[]' $TMP \
  | tr -d '\n' \
  | tr '\[' '\n' \
  | tr -d '[,\]]'; } | cut -b3-12,17-| sed 1d | while read ts price
do
  date=$(date +%Y-%m-%d -d "@$ts")
  printf "%s, %.6f\n" $date $price
done | grep . > /tmp/datapoints-eth-$$ && echo ...datapoints-eth update done. || EXIT=1

sed -n "/^$cont.*/,\$p" /tmp/datapoints-eth-$$ >> datapoints-eth
rm /tmp/datapoints-eth-$$
rm $TMP
test "$EXIT" = "1" && { echo No new data found. Exiting.; exit 1; }
