# multilang-byteio-tests
Tests for Byte I/O code for various languages

# Status
This project is in development. Expect minimal or no support.

# Install dependencies for Centos 8 scratch install
```
$ sudo dnf install git make python3
```

# If you want to query with jq:
```
$ sudo dnf install jq
```

# Checkout and run
Replace repo below.
```
$ git clone $repo/multilang-byteio-tests 
$ cd multilang-byteio-tests/src
$ make install-dependencies-internal
$ export CLOUD_NAME="aws"
$ export CLOUD_INSTANCE_TYPE="m4.large"
$ make
```

# Results

Results are in json lines (jsonlines.org).

```
$ make list-results
./python3/idiomatic1/results.jsonl
$ cat ./python3/idiomatic1/results.jsonl 
{ "test_type": "copy", "language": "python", "python_version": "3.6.9", "buffer_size": 10000, "bytes_per_iter": 10000, "num_iters": 1000, "total_bytes": 10000000, "time_us": 9001, "MB_sec": 1110, "epoch_secs": "1598216487.0729067", "timestamp": "2020-08-23T21:01:27.072907", "cloud_name": "aws", "instance_type": "m4.large" }
{ "test_type": "copy", "language": "python", "python_version": "3.6.9", "buffer_size": 10000, "bytes_per_iter": 100000, "num_iters": 1000, "total_bytes": 100000000, "time_us": 90396, "MB_sec": 1106, "epoch_secs": "1598216487.0820417", "timestamp": "2020-08-23T21:01:27.082042", "cloud_name": "aws", "instance_type": "m4.large" }
{ "test_type": "copy", "language": "python", "python_version": "3.6.9", "buffer_size": 10000, "bytes_per_iter": 1000000, "num_iters": 1000, "total_bytes": 1000000000, "time_us": 903121, "MB_sec": 1107, "epoch_secs": "1598216487.1728005", "timestamp": "2020-08-23T21:01:27.172801", "cloud_name": "aws", "instance_type": "m4.large" }
{ "test_type": "copy", "language": "python", "python_version": "3.6.9", "buffer_size": 100000, "bytes_per_iter": 100000, "num_iters": 1000, "total_bytes": 100000000, "time_us": 91960, "MB_sec": 1087, "epoch_secs": "1598216488.0798693", "timestamp": "2020-08-23T21:01:28.079869", "cloud_name": "aws", "instance_type": "m4.large" }
{ "test_type": "copy", "language": "python", "python_version": "3.6.9", "buffer_size": 100000, "bytes_per_iter": 1000000, "num_iters": 1000, "total_bytes": 1000000000, "time_us": 919511, "MB_sec": 1087, "epoch_secs": "1598216488.1719751", "timestamp": "2020-08-23T21:01:28.171975", "cloud_name": "aws", "instance_type": "m4.large" }
{ "test_type": "copy", "language": "python", "python_version": "3.6.9", "buffer_size": 1000000, "bytes_per_iter": 1000000, "num_iters": 1000, "total_bytes": 1000000000, "time_us": 930443, "MB_sec": 1074, "epoch_secs": "1598216489.0953076", "timestamp": "2020-08-23T21:01:29.095308", "cloud_name": "aws", "instance_type": "m4.large" }
```

# Query top results for python3
Results are in json lines (jsonlines.org).

```
$ cd python3/idiomatic1
$ ./query.sh top1
{
  "test_type": "copy",
  "language": "python",
  "python_version": "3.6.8",
  "buffer_size": 1000000,
  "bytes_per_iter": 1000000,
  "num_iters": 1000,
  "total_bytes": 1000000000,
  "time_us": 1136123,
  "MB_sec": 880,
  "epoch_secs": "1598209859.2708375",
  "timestamp": "2020-08-23T19:10:59.270838",
  "cloud_name": "aws",
  "instance_type": "m4.large"
}
```
