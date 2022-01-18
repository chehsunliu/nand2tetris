#!/usr/bin/env bash

set -Eeuo pipefail

script_dir=$(cd "$(dirname "${BASH_SOURCE[0]}")" &>/dev/null && pwd -P)

# ------------------------------------------------------

build_dir="$script_dir/../target/debug"
tool_dir="$script_dir/../../tools"
PATH="$build_dir:$tool_dir:$PATH"

project_dir="$script_dir/../../projects/10"
folders=(
  ExpressionLessSquare
  ArrayTest
  Square
)

for folder in "${folders[@]}"; do
  input_path="$project_dir/$folder"
  output_path="/tmp/$folder"

  echo "> Test $input_path"
  mkdir -p $output_path
  nand2tetris-rust jack-analyzer --input-path $input_path --output-directory $output_path
done
