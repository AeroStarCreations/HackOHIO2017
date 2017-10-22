-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------
display.setStatusBar(display.HiddenStatusBar)
--calculate distance, convert from coordinates to feet
local function findDistance(lat1, lon1, alt1, lat2, lon2, alt2)
    lat1ft = lat1*(69*5280)
    lat2ft = lat2*(69*5280)
    lon1ft = lon1*(69*5280)
    lon2ft = lon2*(69*5280)
    alt1ft = alt1*(69*5280)
    alt2ft = alt2*(69*5280)
    distance = ((lat1ft- lat2ft)^2 + (lon1ft - lon2ft)^2 + (alt1ft - alt2ft)^2)^(1/2)
    return distance
end

--find latitude, longitude, altitude of user 1
local locationHandler = function( event )
    local latitudeText1 = string.format( "Latitude:\n %.4f\n", event.latitude )
    local longitudeText1 = string.format( "Longitude:\n%.4f", event.longitude )
    local altitudeText1 = string.format( "Altititude:\n%.4f", event.altitude)
    local latitude1 = display.newText( latitudeText1, 150, 150, native.systemFont, 16 )
    local longitude1 = display.newText( longitudeText1, 150, 225, native.systemFont, 16 )
    local altitude1 = display.newText( altitudeText1, 150, 300, native.systemFont, 16)

    --given coordinate values for user 2
    lat2 = 34.00*(69*5280)
    lon2 = -134.00*(69*5280)
    alt2 = 3.00*(69*5280)
    --call function findDistance to find distance in feet
    distance = findDistance(event.latitude, event.longitude, event.altitude, lat2, lon2, alt2)
    local distanceText = string.format( "Distance:\n %.4f feet", distance)
    local distance1 = display.newText(distanceText, 150, 375, native.systemFont, 16)
end

Runtime:addEventListener( "location", locationHandler )



















local function takePhoto( event )
       local photo = event.target
       print( "photo w,h = " .. photo.width .. "," .. photo.height )
    end
media.capturePhoto( { listener=onCm } )




--local cameraImage = display.newRect(display.contentCenterX, display.contentCenterY, display.contentHeight, display.contentWidth)
--cameraImage.fill = { type = "camera"}