import io
from byteio import byteio
import platform
from time import perf_counter

def run_tests():
    buffer_size = 1000
    # repeat 7 times, multiplying size by 10
    for _ in range(1, 8 + 1):
        run_buffer_size_tests(buffer_size)
        buffer_size *= 10

def run_buffer_size_tests(buffer_size):
    input_bytes = "1" * 10

    # repeat 8 times, multiplying size by 10
    for _ in range(1, 8 + 1):
        num_bytes = len(input_bytes)

        input_byte_stream = io.StringIO(input_bytes)
        output_byte_stream = io.StringIO()

        start = perf_counter()
        for _ in range(1, 10 + 1):
             input_byte_stream.seek(0)
             output_byte_stream.seek(0)
             byteio.copy(input_byte_stream, output_byte_stream, buffer_size)
        """
        """
        stop = perf_counter()

        # rounded duration in microseconds (us)
        time_us = int( (stop - start) * 1000000)
        kB_sec = int((num_bytes / (stop - start)) / 1000)

        print('{ "test_name": "copy"', end='')
        print(', "language": "python"', end='')
        print(', "python": "cpython"', end='')
        print(f', "python_version": "{platform.python_version()}"', end='')

        print(f', "buffer_size": {buffer_size}', end='')
        print(f', "num_bytes": {num_bytes}', end='')
        print(f', "time_us": {time_us}', end='')
        # kilobyte = 1000 bytes
        print(f', "kB_sec": {kB_sec}', end='')
        print(' }')
        input_bytes *= 10


if __name__ == "__main__":
    run_tests()
