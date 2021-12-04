ESX                           = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

local xcrdx = Config.LocalCoords

local arvonta = false
local arvontavalmis = false
local liitytty = false
local lahella = false

local tulos = 0
local sattumaluku = 0
local fakelaskuri = 0
local maxLength = 5

Citizen.CreateThread(function()
  Blip()
  local ped = PlayerPedId()
	while true do
		Citizen.Wait(0)
		local coords = GetEntityCoords(ped)
		local distance = GetDistanceBetweenCoords(coords, xcrdx.x, xcrdx.y, xcrdx.z, true)
		if(distance < 10) then
			if(distance < 3) then

				if not lahella then
					TriggerServerEvent('esx_ruletti:lahella')
					lahella = true
				end

				if not arvonta then
					if not liitytty then
						ESX.ShowHelpNotification('Paina ~INPUT_CONTEXT~ osallistuaksesi rulettiin')
					else
						ESX.ShowHelpNotification('Olet osallistunut kierrokselle - odotetaan Voit lisätä panoksia painamalla ~INPUT_CONTEXT~')
					end
				end

				if IsControlJustPressed(0, 38) then
					LiityARvontaan()
				end

				ArvontaTextia()

					DrawText3Ds(xcrdx.x, xcrdx.y, xcrdx.z, text)
			end
		else
			Citizen.Wait(1000)
		end
	end
end)

function ArvontaTextia()
	if arvonta then
		if fakelaskuri > 16 then
			sattumaluku = math.random(0,36)
			fakelaskuri = 0
			if not arvontavalmis then
				PlaySound(-1, "CANCEL", "HUD_MINI_GAME_SOUNDSET", 0, 0, 1)
			end
		end
		if arvontavalmis then
			sattumaluku = tulos
		end
		fakelaskuri = fakelaskuri + 1
		if sattumaluku == 0 then
			text = 'Ruletti: ~g~'..sattumaluku
		elseif sattumaluku > 18 then
			text = 'Ruletti: ~m~'..sattumaluku
		else
			text = 'Ruletti: ~r~'..sattumaluku
		end
	else
		text = 'Ruletti: ~g~asettakaa panoksenne'
	end
end

function LiityARvontaan()
	maxLength = 5
	AddTextEntry('FMMC_KEY_TIP8', "Panos")
	DisplayOnscreenKeyboard(1, "FMMC_KEY_TIP8", "", "", "", "", "", maxLength)
	ESX.ShowNotification("~b~Määritä panos")

	while UpdateOnscreenKeyboard() ~= 1 and UpdateOnscreenKeyboard() ~= 2 do
		Citizen.Wait( 0 )
	end

	local osallistumismaksu = GetOnscreenKeyboardResult()

	osallistumismaksu = tonumber(osallistumismaksu)
	Citizen.Wait(150)

	if osallistumismaksu ~= nil and osallistumismaksu > 0 then
		maxLength = 2
		AddTextEntry('FMMC_KEY_TIP8', "Väri tai numero")
		DisplayOnscreenKeyboard(1, "FMMC_KEY_TIP8", "", "", "", "", "", maxLength)
		ESX.ShowNotification("~w~Valitse väri ~r~P~w~, ~m~M~w~, ~g~V ~w~tai numero 0-36")

		while UpdateOnscreenKeyboard() ~= 1 and UpdateOnscreenKeyboard() ~= 2 do
			Citizen.Wait( 0 )
		end

		local vari = GetOnscreenKeyboardResult()

		Citizen.Wait(150)
		if vari == 'P' or vari == 'M' or vari == 'V' then
			TriggerServerEvent('esx_ruletti:osallistuminen', osallistumismaksu, vari)
			liitytty = true
		else
			vari = tonumber(vari)
			if vari ~= nil and vari >= 0 and vari < 37 then
				TriggerServerEvent('esx_ruletti:osallistuminen', osallistumismaksu, vari)
				liitytty = true
			else
				ESX.ShowNotification('Virheellinen väri tai numero')
			end
		end
	else
		ESX.ShowNotification('Määritä kelvollinen panos')
	end
end

function Blip()
	local BlipConfig = Config.Blip
	local blip = AddBlipForCoord(xcrdx.x, xcrdx.y, xcrdx.z)
	SetBlipSprite (blip, BlipConfig.sprite)
	SetBlipDisplay(blip, BlipConfig.display)
	SetBlipScale  (blip, BlipConfig.scale)
	SetBlipColour (blip, BlipConfig.colour)
	SetBlipAsShortRange(blip, true)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString(Config.Blip.Name)
	EndTextCommandSetBlipName(blip)
end

RegisterNetEvent('esx:ruletti:tulos')
AddEventHandler('esx:ruletti:tulos', function(servuntulos)
	tulos = servuntulos
	arvonta = true
	Citizen.Wait(10000)
	arvontavalmis = true
	Citizen.Wait(5000)
	liitytty = false
	arvonta = false
	arvontavalmis = false
	lahella = false
end)

RegisterNetEvent('esx:ruletti:epaonnistui')
AddEventHandler('esx:ruletti:epaonnistui', function()
	liitytty = false
end)

function DrawText3Ds(x,y,z, text)
    local Fake, _x, _y = World3dToScreen2d(x,y,z)
	SetTextScale(0.5, 0.5)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
	SetTextOutline()
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x,_y)
    local factor = (string.len(text)) / 250
    DrawRect(_x,_y+0.018, 0.015+ factor, 0.03, 41, 11, 41, 68)
end