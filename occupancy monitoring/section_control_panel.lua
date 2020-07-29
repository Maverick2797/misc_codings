if event.punch or (event.channel=="clock" and event.msg=="done") then
local line = "S23" --set line # to monitor
local info = S.section_monitor.line
	digiline_send("status_update",info)
end	