# noless

`noless` gets rid of `less`, no less. (For more puns (is that the right word?), see `superman`.)

## Why Do This?

Well, it all started because I wanted to print to the screen a man page, keep my nice man page colors, but not pipe it into a pager like man does. I wanted it to be like `cat`, except still colored. I couldn't figure out how to do it. I thought it might be impossible, but then... if figured out how! (Kinda. See below.)

It also example of cool things I've learned while research another thing, aka even more useless things I learned while trying to figure out how to do some useless thing. (See below... and say, wasn't there a journalist who had a whole column to this effect? Ten points if you can tell me who that is. (My google-fu failed me just now.))

## Usage

Do something like: `noless man man`. This will run `man` but show only the first page (with colors intact) and go back to the shell prompt (just like `cat`. Kinda. See below.).

## How It Works

It uses `unbuffer` (from `expect`) to trick `man` (or whatever other command you loose it upon) into thinking its outputting to the terminal like usual.

## Caveats
