# https://github.com/chehsunliu/nand2tetris
import subprocess
import sys


if __name__ == "__main__":
    subprocess.call(["./nand2tetris-linux.exe", "vm-translator", "--input-path", sys.argv[1]])
