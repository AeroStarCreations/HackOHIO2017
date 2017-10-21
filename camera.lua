--[[
Camera.lua
File is just supposed to show what the camera sees
--]]
 
local composer = require( "composer" )
local media = require ("media") 
local scene = composer.newScene()
 
-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------
 
 local hasAccessToCamera, hasCamera = media.hasSource( media.Camera )
 local onComplete = function( event )
    print( "Returned from camera view." )
	local image = event
	image.x = display.contentCenterX
	image.y = display.contentCenterY
	
	
	
	local playHeight = 0.33 * display.contentHeight;	
	local playWidth = 1.2 * playHeight;
	local vertices = { -.5 *playWidth, - .5*playHeight, -.5*playWidth, .5*playHeight, .5*playWidth, 0}; 
		
	local playButton = display.newPolygon(sceneGroup, 1.25 * display.contentCenterX, 1.2 * display.contentCenterY, vertices);
	playButton:setFillColor( unpack(red))
	
	if event.completed then
		displaynewText(sceneGroup, "complete", 0, 0, native.systemFont, .15*display.contentHeight)
		
	end
end
 
 
-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------
 
-- create()
function scene:create( event )
 
    local sceneGroup = self.view
    -- Code here runs when the scene is first created but has not yet appeared on screen
 
end
 

-- show()
function scene:show( event )
 
    local sceneGroup = self.view
    local phase = event.phase
	
	local status = display.newText(sceneGroup, "Status", 0.8 * display.contentCenterX, 
		display.contentHeight*0.3,  native.systemFont, 0.15 * display.contentHeight );
 
 
    if ( phase == "will" ) then
        -- Code here runs when the scene is still off screen (but is about to come on screen)
		if ( hasAccessToCamera == true ) then
			-- There is access to the camera
			media.capturePhoto( { listener = onComplete } )
		elseif ( hasCamera == true and native.canShowPopup( "requestAppPermission" ) ) then
			-- A camera exists, but there is no access to it!
			native.showPopup( "requestAppPermission", { appPermission="Camera" } )
		else
			native.showAlert( "Corona", "This device does not have a camera.", { "OK" } )
		end
		
    elseif ( phase == "did" ) then
        -- Code here runs when the scene is entirely on screen
		media.capturePhoto({onComplete}) 
		--Cool, we did it. We got a picture. Could be good since we do want them to take a picture of the stuff. 
		
    end
end
 
 
-- hide()
function scene:hide( event )
 
    local sceneGroup = self.view
    local phase = event.phase
 
    if ( phase == "will" ) then
        -- Code here runs when the scene is on screen (but is about to go off screen)
 
    elseif ( phase == "did" ) then
        -- Code here runs immediately after the scene goes entirely off screen
 
    end
end
 
 
-- destroy()
function scene:destroy( event )
 
    local sceneGroup = self.view
    -- Code here runs prior to the removal of scene's view
 
end
 
 
-- -----------------------------------------------------------------------------------
-- Scene event function listeners
-- -----------------------------------------------------------------------------------
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )
-- -----------------------------------------------------------------------------------
 
return scene