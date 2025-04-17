# nlua

Lua script that lets you use Neovim as a Lua interpreter.

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

- It lets you use Neovim as Lua interpreter for [luarocks]. This in turn allows you to run tools like [busted] to test Neovim plugins.

- It allows tools like [local-lua-debugger-vscode] to use the Neovim Lua. Enabling debugging of busted test cases for Neovim plugins.

See:

- [Using Neovim as Lua interpreter with Luarocks](https://zignar.net/2023/01/21/using-luarocks-as-lua-interpreter-with-luarocks/)
- [Debugging Lua in Neovim](https://zignar.net/2023/06/10/debugging-lua-in-neovim/)


## Requirements

- `env` executable supporting the `-S` option. Run `env --help` in a shell to verify.
- Neovim 0.9+ with LuaJIT

## Installation

[![][luarocks-shield]][luarocks-pkg-url]

This package is available on [luarocks].

- Install luarocks using a package manager. For example `pacman -S luarocks`
- Install `nlua` via `luarocks`:

    ```bash
    luarocks --local install nlua
    ```

- Add `~/.luarocks/bin/nlua` to your `$PATH`:

    ```bash
    export PATH=$PATH:$HOME/.luarocks/bin:
    ```

- Confirm it's working:

  ```bash
  echo "print(1 + 2)" | nlua
  ```

> [!NOTE]
>
> On Windows, luarocks will install a `nlua.bat` wrapper script.

## Usage

### Busted

```bash
luarocks --local install busted
busted --lua nlua spec/mytest_spec.lua
```

If you see a `module 'busted.runner'` not found error you need to update your `LUA_PATH`:

```bash
eval $(luarocks path --no-bin)
busted --lua nlua spec/mytest_spec.lua
```

### CI for Neovim Plugins

You can use the [plugin
template](https://github.com/nvim-lua/nvim-lua-plugin-template) to create a new
repository that contains nlua/busted based test setup.


### As Lua interpreter for luarocks


This allows package installation directly via `nlua` instead of a system `lua`

Create a `~/.luarocks/config-nlua.lua` with the following contents.

For `luarocks 3.10.0` and above:

```lua
lua_version = "5.1"
variables = {
   LUA = "$HOME/.luarocks/bin/nlua", -- path to where nlua is installed
   LUA_INCDIR = "/usr/include/luajit-2.1",
}
```

For `luarocks 3.9.2` and below:

```lua
lua_version = "5.1"
variables = {
   lua_interpreter = "nlua"
   LUA_INCDIR = "/usr/include/luajit-2.1",
   LUA_BINDIR = "$HOME/.luarocks/bin", -- path to where nlua is installed
}
```

To make using this custom configuration a bit easier, you can create a small wrapper.
Create a file called `nluarocks` somewhere in `$PATH` - e.g. in
`~/.local/bin/nluarocks` - with the following content:

```bash
#!/usr/bin/env bash

LUAROCKS_CONFIG=$HOME/.luarocks/config-nlua.lua luarocks --local "$@"
```

Now you should be able to install packages from `luarocks` using the `nvim`
Lua-interpreter. For example:

```bash
nluarocks install busted
```


[luarocks]: https://luarocks.org/
[busted]: https://lunarmodules.github.io/busted/
[local-lua-debugger-vscode]: https://github.com/tomblind/local-lua-debugger-vscode
[luarocks-shield]: https://img.shields.io/luarocks/v/mfussenegger/nlua?logo=lua&color=purple&style=for-the-badge
[luarocks-pkg-url]: https://luarocks.org/modules/mfussenegger/nlua
