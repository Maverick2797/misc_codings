local siding_id = "Industry1"
local rejoin_rc = "pickup"
local drop_prefix = "drop"

if event.train and atc_arrow then
	local rc = get_rc() or " "
	local line = get_line() or " "
	
	if rc:match(rejoin_rc) or rc:match(drop_prefix.."%d+") then
		if not S.runarounds[siding_id].shunting then -- reverse train into siding
			S.runarounds[siding_id].shunting = true
			atc_send("B0S0WRD2S3")
		else
		--train has completed shunting, cancel flag and continue onwards
			S.runarounds[siding_id].shunting = false
		end
	end
end