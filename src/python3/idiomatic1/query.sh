#!/bin/bash
#
# usage:
# ./query.sh {query name}
# example:
# ./query.sh top5
query() {
    case "$1" in
        "top1")
            jq -s 'sort_by(-.MB_sec) | .[0:1] | .[]' results.jsonl
        ;;
        "top5")
            jq -s -c 'sort_by(-.MB_sec) | .[0:5] | .[]' results.jsonl  
        ;;
        "bottom1")
            jq -s 'sort_by(.MB_sec) | .[0:1] | .[]' results.jsonl  
        ;;
        "bottom5")
            jq -s -c 'sort_by(.MB_sec) | .[0:5] | .[]' results.jsonl  
        ;;

        *)
            echo "Valid queries:"
            echo "top5"
            echo
            echo "Example:"
            echo "$ ./query.sh top5"
        ;;
    esac
}

query "$@"
