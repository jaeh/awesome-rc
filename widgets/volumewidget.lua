local wibox = require("wibox")
local vicious = require("vicious")
local awful = require("awful")

local naughty = require("naughty")

--My volume widget
local volumewidget = wibox.widget.textbox()

local control_open = 0

local volumewidget = wibox.widget.textbox()
vicious.register(volumewidget, vicious.widgets.volume,
	function (widget, args)
		local muted = args[2] == "♫"
		local indicator = muted and args[2] or ("<span color=\"red\">%s</span>"):format(args[2])
		local level = muted and ("%d"):format(args[1]) or ""
		if vicious.showhide == true then
			return ("%s%s "):format(indicator, level)
		else 
			return ""
		end
	end, 0.3, {"Master", "-D", "pulse"})

volumewidget:buttons(awful.util.table.join(
	awful.button({ }, 1,
	function () 
		if control_open == 0 then
			control_open = 1
			awful.util.spawn("pavucontrol")
		elseif control_open == 1 then
			control_open = 0
			awful.util.spawn("killall pavucontrol")
		end
	end)
))

return volumewidget
