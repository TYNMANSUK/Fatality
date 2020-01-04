local engine_client     = csgo.interface_handler:get_engine_client()
local menu              = fatality.menu
local render            = fatality.render
local input             = fatality.input
 
local stand_add_ref22   = menu:get_reference("RAGE", "ANTI-AIM", "Standing", "Add")
local stand_add_ref     = menu:get_reference("RAGE", "ANTI-AIM", "Standing", "Fake amount")
local stand_dir_ref     = menu:get_reference("RAGE", "ANTI-AIM", "Standing", "Fake amount")
local move_add_ref22    = menu:get_reference("RAGE", "ANTI-AIM", "Moving", "Add")
local move_add_ref      = menu:get_reference("RAGE", "ANTI-AIM", "Moving", "Add")
local move_dir_ref      = menu:get_reference("RAGE", "ANTI-AIM", "Moving", "Fake amount")
 
local side = false
-- http://asger-p.dk/info/virtualkeycodes.php if you wanna change keys
local switch_key = 0x12
local switch_held = false
 
local font = render:create_font('Verdana', 32, 700, true)
fatality.callbacks:add("paint", function()
    if(engine_client:is_in_game()) then
        -- Logic
        if input:is_key_down(switch_key) then
            if not switch_held then
                side = not side
 
                if side then
                    stand_add_ref22:set_float(-26)  -- STANDING YAW LEFT SIDE //
                    stand_dir_ref:set_int(-60)      -- CUSTOM FAKE .. MOVING LEFT //
                    move_add_ref:set_float(-4)     -- MOVING YAW LEFT SIDE //
                    move_dir_ref:set_int(-41)       -- CUSTOM FAKE // MOVING LEFT //
                else
                    stand_add_ref22:set_float(-16)  -- STANDING YAW RIGHT SIDE //
                    stand_dir_ref:set_int(60)       -- CUSTOM FAKE // STAND RIGHT //
                    move_add_ref:set_float(8)       -- MOVING YAW RIGHT SIDE //
                    move_dir_ref:set_int(44)        -- CUSTOM FAKE // MOVING RIGHT //
                end
            end
 
            switch_held = true
        else
            switch_held = false
        end
 
        -- Drawing // change colors if you want.
        local screen_size = render:screen_size()
        local x, y = screen_size.x / 2, screen_size.y / 2
       
        -- Change colors as you wish (Use html picker
        -- USE HTML COLOR CODES   R   G   B   ALPHA (transparency) 0 = transparent, 255 = solid color
        local col_l = csgo.color(255, 255, 255, 255)
        local col_r = csgo.color(255, 255, 255, 255)
 
        if not side then
            col_l = csgo.color(5, 143, 244, 255)
        else
            col_r = csgo.color(5, 143, 244, 255)
        end
 
        render:text(font, x - 50, y - 18, '(', col_l)
        render:text(font, x + 35, y - 18, ')', col_r)
    end
end)