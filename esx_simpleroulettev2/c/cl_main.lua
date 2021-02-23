ESX = nil
Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

local PlayerData = {}
local coordx = 4890.39
local coordy = -4925.58
local coordz = 3.4
local display22 = 1
local onRoulette = false


Citizen.CreateThread(function()
	while true do
	Wait(20)
	local sleep = true
	local coords = GetEntityCoords(PlayerPedId())
		if (GetDistanceBetweenCoords(coords, coordx, coordy, coordz, true) < 5) then
			sleep = false
			ESX.ShowHelpNotification('Press ~INPUT_PICKUP~ to play ~g~Roulette')
				if IsControlJustPressed(0, 38) then
					bettaus22()
				end
		else
			sleep = true
		end
	if sleep then 
		Wait(1000)
	end
	end
end)

local ruletti = {
	'~g~0',
	'~r~1',
	'~u~2',
	'~r~3',
	'~u~4',
	'~r~5',
	'~u~6',
	'~r~7',
	'~u~8',
	'~r~9',
	'~u~10',
	'~r~11',
	'~u~12',
	'~r~13',
	'~u~14',
	'~r~15',
	'~u~16',
	'~r~17',
	'~u~18',
	'~r~19',
	'~u~20',
	'~r~21',
	'~u~22',
	'~r~23',
	'~u~24',
	'~r~25',
	'~u~26',
	'~r~27',
	'~u~28',
	'~r~29',
	'~u~30',
	'~u~31',
	'~r~32',
	'~u~33',
	'~r~34',
	'~u~35',
	'~r~36',
}

function bettaus22()
	maxLength = 5
	AddTextEntry('FMMC_KEY_TIP8', "Insert ~y~Bet")
	DisplayOnscreenKeyboard(1, "FMMC_KEY_TIP8", "", "", "", "", "", maxLength)
	blockinput = true
	while UpdateOnscreenKeyboard() ~= 1 and UpdateOnscreenKeyboard() ~= 2 do
	Wait(0)
	end
	local osallistumismaksu = GetOnscreenKeyboardResult()
	osallistumismaksu = tonumber(osallistumismaksu)
	Wait(150)
	blockinput = false
	
	if osallistumismaksu ~= nil and osallistumismaksu > 0 then
	Roulettefreeze()
	onRoulette = true


	local elements = {
		{ label = '<span style="color:red;">Red</span>', action = 'red' },
		{ label = '<span style="color:black;">Black</span>', action = 'black' },
		{ label = '<span style="color:limegreen;">Green</span>', action = 'green' },
	}
	FreezeEntityPosition(PlayerPedId(),true)
	ESX.UI.Menu.Open('default', GetCurrentResourceName(), "ruletti22",
		{
			title    = "Choose your color",
			align    = "center",
			elements = elements
		},
	function(data, menu)
		local colour = data.current.action

		if colour == "red" or colour == 'black' or colour == 'green' then
			TriggerEvent('3d:triggeri', ruletti)
			TriggerServerEvent('slerbaruletti:bettaa', osallistumismaksu, colour)
			ESX.UI.Menu.CloseAll()
			DisableAllControlActions()
			Wait(11000)
			FreezeEntityPosition(PlayerPedId(),false)
			onRoulette = false
		end
	end)	
  end
end

--Roulettespinning
local x = 4889.7
local y = -4925.32
local z = 3.4


RegisterNetEvent('3d:triggeri')
AddEventHandler('3d:triggeri', function(ruletti)
    local offset = 1 + (display22*0.15)
    Display(GetPlayerFromServerId(source), ruletti, offset)
end)

function Display(mePlayer, ruletti, offset)
    local displaying = true
	local offset = 1 + (display22*0.15)
    Citizen.CreateThread(function()
        Wait(11000)
        displaying = false
    end)
	
    Citizen.CreateThread(function()
        display22 = display22 + 1
        while displaying do
		Wait(0)
            local coordsMe = GetEntityCoords(GetPlayerPed(mePlayer), false)
            local coords = GetEntityCoords(PlayerPedId(), false)
            local dist = Vdist2(coordsMe, coords)
            if dist < 5 then
				 DrawText3D(x, y, z+offset-0.1400, ruletti)
            end
        end
        display22 = display22 - 1
    end)
end

function DrawText3D(x,y,z, ruletti)
  local onScreen, _x, _y = World3dToScreen2d(x, y, z)
  local p = GetGameplayCamCoords()
  local distance = GetDistanceBetweenCoords(p.x, p.y, p.z, x, y, z, 1)

  if onScreen then
		displaying = true
		SetTextScale(0.55, 0.55)
		SetTextFont(1)
		SetTextProportional(2)
		SetTextColour(255, 255, 255, 255)
		SetTextEntry("STRING")
		SetTextCentre(1)
		AddTextComponentString('~w~The ball is ~g~rolling:~n~~r~ ' ..(ruletti[math.random(1, #ruletti)])..'.')
		DrawText(_x,_y)
    end
end

function Roulettefreeze()
	Citizen.CreateThread(function()
		while onRoulette do
			Citizen.Wait(0)
			DisableControlAction(0, 24, true) -- Attack
			DisableControlAction(0, 257, true) -- Attack 2
			DisableControlAction(0, 25, true) -- Aim
			DisableControlAction(0, 263, true) -- Melee Attack 1
			DisableControlAction(0, 32, true) -- W
			DisableControlAction(0, 34, true) -- A
			DisableControlAction(0, 31, true) -- S (fault in Keys table!)
			DisableControlAction(0, 30, true) -- D (fault in Keys table!)
			DisableControlAction(0,38, true)

			DisableControlAction(0, 45, true) -- Reload
			DisableControlAction(0, 52, true) -- Cover
			DisableControlAction(0, 37, true) -- Select Weapon
			DisableControlAction(0, 288, true) -- Disable phone
			DisableControlAction(0, 289, true) -- Inventory
			DisableControlAction(0, 170, true) -- Animations
			DisableControlAction(0, 167, true) -- Job
			DisableControlAction(0, 26, false) -- Disable looking behind
			DisableControlAction(0, 186, true) -- Disable clearing animation
			DisableControlAction(0, 59, true) -- Disable steering in vehicle
			DisableControlAction(2, 36, true) -- Disable going stealth
			DisableControlAction(0, 47, true)  -- Disable weapon
			DisableControlAction(0, 264, true) -- Disable melee
			DisableControlAction(0, 257, true) -- Disable melee
			DisableControlAction(0, 140, true) -- Disable melee
			DisableControlAction(0, 141, true) -- Disable melee
			DisableControlAction(0, 142, true) -- Disable melee
			DisableControlAction(0, 143, true) -- Disable melee
			DisableControlAction(0, 75, true)  -- Disable exit vehicle
			DisableControlAction(27, 75, true) -- Disable exit vehicle
		end
	end)
end