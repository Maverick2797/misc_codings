--Still need to convert to a function rather than trackside

local siding_id = "TestingF_main"
local length_prefix = "Loco"

local hs_sig = "TestingF_hs"
local hs_route = "Headshunt"

local exit_sig = "TestingF_runaround_exit"
local exit_route = "Mainline"

-- local speed_check = function(data)
	-- if atc_speed > 0 then
		-- interrupt(1,{['cmd'] = "speed_check",['data'] = data})



--testing counter
if event.train then
	digiline_send("errors",tostring(atc_arrow).." "..atc_id)
end

if (event.train and atc_arrow) then
	local rc = get_rc() or " "
	local line = get_line() or " "
	
	-- the RC that controls the link to split
	-- rc value: "<rc><num_wagons to shunt with>"  default is single loco
	-- eg "Loco2" for tenders, "Loco3" for 
	local loco_pos = rc:match(length_prefix.."%d+") or length_prefix.."1"
	loco_pos = tonumber(loco_pos:match("%d+"))+1
		
	if not S.runarounds[siding_id].shunting then -- train to be split
		--store info for later re-insertion
		S.runarounds[siding_id] = {
			['shunting'] = true,
			['rc'] = rc,
			['line'] = line
		}
		atc_send("B0S0")
		interrupt(10,{['cmd'] = "split", ['leng'] = loco_pos})
		-- change int time if needed, depends on approach speed slowdown
		
	else -- train has rejoined
	
		--re-insert info to train
		if S.runarounds[siding_id].rc then set_rc(S.runarounds[siding_id].rc) end
		if S.runarounds[siding_id].line then set_line(S.runarounds[siding_id].line) end
		
		--depart
		unset_autocouple()
		atc_send("B0WD1RSM")
		set_route(exit_sig,exit_route)
		S.runarounds[siding_id].shunting = false
		
		--testing counter
		digiline_send("reset_count","")

	
	end
end
if event.int then
	if event.msg.cmd=="split" then
		cmd = event.msg
		split_at_index(cmd.leng,"S0")
		atc_send("S2")
		set_autocouple()
		set_route(hs_sig,hs_route)
	end
end