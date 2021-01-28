local wibox = require("wibox")
local vicious = require("vicious")
local awful = require("awful")    
local naughty = require("naughty")

local thermwidget = wibox.widget.textbox()
local beautiful = require("beautiful")

vicious.register(thermwidget, vicious.widgets.thermal,
  function (widget, args)
    local value = ''

    -- if vicious.showhide == true then
      local color = beautiful.widget.white
      
      if args[1] > 90 then
        color = beautiful.widget.red
      elseif args[1] > 75 then
        color = beautiful.widget.yellow
  	  end

      value = args[1] .. '<span color="' .. color .. '">' .. 'C</span>'
    -- end

    return value
  end, 
7, "thermal_zone0")

thermwidget:buttons(awful.util.table.join(
  awful.button({}, 1, function()     
    awful.spawn("echo level 0 > /proc/acpi/ibm/fan")
    naughty.notify({ text = "fan reset" })         
  end)
))

return thermwidget
