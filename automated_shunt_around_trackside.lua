--Still need to convert to a function rather than trackside

local hs_sig = "headshunt_control_sig"
local hs_route = "Headshunt"

local exit_sig = "mainline_exit_sig"
local exit_route = "Mainline"

local siding_id = "TheStacks"
local length_prefix = "Loco"

if (event.train and atc_arrow) then
	local rc = get_rc() or " "
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
			['line'] = get_line() or " "
		}
		atc_send("B0S0")
		interrupt(10,{['cmd'] = "split", ['leng'] = loco_pos})
		-- change int time if needed, depends on approach speed slowdown
		
	else -- train has rejoined
	
		--re-insert info to train
		if S.runarounds[siding_id].rc then set_rc(S.runarounds[siding_id].rc) end
		if S.runarounds[siding_id].line then set_line(S.runarounds[siding_id].line) end
		
		--depart
		atc_send("B0WD1RSM")
		set_route(exit_sig,exit_route)
		S.runarounds[siding_id].shunting = false

	
	end
end
if event.int then
	if event.msg.cmd=="split" then
		cmd = event.msg
		split_at_index(cmd.leng,"")
		atc_send("S2")
		set_route(hs_sig,hs_route)
	end
end