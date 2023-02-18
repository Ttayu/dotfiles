from __future__ import annotations

from pathlib import Path

import toml

DEIN_REPO_DIR = Path().home() / ".cache/dein/repos/github.com"


def generate_plugin_rtp(plugin: str) -> str:
    content = f"set rtp+={DEIN_REPO_DIR / plugin}"
    return content


def generate_lua_command(lua: str) -> str:
    return f"lua << EOF\n{lua}EOF\n"


def generate_vim_command(vim: str) -> str:
    return vim


def check_hook(plugin: dict[str, str], hook_keys: list[str]) -> str | None:
    for key in hook_keys:
        if key in plugin:
            return key
    return None


def check_lua_hook(plugin: dict[str, str]) -> str | None:
    return check_hook(plugin, ["lua_add", "lua_source", "lua_post_source"])


def check_vim_hook(plugin: dict[str, str]) -> str | None:
    return check_hook(plugin, ["hook_add", "hook_source", "hook_post_source"])


def parse_toml_config(path: Path) -> str:
    with open(path, "r") as f:
        config = toml.load(f)
    contents: list[str] = []
    for plugin in config["plugins"]:
        contents.append(generate_plugin_rtp(plugin["repo"]))

    for plugin in config["plugins"]:
        if key := check_lua_hook(plugin):
            contents.append(generate_lua_command(plugin[key]))
        if key := check_vim_hook(plugin):
            contents.append(generate_vim_command(plugin[key]))
    return "\n".join(contents)


def main() -> None:
    text = ""
    dein_toml_files = (
        Path().home() / ".config/nvim/dein/dein.toml",
        Path().home() / ".config/nvim/dein/dein_ddc.toml",
        Path().home() / ".config/nvim/dein/dein_lsp.toml",
    )

    for file in dein_toml_files:
        text += parse_toml_config(file)
    text += "runtime rc/base.vim\nruntime rc/map.vim\nruntime rc/color.vim\n"
    with open("minimal_config.vim", "w") as f:
        f.write(text)


if __name__ == "__main__":
    main()
