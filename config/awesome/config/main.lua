local awful = require("awful")

-- Sloppy focus
client.connect_signal("mouse::enter", function(c)
    c:activate { context = "mouse_enter", raise = false }
end)

-- Layouts and tag table
screen.connect_signal("request::desktop_decoration", function(s)
    tag.connect_signal("request::default_layouts", function()
        awful.layout.append_default_layouts({
            awful.layout.suit.tile,
            awful.layout.suit.floating,
            awful.layout.suit.max,
            awful.layout.suit.spiral.dwindle,
            awful.layout.suit.fair,

        })
    end)

    if user.jtag then
        awful.tag({ "一", "二", "三", "四", "五", "六" }, s, awful.layout.layouts[1])
    else
        awful.tag({ "1", "2", "3", "4", "5", "6" }, s, awful.layout.layouts[1])
    end
end)
