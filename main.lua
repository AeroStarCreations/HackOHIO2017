-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------

local server = require("server")
server.setCoordinates(1, 2, 3)
local coordinates = server.getCoordinates()
print("*******************")
print(unpack(coordinates))
print("endasdfasdf")
--[[ for i = 1, #coordinates, 1 do
    print(coordinates[i])
end ]]
