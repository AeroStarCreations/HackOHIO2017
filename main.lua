-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

-- Your code here

local latitude = display.newText( "-", 100, 50, native.systemFont, 16 )
local longitude = display.newText( "-", 100, 100, native.systemFont, 16 )
local latitudeText = string.format( '%.4f', event.latitude )
latitude.text = latitudeText

Runtime:addEventListener( "location", locationHandler )