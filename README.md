# Tomato timer

A small Bash Pomodoro-style timer. It displays a red ASCII tomato while it
runs, then reminds you to take a break, drink water, and go to the toilet.

## Usage

```bash
tomato       # 20-minute timer with sound
tomato 1     # 1-minute timer with sound
tomato -s    # 20-minute timer without sound
tomato 1 -s  # 1-minute timer without sound
```

Press `Ctrl-C` to cancel a running timer.

## Install

From this directory, install the script as a command in `~/.local/bin`:

```bash
mkdir -p "$HOME/.local/bin"
cp tomato.sh "$HOME/.local/bin/tomato"
chmod +x "$HOME/.local/bin/tomato"
```

Add the directory to your `PATH` if it is not already there. For zsh (the
default shell on macOS):

```bash
printf '\nexport PATH="$HOME/.local/bin:$PATH"\n' >> "$HOME/.zshrc"
source "$HOME/.zshrc"
```

For Bash, add the same line to `~/.bashrc` and run `source ~/.bashrc`.

You can now run `tomato` from any terminal. On macOS, the timer uses the
system `Glass.aiff` sound when sound is enabled; the terminal bell is used as
a fallback.
