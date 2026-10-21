{pinentry-curses}:
pinentry-curses.overrideAttrs (oldAttrs: {
  patches = oldAttrs.patches or [] ++ [./ctrl-c-clears-pin.patch];
})
