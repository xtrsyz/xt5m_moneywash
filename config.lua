Config 					= {}

Config.Locale 			= 'en'
Config.DrawDistance 	= 10
Config.Radius			= 10
Config.TaxRate			= 0.85 -- default value if not set per spot. 85% of the dirty you will get back in clean.

local second = 1000
local minute = 60 * second
local hour = 60 * minute

--[[ 
	Below are the zones for laundering. You can set multiple zones just follow the format below. 
	Failure to do so will result in the script breaking.
	Set the job to 'any' if you want anybody to use the location. Otherwise set the required job you want to use for the location
	Any job not allowed to use the location WILL NOT see a marker or get a popup to use it.
	
	EXAMPLE LOCATION!!! JUST COPY THIS AND PASTE TO ADD MORE LOCATIONS!
		
	{
		Pos = {
			vector3(1090.84, -2233.43, 31.5)
		},
		
		Jobs = {
			--'any', -- SET THE 'any' TAG TO ALLOW ALL JOBS INCLUDING POLICE TO USE THE LOCATION
			--'miner',
			--'cardealer'
		},
		TaxRate = 0.50, -- set taxrate per spot. Default is 0.5 or 50% of the dirty you will get back in clean
		enableTimer = false, -- Enable ONLY IF you want a timer on the money washing. Keep in mind the Player does not have to stay at the wash for it to actually wash the money.
		timer = 5 * second, -- Actual Timer for the spot. The * amount will determine if its hours, second, or minutes. which are found above. DEFAULT: 5 * second
		mustStay = true, -- need to stay in spot or lost money
		Size = {x = 1.5, y = 1.5, z = 1.5},
		Color = {r = 255, g = 120, b = 0},
		Type = 1,
	},
	
]]

Config.Zones = {
	
	['LaundryMat'] = {	
		Pos = { 
			vector3(854.66, -2113.21, 30.58),
		},
		
		Jobs = {
			--'any', -- set to 'any' to allow the location for any player regardless of job
			'mafia'
		},
		TaxRate = 1, -- set taxrate per spot. Default is 0.5 or 50% of the dirty you will get back in clean
		enableTimer = true, -- Enable ONLY IF you want a timer on the money washing. Keep in mind the Player does not have to stay at the wash for it to actually wash the money.
		timer = 30 * second, -- Actual Timer for the spot. The * amount will determine if its hours, second, or minutes. which are found above. DEFAULT: 5 * second
		mustStay = true,
		Size = {x = 1.5, y = 1.5, z = 1.5},
		Color = {r = 120, g = 120, b = 0},
		Type = 27,
	
	},

}