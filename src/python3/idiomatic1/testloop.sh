#!/bin/bash

while python perftest.py >> results.jsonl; do
  # Analyze results
  echo "$(wc -l < results.jsonl) results"
  for num_bytes in 10 100 1000 10000 100000 1000000; do
    for buffer_size in 1000 10000 100000 1000000; do
        select_record="select(.buffer_size==$buffer_size and .num_bytes==$num_bytes)"
        jq_avg='add / length | . + .5 | floor'
        avg=$(jq -c -s "[ .[] | ${select_record}] | [.[] | .kB_sec] | $jq_avg" results.jsonl)
        echo -n '{ "num_bytes":' ${num_bytes}, 
        echo -n '"buffer size":' ${buffer_size}, 
        echo  '"average_kB_sec":' "${avg}" ' }'
    done
  done | jq -s -c 'sort_by(-.average_kB_sec) | .[0:5] | .[]'
done

