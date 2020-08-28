#!/bin/bash
analyze() {

  # Analyze results
  echo "$(wc -l < results.jsonl) results"

  # headers across top
  printf "%9s%s\n%9s" "" "buffer size ->" "bytes vvv"

  for buffer_size in 10000 100000 1000000 10000000; do
    printf "%9d" "$buffer_size"
  done
  printf "\n"

  for num_bytes in 100 2000 10000 100000 1000000 10000000; do
    printf "%9d" "$num_bytes"
    for buffer_size in 10000 100000 1000000 10000000; do
        if [ $buffer_size -gt $num_bytes ]; then
            continue
        fi

        select_record="select(.buffer_size==$buffer_size and .bytes_per_iter==$num_bytes)"
        jq_avg='add / length | . + .5 | floor'
        avg=$(jq -c -s "[ .[] | ${select_record}] | [.[] | .MB_sec] | $jq_avg" results.jsonl 2> /dev/null)

        printf "%9d" "$avg"
    done
    printf "\n"
  done
}

analyze
echo -n 'press return to start: '
read input
while python3 perftest.py >> results.jsonl; do
  analyze
done
