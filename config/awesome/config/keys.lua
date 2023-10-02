local awful = require("awful")
local mod = "Mod4"

-- Mouse

client.connect_signal("request::default_mousebindings", function()
	awful.mouse.append_client_mousebindings({

		-- Move

		awful.button({ mod }, 1, function(c)
			c:activate { context = "mouse_click", action = "mouse_move" }
		end),

		-- Resize

		awful.button({ mod }, 3, function(c)
			c:activate { context = "mouse_click", action = "mouse_resize" }
		end),

	})
end)

-- Keys

awful.keyboard.append_global_keybindings({

	-- Awesome

	awful.key(
		{ mod, "Shift" }, "r",
		awesome.restart,
		{ description = "reload awesome", group = "awesome" }
	),
	awful.key(
		{ mod }, "z", function()
			awful.layout.inc(1)
		end,
		{ description = "next layout", group = "awesome" }
	),
	awful.key(
		{ mod, "Shift" }, "z", function()
			awful.layout.inc(-1)
		end,
		{ description = "previous layout", group = "awesome" }
	),
	awful.key(
		{ mod }, "space", function()
			awesome.emit_signal("widget::menu")
		end,
		{ description = "show menu", group = "awesome" }
	),
	awful.key(
		{ mod }, "d", function()
			awful.spawn.with_shell("rofi -show drun -theme ~/.config/awesome/theme/rofi.rasi")
		end,
		{ description = "show launcher", group = "awesome" }
	),
	awful.key(
		{ mod, "Shift" }, "c", function()
			awesome.emit_signal("widget::config")
		end,
		{ description = "show config", group = "awesome" }
	),
	awful.key(
		{ mod }, "BackSpace", function()
			awful.spawn.with_shell(user.lock)
		end,
		{ description = "lock screen", group = "awesome" }
	),
	awful.key(
		{ mod }, "grave", function()
			awful.spawn.with_shell("firefox https://github.com/p3nguin-kun/penguinRice/wiki/Keybindings-and-commands")
		end,
		{ description = "wiki", group = "awesome" }
	),



	-- Programs

	awful.key(
		{ mod }, "Return", function()
			awful.spawn.with_shell(user.terminal)
		end,
		{ description = "open a terminal", group = "programs" }
	),

	-- Screenshot

	awful.key(
		{ mod }, "Delete", function()
			awful.spawn.with_shell("~/.config/awesome/bin/screenshot")
		end,
		{ description = "full screen", group = "screenshot" }
	),
	awful.key(
		{ mod, "Control" }, "Delete", function()
			awful.spawn.with_shell("~/.config/awesome/bin/screenshot-delay")
		end,
		{ description = "full screen delay", group = "screenshot" }
	),
	awful.key(
		{ mod, "Shift" }, "Delete", function()
			awful.spawn.with_shell("~/.config/awesome/bin/screenshot-select")
		end,
		{ description = "part screen", group = "screenshot" }
	),

	awful.key(
		{}, "Print", function()
			awful.spawn.with_shell("~/.config/awesome/bin/screenshot")
		end,
		{ description = "full screen", group = "screenshot" }
	),
	awful.key(
		{ "Control" }, "Print", function()
			awful.spawn.with_shell("~/.config/awesome/bin/screenshot-delay")
		end,
		{ description = "full screen delay", group = "screenshot" }
	),
	awful.key(
		{ "Shift" }, "Print", function()
			awful.spawn.with_shell("~/.config/awesome/bin/screenshot-select")
		end,
		{ description = "part screen", group = "screenshot" }
	),


	-- Volume

	awful.key(
		{}, "XF86AudioRaiseVolume", function()
			awful.spawn.with_shell("wpctl set-mute @DEFAULT_AUDIO_SINK@ 0")
			awful.spawn.with_shell("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+")
			awesome.emit_signal("widget::volume")
		end,
		{ description = "raise volume", group = "volume" }
	),
	awful.key(
		{}, "XF86AudioLowerVolume", function()
			awful.spawn.with_shell("wpctl set-mute @DEFAULT_AUDIO_SINK@ 0")
			awful.spawn.with_shell("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-")
			awesome.emit_signal("widget::volume")
		end,
		{ description = "lower volume", group = "volume" }
	),
	awful.key(
		{}, "XF86AudioMute", function()
			awful.spawn.with_shell("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle")
			awesome.emit_signal("widget::volume")
		end,
		{ description = "mute volume", group = "volume" }
	),

	awful.key(
		{ mod, "Control" }, "equal", function()
			awful.spawn.with_shell("wpctl set-mute @DEFAULT_AUDIO_SINK@ 0")
			awful.spawn.with_shell("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+")
			awesome.emit_signal("widget::volume")
		end,
		{ description = "raise volume", group = "volume" }
	),
	awful.key(
		{ mod, "Control" }, "minus", function()
			awful.spawn.with_shell("wpctl set-mute @DEFAULT_AUDIO_SINK@ 0")
			awful.spawn.with_shell("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-")
			awesome.emit_signal("widget::volume")
		end,
		{ description = "lower volume", group = "volume" }
	),
	awful.key(
		{ mod, "Control" }, "0", function()
			awful.spawn.with_shell("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle")
			awesome.emit_signal("widget::volume")
		end,
		{ description = "mute volume", group = "volume" }
	),



	-- Brightness

	awful.key(
		{}, "XF86MonBrightnessUp", function()
			awful.spawn.with_shell("brightnessctl s 5%+")
			awesome.emit_signal("widget::brightness")
		end,
		{ description = "raise brightness", group = "brightness" }
	),
	awful.key(
		{}, "XF86MonBrightnessDown", function()
			awful.spawn.with_shell("brightnessctl s 5%-")
			awesome.emit_signal("widget::brightness")
		end,
		{ description = "lower brightness", group = "brightness" }
	),

	awful.key(
		{ mod, "Control" }, "bracketright", function()
			awful.spawn.with_shell("brightnessctl s 5%+")
			awesome.emit_signal("widget::brightness")
		end,
		{ description = "raise brightness", group = "brightness" }
	),
	awful.key(
		{ mod, "Control" }, "bracketleft", function()
			awful.spawn.with_shell("brightnessctl s 5%-")
			awesome.emit_signal("widget::brightness")
		end,
		{ description = "lower brightness", group = "brightness" }
	),


	-- Tag

	awful.key {
		modifiers   = { mod },
		keygroup    = "numrow",
		description = "only view tag",
		group       = "tag",
		on_press    = function(index)
			local screen = awful.screen.focused()
			local tag = screen.tags[index]
			if tag then
				tag:view_only()
			end
		end,
	},
	awful.key {
		modifiers   = { mod, "Shift" },
		keygroup    = "numrow",
		description = "move focused client to tag",
		group       = "tag",
		on_press    = function(index)
			if client.focus then
				local tag = client.focus.screen.tags[index]
				if tag then
					client.focus:move_to_tag(tag)
				end
			end
		end,
	},
})

client.connect_signal("request::default_keybindings", function()
	awful.keyboard.append_client_keybindings({

		-- Client

		awful.key(
			{ mod }, "c",
			function(c)
				awful.placement.centered(c, { honor_workarea = true })
			end,
			{ description = "center window", group = "client" }
		),
		awful.key(
			{ mod }, "f",
			function(c)
				c.fullscreen = not c.fullscreen
				c:raise()
			end,
			{ description = "toggle fullscreen", group = "client" }
		),
		awful.key(
			{ mod }, "s",
			function(c)
				c.floating = not c.floating
				c:raise()
			end,
			{ description = "toggle floating", group = "client" }
		),
		awful.key(
			{ mod }, "n",
			function(c)
				client.focus.minimized = true
			end,
			{ description = "minimize", group = "client" }
		),
		awful.key(
			{ mod }, "m",
			function(c)
				c.maximized = not c.maximized
				c:raise()
			end,
			{ description = "toggle maximize", group = "client" }
		),
		awful.key(
			{ mod }, "q", function(c)
				c:kill()
			end,
			{ description = "close", group = "client" }
		),
		-- Focus client by direction (arrow keys)
		awful.key({ mod }, "Down",
			function()
				awful.client.focus.byidx(1)
			end,
			{ description = "next window", group = "client" }),
		awful.key({ mod }, "Up",
			function()
				awful.client.focus.byidx(-1)
			end,
			{ description = "previous window", group = "client" }),
		awful.key({ mod }, "Left",
			function()
				awful.tag.incmwfact(-0.01)
			end,
			{ description = "resize left", group = "client" }),
		awful.key({ mod }, "Right",
			function()
				awful.tag.incmwfact(0.01)
			end,
			{ description = "resize right", group = "client" }),

		-- Focus client by direction (hjkl keys)
		awful.key({ mod }, "j",
			function()
				awful.client.focus.byidx(1)
			end,
			{ description = "next window", group = "client" }),
		awful.key({ mod }, "k",
			function()
				awful.client.focus.byidx(-1)
			end,
			{ description = "previous window", group = "client" }),
		awful.key({ mod }, "h",
			function()
				awful.tag.incmwfact(-0.01)
			end,
			{ description = "resize left", group = "client" }),
		awful.key({ mod }, "l",
			function()
				awful.tag.incmwfact(0.01)
			end,
			{ description = "resize right", group = "client" }),

	})
end)

-- Move client with hjkl
awful.keyboard.append_global_keybindings({
	awful.key({ mod, "Shift" }, "j", function() awful.client.swap.byidx(1) end,
		{ description = "swap with next client by index", group = "client" }),
	awful.key({ mod, "Shift" }, "k", function() awful.client.swap.byidx(-1) end,
		{ description = "swap with previous client by index", group = "client" }),
	awful.key({ mod, "Shift" }, "h", function() awful.tag.incnmaster(1, nil, true) end,
		{ description = "increase the number of master clients", group = "layout" }),
	awful.key({ mod, "Shift" }, "l", function() awful.tag.incnmaster(-1, nil, true) end,
		{ description = "decrease the number of master clients", group = "layout" }),
})

-- Move client with arrow keys
awful.keyboard.append_global_keybindings({
	awful.key({ mod, "Shift" }, "Down", function() awful.client.swap.byidx(1) end,
		{ description = "swap with next client by index", group = "client" }),
	awful.key({ mod, "Shift" }, "Up", function() awful.client.swap.byidx(-1) end,
		{ description = "swap with previous client by index", group = "client" }),
	awful.key({ mod, "Shift" }, "Left", function() awful.tag.incnmaster(1, nil, true) end,
		{ description = "increase the number of master clients", group = "layout" }),
	awful.key({ mod, "Shift" }, "Right", function() awful.tag.incnmaster(-1, nil, true) end,
		{ description = "decrease the number of master clients", group = "layout" }),
})
