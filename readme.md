# dotfiles

The dotfiles I use on my machines. (currently a desktop running Arch, and a MacBook Pro)

## Instructions

Clone this repo, and run `setup.py`, either by running `python setup.py` or `./setup.py`. Do not delete the cloned repo.

## Notes

Most colours here are based on / taken from [here](https://github.com/joshdick/onedark.vim).

```
|  Color Name  |         RGB        |   Hex   |
| Black        | rgb(40, 44, 52)    | #282c34 |
| White        | rgb(171, 178, 191) | #abb2bf |
| Light Red    | rgb(224, 108, 117) | #e06c75 |
| Dark Red     | rgb(190, 80, 70)   | #be5046 |
| Green        | rgb(152, 195, 121) | #98c379 |
| Light Yellow | rgb(229, 192, 123) | #e5c07b |
| Dark Yellow  | rgb(209, 154, 102) | #d19a66 |
| Blue         | rgb(97, 175, 239)  | #61afef |
| Magenta      | rgb(198, 120, 221) | #c678dd |
| Cyan         | rgb(86, 182, 194)  | #56b6c2 |
| Gutter Grey  | rgb(76, 82, 99)    | #4b5263 |
| Comment Grey | rgb(92, 99, 112)   | #5c6370 |
```
I've created a 16-colour version of this, by adding 20 to the saturation value (in HSV) to each colour.

```yaml
# Normal colors
normal:
  black: "#282c34"
  red: "#be5046"
  green: "#98c379"
  yellow: "#e5c07b"
  blue: "#61afef"
  magenta: "#c678dd"
  cyan: "#56b6c2"
  white: "#abb2bf"

# Bright colors
bright:
  black: "#4b5263"
  red: "#bf2e21"
  green: "#80c251"
  yellow: "#e6b04e"
  blue: "#329af0"
  magenta: "#bc4bde"
  cyan: "#2fb1c2"
  white: "#ccd0d8"
```

---

The content in this repository is available under version 2.0 of the Mozilla Public Licence
