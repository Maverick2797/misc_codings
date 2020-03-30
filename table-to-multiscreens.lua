local stack = function(t,channel,num_screens)
	for i=0,math.ceil(#t/4) do
		local calc = i*4
		local working_t = {t[calc+1],t[calc+2],t[calc+3],t[calc+4]}
		local message = table.concat(working_t,"\n")
		if i+1 > num_screens then return end
		digiline_send(channel..i+1,message)
	end
end