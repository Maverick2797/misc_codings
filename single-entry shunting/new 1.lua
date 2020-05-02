--Still need to convert to a function rather than trackside

-- local hs_sig = "headshunt_control_sig"
-- local hs_route = "Headshunt"

local exit_sig = "Industry1_exit"
local exit_route = "Mainline"
local exit_speed = "M"

local siding_id = "Industry1"
local length_prefix = "drop"

if (event.train and atc_arrow) then
	local rc = get_rc() or " "
	local line = get_line() or " "
	-- the RC that controls the link to split
	-- rc value: "<rc><num_wagons to shunt with>"  default is single loco
	-- eg "Loco2" for tenders, "Loco3" for 
	local drop_length = rc:match(length_prefix.."%d+") or length_prefix.."1"
	drop_length = tonumber(drop_length:match("%d+"))+1
		
	if S.runarounds[siding_id].shunting then -- train to be split
		--store info for later re-insertion
		S.runarounds[siding_id].rc = rc
		S.runarounds[siding_id].line = line
		atc_send("B0S0")
		interrupt(3,{['cmd'] = "split", ['leng'] = drop_length})
		-- change int time if needed, depends on approach speed deceleration
		
	else -- train has rejoined
		--depart
		atc_send("B0WD1RSM")
		set_route(exit_sig,exit_route)

	
	end
end
if event.int then
	if event.msg.cmd=="split" then
		cmd = event.msg
		split_at_index(cmd.leng,"RS"..exit_speed)
		set_route(exit_sig,exit_route)
		-- remaining train departs
	end
end