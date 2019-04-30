#!/bin/python3
import os, subprocess

zshrc = os.path.expanduser("~/.zshrc")
initdotvim = os.path.expanduser("~/.config/nvim/init.vim")
pycodestyle = os.path.expanduser("~/.config/pycodestyle")
i3=os.path.expanduser("~/.config/i3")

subprocess.run(["rm", "-rf", zshrc])
subprocess.run(["ln", "-s", os.getcwd() + "/zshrc", zshrc])
print("Installed zshrc")

try:
    os.makedirs("~/.config/nvim")
except OSError:
    pass
subprocess.run(["rm", "-rf", initdotvim])
subprocess.run(["ln", "-s", os.getcwd() + "/init.vim", initdotvim])
print("Installed init.vim")

subprocess.run(["rm", "-rf", pycodestyle])
subprocess.run(["ln", "-s", os.getcwd() + "/pycodestyle", pycodestyle])
print("Installed pycodestyle")

subprocess.run(["rm", "-rf", i3])
subprocess.run(["ln", "-s", os.getcwd() + "/i3", i3])
print("Installed i3 configs")
