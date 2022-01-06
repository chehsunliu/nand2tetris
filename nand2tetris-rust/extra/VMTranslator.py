import subprocess
import sys


# The source code is on GitHub: https://github.com/chehsunliu/nand2tetris/nand2tetris-rust.
if __name__ == "__main__":
    subprocess.call(["./nand2tetris-rust", "vm-translator", "--input-path", sys.argv[1]])
