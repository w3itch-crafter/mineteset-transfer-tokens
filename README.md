### For developers
To read the source or contribute to this project, you need prepare following tools:
- emmylua
- an IDE supports emmylua (e.g. Intellij Idea, Vscode)

and learn following libraries(included in the source):
- chatcmdbuilder
- [minetest-api-types](https://github.com/grapereader/minetest-api-types)

### Install this mod
- copy `src/` to `worldmods/` in your world directory
- rename `src/` to `minetest_transfer_tokens`
- include this mod in the key `secure.http_mods` or `secure.trusted_mods` of `minetest.conf`
- modify `config.lua`

### Defined Chat Commands
- `/token address :username`: look for `username`'s blockchain address
