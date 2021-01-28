local awful = require("awful")
local vicious = require("vicious")
local beautiful = require("beautiful")
local wibox = require("wibox")

-- Initialize widget
local sep = wibox.widget{
    widget = wibox.widget.separator,
    orientation = "vertical", 
    forced_width = 1,
    forced_height = 18
}

return sep
