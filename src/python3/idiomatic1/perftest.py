from byteio import byteio
import datetime
import io
import os
import platform
import time


cloud_name = os.environ.get("CLOUD_NAME", "unknown")
instance_type = os.environ.get("CLOUD_INSTANCE_TYPE", "unknown")
try:
    with open('/etc/centos-release', 'r') as file:
        distro = file.read().replace('\n', '')
except Exception:
    distro = "unknown"

num_iters = 10000


def run_tests():
    for buffer_size in (10000, 100000, 1000000):
        run_buffer_size_tests(buffer_size)


def run_buffer_size_tests(buffer_size):

    for bytes_per_iter in (100, 2000, 10000, 100000, 1000000):
        epoch_secs = time.time()
        timestamp = datetime.datetime.utcfromtimestamp(epoch_secs).isoformat()

        input_bytes = b"1" * bytes_per_iter

        input_byte_stream = io.BytesIO(input_bytes)
        output_byte_stream = io.BytesIO()

        start = time.perf_counter()
        for _ in range(1, num_iters + 1):
            input_byte_stream.seek(0)
            output_byte_stream.seek(0)
            byteio.copy(input_byte_stream, output_byte_stream, buffer_size)
        stop = time.perf_counter()

        # rounded duration in microseconds (us)
        total_bytes_all_iters = bytes_per_iter * num_iters
        time_us = int((stop - start) * 1000000)
        MB_sec = int((total_bytes_all_iters / (stop - start)) / 1000000)

        print('{"operation": "copy"', end='')
        print(', "interface": "lib"', end='')
        print(', "input_paradigm": "stream"', end='')
        print(', "input_type": "bytes"', end='')
        print(', "output_paradigm": "stream"', end='')
        print(', "output_type": "bytes"', end='')
        print(', "language": "python3"', end='')
        print(f', "python3_version": "{platform.python_version()}"', end='')
        print(f', "distro": "{distro}"', end='')

        print(f', "buffer_size": {buffer_size}', end='')
        print(f', "bytes_per_iter": {bytes_per_iter}', end='')
        print(f', "num_iters": {num_iters}', end='')
        print(f', "total_bytes": {total_bytes_all_iters}', end='')
        print(f', "time_us": {time_us}', end='')
        # MB = 1000000 bytes
        print(f', "MB_sec": {MB_sec}', end='')
        print(f', "epoch_secs": "{epoch_secs}"', end='')
        print(f', "timestamp": "{timestamp}"', end='')
        print(f', "cloud_name": "{cloud_name}"', end='')
        print(f', "instance_type": "{instance_type}"', end='')
        print('}')


if __name__ == "__main__":
    run_tests()
