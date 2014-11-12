-- Load Extensions
local application = require "mjolnir.application"
local window = require "mjolnir.window"
local hotkey = require "mjolnir.hotkey"
local fnutils = require "mjolnir.fnutils"
local alert = require "mjolnir.alert"
local grid = require "mjolnir.bg.grid"

-- Set up hotkey combinations
local mash = {"cmd", "alt", "ctrl"}
local mashshift = {"cmd", "alt", "shift"}
-- Set grid size.
grid.GRIDWIDTH  = 6
grid.GRIDHEIGHT = 4
grid.MARGINX = 0
grid.MARGINY = 0

hotkey.bind(mash, ';', function() grid.snap(window.focusedwindow()) end)
hotkey.bind(mash, "'", function() fnutils.map(window.visiblewindows(), grid.snap) end)

hotkey.bind(mash, '=', function() grid.adjustwidth( 1) end)
hotkey.bind(mash, '-', function() grid.adjustwidth(-1) end)
hotkey.bind(mashshift, '=', function() grid.adjustheight(1) end)
hotkey.bind(mashshift, '-', function() grid.adjustheight(-1) end)

hotkey.bind(mash, 'left', function() window.focusedwindow():focuswindow_west() end)
hotkey.bind(mash, 'right', function() window.focusedwindow():focuswindow_east() end)
hotkey.bind(mash, 'up', function() window.focusedwindow():focuswindow_north() end)
hotkey.bind(mash, 'down', function() window.focusedwindow():focuswindow_south() end)

hotkey.bind(mash, 'M', grid.maximize_window)

hotkey.bind(mash, 'N', grid.pushwindow_nextscreen)
hotkey.bind(mash, 'P', grid.pushwindow_prevscreen)

hotkey.bind(mash, 'J', grid.pushwindow_down)
hotkey.bind(mash, 'K', grid.pushwindow_up)
hotkey.bind(mash, 'H', grid.pushwindow_left)
hotkey.bind(mash, 'L', grid.pushwindow_right)

hotkey.bind(mash, 'I', grid.resizewindow_taller)
hotkey.bind(mash, 'O', grid.resizewindow_wider)
hotkey.bind(mash, 'Y', grid.resizewindow_thinner)
hotkey.bind(mash, 'U', grid.resizewindow_shorter)

alert.show("Mjolnir, at your service.")
