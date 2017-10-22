-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

local GS = require("plugin.gamesparks")
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
multiplayer = gs.getMultiplayer()

--------------------Authentication
--Build request
local requestBuilder = gs.getRequestBuilder()
local deviceAuthenticationRequest = requestBuilder.createDeviceAuthenticationRequest()
local saveLocationRequest = requestBuilder.createLogEventRequest()
local getLocationRequest = requestBuilder.createLogEventRequest()

authenticateTheUser = function()
    --Set values
    deviceAuthenticationRequest:setDeviceId(system.getInfo("deviceID"))
    deviceAuthenticationRequest:setDeviceOS(system.getInfo("platform"))

    --Send and print authentication token
    deviceAuthenticationRequest:send(function(authenticationResponse)
        writeText("token: "..authenticationResponse:getAuthToken().."\n")
    end)

    -- Call Emily's function to set long., lat., and alt.
    sendLocation = function(Longitude, Latitude, Altitude)
        saveLocationRequest:setEventKey("Set_Position")
        saveLocationRequest:setEventAttribute("POS",{X=Longitude,Y=Latitude,Z=Altitude})
    end
end

--Send request.
getLocation = function()
    getLocationRequest:setEventKey("Get_Position")
    saveLocationRequest:send(function(response)
        if response:hasErrors() then
            for key,value in pairs(response:getErrors()) do print(key,value) end
        end
    end)
    getLocationRequest:send(function(response)
        --Process Response
        if response:hasErrors() then--If errors then print errors
            for key,value in pairs(response:getErrors()) do print(key,value) end
            --Else extract the POS variable (Type table) and print the contents within it
        else local POS = response:getScriptData().POS
            for key,value in pairs(POS) do print(key,value) end
        end
    end)
end

authenticateTheUser()

sendLocation(2,4,7)
getLocation()

sendLocation(1,1,2.3)
getLocation()

--local cameraImage = display.newRect(display.contentCenterX, display.contentCenterY, display.contentHeight, display.contentWidth)
--cameraImage.fill = { type = "camera" }
