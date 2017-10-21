local GS = require("plugin.gamesparks")

--Longitude, Latitude, and Altitude from Emily.
local v = {}

--------------------Authentication
--Build request
local function writeText(string)
    print(string)
end

local function availabilityCallback(isAvailable)
    print("Availability: " .. tostring(isAvailable) .. "\n")

    if isAvailable then
        --Do something
    end

end

v.gs = createGS()
v.gs.setLogger(writeText)
v.gs.setApiKey("z321094vxS3F")
v.gs.setApiSecret("gfAMnRRDZaueUFWF3VgMDNADBP1y0nlu")
v.gs.setApiCredential("device")
v.gs.setAvailabilityCallback(availabilityCallback)
v.gs.connect()

v.requestBuilder = v.gs.getRequestBuilder()
v.deviceAuthenticationRequest = v.requestBuilder.createDeviceAuthenticationRequest()

--Set values
v.deviceAuthenticationRequest:setDeviceId(system.getInfo("deviceID"))
v.deviceAuthenticationRequest:setDeviceOS(system.getInfo("platform"))

--Send and print authentication token
v.deviceAuthenticationRequest:send(function(authenticationResponse)
    writeText("token: "..authenticationResponse:getAuthToken().."\n")
end)

------------------------GEt and Set Coordinates
v.setCoordinates = function(Latitude, Longitude, Altitude) 
    local saveLocationRequest = v.requestBuilder.createLogEventRequest()
    saveLocationRequest:setEventKey("Set_Position")
    --Emily's function.
    saveLocationRequest:setEventAttribute("POS",{X=Latitude,Y=Longitude,Z=Altitude})

    --Send request and check for errors
    saveLocationRequest:send(function(response)
        if response:hasErrors() then
            for key,value in pairs(response:getErrors()) do print(key,value) end
        end
    end)
end

v.getCoordinates = function()
    local getLocationRequest = v.requestBuilder.createLogEventRequest()
    getLocationRequest:setEventKey("Get_Position")
    local coordinates = {}
    --Send request.
    getLocationRequest:send(function(response)
        --Process Response
        if response:hasErrors() then--If errors then print errors
            for key,value in pairs(response:getErrors()) do print(key,value) end
            --Else extract the POS variable (Type table) and print the contents within it
        else local POS = response:getScriptData().POS
            for key,value in pairs(POS) do 
                --print(key,value)
                coordinates[key] = value
             end
        end      
    end)
    return coordinates
end

return v
