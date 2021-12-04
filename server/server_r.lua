ESX             = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

local lahella1 = {}
local lahella2 = {}
local osallistuneet = {}
local arvontakesken = false

RegisterServerEvent('esx_ruletti:osallistuminen')
AddEventHandler('esx_ruletti:osallistuminen', function(osallistumismaksu, vari)
	if not arvontakesken then
		local _source = source
		local xPlayer = ESX.GetPlayerFromId(_source)

		if xPlayer.getMoney() >= osallistumismaksu then
			xPlayer.removeMoney(osallistumismaksu)
			osallistuneet[#osallistuneet+1] = { pelaaja=_source, osallistujanpanos=osallistumismaksu, osallistujanvari=vari }
			TriggerClientEvent('esx:showNotification', _source, 'Panos ~g~'..osallistumismaksu..'~w~ asetettu: ~b~'..vari)
			perse = vari
			if vari == 'M' then
				perse = 'mustalle'
			elseif vari == 'P' then
				perse = 'punaiselle'
			elseif vari == 0 or vari == 'V' then
				perse = 'vihreälle'
			else
				perse = 'numerolle '..perse
			end
			TriggerClientEvent('3dme:triggerDisplay', -1, '* panostaa '..osallistumismaksu..'€ '..perse..' *', _source)
		else
			TriggerClientEvent('esx:showNotification', _source, 'Sinulla ei ole tarpeeksi käteistä')
			TriggerClientEvent('esx:ruletti:epaonnistui', _source)
		end
	else
		TriggerClientEvent('esx:showNotification', source, 'Et voi osallistua enää tälle kierrokselle')
		TriggerClientEvent('esx:ruletti:epaonnistui', source)
	end
end)

RegisterServerEvent('esx_ruletti:lahella')
AddEventHandler('esx_ruletti:lahella', function()
	if source ~= nil then
		if arvontakesken then
			lahella2[#lahella2+1] = { pelaaja=source }
		else
			lahella1[#lahella1+1] = { pelaaja=source }
		end
	end
end)

function arvonta()

	arvontakesken = true
	local tulos = math.random(0,36)
	if lahella1[1] ~= nil then
		for i=1, #lahella1, 1 do
			TriggerClientEvent('esx:ruletti:tulos', lahella1[i].pelaaja, tulos)
        end
	end

	SetTimeout(12000, function()

		if osallistuneet[1] ~= nil then
			for i=1, #osallistuneet, 1 do
				if osallistuneet[i].osallistujanvari == tulos or osallistuneet[i].osallistujanvari == 'V' and tulos == 0 then
					local xPlayer = ESX.GetPlayerFromId(osallistuneet[i].pelaaja)
					TriggerClientEvent('esx:showNotification', osallistuneet[i].pelaaja, 'Voitit ~g~'.. osallistuneet[i].osallistujanpanos*35 ..'€')
					TriggerClientEvent('3dme:triggerDisplay', -1, '* voitti '.. osallistuneet[i].osallistujanpanos*35 ..'€ *', osallistuneet[i].pelaaja)
					xPlayer.addMoney(osallistuneet[i].osallistujanpanos*35)
				elseif osallistuneet[i].osallistujanvari == 'M' and tulos > 18 or osallistuneet[i].osallistujanvari == 'P' and tulos <= 18 and tulos > 0 then
					local xPlayer = ESX.GetPlayerFromId(osallistuneet[i].pelaaja)
					TriggerClientEvent('esx:showNotification', osallistuneet[i].pelaaja, 'Voitit ~g~'.. osallistuneet[i].osallistujanpanos*2 ..'€')
					TriggerClientEvent('3dme:triggerDisplay', -1, '* voitti '.. osallistuneet[i].osallistujanpanos*2 ..'€ *', osallistuneet[i].pelaaja)
					xPlayer.addMoney(osallistuneet[i].osallistujanpanos*2)
				else
					TriggerClientEvent('esx:showNotification', osallistuneet[i].pelaaja, 'Hävisit ~r~'..osallistuneet[i].osallistujanpanos..'€')
				end
			end
		end

		lahella1 = lahella2
		lahella2 = {}
		osallistuneet = {}
		arvontakesken = false
		SetTimeout(30000, arvonta)
	end)

end

arvonta()