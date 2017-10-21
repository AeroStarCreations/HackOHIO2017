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

--Set values
deviceAuthenticationRequest:setDeviceId("1111")
deviceAuthenticationRequest:setDeviceOS("Corona")

--Send and print authentication token
deviceAuthenticationRequest:send(function(authenticationResponse)
writeText("token: "..authenticationResponse:getAuthToken().."\n")
end)