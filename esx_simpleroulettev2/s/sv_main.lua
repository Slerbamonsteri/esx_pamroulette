ESX = nil
TriggerEvent('pkrp:getSharedObject', function(obj) ESX = obj end)


local maksu = 0
RegisterServerEvent('slerbaruletti:bettaa')
AddEventHandler('slerbaruletti:bettaa', function(osallistumismaksu, colour)
    local xPlayer = ESX.GetPlayerFromId(source)
	local _source = source
    local puoli = math.random(0,37)
    if xPlayer.getAccount('bank').money >= osallistumismaksu then
        xPlayer.removeAccountMoney('bank', tonumber(osallistumismaksu))
		print('maksu onnistunut')
		print(colour)
		print(puoli)
		TriggerClientEvent('pkrp:showNotification', _source, 'Panostit: ~g~' .. osallistumismaksu .."€")
		Wait(3000)
		TriggerClientEvent('pkrp:showNotification', _source, '~m~Pallo ~w~rullaa...')
		Wait(3000)
		TriggerClientEvent('pkrp:showNotification', _source, '~o~You spin me right round...')
		Wait(2600)
		TriggerClientEvent('pkrp:showNotification', _source, '~m~Pallo ~w~pysähtyy...')
		Wait(2000)
        if colour == 'Punainen' then
			if puoli >= 18 and puoli <= 36 then
				TriggerClientEvent('pkrp:showNotification', _source, '~m~Pallo~w~ pysähtyi värille: ~r~~h~Punainen~h~~w~.')
				Wait(200)
				maksu = osallistumismaksu*2
				xPlayer.addAccountMoney('bank', maksu) 
				TriggerClientEvent('pkrp:showNotification', _source, '~g~Voitit: ' ..maksu..'€')
			else
				TriggerClientEvent('pkrp:showNotification', _source, 'Pallo pysähtyi värille: ~h~~u~ Musta~h~~w~.')
				TriggerClientEvent('pkrp:showNotification', _source, "~r~Hävisit!")
			end
        elseif colour == 'Musta' then
			if puoli >= 1 and puoli <= 17 then
			TriggerClientEvent('pkrp:showNotification', _source, 'Pallo pysähtyi värille: ~u~~h~Musta~h~~w~.')
			Wait(200)
			maksu = osallistumismaksu*2
            xPlayer.addAccountMoney('bank', maksu) 
            TriggerClientEvent('pkrp:showNotification', _source, '~g~Voitit: ' ..maksu..'€')
        else
			TriggerClientEvent('pkrp:showNotification', _source, 'Pallo pysähtyi värille: ~h~~r~Punainen~h~~w~.')
            TriggerClientEvent('pkrp:showNotification', _source, "~r~Hävisit.")
        end
        elseif colour == 'Vihreä' then
			if puoli == 37 then
				TriggerClientEvent('pkrp:showNotification', _source, 'Pallo pysähtyi värille: ~g~~h~Vihreä~h~~w~.')
				Wait(200)
				maksu = osallistumismaksu*14
				xPlayer.addAccountMoney('bank', maksu) 
				TriggerClientEvent('pkrp:showNotification', _source, '~g~Voitit: ' ..maksu..'€')
			else
				TriggerClientEvent('pkrp:showNotification', _source, 'Pallo pysähtyi värille: ~h~~r~Punainen~h~~w~.~n~ HAHA HÄVISIT LUUSERI')
        end
	end
	else
		TriggerClientEvent('pkrp:showNotification', _source, 'Ei massii, köyhä. Tai maxbet 50000')
    end
end)