local application = require "mjolnir.application"
local hotkey = require "mjolnir.hotkey"
local window = require "mjolnir.window"
local fnutils = require "mjolnir.fnutils"

hotkey.bind({"cmd", "alt", "ctrl"}, "left", function()
  local win = window.focusedwindow()
  local f = win:frame()
  f.x = f.x - 20
  win:setframe(f)
end)

hotkey.bind({"cmd", "alt", "ctrl"}, "right", function()
  local win = window.focusedwindow()
  local f = win:frame()
  f.x = f.x + 20
  win:setframe(f)
end)

hotkey.bind({"cmd", "alt", "ctrl"}, "down", function()
  local win = window.focusedwindow()
  local f = win:frame()
  f.y = f.y - 20
  win:setframe(f)
end)

hotkey.bind({"cmd", "alt", "ctrl"}, "up", function()
  local win = window.focusedwindow()
  local f = win:frame()
  f.y = f.y + 20
  win:setframe(f)
end)
