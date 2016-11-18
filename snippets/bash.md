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

## Similar Days of Week and Days of the Month

```
awk 'BEGIN{cmd = "date \"+%w-%d\"" | getline d; close(cmd); match(d, /(.+)-(.+)/, arg)}
  {for (i=arg[1]+1; i<=21; i+=7) if ($i ~ arg[2]) c+=1}
  END{printf "The number of %dth days of the week that occur on the %dth day of the month this year is %d.\n", arg[1]+1, arg[2], c}' <<<$(cal -y)
```
