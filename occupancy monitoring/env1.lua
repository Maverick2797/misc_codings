if event.init then
	S.sidings = {}
	S.section_monitor = {} -- for 
end
function F.section_monitor_pLoop(siding_id)
	if not S.sidings[siding_id] then
		S.sidings[siding_id] = {
			['name'] = siding_id,
			['occupancy'] = "initial occ",
			['id'] = "init id",
			['rc'] = "init notes"
		}
	end
	if event.train then
		if atc_arrow == true then 				-- entering siding
			S.sidings[siding_id].occupancy = true
			S.sidings[siding_id].id = atc_id
			S.sidings[siding_id].rc = get_rc() or "N/A"
		else 									-- exiting siding
			S.sidings[siding_id].occupancy = false
			S.sidings[siding_id].id = nil
			S.sidings[siding_id].rc = "N/A"
		end
	end
end
F.monitor_occupancy = F.section_monitor_pLoop

F.section_monitor = function (line,this_section,next_section)
--<documentation>
	--line: used to differentiate which control board in high usage cases
	--this_section: the section the arrow points away from. set as nil if entering from unmonitored sections
	--next_section: the section the arrow points to. set as nil if entering unmonitored sections
--</documentation>
--
	if this_section then
		if not S.section_monitor[line][this_section] then
			S.section_monitor[line][this_section] = {
				['name'] = this_section,
				['occupancy'] = "initial occ",
				['id'] = "init id"
			}
		end
	end
	if next_section then
		if not S.section_monitor[line][next_section] then
			S.section_monitor[line][next_section] = {
				['name'] = next_section,
				['occupancy'] = "initial occ",
				['id'] = "init id",
			}
		end
	end
	if event.train then
		if atc_arrow == true then --arrow points to next section
			if this_section then
				S.section_monitor[line][this_section].occupancy = false
				S.section_monitor[line][this_section].id = nil
			end
			if next_section then
				S.section_monitor[line][next_section].occupancy = true
				S.section_monitor[line][next_section].id = atc_id
			end
		else -- going against for some reason... unusual but not impossible
			if this_section then
				S.section_monitor[line][this_section].occupancy = true
				S.section_monitor[line][this_section].id = atc_id
			end
			if next_section then
				S.section_monitor[line][next_section].occupancy = false
				S.section_monitor[line][next_section].id = nil
			end
		end
	end
end