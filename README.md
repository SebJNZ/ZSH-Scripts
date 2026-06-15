# ZSH-Scripts 
- **`compile.zsh` - `cm()` and `ru()`**

  `cm()` is configured to compile C files by default, unless the file has .asm as it's extension (currently only x86, and x86_64 supported).
  
  Usage:
  `cm <filename>`

  If it's an assembly file:
  Usage:
  `cm <filename.asm> <architecture>`

  `ru()` stores the last file's name in memory, and can execute it, ensure you are in the correct path though!
  
  Usage:
  `ru`

  Examples:
  ```
  $ cm main.c
  $ ru
  Hello, World!
  ```
  ```
  $ cu main64.asm 64
  $ ru
  Hello, World!
  ```
  ```
  $ cu main32.asm 32
  $ ru
  Hello, World!
  ```
  
## How to install
Open your zsh config file, by default located at:
`~/.zshrc`

Append the script to the end of the file (or wherever you want).

Reload your config:
`source ~/.zshrc`
