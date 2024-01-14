```plaintext
 ___________________________________ 
< man, i hate all these keybindings >
 ----------------------------------- 
       \   ,__,
        \  (oo)____
           (__)    )\
              ||--|| *
```

## Overview

"Rofi Command Palette" takes an inspiration from VSCode's command palette that has everything included including your custom commands and it fuzzy searches it.

### Features
- Uses .yaml file for configuration file so that you can no longer have the need to escape double quotes or something that needs it.
- Run as sudo implementation

### Usage
1. First add an initial config, it's up to you where to place it. Name it whatever you want, but the default one will be read on `~/.rofi-commands.yaml`. Heres an example on how it should look:
```yaml
- name: Sleep
  confirm: true
  command: systemctl suspend

- name: Another Command
  run_as_sudo: true
  command: notify-send "Hello, World!"
```
2. Launch `command-palette.sh`.
3. And it's done, now you can bind it to some key like $mod (alt or command key) + shift + p on sxhkd or something.

#### -- YAML Options --
* `name:` used for the command's name.
* `confirm:` used for indicating the command that it needs to be confirmed first (confirmation y/n).
* `run_as_sudo:` used for indicating that the command has to be ran as root.
* `command:` commands that will be executed.

### Thanks to
- [myrmidon](https://github.com/moustacheful/myrmidon) for the "inspiration". I literally copy-pasted all it's code and then rewrite it with yq (even tho i only modified it a little, for example; running with sudo and .yaml replacement)
- [rofi](https://github.com/davatorium/rofi) for being a wonderful dmenu replacement
- [yq](https://github.com/mikefarah/yq) for command-line YAML, JSON, XML, CSV, TOML and properties processor.