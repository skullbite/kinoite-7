#!/usr/bin/env python

import os

lines = []
def get_key(key: str):
    return next(i for i in lines if key in i).split("=")[1].replace("\n", "").replace("\"", "")

def edit_key(key: str, val: str | int):
    dex = lines.index(next(i for i in lines if key in i))
    lines[dex] = f"{key}={f'"{val}"' if type(val) == str else val}\n"

with open("/etc/os-release", "r") as file:
    lines = file.readlines()
    edit_key("NAME", "Kinoite 7" + ": Gamer Edition" if os.getenv("GAMER") == "1" else "")
    edit_key("PRETTY_NAME", get_key("NAME") + " " + get_key("VERSION"))
    edit_key("DEFAULT_HOSTNAME", "kinoite7")
    edit_key("HOME_URL", "https://github.com/skullbite/kinoite-7")

with open("/etc/os-release", "w") as file:
    file.write("".join(lines))