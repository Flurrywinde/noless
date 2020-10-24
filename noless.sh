#!/bin/bash

# Whatis: Preface your `man` command with `noless` to effectively `cat` the first screenful of it but keep all colored text.

# Description: Runs a command (with its parms, if any) unbuffered to keep any ansi escape codes (e.g. color) from being stripped, e.g. for man pages, then kills it, after one second and erases the last line. Thus, what this effectively does is let you `cat` a short man page (or the first page of a man page longer than your screen), but keep the color, which seems otherwise impossible, i.e. `man -P cat` still strips out the ansi sequences.

# Get number of already running processes ps and grep will be looking for
grepsrch="/[u]sr/bin/unbuffer $@" # Why did $2 get interpreted as the file when this string was grep's parm directly?
pscount=$(ps ax | grep -c "$grepsrch")

# Unbuffer and kill right after
unbuffer "$@" 2> /dev/null &  # Only way to show the colors seems to be to keep man's output to less unless I somehow find a way to interpret overstrikes as bold and underline. Added 2> part because got "gzip: stdout: Permission denied", but didn't help. Still occurs, but I think always only in kitty, not gnome-terminal, but gnome-terminal clears the window above it, while kitty does what I wanted and just scrolls it.

# Wait for unbuffer process to exist (seems unnecessary, except maybe on very slow system?)
while ! ps ax | grep -c "$grepsrch" > /dev/null 2>&1; do
	sleep .01
	echo "/[u]sr/bin/unbuffer $@"
done
# Wait for man page to actually be displayed
sleep 1

# Kill it to stop the pager
unbufs="$(ps ax | grep "$grepsrch" | grep -oP '^\s*\K\d*')"  # fetch all pid's ([u] to exclude grep's own pid)
for buf in "${unbufs[@]}"; do
	# echo "$buf"
	kill $buf  # Hopefully the above grep will find only what we really want to kill!
	wait $buf 2>/dev/null  # Get rid of shell's termination message, see: https://stackoverflow.com/questions/81520/how-to-suppress-terminated-message-after-killing-in-bash
done
# Erase less's status bar
tput cr ce
