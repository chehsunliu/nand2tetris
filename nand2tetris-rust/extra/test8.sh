#!/usr/bin/env bash

set -Eeuo pipefail

script_dir=$(cd "$(dirname "${BASH_SOURCE[0]}")" &>/dev/null && pwd -P)

# ------------------------------------------------------

build_dir="$script_dir/../target/debug"
tool_dir="$script_dir/../../tools"
PATH="$build_dir:$tool_dir:$PATH"

project_dir="$script_dir/../../projects/08"
vm_codes=(
  $project_dir/ProgramFlow/BasicLoop/BasicLoop.vm
  $project_dir/ProgramFlow/FibonacciSeries/FibonacciSeries.vm
)

for vm_code in "${vm_codes[@]}"; do
  echo "> Test $vm_code"
  nand2tetris-rust vm-translator --input-path $vm_code

  test_script=${vm_code%.vm}.tst
  CPUEmulator.sh $test_script
done
