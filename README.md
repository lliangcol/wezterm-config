# WezTerm Config

Opinionated, modular WezTerm configuration with themed UI, background controls, and custom status/tab UI.

## Structure

- `wezterm.lua`: entry point that wires modules and events.
- `config/`: split configs (appearance, bindings, domains, fonts, general, launch).
- `events/`: status bars, tab title rendering, new-tab menu, GUI startup.
- `utils/`: helpers (backgrounds, cells, gpu adapter selection, platform checks, validation).
- `colors/`: custom color scheme.
- `backdrops/`: background images.
- `docs/wezterm-config.md`: English configuration guide generated from this repo.

## Setup

WezTerm loads `wezterm.lua` from its config path. Point WezTerm at this repo:

Windows (PowerShell, per-user):
```powershell
[Environment]::SetEnvironmentVariable("WEZTERM_CONFIG_FILE", "D:\\Work\\Projects\\wezterm-config\\wezterm.lua", "User")
```

macOS/Linux (shell):
```sh
export WEZTERM_CONFIG_FILE="$HOME/path/to/wezterm-config/wezterm.lua"
```

Alternatively, symlink `wezterm.lua` into the default location.

## Highlights

- WebGPU rendering with adapter selection and 120 FPS.
- Custom tab title UI with unseen output indicators.
- Left/right status bars with leader/key-table state, clock, and battery.
- Background image cycling with focus mode toggle.
- Rich key bindings and leader tables for panes/font resizing.

## Documentation

`docs/wezterm-config.md` walks through:
- Load order and module wiring.
- Behavior of each config module.
- Event handlers for status/tab UI.
- Utilities and background management.

## Common Key Bindings

Note: `SUPER` is `ALT` on Windows/Linux and `SUPER` on macOS.

- `F1` copy mode, `F2` command palette, `F3` launcher, `F11` fullscreen.
- `SUPER+t` new tab, `SUPER+[`/`]` tab navigation.
- `SUPER+Enter` zoom pane, `SUPER+\\` split vertical, `SUPER_REV+\\` split horizontal.
- `SUPER+/` random background, `SUPER+,`/`.` previous/next background.
- `LEADER+f` resize font table, `LEADER+p` resize pane table.

See `docs/wezterm-config.md` for the full breakdown.
