local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")
local dpi = beautiful.xresources.apply_dpi

-- Menu

local menu = hovercursor(wibox.widget({
	buttons = {
		awful.button({}, 1, function()
			awesome.emit_signal("widget::menu")
		end),
	},
	image = beautiful.awesome,
	widget = wibox.widget.imagebox,
}))

-- Clock

local clock = wibox.widget.textclock("%a %I:%M %p")

-- Screen

screen.connect_signal("request::desktop_decoration", function(s)
	-- Taglist

	s.taglist = hovercursor(awful.widget.taglist({
		screen = s,
		filter = awful.widget.taglist.filter.all,
		buttons = {
			awful.button({}, 1, function(t)
				t:view_only()
			end),
		},
	}))

	-- Tasklist

	s.tasklist = hovercursor(awful.widget.tasklist({
		screen = s,
		filter = awful.widget.tasklist.filter.currenttags,
		widget_template = {
			{
				{
					id = "text_role",
					forced_height = dpi(20),
					widget = wibox.widget.textbox,
				},
				valign = "center",
				halign = "center",
				widget = wibox.container.place,
			},
			id = "background_role",
			widget = wibox.container.background,
		},
		buttons = {
			awful.button({}, 1, function(c)
				c:activate({ context = "tasklist", action = "toggle_minimization" })
			end),
		},
	}))

	-- Layouts

	s.layouts = hovercursor(awful.widget.layoutbox({
		screen = s,
		buttons = {
			awful.button({}, 1, function()
				awful.layout.inc(1)
			end),
			awful.button({}, 3, function()
				awful.layout.inc(-1)
			end),
		},
	}))

	-- Panel

	s.wibar = awful.wibar({
		position = "top",
		height = dpi(24),
		bg = beautiful.bg_normal,
		fg = beautiful.fg_normal,
		screen = s,
		widget = {
			{
				{
					menu,
					s.taglist,
					s.layouts,
					spacing = dpi(10),
					layout = wibox.layout.fixed.horizontal,
				},
				s.tasklist,
				{
					clock,
					controlspanel,
					spacing = dpi(10),
					layout = wibox.layout.fixed.horizontal,
				},
				layout = wibox.layout.align.horizontal,
			},
			margins = dpi(3),
			widget = wibox.container.margin,
		},
	})
end)
