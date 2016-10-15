## Binning files in directories

```
for bin in $(seq 1 8);
  do for file in $(ls url_counts | head -n311);
    do mv url_counts/$file bins/$bin/;
  done;
done
```

## AWK Histogram

```
awk '{print $9}' listing.txt| awk 'BEGIN{FS="."} {timeslice[$2]++} END {for(k in timeslice) print k,timeslice[k]}' |
awk '{printf $0; for(i=0; i<=$2; ++i) printf "-"; printf "\n"}' |
sort | less
```
