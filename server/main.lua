ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

function secondsToClock(seconds)
  local seconds = tonumber(seconds)

  if seconds <= 0 then
	return "00:00:00";
  else
	hours = string.format("%02.f", math.floor(seconds/3600));
	mins = string.format("%02.f", math.floor(seconds/60 - (hours*60)));
	secs = string.format("%02.f", math.floor(seconds - hours*3600 - mins *60));
	return hours..":"..mins..":"..secs
  end
end

RegisterServerEvent('xt5m_moneywash:washMoney')
AddEventHandler('xt5m_moneywash:washMoney', function(amount, zone)
	local xPlayer = ESX.GetPlayerFromId(source)
	local data = Config.Zones[zone]

	amount = ESX.Math.Round(tonumber(amount))
	if not data.TaxRate then data.TaxRate = Config.TaxRate end
	local washedTotal = ESX.Math.Round(tonumber(amount * data.TaxRate))

	if data.enableTimer then
		if not data.Radius then data.Radius = Config.Radius end
		local timeClock = ESX.Math.Round(data.timer / 1000)		
	
		if amount > 0 and xPlayer.getAccount('black_money').money >= amount then
			xPlayer.removeAccountMoney('black_money', amount)
			TriggerClientEvent('esx:showNotification', xPlayer.source, _U('you_have_washed_waiting') ..  secondsToClock(timeClock))
			Citizen.CreateThread(function()
				waitForLaundry( xPlayer, washedTotal, data )
			end)
		else
			TriggerClientEvent('esx:showNotification', xPlayer.source, _U('invalid_amount'))
		end
	else 
	
		if amount > 0 and xPlayer.getAccount('black_money').money >= amount then
			xPlayer.removeAccountMoney('black_money', amount)
			TriggerClientEvent('esx:showNotification', xPlayer.source, _U('you_have_washed') .. ESX.Math.GroupDigits(amount) .. _U('dirty_money') .. _U('you_have_received') .. ESX.Math.GroupDigits(washedTotal) .. _U('clean_money'))
			xPlayer.addMoney(washedTotal, 'washMoney')
		else
			TriggerClientEvent('esx:showNotification', xPlayer.source, _U('invalid_amount'))
		end
	end
	
end)

function waitForLaundry( xPlayer, washedTotal, data )
	Citizen.Wait(data.timer)
	if data.mustStay then
		for k,v in pairs(data.Pos) do
			local distance = #(xPlayer.getCoords(true) - v)
			if distance <= data.Radius then
				xPlayer.showNotification(_U('you_have_received') .. ESX.Math.GroupDigits(washedTotal) .. _U('clean_money'))
				xPlayer.addMoney(washedTotal, 'washMoney')
				return
			end
		end
		xPlayer.showNotification(_U('you_lost') .. _U('dirty_money'))
	else
		xPlayer.showNotification(_U('you_have_received') .. ESX.Math.GroupDigits(washedTotal) .. _U('clean_money'))
		xPlayer.addMoney(washedTotal, 'washMoney')
	end	
end