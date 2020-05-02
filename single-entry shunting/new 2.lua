local siding_id = "Industry1"

if event.train and atc_arrow then
	if get_rc() == nil then
	--rc should only ever be empty if train has split
		if S.runarounds[siding_id].rc then set_rc(S.runarounds[siding_id].rc) end
		if S.runarounds[siding_id].line then set_line(S.runarounds[siding_id].line) end
	end
end	