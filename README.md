This is a collection of tools meant to be used in addon and/or server development. Most tools were designed to be used on servers, and do not work at all on single player. If you need to use a tool on single player, start a 2 player LAN game instead.

# Tool List:
- Get color of trace entity.
- Get index, creation ID, and map creation ID of trace entity.
- Get model and material of trace entity.
- Get vector and angle of local player.
- Get vector and angles of trace entity relative to world.
- Get vector and angles relative to trace entity.
- Get velocity of trace entity. (Supports MPH, KPH, and Hammer Units per second.)
- Get class and name of trace entity.
- Find all entities of a specified class on the map.
- Create a boundary and get the upper and lower values of it

# Client Settings:
These settings are now saved client-side instead of server-side and can be accessed through the options tab of the spawn menu.

- DevTools_ShouldClipboard (Whether or not the text that a tool prints out gets copied to your clipboard.)
- DevTools_ShouldFancyText (Whether or not the text that a tool prints out gets formatted into a Lua function. (Ex: 0 0 0 gets formatted into Vector( 0, 0, 0 ))
- DevTools_ShouldRoundDecimals (Should angles and vectors have their decimals removed. Only available if fancy text is enabled.)

If you have any suggestions or bug reports, post them here on Github or on the [workshop page.](https://steamcommunity.com/sharedfiles/filedetails/?id=1614988605)
