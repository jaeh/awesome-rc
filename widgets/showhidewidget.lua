local wibox = require('wibox')
local vicious = require('vicious')
local awful = require('awful')

local cpuwidget = require("widgets/cpuwidget")
local wifiwidget = require("widgets/wifiwidget")
local memwidget = require("widgets/memwidget")
local shspacer = require("widgets/shspacer")
local volumewidget = require("widgets/volumewidget")

-- Create a showhidewidget
-- shows the text more if closed and less if open
-- sets vicious.showhide which can be used to show or hide other widgets

showhidewidget = wibox.widget.textbox()

vicious.showhide = false

-- Register widget
vicious.register(showhidewidget, vicious.widgets.cpu, 
  function(widget, args)
    if vicious.showhide == true then
      return "less"
    end

    return "more"
  end, 
  10000) 

-- left click shows and hides widgets
showhidewidget:buttons(awful.util.table.join(
  awful.button({}, 1, function()     
    -- toggle value
    vicious.showhide = not vicious.showhide 

    -- force all widgets to reload and show themselves
    vicious.force({cpuwidget})  
    vicious.force({memwidget})  
    vicious.force({wifiwidget}) 
    vicious.force({shspacer}) 
    vicious.force({volumewidget})
    vicious.force({showhidewidget})
  end)
))

return showhidewidget
