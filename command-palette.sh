#!/bin/bash

cwd=$(dirname "$0")
config_file="${1:-"$HOME/.rofi-commands.yaml"}"

selected=$(yq -r '.[].name' "$config_file" | rofi -dmenu -matching fuzzy -i -p ">")
task=$(cat "$config_file" | yq -r ".[] | select(.name == \"$selected\")")

if [[ $task == "" ]]; then
  echo "No command defined as '$selected' within config file."
  exit 1
fi

task_command=$(yq -r ".[] | select(.name == \"$selected\").command" "$config_file")
confirm=$(yq -r ".[] | select(.name == \"$selected\").confirm" "$config_file")
is_sudo=$(yq -r ".[] | select(.name == \"$selected\").run_as_sudo" "$config_file")

run_with_password_prompt() {
  echo "Enter your password:" | rofi -dmenu -p "Password:" -password -lines 0 | sudo -S -E bash -c "$task_command > /dev/null &"
}

if [[ "$confirm" == "true" || "$is_sudo" == "true" ]]; then
  confirm_script="$cwd/confirm.sh 'Execute $selected?'"
  if [[ "$is_sudo" == "true" ]]; then
    eval "$confirm_script" && run_with_password_prompt
  else
    eval "$confirm_script" && eval "$task_command > /dev/null &"
  fi
else
  eval "$task_command > /dev/null &"
fi
