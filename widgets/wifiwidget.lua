local wibox = require('wibox')
local vicious = require('vicious')
local awful = require("awful")
local beautiful = require('beautiful')

-- Create a wifiwidget
-- It displays the SSID of the net you are connected to ( args["{ssid}"] ) and the percentage of connectivity ( args["{link}"] )
-- Initialize widget
local wifiwidget = wibox.widget.textbox()

-- Register widget
vicious.register(wifiwidget, vicious.widgets.wifi, function(widget, args)
  link = args["{link}"]
  ssid = args["{ssid}"]

    -- if there is no wifi connected:
  if ssid == "N/A" and vicious.showhide == true then
    return "no net"
  end

  local color = "white"

  if link < 10 then
	color = beautiful.widget.red
  elseif link < 20 then
	color = beautiful.widget.pink
  elseif link < 40 then
	color = beautiful.widget.yellow
  elseif link < 60 then
	color = beautiful.widget.lightgreen
  elseif link < 80 then
	color = beautiful.widget.green
  end
 
  local value = ''
  if vicious.showhide == true then 
    value = '<span color="' .. color .. '">' .. ssid .. ' ' .. link .. '%</span>'
  end

  return value
end, 10, "wlp59s0")

local control_open = 0

wifiwidget:buttons(awful.util.table.join(
	awful.button({ }, 1, 
	function () 
		if control_open == 0 then
			control_open = 1
			awful.util.spawn("nm-tray")
		elseif control_open == 1 then
			control_open = 0
			awful.util.spawn("killall nm-tray")
		end
	end)
))

return wifiwidget
