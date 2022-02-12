#!/usr/bin/lua
local options = {
    ["鍵"] = "swaylock",
    ["切"] = "systemctl poweroff",
    ["再"] = "systemctl reboot",
    ["出"] = "swaymsg exit",
    ["寝"] = "systemctl suspend",
    ["眠"] = "systemctl hibernate",
}

local options_string = ""
local length = 0
for key, _ in pairs(options) do
    options_string = options_string .. key .. "\n"
    length = length + 1
end
options_string = options_string:sub(1, -2)

local f = assert(
    io.popen(
        "echo -e '"
            .. options_string
            .. "' | wofi --dmenu --insensitive --prompt 'Power menu' --width 300 --style ./powermenu.css --lines "
            .. length,
        "r"
    )
)
local s = assert(f:read("*a"))
s = string.gsub(s, "^%s+", "")
s = string.gsub(s, "%s+$", "")
s = string.gsub(s, "[\n]+", " ")
f:close()

os.execute(options[s])
