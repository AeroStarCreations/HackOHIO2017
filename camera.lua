local function takePhoto( event )
       local photo = event.target
       print( "photo w,h = " .. photo.width .. "," .. photo.height )
    end
media.capturePhoto( { listener=takePhoto } )
