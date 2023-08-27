local theme_path = require("gears").filesystem.get_configuration_dir() .. "color/macintosh/"
local color = {}

color.bg      	   = "#f3f3f3"
color.fg 	   	   = "#000000"
color.black		   = "#4b4646"
color.white		   = "#dddddd"
color.red		   = "#e70000"
color.green		   = "#0abf0a"
color.yellow	   = "#dada00"
color.blue		   = "#0000ff"
color.magenta	   = "#d7a0e6"
color.cyan		   = "#8080ff"

color.bgalt        = color.white
color.icons		   = "Qogir"

return color
