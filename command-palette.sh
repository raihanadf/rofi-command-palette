#!/bin/bash

# Check current directory and set ~/.rofi-commands.yaml as default
# configuration file. And you can also set a parameter for the config file
# for a specific one.
cwd=$(dirname "$0")
config_file="${1:-"$HOME/.rofi-commands.yaml"}"

# Outputs config file to rofi with fuzzy, list every commands
selected=$(yq -r '.[].name' "$config_file" | rofi -dmenu -matching fuzzy -i -p ">")

# Check if selected task exist
task=$(cat "$config_file" | yq -r ".[] | select(.name == \"$selected\")")
if [[ $task == "" ]]; then
  echo "No command defined as '$selected' within config file."
  exit 1
fi

# task_command used for executing (fetching) current selected command
# and confirm and is_sudo checks whether the config has it or not
task_command=$(yq -r ".[] | select(.name == \"$selected\").command" "$config_file")
confirm=$(yq -r ".[] | select(.name == \"$selected\").confirm" "$config_file")
is_sudo=$(yq -r ".[] | select(.name == \"$selected\").run_as_sudo" "$config_file")

# This one will pops up rofi for running the command with sudo
run_with_password_prompt() {
  echo "Enter your password:" | rofi -dmenu -p "Password:" -password -lines 0 | sudo -S -E bash -c "$task_command > /dev/null &"
}

# This will check if the config file has an option confirm or is_sudo to true
# if it has then proceed to first block, if not then go to the else block.
# Else block does the command immediately without having to confirm.
# And then in the confirm block there's a checking one too for is_sudo.
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
