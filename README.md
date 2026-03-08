# Plasma Caffeine

KDE Plasma 6 system tray widget to prevent the system from sleeping.

## Requirements

- KDE Plasma 6.x
- Wayland or X11
- systemd

## Install

```bash
./install.sh
```

Then add the widget: right-click the desktop → **Add Widgets** → search **Plasma Caffeine**.

## Usage

Click the tray icon to toggle sleep inhibition.

| State | Icon                | Behavior                |
| ----- | ------------------- | ----------------------- |
| OFF   | 💤 (system-suspend) | Sleep allowed (default) |
| ON    | ▶ (system-run)      | Sleep inhibited         |

## Uninstall

```bash
./uninstall.sh
```

## How it works

Uses `systemd-inhibit` to block `sleep`, `idle`, and `handle-lid-switch` via logind DBus.
