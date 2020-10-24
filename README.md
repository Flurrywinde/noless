# noless

`noless` gets rid of `less`, no less.

## Why Do This?

Well, it all started because I wanted to print to the screen a man page, keep my nice man page colors, but not pipe it into a pager like man does. I wanted it to be like `cat`, except still colored. I couldn't figure out how to do it. I thought it might be impossible, but then... if figured out how! (Kinda. See below.)

## Usage

Do something like: `noless man man`. This will run `man` but show only the first page (with colors intact) and go back to the shell prompt (just like `cat`. Kinda. See below.).

## How It Works

It uses `unbuffer` (from `expect`) to trick `man` (or whatever other command you loose it upon) into thinking its outputting to the terminal like usual.
