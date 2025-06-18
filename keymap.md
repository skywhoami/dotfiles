# Keymap

## Basic Navigation and Editing

| Keybinding | Mode | Description |
|------------|------|-------------|
| `<`        | Visual | Indent left and reselect |
| `>`        | Visual | Indent right and reselect |
| `<A-j>`    | Normal | Move line down |
| `<A-k>`    | Normal | Move line up |
| `<A-j>`    | Visual | Move selection down |
| `<A-k>`    | Visual | Move selection up |
| `<leader>p` | Visual | Paste over selected text |

## File Operations

| Keybinding | Mode | Description |
|------------|------|-------------|
| `<leader>w` | Normal | Save file |
| `<leader>q` | Normal | Quit |
| `<leader>Q` | Normal | Quit all without saving |
| `<leader>x` | Normal | Execute the current file |

## Buffer Navigation

| Keybinding | Mode | Description |
|------------|------|-------------|
| `<S-h>`    | Normal | Previous buffer |
| `<S-l>`    | Normal | Next buffer |
| `[b`       | Normal | Previous buffer |
| `]b`       | Normal | Next buffer |
| `<leader>bd` | Normal | Delete current buffer |
| `<leader>bn` | Normal | New buffer |

## Window Management

| Keybinding | Mode | Description |
|------------|------|-------------|
| `<leader>sv` | Normal | Split window vertically |
| `<leader>sh` | Normal | Split window horizontally |
| `<leader>se` | Normal | Make splits equal size |
| `<leader>sx` | Normal | Close current split |
| `<C-h>`    | Normal | Go to left window |
| `<C-j>`    | Normal | Go to lower window |
| `<C-k>`    | Normal | Go to upper window |
| `<C-l>`    | Normal | Go to right window |

## LSP Features

| Keybinding | Mode | Description |
|------------|------|-------------|
| `<leader>gd` | Normal | Go to definition |
| `K`        | Normal | Show hover information |
| `<leader>ca` | Normal | Code action |
| `<leader>rn` | Normal | Rename symbol |
| `<leader>r` | Normal | Restart LSP |
| `gr`       | Normal | LSP references (Telescope) |
| `gd`       | Normal | LSP definitions (Telescope) |
| `gD`       | Normal | LSP type definitions (Telescope) |

## Telescope

### General File Navigation

| Keybinding | Mode | Description |
|------------|------|-------------|
| `<leader>ff` | Normal | Find files |
| `<leader>fb` | Normal | Fuzzy find in current buffer |
| `<leader>fg` | Normal | Live grep |
| `<leader>fG` | Normal | Live grep with args |
| `<leader>fr` | Normal | Recent files |
| `<leader>ft` | Normal | Help tags / Treesitter |
| `<leader>fk` | Normal | Keymaps |
| `<leader>fc` | Normal | Commands |
| `<leader>fh` | Normal | Command history |
| `<leader>fs` | Normal | Search history |
| `<leader>fm` | Normal | Marks |
| `<leader>fq` | Normal | Quickfix |
| `<leader>fl` | Normal | Location list |
| `<leader>fj` | Normal | Jumplist |
| `<leader>fd` | Normal | Diagnostics |
| `<leader>fp` | Normal | Planets |
| `<leader>fi` | Normal | Builtin pickers |

## Completion

| Keybinding | Mode | Description |
|------------|------|-------------|
| `<C-p>`    | Insert | Select previous item |
| `<C-n>`    | Insert | Select next item |
| `<C-y>`    | Insert | Confirm selection |
| `<C-Space>` | Insert | Complete |
| `<Tab>`    | Insert | Select next item or expand snippet |
| `<S-Tab>`  | Insert | Select previous item |

## Notes

- `<leader>` is set to space.
