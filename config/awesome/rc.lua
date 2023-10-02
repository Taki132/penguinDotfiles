-- Errors

require("naughty").connect_signal("request::display_error", function(message, startup)
    require("naughty").notification {
        urgency = "critical",
        title   = "Error"..(startup and " during startup!" or "!"),
        message = message
    }
end)

-- User

local r = assert(io.open(".config/awesome/json/user.json", "r"))
local table = r:read("*all")
r:close()

user = require("json.json").decode(table)

-- Config

require("awful.autofocus")
require("signal")
require("config")
require("theme")

-- Screen setup
require("awful").spawn.with_shell("~/.screenlayout/monitor")

-- Autostart
require("awful").spawn.with_shell("~/.config/awesome/autostart")
