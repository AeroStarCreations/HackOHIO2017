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
end)

local cameraImage = display.newRect(display.contentCenterX, display.contentCenterY, display.contentHeight, display.contentWidth)
cameraImage.fill = { type = "camera" }
