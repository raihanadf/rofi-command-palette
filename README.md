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

### Thanks to
- [myrmidon](https://github.com/moustacheful/myrmidon) for the "inspiration". I literally copy-pasted all it's code and then rewrite it with yq (even tho i only modified it a little, for example; running with sudo and .yaml replacement)
- [rofi](https://github.com/davatorium/rofi) for being a wonderful dmenu replacement
- [yq](https://github.com/mikefarah/yq) for command-line YAML, JSON, XML, CSV, TOML and properties processor.