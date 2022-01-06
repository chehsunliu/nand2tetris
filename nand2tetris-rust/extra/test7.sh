#!/usr/bin/env bash

set -Eeuo pipefail

script_dir=$(cd "$(dirname "${BASH_SOURCE[0]}")" &>/dev/null && pwd -P)

# ------------------------------------------------------

build_dir="$script_dir/../target/debug"
tool_dir="$script_dir/../../tools"
PATH="$build_dir:$tool_dir:$PATH"

project_dir="$script_dir/../../projects/07"
vm_codes=(
  $project_dir/StackArithmetic/SimpleAdd/SimpleAdd.vm
  $project_dir/StackArithmetic/StackTest/StackTest.vm
  $project_dir/MemoryAccess/BasicTest/BasicTest.vm
  $project_dir/MemoryAccess/PointerTest/PointerTest.vm
  $project_dir/MemoryAccess/StaticTest/StaticTest.vm
)

for vm_code in "${vm_codes[@]}"; do
  echo "> Test $vm_code"
  nand2tetris-rust vm-translator --input-path $vm_code

  test_script=${vm_code%.vm}.tst
  CPUEmulator.sh $test_script
done
