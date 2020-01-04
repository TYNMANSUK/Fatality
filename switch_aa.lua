local render = fatality.render
local config = fatality.config
local menu = fatality.menu
local cvar = csgo.interface_handler:get_cvar()
local engine_client = csgo.interface_handler:get_engine_client()
local entity_list = csgo.interface_handler:get_entity_list( )
local global_vars = csgo.interface_handler:get_global_vars()

local switch_antiaim_item = config:add_item( "switch_antiaim_lua", 1.0 )
local switch_antiaim_item_stand = config:add_item( "switch_antiaim_lua_st", 1.0 )
local switch_antiaim_item_move = config:add_item( "switch_antiaim_lua_mv", 1.0 )
local switch_antiaim_item_jump = config:add_item( "switch_antiaim_lua_jp", 1.0 )
local switch_aa_combo = menu:add_multi_combo( "AA - Switch", "RAGE", "ANTI-AIM", "General", switch_antiaim_item, 0.0, 100.0, 1.0 )
switch_aa_combo:add_item( "Standing", switch_antiaim_item_stand )
switch_aa_combo:add_item( "Moving", switch_antiaim_item_move )
switch_aa_combo:add_item( "Air", switch_antiaim_item_jump )

local switch_bool = false
local tickcount = 0
local jitterspeed_item = config:add_item( "jitterspeed_lua", 0 );
local tick = math.floor( 1.0 / global_vars.interval_per_tick )
local jitterspeed = menu:add_slider( "Switch speed", "RAGE", "ANTI-AIM", "General", jitterspeed_item, 0, tick, 1 )

local aa_range_stand = menu:get_reference( "RAGE", "ANTI-AIM", "Standing", "Range" )
local aa_range_move = menu:get_reference( "RAGE", "ANTI-AIM", "Moving", "Range" )
local aa_range_jump = menu:get_reference( "RAGE", "ANTI-AIM", "Air", "Range" )

local aa_override = menu:get_reference( "RAGE", "ANTI-AIM", "General", "Antiaim override" )
local aa_yawoverride_stand = menu:get_reference( "RAGE", "ANTI-AIM", "Standing", "Yaw add")
local aa_yawoverride_move = menu:get_reference( "RAGE", "ANTI-AIM", "Moving", "Yaw add" )
local aa_yawoverride_jump = menu:get_reference( "RAGE", "ANTI-AIM", "Air", "Yaw add" )

local aa_yawadd_stand = menu:get_reference( "RAGE", "ANTI-AIM", "Standing", "Add" )
local aa_yawadd_move = menu:get_reference( "RAGE", "ANTI-AIM", "Moving", "Add" )
local aa_yawadd_jump = menu:get_reference( "RAGE", "ANTI-AIM", "Air", "Add" )

local aa_shitjitter_stand = menu:get_reference( "RAGE", "ANTI-AIM", "Standing", "Jitter" )
local aa_shitjitter_move = menu:get_reference( "RAGE", "ANTI-AIM", "Moving", "Jitter" )
local aa_shitjitter_jump = menu:get_reference( "RAGE", "ANTI-AIM", "Air", "Jitter" )


function on_paint()
     if not engine_client:is_in_game() then
        return end
        
    local local_player = entity_list:get_localplayer()

    if not local_player:is_alive() then
        return end
    
    --disable/enable things
    
    if switch_antiaim_item_stand:get_bool() then
        aa_override:set_bool( false )
        aa_yawoverride_stand:set_bool( true )   
        aa_shitjitter_stand:set_bool( false )
    end
    
    if switch_antiaim_item_move:get_bool() then
        aa_override:set_bool( false )
        aa_yawoverride_move:set_bool( true )
        aa_shitjitter_move:set_bool( false )
    end
    
    if switch_antiaim_item_jump:get_bool() then
        aa_override:set_bool( false )
        aa_yawoverride_jump:set_bool( true )
        aa_shitjitter_jump:set_bool( false )       
    end
    --aa code
    if(global_vars.tickcount > (tickcount + jitterspeed_item:get_float())) then
            
        tickcount = global_vars.tickcount
        switch = not switch
        
        if switch_antiaim_item_stand:get_bool() then
            if switch then
                aa_yawadd_stand:set_float( 34 ) --you can edit this number to any other number you want
            else
                aa_yawadd_stand:set_float( -32 ) --this too
            end
        end
    
        if switch_antiaim_item_move:get_bool() then
            if switch then
                aa_yawadd_move:set_float( 34 ) --you can edit this number to any other number you want
            else
                aa_yawadd_move:set_float( -33 ) --this too
            end
        end
    
        if switch_antiaim_item_jump:get_bool() then
            if switch then
                aa_yawadd_jump:set_float( 67 ) --you can edit this number to any other number you want
            else
                aa_yawadd_jump:set_float( 78 ) --this too
            end
        end
        
    end
end



local callbacks = fatality.callbacks
callbacks:add("paint", on_paint)