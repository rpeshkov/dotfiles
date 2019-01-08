# Karabiner

I use Karabiner for defining my own keybindings and layouts. Instead of direct editing of its rules, that are `json` files I use tool, called [Goku][Goku]. It allows writing of Karabiner rules using `edn` file format which is much more compact than `json`. `edn` files are just clojure files, so there's no problem with syntax highlighting in most editors.

## Installation

```sh
brew install yqrashawn/goku/goku
```

In Karabiner you need to create new profile, called 'Goku' - that's where your rules from edn will be compiled.

[`Karabiner.edn`](./karabiner.edn) file should be placed in a folder `~/.config/karabiner.edn`.

## Rules build

In order to build rules that you defined in `karabiner.edn` file, just launch this command in your terminal:

```sh
goku
```

In case you want rules to be automatically rebuilt, you may launch goku in watch mode:

```sh
goku -w
```

or you may start it as a brew service

```sh
brew services start goku
```

**NOTE**: Autowatch doesn't work if you symlinked your karabiner.edn file.

## Configuration

Modifiers:

```text
C - cmd
O - option
T - control
S - shift
! - mandatory modifier
# - optional modifier
## - any optional
```

[Goku]: https://github.com/yqrashawn/GokuRakuJoudo/
