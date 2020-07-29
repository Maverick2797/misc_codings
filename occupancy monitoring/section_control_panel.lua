if event.punch or (event.channel=="clock" and event.msg=="done") then
local line = "S23" --set line # to monitor
local info = S.section_monitor.line
	for _,v in pairs(info) do
		local msg = "Section: "..v.name.."||Occupancy: "..tostring(v.occupancy).."||Train ID: "..tostring(v.id)
		digiline_send(v.name,msg)
	end
    -- digiline_send("CCnr",tostring(S.section_monitor.CCnr.occupancy))
end	