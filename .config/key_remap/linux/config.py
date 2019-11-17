import re

from xkeysnail.transform import *

define_modmap({Key.CAPSLOCK: Key.LEFT_CTRL})


# something remap
define_multipurpose_modmap(
    {
        # Key.LEFT_CTRL: [Key.ESC, Key.LEFT_CTRL],
        Key.LEFT_CTRL: [Key.ESC, Key.LEFT_CTRL],
        # SandS
        Key.SPACE: [Key.SPACE, Key.LEFT_SHIFT],
        Key.LEFT_ALT: [Key.MUHENKAN, Key.LEFT_ALT],
        Key.RIGHT_ALT: [Key.HENKAN, Key.RIGHT_ALT],
    }
)

define_keymap(
    None,
    {
        K("LC-key_1"): with_mark(K("f1")),
        K("LC-key_2"): with_mark(K("f2")),
        K("LC-key_3"): with_mark(K("f3")),
        K("LC-key_4"): with_mark(K("f4")),
        K("LC-key_5"): with_mark(K("f5")),
        K("LC-key_6"): with_mark(K("f6")),
        K("LC-key_7"): with_mark(K("f7")),
        K("LC-key_8"): with_mark(K("f8")),
        K("LC-key_9"): with_mark(K("f9")),
        K("LC-key_0"): with_mark(K("f10")),
        K("LC-minus"): with_mark(K("f11")),
        K("LC-equal"): with_mark(K("f12")),
    },
    "Global",
)
