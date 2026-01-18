# WezTerm Configuration Guide

This document is generated from the current repository configuration. It explains the entry point, module wiring, events, utilities, and assets so you can quickly understand behavior and tweak it.

## Entry Point and Load Order

- `wezterm.lua` is the entry file:
  - Initializes the backdrop controller and randomly selects a background image: `utils.backdrops:set_images():random()`.
  - Registers events: left/right status, tab title, new tab button, GUI startup.
  - Composes config via `Config:init():append(...)` and returns `options`.
- `config/init.lua` defines the config builder:
  - Uses `wezterm.config_builder()` when available and enables `set_strict_mode(true)`; otherwise falls back to a normal table.
  - `append` merges fields into `options`.
  - Duplicate keys log a warning and keep the earlier value (new values do not override).
- Actual load order (controls duplicate-key precedence):
  1) `config.appearance`
  2) `config.bindings`
  3) `config.domains`
  4) `config.fonts`
  5) `config.general`
  6) `config.launch`

## Official Config Notes (Configuration Files)

- Recommended config file: `$HOME/.wezterm.lua` (Windows: `%USERPROFILE%/.wezterm.lua`).
- Multi-file configs: `$XDG_CONFIG_HOME/wezterm/wezterm.lua` or `~/.config/wezterm/wezterm.lua`.
- Lookup order (simplified): `--config-file` > `WEZTERM_CONFIG_FILE` > Windows portable (`wezterm.exe` folder) > `$XDG_CONFIG_HOME/wezterm/wezterm.lua` > `~/.config/wezterm/wezterm.lua` > `~/.wezterm.lua`.
- Auto reload: WezTerm watches loaded config files; you can also use `CTRL+SHIFT+R`.
- Top-level side effects: config files can run multiple times on startup/reload; avoid top-level actions with side effects (like starting background processes).

### Overrides (CLI and Window)

- CLI override: `wezterm --config enable_scroll_bar=true` or `wezterm --config 'exit_behavior="Hold"'`. These always win and are not hot-reloaded.
- Window override: use `window:set_config_overrides` for per-window settings.

### Module Search Path

- `package.path` search order: Windows portable `wezterm_modules` -> `~/.config/wezterm` -> `~/.wezterm` -> system Lua paths.
- Official recommendation: modules expose `apply_to_config(config)` and are called from the main config.

### config_builder (Recommended)

- `wezterm.config_builder()` returns a config object that warns on invalid options.
- `config:set_strict_mode(true)` promotes warnings to errors (fallback to defaults until fixed and reloaded).
- Requires WezTerm `20230320-124340-559cb7b0` or newer.

### Using This Repo as Your Config

- Point `WEZTERM_CONFIG_FILE` to this repo's `wezterm.lua`, or place it in the recommended paths.

## Install and Use (This Repo)

- Keep the directory structure intact: `wezterm.lua` alongside `config/`, `events/`, `utils/`, `colors/`, `backdrops/`.
- Windows (PowerShell, temporary):
  - `$env:WEZTERM_CONFIG_FILE = "D:\Work\Projects\wezterm-config\wezterm.lua"`
- Windows (PowerShell, user-level persistent):
  - `[Environment]::SetEnvironmentVariable("WEZTERM_CONFIG_FILE", "D:\Work\Projects\wezterm-config\wezterm.lua", "User")`
- macOS/Linux (temporary):
  - `export WEZTERM_CONFIG_FILE="$HOME/path/to/wezterm-config/wezterm.lua"`
- macOS/Linux (symlink to default location):
  - `ln -s ~/path/to/wezterm-config/wezterm.lua ~/.wezterm.lua`
  - or `ln -s ~/path/to/wezterm-config/wezterm.lua ~/.config/wezterm/wezterm.lua`
- Apply changes: restart WezTerm or use `CTRL+SHIFT+R`.
- Auto-update WSL port proxy (Windows, elevated PowerShell):
  - `powershell -ExecutionPolicy Bypass -File scripts\wsl-portproxy.ps1 -Distro Ubuntu -ListenPort 2222 -TargetPort 22`

## General Behavior (`config/general.lua`)

- Auto reload: `automatically_reload_config = true`.
- Exit behavior: `exit_behavior = 'CloseOnCleanExit'`.
- `exit_behavior_messaging = 'Verbose'`.
- Status update: `status_update_interval = 1000` ms.
- Bell: `audible_bell = 'Disabled'`.
- Scrollback: `scrollback_lines = 20000`.
- Hyperlink rules:
  - Supports `(URL)`, `[URL]`, `{URL}`, `<URL>` patterns with highlight.
  - Supports bare `scheme://...` URLs.
  - Supports email addresses (converted to `mailto:`).

## Appearance and Rendering (`config/appearance.lua`)

- Rendering and performance:
  - `front_end = 'WebGpu'` with WebGPU preferred.
  - `webgpu_power_preference = 'HighPerformance'`.
  - `webgpu_preferred_adapter = utils.gpu-adapter:pick_best()`.
  - `max_fps = 120`, `animation_fps = 120`.
- Cursor:
  - `default_cursor_style = 'BlinkingBlock'`, `cursor_blink_rate = 650`.
  - `cursor_blink_ease_in/out = 'EaseOut'`.
- Underline: `underline_thickness = '1.5pt'`.
- Colors: `colors/custom.lua`.
- Background:
  - `background = backdrops:initial_options(false)` for image + overlay.
  - Overlay opacity is `0.96`.
- Scrollbar: `enable_scroll_bar = true`.
- Tab bar:
  - `enable_tab_bar = true`, `use_fancy_tab_bar = false` (custom styling via events).
  - `hide_tab_bar_if_only_one_tab = false`.
  - `tab_max_width = 25`, `show_tab_index_in_tab_bar = false`.
  - `switch_to_last_active_tab_when_closing_tab = true`.
- Command palette:
  - `command_palette_fg_color = '#b4befe'`, `command_palette_bg_color = '#11111b'`.
  - `command_palette_font_size = 12`, `command_palette_rows = 25`.
- Window:
  - `window_padding = { left = 0, right = 0, top = 10, bottom = 7.5 }`.
  - `adjust_window_size_when_changing_font_size = false`.
  - `window_close_confirmation = 'NeverPrompt'`.
  - `window_frame.active_titlebar_bg = '#090909'`.
  - `inactive_pane_hsb = { saturation = 1, brightness = 1 }`.
- Visual bell:
  - `visual_bell.target = 'CursorColor'`, fade in/out 250ms.

## Fonts (`config/fonts.lua`)

- Family: `JetBrainsMono Nerd Font`, weight `Medium`.
- Size:
  - macOS: 12
  - others: 9.75
- FreeType:
  - `freetype_load_target = 'Normal'`
  - `freetype_render_target = 'Normal'`

## Launch and Menu (`config/launch.lua`)

- Windows:
  - `default_prog = { 'pwsh', '-NoLogo' }`
  - `launch_menu`: PowerShell Core / PowerShell Desktop / Command Prompt.
- macOS:
  - `default_prog = { '/opt/homebrew/bin/fish', '-l' }`
  - `launch_menu`: Bash / Fish / Nushell / Zsh.
- Linux:
  - `default_prog = { 'fish', '-l' }`
  - `launch_menu`: Bash / Fish / Zsh.

## Domains (`config/domains.lua`)

- Placeholders: `ssh_domains`, `unix_domains`, `wsl_domains` default to empty arrays.
- Windows extras:
  - SSH domain `ssh:wsl`: localhost, `multiplexing = 'None'`, default `bash -l`.
  - WSL domain `wsl:ubuntu-bash`:
    - `distribution = 'Ubuntu'`
    - `username = 'liuliang'`
    - `default_cwd = '/home/liuliang'`
    - `default_prog = { 'bash', '-l' }`

## Key Bindings (`config/bindings.lua`)

- Defaults: `disable_default_key_bindings = true`.
- Modifiers:
  - macOS: `SUPER = SUPER`, `SUPER_REV = SUPER|CTRL`
  - Windows/Linux: `SUPER = ALT`, `SUPER_REV = ALT|CTRL`
- Leader: `leader = { key = 'Space', mods = SUPER_REV }`

### Common Shortcuts (by function)

Misc:
- `F1` copy mode.
- `F2` command palette.
- `F3` launcher; `F4` tabs only; `F5` workspaces only.
- `F11` fullscreen; `F12` debug overlay.
- `SUPER+f` search (case-insensitive).
- `SUPER_REV+u` quick URL selection and open.

Cursor and input:
- `SUPER+Left/Right` sends Home/End.
- `SUPER+Backspace` sends `^U` (clear line).

Copy/paste:
- `CTRL+SHIFT+c` copy to clipboard.
- `CTRL+SHIFT+v` paste from clipboard.

Tabs:
- New: `SUPER+t` (DefaultDomain); `SUPER_REV+t` (WSL: ubuntu-bash).
- Close: `SUPER_REV+w` close current tab.
- Navigate: `SUPER+[` / `SUPER+]`.
- Reorder: `SUPER_REV+[` / `SUPER_REV+]`.
- Title: `SUPER+0` prompt name; `SUPER_REV+0` reset.
- Tab bar toggle: `SUPER+9`.

Window:
- `SUPER+n` new window.
- `SUPER+-` / `SUPER+=` resize window.
- `SUPER_REV+Enter` maximize window.

Background:
- `SUPER+/` random background.
- `SUPER+,` / `SUPER+.` previous/next background.
- `SUPER_REV+/` open background selector.
- `SUPER+b` toggle focus mode (solid color only).

Panes:
- `SUPER+\\` split vertical; `SUPER_REV+\\` split horizontal.
- `SUPER+Enter` zoom/unzoom pane.
- `SUPER+w` close pane.
- `SUPER_REV+h/j/k/l` move focus.
- `SUPER_REV+p` pane selector (SwapWithActiveKeepFocus).

Scrolling:
- `SUPER+u` / `SUPER+d` scroll by 5 lines.
- `PageUp` / `PageDown` scroll by 0.75 page.

### Key Tables

- `LEADER+f` enters `resize_font`: `k/j` size, `r` reset.
- `LEADER+p` enters `resize_pane`: `h/j/k/l` resize pane.

### Mouse

- `CTRL+left click` opens the link under the cursor.

## Color Scheme (`colors/custom.lua`)

- Based on Catppuccin Mocha with slight tweaks.
- Sets foreground/background, cursor, selection, ANSI/brights.
- Custom tab bar colors (hover/active).
- Also sets `scrollbar_thumb`, `split`, `compose_cursor`, etc.

## Backdrops (`utils/backdrops.lua` + `backdrops/`)

- Images are loaded from `wezterm.config_dir .. '/backdrops/'`.
- `set_images()` uses glob `*.{jpg,jpeg,png,gif,bmp,ico,tiff,pnm,dds,tga}`.
- `set_images()` must run from `wezterm.lua` on initial load (avoids coroutine errors).
- Initial background is from `initial_options(false)`:
  - Centered image.
  - Color overlay (defaults to `colors.background`).
- Focus mode uses a solid color (no image).
- Supports random, next/previous, direct select, and selector UI.

## GPU Adapter Selection (`utils/gpu-adapter.lua`)

- Backend preference by system:
  - Windows: Dx12 > Vulkan > OpenGL
  - Linux: Vulkan > OpenGL
  - macOS: Metal
- Adapter priority: Discrete > Integrated > Other (OpenGL) > CPU.
- Falls back to WezTerm defaults if no match.

## Status and Events (`events/*.lua`)

### Left Status (`events/left-status.lua`)

- Listens to `update-right-status` and syncs left status.
- Shows leader state and active key table name (uppercase).

### Right Status (`events/right-status.lua`)

- Listens to `update-right-status`, shows date and battery.
- Date format from `wezterm.lua`: `%a %H:%M:%S`.
- Battery icon changes based on charging state and level.

### Tab Title (`events/tab-title.lua`)

- Handles `format-tab-title` with custom styling.
- Supports:
  - WSL process indicator and admin indicator.
  - Unseen output indicator (dot or number).
  - Special icons for input selector/debug.
- Options set in `wezterm.lua`:
  - `hide_active_tab_unseen = false`
  - `unseen_icon = 'numbered_box'`
- Custom events:
  - `tabs.manual-update-tab-title`: prompt and lock tab title.
  - `tabs.reset-tab-title`: unlock title.
  - `tabs.toggle-tab-bar`: toggle tab bar visibility.

### New Tab Button (`events/new-tab-button.lua`)

- Left click: default new tab action.
- Right click: `InputSelector` built from:
  - `launch_menu` + `ssh_domains` + `unix_domains` + `wsl_domains`.
  - Spawns with `SpawnCommandInNewTab`.

### GUI Startup (`events/gui-startup.lua`)

- Maximizes the window on startup.

## Utilities (`utils/*.lua`)

- `utils.platform`: platform detection via `wezterm.target_triple`.
- `utils.cells`: helper for `wezterm.format` segment construction.
- `utils.opts-validator`: event options validation with defaults.
- `utils.math`: `clamp` and `round`.

## Assets

- Background images live in `backdrops/` and are loaded randomly or in order. Current files:
  - `5-cm.jpg`
  - `angry-samurai.jpg`
  - `appa.jpg`
  - `astro-jelly.jpg`
  - `cherry-lava.jpg`
  - `cloudy-quasar.png`
  - `final-showdown.jpg`
  - `frieren.jpeg`
  - `house.jpg`
  - `nord-space.png`
  - `pastel-samurai.jpg`
  - `space.jpg`
  - `sunset.jpg`
  - `sword.jpg`
  - `totoro.jpeg`
  - `voyage.jpg`
