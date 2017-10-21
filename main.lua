-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

-- Your code here


Runtime:addEventListener( "location", locationHandler )
local locationHandler = function( event )
    

-- display latitude and longitude
local latitude = display.newText( latitudeText, 150, 200, native.systemFont, 16 )
local longitude = display.newText( longitudeText, 150, 400, native.systemFont, 16 )
local latitudeText = string.format( '%.4f', event.latitude )
local longitudeText = string.format( '%.4f', event.longitude )

