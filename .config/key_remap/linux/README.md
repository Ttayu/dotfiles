# Xkeysnial

`xkeysnail` is yet another keyboard remapping tool for X environment written in Python. It's like
`xmodmap` but allows more flexible remappings.

## Installation

Requires root privilege and **Python 3**.

### Ubuntu

    sudo apt install python3-pip
    sudo pip3 install xkeysnail

## Usage

    sudo xkeysnail config.py
    
When you encounter the errors like `Xlib.error.DisplayConnectionError: Can't connect to display ":0.0": b'No protocol specified\n'
`, try

    xhost +SI:localuser:root
    sudo xkeysnail config.py

If you want to specify keyboard devices, use `--devices` option:

    sudo xkeysnail config.py --devices /dev/input/event3 'Topre Corporation HHKB Professional'

If you have hot-plugging keyboards, use `--watch` option.

If you want to suppress output of key events, use `-q` / `--quiet` option especially when running as a daemon.

manual launch
```sh
mv ./start_xkeysnail.sh /etc/opt/xkeysnail/
mv ./config.py /etc/opt/xkeysnail/
sudo bash /etc/opt/xkeysnail/start_xkeysnail
```

auto launch when startup Ubuntu.
```sh
mv ./xkeysnail.service /etc/systemd/system/xkeysnail.service
sudo service xkeysnail enable
sudo service xkeysnail start
```

## License

`xkeysnail` is distributed under GPL.

    xkeysnail
    Copyright (C) 2018 Masafumi Oyamada

    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program.  If not, see <http://www.gnu.org/licenses/>.

`xkeysnail` is based on `pykeymacs`
 (https://github.com/DreaminginCodeZH/pykeymacs), which is distributed under
 GPL.

    pykeymacs
    Copyright (C) 2015 Zhang Hai

    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program.  If not, see <http://www.gnu.org/licenses/>.
