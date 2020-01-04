local entity_list = csgo.interface_handler:get_entity_list()
local render = fatality.render
local menu = fatality.menu
local config = fatality.config
local input = fatality.input
local cvar = csgo.interface_handler:get_cvar( )
local global_vars = csgo.interface_handler:get_global_vars()
local misc_item = config:add_item( "misc.sync", 0 );
local misc_checkbox = menu:add_checkbox( "misc sync", "rage", "anti-aim", "general", misc_item );
local real_stand = menu:get_reference("rage", "anti-aim", "standing", "add")
local fake_stand = menu:get_reference("rage", "anti-aim", "standing", "fake direction")
local real_move = menu:get_reference("rage", "anti-aim", "moving", "add")
local fake_move = menu:get_reference("rage", "anti-aim", "moving", "fake direction")
local real_air = menu:get_reference("rage", "anti-aim", "air", "add")
local fake_air = menu:get_reference("rage", "anti-aim", "air", "fake direction")
local tickcount = 0
local screen_size = render:screen_size()

-- left true, right false
function draw_arrow(x, y, size, color, side)
    if(side) then
        for i = 0, (size - 1) do
            render:rect(x - i, y + (i / 2) + 1, 1, size - i, color)
        end
    else
        for i = 0, (size - 1) do
            render:rect(x + i, y + (i / 2) + 1, 1, size - i, color)
    
        end
    end
end
function fake_angle(ang)
    fake_stand:set_int(ang)
    fake_move:set_int(ang)
    fake_air:set_int(ang)
end
function real_angle(ang)
    real_stand:set_int(ang)
    real_move:set_int(ang)
    real_air:set_int(ang)
end
local side = false
local switch = false
function on_paint()
    local_player = entity_list:get_localplayer()
    if(local_player ~= nil and local_player:is_alive()) then

        if(tickcount > global_vars.tickcount) then tickcount = 0
        end
        if misc_item:get_bool() then
            if  fake_stand:get_bool(true) or fake_move:get_bool(true) or fake_air:get_bool(true) then
                fk = true
            else
                fk = false
            end
            render:indicator( 15, screen_size.y - 60, "FAKE", fk , -1)
 
            if(input:is_key_pressed(5)) then
                side = not side
            end
            if side then
                draw_arrow(screen_size.x / 2 - 10 - 30, screen_size.y / 2 - 10, 20, csgo.color(153, 255, 204, 30), side)
            else
                draw_arrow(screen_size.x / 2 + 10 + 30, screen_size.y / 2 - 10, 20, csgo.color(153, 255, 204, 30), side)
            end
            if(global_vars.tickcount > (tickcount + 5)) then
                tickcount = global_vars.tickcount
                switch = not switch
                if switch then
                    if side then
                        fake_angle(2) 
                    else
                        fake_angle(3)
                    end
                else
                    fake_angle(0)
                end
            end
        end
    end
end
local callbacks = fatality.callbacks
callbacks:add( "paint", on_paint )