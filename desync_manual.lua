local menu = fatality.menu
local config = fatality.config
local input = fatality.input
local render = fatality.render
local engine_client = csgo.interface_handler:get_engine_client()
local entity_list = csgo.interface_handler:get_entity_list()
local aa_state_standing = menu:get_reference( "rage", "anti-aim", "standing", "yaw add" )
local aa_state_standing2 = menu:get_reference( "rage", "anti-aim", "standing", "add" )
local standing_fakedir = menu:get_reference( "rage", "anti-aim", "standing", "fake direction" )
local aa_state_moving = menu:get_reference( "rage", "anti-aim", "moving", "yaw add" )
local aa_state_moving2 = menu:get_reference( "rage", "anti-aim", "moving", "add" )
local moving_fakedir = menu:get_reference( "rage", "anti-aim", "moving", "fake direction" )
local aa_state_air = menu:get_reference( "rage", "anti-aim", "air", "yaw add" )
local aa_state_air2 = menu:get_reference( "rage", "anti-aim", "air", "add" )
local air_fakedir = menu:get_reference( "rage", "anti-aim", "air", "fake direction" )
local screen_size = render:screen_size()
local aa_state_item = config:add_item( "aa_state_item", 0 )
local aa_state_checkbox = menu:add_checkbox( "Advanced manual AA binds (M3/A/E)", "rage", "anti-aim", "general", aa_state_item )
local p_value_item = config:add_item ( "p_value" , 0 )
local p_value_slider = menu:add_slider( "p value", "rage", "anti-aim", "general", p_value_item ,0,180, 1)
local Desync_inverter_item = config:add_item( "Desync_inverter_item", 0 )
local Desync_inverter_checkbox = menu:add_checkbox( "Toggle invert Desync", "rage", "anti-aim", "general", Desync_inverter_item )
local font = render:create_font("arial", 25, 1,  true)
-- http://asger-p.dk/info/virtualkeycodes.php if you wanna change keys

local key = 0x58  -- Mouse 5 key 
local key2 = 0x51 -- Mouse 4 key
local key3 = 0x60 -- Mouse 3 key
local switch = false
local switch2 = false
local switch3 = false

fatality.callbacks:add("paint",

function()

if not engine_client:is_in_game( ) then
    return end
      
local local_player = entity_list:get_localplayer( )

if not local_player:is_alive( ) then
    return end

if not aa_state_item:get_bool() then

    aa_state_standing:set_bool(false)
    aa_state_moving:set_bool(false)
    aa_state_air:set_bool(false)
    
else


        if not Desync_inverter_item:get_bool()then
            
            if (input:is_key_pressed(key)) then
        
                if aa_state_item:get_bool() then

                switch = true
                switch2 = false
                switch3 = false       
                aa_state_standing:set_bool(true)
                aa_state_moving:set_bool(true)
                aa_state_air:set_bool(true)
                aa_state_standing2:set_float(p_value_item:get_float())
                aa_state_moving2:set_float(p_value_item:get_float())
                aa_state_air2:set_float(p_value_item:get_float())
                standing_fakedir:set_int( 2 )
                moving_fakedir:set_int( 2 )
                air_fakedir:set_int( 2 )
                
                end

            end

            if (input:is_key_pressed(key2)) then

                if aa_state_item:get_bool() then

                switch = false
                switch2 = true
                switch3 = false       
                aa_state_standing:set_bool(true)
                aa_state_moving:set_bool(true)
                aa_state_air:set_bool(true)
                aa_state_standing2:set_float(-p_value_item:get_float())
                aa_state_moving2:set_float(-p_value_item:get_float())
                aa_state_air2:set_float(-p_value_item:get_float())
                standing_fakedir:set_int( 3 )
                moving_fakedir:set_int( 3 )
                air_fakedir:set_int( 3 )
                      
            
                end
            
            end

            if (input:is_key_pressed(key3)) then

                if aa_state_item:get_bool() then

                switch = false
                switch2 = false
                switch3 = true
                aa_state_standing:set_bool(true)
                aa_state_moving:set_bool(true)
                aa_state_air:set_bool(true)
                aa_state_standing2:set_float(0)
                aa_state_moving2:set_float(0)
                aa_state_air2:set_float(0)
                standing_fakedir:set_int( 1 )
                moving_fakedir:set_int( 1 )
                air_fakedir:set_int( 1 )
                
                end
            
            end


        else

            if (input:is_key_pressed(key)) then
        
                if aa_state_item:get_bool() then

                switch = true
                switch2 = false
                switch3 = false       
                aa_state_standing:set_bool(true)
                aa_state_moving:set_bool(true)
                aa_state_air:set_bool(true)
                aa_state_standing2:set_float(p_value_item:get_float())
                aa_state_moving2:set_float(p_value_item:get_float())
                aa_state_air2:set_float(p_value_item:get_float())
                standing_fakedir:set_int( 3 )
                moving_fakedir:set_int( 3 )
                air_fakedir:set_int( 3 )
                
                end

            end

            if (input:is_key_pressed(key2)) then

                if aa_state_item:get_bool() then

                switch = false
                switch2 = true
                switch3 = false       
                aa_state_standing:set_bool(true)
                aa_state_moving:set_bool(true)
                aa_state_air:set_bool(true)
                aa_state_standing2:set_float(-p_value_item:get_float())
                aa_state_moving2:set_float(-p_value_item:get_float())
                aa_state_air2:set_float(-p_value_item:get_float())
                standing_fakedir:set_int( 2 )
                moving_fakedir:set_int( 2 )
                air_fakedir:set_int( 2 )
                      
            
                end
            
            end

            if (input:is_key_pressed(key3)) then

                if aa_state_item:get_bool() then

                switch = false
                switch2 = false
                switch3 = true
                aa_state_standing:set_bool(true)
                aa_state_moving:set_bool(true)
                aa_state_air:set_bool(true)
                aa_state_standing2:set_float(0)
                aa_state_moving2:set_float(0)
                aa_state_air2:set_float(0)
                standing_fakedir:set_int( 1 )
                moving_fakedir:set_int( 1 )
                air_fakedir:set_int( 1 )
                
                end
            
            end

end
end


if aa_state_item:get_bool() then
    if switch then
        render:indicator( screen_size.x / 1.9 , screen_size.y / 2 - 15, ">", true, -1 );   
    else
        render:indicator( screen_size.x / 1.9, screen_size.y / 2 - 15, ">", false, -1 );   
    end
    if switch2 then
        render:indicator( screen_size.x / 2.15, screen_size.y / 2 - 15, "<", true, -1 );   
    else
        render:indicator( screen_size.x / 2.15, screen_size.y / 2 - 15, "<", false, -1 );
    end
    if switch3 then
        render:indicator( screen_size.x / 150, screen_size.y / 2 - 15, "BACK", true, -1 );   
    else
        render:indicator( screen_size.x / 150, screen_size.y / 2 - 15, "BACK", false, -1 );   
    end

else
    switch = false
    switch2 = false
    switch3 = false
end

end)