# nlua

Lua script that let's you use Neovim as a Lua interpreter.

Neovim embeds a Lua interpreter, but it doesn't expose the same command line interface as plain `lua`.

The plain interface looks like this:

```
usage: lua [options] [script [args]]
Available options are:
  -e stat   execute string 'stat'
  -i        enter interactive mode after executing 'script'
  -l mod    require library 'mod' into global 'mod'
  -l g=mod  require library 'mod' into global 'g'
  -v        show version information
  -E        ignore environment variables
  -W        turn warnings on
  --        stop handling options
  -         stop handling options and execute stdin
```


`nlua` is a script which emulates that interface, Using Neovim's `-l` option under the hood.

Currently supported:

- `-e`
- `-v`
- `--`
- `[script [args]]`
- stdin handling


## Motivation

- It let's you use Neovim as Lua interpreter for [luarocks]. This in turn allows you to run tools like [busted] to test Neovim plugins.

- It allows tools like [local-lua-debugger-vscode] to use the Neovim Lua. Enabling debugging of busted test cases for Neovim plugins.

See:

- [Using Neovim as Lua interpreter with Luarocks](https://zignar.net/2023/01/21/using-luarocks-as-lua-interpreter-with-luarocks/)
- [Debugging Lua in Neovim](https://zignar.net/2023/06/10/debugging-lua-in-neovim/)


## Requirements

- `env` executable supporting the `-S` option. Run `env --help` in a shell to verify.
- Neovim 0.9+ with LuaJIT

## Installation

### Using luarocks

[![][luarocks-shield]][luarocks-url]

This package is available on [luarocks].

```
luarocks install --local nlua
```

### Manually

For [luarocks] support, copy or symlink `nlua` to `/usr/bin/`
If you don't need [luarocks] support, copy it into any folder in your `$PATH`.


## Luarocks setup

- Install luarocks using a package manager. For example `pacman -S luarocks`
- Create a configuration file under `~/.luarocks/config-nlua.lua` with the following content:

```lua
lua_interpreter = "nlua"
lua_version = "5.1"
variables = {
   LUA_INCDIR = "/usr/include/luajit-2.1",
   LUA_BINDIR = "$HOME/.luarocks/bin", -- path to where nlua is installed
}
```

- Create a wrapper script somewhere in `$PATH` - e.g. in `~/.local/bin/nluarocks` - with the following content:

```bash
#!/usr/bin/env bash

LUAROCKS_CONFIG=$HOME/.luarocks/config-nlua.lua luarocks --local "$@"
```

Now you should be able to install packages from luarocks using the Neovim interpreter. For example:

```bash
nluarocks install busted
```


[luarocks]: https://luarocks.org/
[busted]: https://lunarmodules.github.io/busted/
[local-lua-debugger-vscode]: https://github.com/tomblind/local-lua-debugger-vscode
[luarocks-shield]: https://img.shields.io/luarocks/v/mfussenegger/nlua?logo=lua&color=purple&style=for-the-badge
[luarocks-pkg-url]: https://luarocks.org/modules/mfussenegger/nlua
