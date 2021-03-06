--
-- For more information on config.lua see the Project Configuration Guide at:
-- https://docs.coronalabs.com/guide/basics/configSettings
--

local aspectRatio = display.pixelHeight / display.pixelWidth

application = {
    content = {
        width = aspectRatio > 1.5 and 800 or math.floor( 1200 / aspectRatio ),
        height = aspectRatio < 1.5 and 1200 or math.floor( 800 * aspectRatio ),
        scale = "letterBox",
        fps = 60,
        imageSuffix = {
             ["@2x"] = 1.3,
        },
    },
}
