#!/usr/bin/env bash

set -Eeuo pipefail

script_dir=$(cd "$(dirname "${BASH_SOURCE[0]}")" &>/dev/null && pwd -P)

# ------------------------------------------------------

build_dir="$script_dir/../target/debug"
tool_dir="$script_dir/../../tools"
PATH="$build_dir:$tool_dir:$PATH"

project_dir="$script_dir/../../projects/08"

nand2tetris-rust vm-translator --input-path $project_dir/ProgramFlow/BasicLoop/BasicLoop.vm
CPUEmulator.sh $project_dir/ProgramFlow/BasicLoop/BasicLoop.tst

nand2tetris-rust vm-translator --input-path $project_dir/ProgramFlow/FibonacciSeries/FibonacciSeries.vm
CPUEmulator.sh $project_dir/ProgramFlow/FibonacciSeries/FibonacciSeries.tst

nand2tetris-rust vm-translator --input-path $project_dir/FunctionCalls/SimpleFunction/SimpleFunction.vm
CPUEmulator.sh $project_dir/FunctionCalls/SimpleFunction/SimpleFunction.tst

nand2tetris-rust vm-translator --input-path $project_dir/FunctionCalls/FibonacciElement
CPUEmulator.sh $project_dir/FunctionCalls/FibonacciElement/FibonacciElement.tst

nand2tetris-rust vm-translator --input-path $project_dir/FunctionCalls/StaticsTest
CPUEmulator.sh $project_dir/FunctionCalls/StaticsTest/StaticsTest.tst

nand2tetris-rust vm-translator --input-path $project_dir/FunctionCalls/NestedCall
CPUEmulator.sh $project_dir/FunctionCalls/NestedCall/NestedCall.tst
