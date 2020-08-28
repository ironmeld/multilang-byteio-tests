from byteio import byteio
import datetime
import io
import os
import platform
import time


cloud_name = os.environ.get("CLOUD_NAME", "unknown")
instance_type = os.environ.get("CLOUD_INSTANCE_TYPE", "unknown")
num_iters = 1000


def run_tests():
    buffer_size = 10000
    # repeat 3 times, multiplying size by 10
    for _ in range(1, 3 + 1):
        run_buffer_size_tests(buffer_size)
        buffer_size *= 10


def run_buffer_size_tests(buffer_size):

    for bytes_per_iter in (100, 2000, 10000, 100000, 1000000):

        # we do not need to test buffers that are too large
        # for the test anyway. tests with smaller buffers are
        # sufficient.
        if buffer_size > bytes_per_iter:
            continue

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

        print('{ "test_type": "copy"', end='')
        print(', "language": "python"', end='')
        print(f', "python_version": "{platform.python_version()}"', end='')

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
        print(' }')


if __name__ == "__main__":
    run_tests()
