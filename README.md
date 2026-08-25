# ZSH-Scripts 
- # **`compile.zsh` - `cm()`, `ru()` and `cmru()`**
  ## `cm()`
  `cm()` is configured to compile C files by default, unless the file has .asm as it's extension (currently only x86, and x86_64 supported).
  
  Usage:
  `cm <filename> <flags>`
  <br>

  If it's an assembly file:
  Usage:
  `cm <filename.asm> <architecture>`
  <br>

  `cm` flags (only available for C++ currently):
  
  `opt` / `-O3` - Aggressive Optimisation

  ## `ru()`
  `ru()` stores the last file's name in memory, and can execute it, ensure you are in the correct path though!
  
  Usage:
  `ru <flags>`

  `ru()` flags:
  
  `clear` or `-c` - Toggle clear output before running program, run with flag ONCE, if you run it twice, it will disable itself.

  # `cmru()`
  `cmru()` combines both compile and run functions into one simple command. Pass the same parameters you would usually pass for `cm()` to `cmru()` and it will automatically compile and run the program.

  Usage:
  `cmru <filename>`

  Examples:
  ```
  $ cm main.c
  $ ru
  Hello, World!
  ```
  ```
  $ cm main64.asm 64
  $ ru
  Hello, World!
  ```
  ```
  $ cm main32.asm 32
  $ ru
  Hello, World!
  ```
  
## How to install
Open your zsh config file, by default located at:
`~/.zshrc`

Append the script to the end of the file (or wherever you want).

Reload your config:
`source ~/.zshrc`
