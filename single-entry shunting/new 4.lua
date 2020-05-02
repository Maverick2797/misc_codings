local exit_sig = "Industry1_exit"
local exit_route = "Mainline"
local exit_speed = "M"

if event.train and atc_arrow then
	atc_send("B0S0WD2RS"..exit_speed)
	set_route(exit_sig,exit_route)
end