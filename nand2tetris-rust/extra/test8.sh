#!/usr/bin/env bash

set -Eeuo pipefail

script_dir=$(cd "$(dirname "${BASH_SOURCE[0]}")" &>/dev/null && pwd -P)

# ------------------------------------------------------

build_dir="$script_dir/../target/debug"
tool_dir="$script_dir/../../tools"
PATH="$build_dir:$tool_dir:$PATH"

project_dir="$script_dir/../../projects/08"

input_path=$project_dir/ProgramFlow/BasicLoop/BasicLoop.vm
echo "> $input_path"
nand2tetris-rust vm-translator --input-path $input_path
CPUEmulator.sh $project_dir/ProgramFlow/BasicLoop/BasicLoop.tst

input_path=$project_dir/ProgramFlow/FibonacciSeries/FibonacciSeries.vm
echo "> $input_path"
nand2tetris-rust vm-translator --input-path $input_path
CPUEmulator.sh $project_dir/ProgramFlow/FibonacciSeries/FibonacciSeries.tst

input_path=$project_dir/FunctionCalls/SimpleFunction/SimpleFunction.vm
echo "> $input_path"
nand2tetris-rust vm-translator --input-path $input_path
CPUEmulator.sh $project_dir/FunctionCalls/SimpleFunction/SimpleFunction.tst

input_path=$project_dir/FunctionCalls/FibonacciElement
echo "> $input_path"
nand2tetris-rust vm-translator --input-path $input_path
CPUEmulator.sh $project_dir/FunctionCalls/FibonacciElement/FibonacciElement.tst

input_path=$project_dir/FunctionCalls/StaticsTest
echo "> $input_path"
nand2tetris-rust vm-translator --input-path $input_path
CPUEmulator.sh $project_dir/FunctionCalls/StaticsTest/StaticsTest.tst

input_path=$project_dir/FunctionCalls/NestedCall
echo "> $input_path"
nand2tetris-rust vm-translator --input-path $input_path
CPUEmulator.sh $project_dir/FunctionCalls/NestedCall/NestedCall.tst
