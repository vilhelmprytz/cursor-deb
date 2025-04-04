# Cursor Debian Package

This repository contains the build files for creating a Debian package for Cursor IDE.

## Building the Package

To build the package, you need to have the following dependencies installed:

```bash
sudo apt-get install build-essential wget
```

Then run:

```bash
make
```

This will:
1. Download the Cursor AppImage
2. Download the Cursor icon
3. Create the desktop entry
4. Build the Debian package using dpkg-deb

The resulting package will be `cursor.deb` in the current directory.

## Installation

After building, you can install the package using:

```bash
sudo dpkg -i cursor.deb
sudo apt-get install -f  # Install any missing dependencies
```

## Features

- Installs Cursor IDE system-wide
- Adds a desktop entry for launching Cursor
- Adds the `cursor` command to your PATH (e.g., `cursor .` to open current directory)
- Properly integrates with the system's application menu
- Requires libfuse2 for AppImage support
- Supports custom launch options via `/etc/default/cursor` configuration file

## Configuration

The package supports reading custom launch options from `/etc/default/cursor`. 
To configure Cursor with specific command line parameters:

1. Edit the configuration file:
   ```bash
   sudo nano /etc/default/cursor
   ```

2. Add your custom options by setting the `CURSOR_OPTS` variable:
   ```bash
   CURSOR_OPTS="--your-option-here"
   ```

Any options specified in this file will be applied when launching Cursor from the desktop 
entry or from the command line.

## Package Structure

The package installs the following files:
- `/usr/share/cursor/cursor.AppImage` - The main application
- `/usr/share/icons/hicolor/256x256/apps/cursor.png` - Application icon
- `/usr/share/applications/cursor.desktop` - Desktop entry
- `/usr/bin/cursor` - Command-line launcher (wrapper script)
- `/etc/default/cursor` - Configuration file for custom options
