--define signals and routes

--register initial train arrival

--clone RC/LN

--set autocouple mode

--ensure train stopped

--split train

--set headshunt signal

-- //train manuevers around wagons//

-- //train re-couples with wagons, info is nil//

--unset autocouple mode

--reset info

--depart train in direction x (set direction from definitions: exit_dir = {route = "route"} if direction = not arrow then exit_dir.sig = rev_sig, exit_dir.atc = "R" else exit_dir.sig = hs_sig, exit_dir.atc = " " end )
	--set atc from above
	--set signal from above