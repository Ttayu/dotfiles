import os
import sys

import pyauto
from keyhac import *


def configure(keymap):
    # --------------------------------------------------------------------
    # Customizing the display

    # Font
    keymap.setFont("MS Gothic", 12)

    # Theme
    keymap.setTheme("black")

    # --------------------------------------------------------------------

    keymap_global = keymap.defineWindowKeymap()

    # SandS
    keymap.replaceKey("Space", "RShift")
    keymap_global["O-RShift"] = "Space"
    keymap_global["O-LC-RShift"] = "C-Space"

    # ctrl and escape
    keymap_global["O-LCtrl"] = "Esc"

    # Ctrl + 数値 で Fn
    keymap_global["C-1"] = "F1"
    keymap_global["C-2"] = "F2"
    keymap_global["C-3"] = "F3"
    keymap_global["C-4"] = "F4"
    keymap_global["C-5"] = "F5"
    keymap_global["C-6"] = "F6"
    keymap_global["C-7"] = "F7"
    keymap_global["C-8"] = "F8"
    keymap_global["C-9"] = "F9"
    keymap_global["C-0"] = "F10"
    keymap_global["C-Minus"] = "F11"
    keymap_global["C-Caret"] = "F12"
