import os
import subprocess
import sys


# The source code is on GitHub: https://github.com/chehsunliu/nand2tetris/nand2tetris-rust.
if __name__ == "__main__":
    input_path = sys.argv[1]

    if os.path.isdir(input_path):
        output_path = input_path
    else:
        output_path = os.path.dirname(input_path)

    subprocess.call(
        [
            "./nand2tetris-rust",
            "jack-analyzer",
            "--input-path", input_path,
            "--output-directory", output_path,
        ]
    )
