-- interfaces
local render = fatality.render
local menu = fatality.menu
local config = fatality.config
local input = fatality.input
local entity_list = csgo.interface_handler:get_entity_list()
local global_vars = csgo.interface_handler:get_global_vars()
 
 
-- getting reference of menu features
local aa_back = menu:get_reference( "rage", "anti-aim", "general", "back" )
local aa_right = menu:get_reference( "rage", "anti-aim", "general", "right" )
local aa_left = menu:get_reference( "rage", "anti-aim", "general", "left" )


-- adding features to the menu
local manualAA_item = config:add_item( "manual_arrows", 0 )
local manualAA_checkbox = menu:add_checkbox( "Manual arrows", "visuals", "misc", "local", manualAA_item )
local typeOfDesign_item = config:add_item( "typeOfDesign_item", 0 )
local typeOfDesign_checkbox = menu:add_checkbox( "Switch design", "visuals", "misc", "local", typeOfDesign_item )
local size_item = config:add_item( "size_item", 20 )
local size_slider = menu:add_slider( "Size of arrows", "visuals", "misc", "local", size_item, 10, 25, 1 )
local red_item = config:add_item( "red_item", 255 )
local red_slider = menu:add_slider( "[ r ] Amount", "visuals", "misc", "local", red_item, 0, 255, 1 )
local green_item = config:add_item( "green_item", 255 )
local green_slider = menu:add_slider( "[ g ] Amount", "visuals", "misc", "local", green_item, 0, 255, 1 )
local blue_item = config:add_item( "blue_item", 255 )
local blue_slider = menu:add_slider( "[ b ] Amount", "visuals", "misc", "local", blue_item, 0, 255, 1 )


-- needed variables
local side = false
local back = false
local count = 0


-- left and right arrows
function draw_side_arrow(x, y, size, color, side)
    if(side) then
        for i = 0, (size - 1) do
            render:rect(x + i, y + (i / 2) + 1, 1, size - i, color)
        end
        
    else
        for i = 0, (size - 1) do
            render:rect(x - i, y + (i / 2) + 1, 1, size - i, color)
        end 
    end  
end


-- back arrow
function draw_back_arrow(x, y, size, color, side)
    if(back) then
        for i = 0, (size - 1) do
            render:rect(x - 0.5 - (i / 2), y - i / 50 + 30, 1, size - i, color)
        end
        for i = 0, (size - 1) do
            render:rect(x + (i / 2), y - i / 50 + 30, 1, size - i, color)
        end
        
    else
        for i = 0, (size - 1) do
            render:rect(x - i, y + (i / 2) + 1, 1, size - i, color)
        end 
    end  
end



-- rendering arrows
function on_paint()

    -- changing values from float to int
    local red_slider = red_item:get_float() * 1
    local green_slider = green_item:get_float() * 1
    local blue_slider = blue_item:get_float() * 1 
    local size_slider = size_item:get_float() * 1 

    -- colours
    local white_colour = csgo.color(100, 100, 100, 100)
    local black_colour = csgo.color(0, 0, 0, 100)
    local custom_colour = csgo.color(red_slider, green_slider, blue_slider, 255)

    -- getting localplayer variable
    local local_player = entity_list:get_localplayer()

    -- getting screen size
    local screen_size = render:screen_size()

      -- check box check
      if manualAA_item:get_bool() then

        -- local player check
        if(local_player ~= nil and local_player:is_alive()) then
       
            -- if new design is enabled
            if typeOfDesign_item:get_bool() then

                -- background
                render:rect( screen_size.x / 2 - 100, screen_size.y - 70, 200, 60, csgo.color(100, 100, 100, 255))

                -- outline of the background
                render:rect_filled( screen_size.x / 2 - 100, screen_size.y - 70, 200, 60, csgo.color(0, 0, 0, 120))

                -- [ DISABLED ARROWS ] --
                -- right 
                side = true;
                draw_side_arrow(screen_size.x / 2 + 10 + 30 + 1, screen_size.y - 50, size_slider, white_colour, side)

                -- left 
                side = false;
                draw_side_arrow(screen_size.x / 2 - 10 - 30 + 1, screen_size.y - 50, size_slider, white_colour, side)

                -- back 
                back = true;
                draw_back_arrow(screen_size.x / 2, screen_size.y - 77, size_slider, white_colour, back)
                -- [ DISABLED ARROWS ] --



                -- [ ENABLED ARROWS ] --
                -- right activated
                if aa_right:get_bool() then
                side = true;
                draw_side_arrow(screen_size.x / 2 + 10 + 30 + 1, screen_size.y - 50, size_slider, custom_colour, side)

                -- left activated
                elseif aa_left:get_bool() then
                side = false;
                draw_side_arrow(screen_size.x / 2 - 10 - 30 + 1, screen_size.y - 50, size_slider, custom_colour, side)

                 -- back activated
                elseif aa_back:get_bool() then
                back = true;
                draw_back_arrow(screen_size.x / 2, screen_size.y - 77, size_slider, custom_colour, back)
                  -- [ ENABLED ARROWS ] --
                end

            -- old design
            else
                -- [ DISABLED ARROWS ] --
                -- right 
                side = true;
                draw_side_arrow(screen_size.x / 2 + 10 + 30 + 1, screen_size.y / 2 - 10, size_slider, white_colour, side)

                -- left 
                side = false;
                draw_side_arrow(screen_size.x / 2 - 10 - 30 + 1, screen_size.y / 2 - 10, size_slider, white_colour, side)

                -- back 
                back = true;
                draw_back_arrow(screen_size.x / 2, screen_size.y / 2 + 10, size_slider, white_colour, back)
                -- [ DISABLED ARROWS ] --



                -- [ ENABLED ARROWS ] --
                -- right activated
                if aa_right:get_bool() then
                    side = true;
                    draw_side_arrow(screen_size.x / 2 + 10 + 30 + 1, screen_size.y / 2 - 10, size_slider, custom_colour, side)

                -- left activated
                elseif aa_left:get_bool() then
                    side = false;
                    draw_side_arrow(screen_size.x / 2 - 10 - 30 + 1, screen_size.y / 2 - 10, size_slider, custom_colour, side)

                -- back activated
                elseif aa_back:get_bool() then
                    back = true;
                    draw_back_arrow(screen_size.x / 2, screen_size.y / 2 + 10, size_slider, custom_colour, back)
                -- [ ENABLED ARROWS ] --
                end

            end            

        end  

    end

end



-- callbacks
local callbacks = fatality.callbacks
callbacks:add("paint", on_paint)

-- end of the code