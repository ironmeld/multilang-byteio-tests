# perftest.py
Runs a performance test run of byteio.byteio.copy()
A test run may produce multiple results for tests with different parameters.

Results are placed in results.jsonl. The format is lines of json.

Set CLOUD_NAME and CLOUD_INSTANCE_TYPE to record these, as
"cloud_name" and "cloud_instance_type" respectively, in the json.

# jq query
Use can use jq to query the results. The following is a mini tutorial on jq.

Example: top 5 fastest results for 10000 bytes
$ jq -s -c '[ .[] | select(.num_bytes==10000)] | sort_by(-.kB_sec) | .[0:5] | .[]' results.jsonl

Note:
The -s converts multiline input of values into an array of those values
The -c option outputs in compact format.

There is a subtle issue in the query that begs for an explanation. It is helpful
to understand the distinction between this expression:

[ .[] | select(.num_bytes==10000)]

and this:

.[] | [select(.num_bytes==10000)]


The first query filters each array element against the select expression and aggregates the overall results into a new array
Note that if select does not succeed then a new element is not added to the new array.

The second query takes each array element and outputs the expression.

The following is a longer explanation of this issues.

jq can process BOTH lines of values and a single json value. It is helpful to understand how
these different inputs are processed by the iterator operator:
.[]

When an input line is a json array then .[] iteratively outputs each element separately (on its own line).
When an input line is any other type of json value, then .[] throws an error.
When the input is a series of lines, then each line is sent through .[] one after the other.


$ echo '[1,2]' | jq '.[]'
1
2

$ echo -e '[1,2]\n[3,4]' | jq '.[]'
1
2
3
4


Besides the .[] iterator, the following syntax is useful:

[ lines-expression ] -  create an array that aggregates the elements computed (which might be empty)
for each line resulting from the lines-expression.

Examples:

$ echo '[1,2,3]' | jq -c '[.]'
[[1,2,3]]

$ echo -e '1\n2\n3' | jq -c '[select(. == 2)]'
[]
[2]
[]

$ echo -e '1\n2\n3' | jq -c '[select(. == 2)]'
[]
[2]
[]

$ echo -e '[1,2,3]' | jq -c '[ .[] | select(. == 2)]'
[2]


$ echo -e '1\n2\n3' | jq -c '[inputs] | [ .[] | select(. == 2)]'
[2]


jq -s (slurp) can convert the input to an array for you:

$ echo -e '1\n2\n3' | jq -c -s '[ .[] | select(. == 2)]'
[2]
