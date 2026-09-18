# Tomato timer

A small Bash Pomodoro-style timer. It displays a red ASCII tomato while it
runs, then reminds you to take a break, drink water, and go to the toilet.

## Usage

```bash
tomato        # 20-minute timer with sound
tomato 1      # 1-minute timer with sound
tomato -s     # 20-minute timer without sound
tomato 1 -s   # 1-minute timer without sound
tomato --help # show all options
```

Press `Ctrl-C` to cancel a running timer.

## Install

Clone the repository and run:

```bash
./install.sh
```

The installer copies `tomato` to:

```text
~/.local/bin/tomato
```

If `~/.local/bin` is not already in your `PATH`, the installer will show
instructions for adding it.

You can then run `tomato` from any terminal.

## Update

Pull the latest changes and run the installer again:

```bash
git pull
./install.sh
```

## Sound

On macOS, Tomato uses the system `Glass.aiff` sound when the timer finishes.
The terminal bell is used as a fallback.
