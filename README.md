# Plasma Caffeine

KDE Plasma 6 panel widget to prevent the system from sleeping.

Click the icon to toggle sleep inhibition on/off.

## Requirements

- KDE Plasma 6.x
- Wayland or X11
- systemd

## Install

```bash
git clone https://github.com/archfill/plasma-caffeine.git
cd plasma-caffeine
./install.sh
```

Then add the widget to your panel:

1. Right-click the panel → **Edit Panel** → **Add Widgets**
2. Search for **Plasma Caffeine**
3. Drag it to the panel

## Usage

| State | Icon          | Behavior                |
| ----- | ------------- | ----------------------- |
| OFF   | ☕ coffee-off | Sleep allowed (default) |
| ON    | ☕ coffee     | Sleep inhibited         |

Hovering shows a tooltip with the current state. Clicking the icon in the panel toggles sleep inhibition.

## Uninstall

```bash
./uninstall.sh
```

## How it works

- The widget calls a helper script (`~/.local/bin/plasma-caffeine`) on each toggle
- The helper runs `systemd-inhibit` to block `sleep`, `idle`, and `handle-lid-switch` via logind DBus
- The inhibitor is released immediately when toggled off or when the session ends

## Credits

- Icons: [Tabler Icons](https://tabler.io/icons) (MIT License)
