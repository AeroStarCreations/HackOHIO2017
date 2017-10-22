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
    alt1ft = alt1*(3.28084)
    alt2ft = alt2
    distance = (((lat1ft- lat2ft)^2) + ((lon1ft - lon2ft)^2) + ((alt1ft - alt2ft)^2))^(1/2)
    return distance
end

--find latitude, longitude, altitude of user 1
local locationHandler = function( event )
    local latitudeText1 = string.format( "Latitude:\n %.4f\n", event.latitude )
    local longitudeText1 = string.format( "Longitude:\n%.4f", event.longitude )
    local altitudeText1 = string.format( "Altititude:\n%.4f", event.altitude)
    local latitude1 = display.newText( latitudeText1, display.contentWidth/2, display.contentHeight/4, native.systemFont, 45 )
    local longitude1 = display.newText( longitudeText1, latitude1.x, display.contentHeight/2, native.systemFont, 45 )
    local altitude1 = display.newText( altitudeText1, latitude1.x, display.contentHeight*(3/4), native.systemFont, 45)

    --given coordinate values for user 2
    lat2 = 39.9980
    lon2 = -83.0142
    alt2 = 738
    --call function findDistance to find distance in feet
    distance = findDistance(event.latitude, event.longitude, event.altitude, lat2, lon2, alt2)
    local distanceText = string.format( "Distance:\n %.4f feet", distance)
    local distance1 = display.newText(distanceText, latitude1.x, display.contentHeight*.9, native.systemFont, 45)
end

Runtime:addEventListener( "location", locationHandler )

--[[ local GS = require("plugin.gamesparks")

local function writeText(string)
    print(string)
end

local function availabilityCallback(isAvailable)
    writeText("Availability: " .. tostring(isAvailable) .. "\n")

    if isAvailable then
        --Do something
    end

end

--Create GS Instance
gs = createGS()
--Set the logger for debugging the Responses, Messages and Requests flowing in and out
gs.setLogger(writeText)
--Set API Key
gs.setApiKey("z321094vxS3F")
--Set Secret
gs.setApiSecret("gfAMnRRDZaueUFWF3VgMDNADBP1y0nlu")
--Set Credential
gs.setApiCredential("device")
--Set availability callback function
gs.setAvailabilityCallback(availabilityCallback)
--Connect to your game's backend
gs.connect()

--------------------Authentication
--Build request
local requestBuilder = gs.getRequestBuilder()
local deviceAuthenticationRequest = requestBuilder.createDeviceAuthenticationRequest()
local saveLocationRequest = requestBuilder.createLogEventRequest()
local getLocationRequest = requestBuilder.createLogEventRequest()

--Set values
deviceAuthenticationRequest:setDeviceId(system.getInfo("deviceID"))
deviceAuthenticationRequest:setDeviceOS(system.getInfo("platform"))
saveLocationRequest:setEventKey("Set_Position")
--Emily's function.
saveLocationRequest:setEventAttribute("POS",{X=23,Y=23,Z=23})
getLocationRequest:setEventKey("Get_Position")

--Send and print authentication token
deviceAuthenticationRequest:send(function(authenticationResponse)
    writeText("token: "..authenticationResponse:getAuthToken().."\n")
end)

--Send request and check for errors
saveLocationRequest:send(function(response)
    if response:hasErrors() then
        for key,value in pairs(response:getErrors()) do print(key,value) end
    end
end)

--Send request.
getLocationRequest:send(function(response)
    --Process Response
    if response:hasErrors() then--If errors then print errors
        for key,value in pairs(response:getErrors()) do print(key,value) end
        --Else extract the POS variable (Type table) and print the contents within it
    else local POS = response:getScriptData().POS
        for key,value in pairs(POS) do print(key,value) end
    end
end) ]]

--[[ local cameraImage = display.newRect(display.contentCenterX, display.contentCenterY, display.contentHeight*(3/4), display.contentHeight)
cameraImage.fill = { type = "camera" }

local function updateCamera()
    cameraImage.fill = { type="camera" }
end

 Runtime:addEventListener("enterFrame", updateCamera) ]]
