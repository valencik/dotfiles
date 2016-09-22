## Binning files in directories

```
for bin in $(seq 1 8);
  do for file in $(ls url_counts | head -n311);
    do mv url_counts/$file bins/$bin/;
  done;
done
```
