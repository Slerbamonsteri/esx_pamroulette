ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)


local maksu = 0
RegisterServerEvent('slerbaruletti:bettaa')
AddEventHandler('slerbaruletti:bettaa', function(osallistumismaksu, colour)
    local xPlayer = ESX.GetPlayerFromId(source)
	local _source = source
    local colors = math.random(0,37)
    if xPlayer.getAccount('bank').money >= osallistumismaksu then
        xPlayer.removeAccountMoney('bank', tonumber(osallistumismaksu))

		TriggerClientEvent('esx:showNotification', _source, 'Your bet: ~g~' .. osallistumismaksu .."€")
		Wait(3000)
		TriggerClientEvent('esx:showNotification', _source, '~m~The Ball ~w~is rolling...')
		Wait(3000)
		TriggerClientEvent('esx:showNotification', _source, '~o~You spin me right round...')
		Wait(2600)
		TriggerClientEvent('esx:showNotification', _source, '~m~Ball ~w~stops rolling...')
		Wait(2000)
        if colour == 'red' then
			if colors >= 18 and colors <= 36 then
				TriggerClientEvent('esx:showNotification', _source, '~m~The ball~w~ stopped on color: ~r~~h~Red~h~~w~.')
				Wait(200)
				maksu = osallistumismaksu*2
				xPlayer.addAccountMoney('bank', maksu) 
				TriggerClientEvent('esx:showNotification', _source, '~g~You won: ' ..maksu..'€')
			else
				TriggerClientEvent('esx:showNotification', _source, '~m~The ball~w~ stopped on color: ~h~~u~ Black~h~~w~.')
				TriggerClientEvent('esx:showNotification', _source, "~r~You lose!")
			end
        elseif colour == 'black' then
			if colors >= 1 and colors <= 17 then
			TriggerClientEvent('esx:showNotification', _source, '~m~The ball~w~ stopped on color: ~u~~h~Black~h~~w~.')
			Wait(200)
			maksu = osallistumismaksu*2
            xPlayer.addAccountMoney('bank', maksu) 
            TriggerClientEvent('esx:showNotification', _source, '~g~You won: ' ..maksu..'€')
        else
			TriggerClientEvent('esx:showNotification', _source, '~m~The ball~w~ stopped on color: ~h~~r~Red~h~~w~.')
            TriggerClientEvent('esx:showNotification', _source, "~r~You lose.")
        end
        elseif colour == 'green' then
			if colors == 37 then
				TriggerClientEvent('esx:showNotification', _source, '~m~The ball~w~ stopped on color: ~g~~h~Green~h~~w~.')
				Wait(200)
				maksu = osallistumismaksu*14
				xPlayer.addAccountMoney('bank', maksu) 
				TriggerClientEvent('esx:showNotification', _source, '~g~You won: ' ..maksu..'€')
			else
				TriggerClientEvent('esx:showNotification', _source, '~m~The ball~w~ stopped on color: ~h~~r~Red~h~~w~.~n~ You lost.')
        end
	end
	else
		TriggerClientEvent('esx:showNotification', _source, 'Not enough money.')
    end
end)