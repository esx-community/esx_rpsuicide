local open = false
local Keys = {
  ["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57, 
  ["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177, 
  ["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
  ["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
  ["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
  ["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70, 
  ["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
  ["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
  ["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}

ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

function loadAnimDict( dict ) 
    while ( not HasAnimDictLoaded( dict ) ) do
        RequestAnimDict( dict )
        Citizen.Wait( 5 )
    end
end 

function openMenu()
  ESX.UI.Menu.Open(
	'default', GetCurrentResourceName(), 'suicide_menu',
	{
		title    = _U('suicide'),
		elements = {
			{label = _U('suicidepistol'), value = 'suicidepistol'},
			{label = _U('suicidepills'), value = 'suicidepills'},
		}
	},
	function(data, menu)
		local val = data.current.value
		
		if val == 'suicidepistol' then

		           local lPed = GetPlayerPed(-1)
				   local maxHealth = GetEntityMaxHealth(lPed)
				   local weaponStealeableList = {453432689, 1593441988, 584646201, 2578377531, 3523564046, 137902532, 4024951519}
							for i=1, #weaponStealeableList do
								if GetCurrentPedWeapon(GetPlayerPed(-1), weaponStealeableList[i], false) then
								   haveWeapon = true
								end
							end
		
		    if not IsPedInAnyVehicle(lPed, false) and not IsPedSwimming(lPed) and not IsPedShooting(lPed) and not IsPedClimbing(lPed) and not IsPedDiving(lPed) and not IsPedFalling(lPed) and not IsPedJumping(lPed) and not IsPedJumpingOutOfVehicle(lPed) and IsPedOnFoot(lPed) and not IsPedRunning(lPed) and not IsPedUsingAnyScenario(lPed) and not IsPedInParachuteFreeFall(lPed) then
			            if (haveWeapon) then
					        Citizen.CreateThread(function()
							
							   loadAnimDict( "mp_suicide" )
							   TaskPlayAnim( lPed, "mp_suicide", "pistol", 8.0, 1.0, -1, 2, 0, 0, 0, 0 )
							   Citizen.Wait(1000)
							   PlaySoundFrontend(-1, "Bed", "WastedSounds", 1)
		                       ShakeGameplayCam("DEATH_FAIL_IN_EFFECT_SHAKE", 1.0)
		                       Citizen.Wait(500)
		                       PlaySoundFrontend(-1, "TextHit", "WastedSounds", 1)
							   StartScreenEffect('DeathFailOut', 0, false)
							   DisableControlAction(2, 1, true) 
			                   DisableControlAction(2, 2, true) 
			                   DisableControlAction(2, 24, true) 
			                   DisableControlAction(2, 257, true) 
			                   DisableControlAction(2, 25, true) 
			                   DisableControlAction(2, 263, true) 
			                   DisableControlAction(2, Keys['R'], true) 
			                   DisableControlAction(2, Keys['TOP'], true) 
			                   DisableControlAction(2, Keys['SPACE'], true) 
			                   DisableControlAction(2, Keys['Q'], true) 
			                   DisableControlAction(2, Keys['TAB'], true) 
			                   DisableControlAction(2, Keys['F'], true) 
			                   DisableControlAction(2, Keys['F1'], true) 
			                   DisableControlAction(2, Keys['F2'], true) 
			                   DisableControlAction(2, Keys['F3'], true) 
			                   DisableControlAction(2, Keys['V'], true) 
			                   DisableControlAction(2, Keys['P'], true) 
			                   DisableControlAction(2, 59, true) 
			                   DisableControlAction(2, Keys['LEFTCTRL'], true) 
			                   DisableControlAction(0,21,true)
			                   DisableControlAction(0, 47, true)  
			                   DisableControlAction(0, 264, true) 
			                   DisableControlAction(0, 257, true) 
			                   DisableControlAction(0, 140, true) 
			                   DisableControlAction(0, 141, true) 
			                   DisableControlAction(0, 142, true) 
			                   DisableControlAction(0, 143, true)
			                   DisableControlAction(0, 75, true) 
			                   DisableControlAction(27, 75, true) 
			                   FreezeEntityPosition(lPed, true)
							   ESX.ShowNotification(_U('suicidenotify'))
							   Citizen.Wait(4000)
							   ESX.TriggerServerCallback('esx_ambulancejob:removeItemsAfterRPDeath', function()
			                   ESX.SetPlayerData('lastPosition', Config.Zones.HospitalInteriorInside1.Pos)
			                   ESX.SetPlayerData('loadout', {})

			                   TriggerServerEvent('esx:updateLastPosition', Config.Zones.HospitalInteriorInside1.Pos)
			                   RespawnPed(GetPlayerPed(-1), Config.Zones.HospitalInteriorInside1.Pos)

			                   StopScreenEffect('DeathFailOut')
			                   DoScreenFadeIn(800)
		                       end)
							   StopScreenEffect('DeathFailOut')
							   DoScreenFadeOut(100)
							   SetEntityCoords(lPed, 272.8, -1358.8, 23.5)
							   Citizen.Wait(4000)
							   DoScreenFadeIn(250)
							   DisableControlAction(2, 2, true) 
			                   DisableControlAction(2, 24, false)
			                   DisableControlAction(2, 257, false) 
			                   DisableControlAction(2, 25, false) 
			                   DisableControlAction(2, 263, false) 
			                   DisableControlAction(2, Keys['R'], false) 
			                   DisableControlAction(2, Keys['TOP'], false) 
			                   DisableControlAction(2, Keys['SPACE'], false) 
			                   DisableControlAction(2, Keys['Q'], false) 
			                   DisableControlAction(2, Keys['TAB'], false) 
			                   DisableControlAction(2, Keys['F'], false) 
			                   DisableControlAction(2, Keys['F1'], false) 
			                   DisableControlAction(2, Keys['F2'], false) 
			                   DisableControlAction(2, Keys['F3'], false) 
			                   DisableControlAction(2, Keys['V'], false) 
			                   DisableControlAction(2, Keys['P'], false) 
			                   DisableControlAction(2, 59, false) 
			                   DisableControlAction(2, Keys['LEFTCTRL'], false) 
			                   DisableControlAction(0,21,false) 
			                   DisableControlAction(0, 47, false)  
			                   DisableControlAction(0, 264, false) 
			                   DisableControlAction(0, 257, false) 
			                   DisableControlAction(0, 140, false) 
			                   DisableControlAction(0, 141, false) 
			                   DisableControlAction(0, 142, false) 
			                   DisableControlAction(0, 143, false) 
			                   DisableControlAction(0, 75, false)  
			                   DisableControlAction(27, 75, false) 
			                   FreezeEntityPosition(lPed, false)
			                   haveWeapon = false
			                   SetEntityHealth(lPed, maxHealth)
					        end)
						else
						       ESX.ShowNotification(_U('musthaveweapon'))
				        end
		    end
		elseif val == 'suicidepills' then
		               local lPed = GetPlayerPed(-1)
				       local maxHealth = GetEntityMaxHealth(lPed)
		           
		    if not IsPedInAnyVehicle(lPed, false) and not IsPedSwimming(lPed) and not IsPedShooting(lPed) and not IsPedClimbing(lPed) and not IsPedDiving(lPed) and not IsPedFalling(lPed) and not IsPedJumping(lPed) and not IsPedJumpingOutOfVehicle(lPed) and IsPedOnFoot(lPed) and not IsPedRunning(lPed) and not IsPedUsingAnyScenario(lPed) and not IsPedInParachuteFreeFall(lPed) then
						  
						    Citizen.CreateThread(function()
							
							   loadAnimDict( "mp_suicide" )
							   TaskPlayAnim( lPed, "mp_suicide", "pill_fp", 8.0, 1.0, -1, 2, 0, 0, 0, 0 )
							   Citizen.Wait(3000)
							   PlaySoundFrontend(-1, "Bed", "WastedSounds", 1)
		                       ShakeGameplayCam("DEATH_FAIL_IN_EFFECT_SHAKE", 1.0)
		                       Citizen.Wait(500)
		                       PlaySoundFrontend(-1, "TextHit", "WastedSounds", 1)
							   StartScreenEffect('DeathFailOut', 0, false)
							   DisableControlAction(2, 1, true) 
			                   DisableControlAction(2, 2, true) 
			                   DisableControlAction(2, 24, true) 
			                   DisableControlAction(2, 257, true) 
			                   DisableControlAction(2, 25, true) 
			                   DisableControlAction(2, 263, true) 
			                   DisableControlAction(2, Keys['R'], true) 
			                   DisableControlAction(2, Keys['TOP'], true) 
			                   DisableControlAction(2, Keys['SPACE'], true) 
			                   DisableControlAction(2, Keys['Q'], true) 
			                   DisableControlAction(2, Keys['TAB'], true) 
			                   DisableControlAction(2, Keys['F'], true) 
			                   DisableControlAction(2, Keys['F1'], true) 
			                   DisableControlAction(2, Keys['F2'], true) 
			                   DisableControlAction(2, Keys['F3'], true) 
			                   DisableControlAction(2, Keys['V'], true) 
			                   DisableControlAction(2, Keys['P'], true) 
			                   DisableControlAction(2, 59, true) 
			                   DisableControlAction(2, Keys['LEFTCTRL'], true) 
			                   DisableControlAction(0,21,true) 
			                   DisableControlAction(0, 47, true)  
			                   DisableControlAction(0, 264, true) 
			                   DisableControlAction(0, 257, true) 
			                   DisableControlAction(0, 140, true) 
			                   DisableControlAction(0, 141, true) 
			                   DisableControlAction(0, 142, true) 
			                   DisableControlAction(0, 143, true) 
			                   DisableControlAction(0, 75, true)  
			                   DisableControlAction(27, 75, true) 
			                   FreezeEntityPosition(lPed, true)
							   ESX.ShowNotification(_U('suicidenotify'))
							   Citizen.Wait(4000)
							ESX.TriggerServerCallback('esx_ambulancejob:removeItemsAfterRPDeath', function()
			                   ESX.SetPlayerData('lastPosition', Config.Zones.HospitalInteriorInside1.Pos)
			                   ESX.SetPlayerData('loadout', {})

			                   TriggerServerEvent('esx:updateLastPosition', Config.Zones.HospitalInteriorInside1.Pos)
			                   RespawnPed(GetPlayerPed(-1), Config.Zones.HospitalInteriorInside1.Pos)

			                   StopScreenEffect('DeathFailOut')
			                   DoScreenFadeIn(800)
		                    end)
							   StopScreenEffect('DeathFailOut')
							   DoScreenFadeOut(100)
							   SetEntityCoords(lPed, 272.8, -1358.8, 23.5)
							   Citizen.Wait(4000)
							   DoScreenFadeIn(250)
							   DisableControlAction(2, 2, true) 
			                   DisableControlAction(2, 24, false) 
			                   DisableControlAction(2, 257, false) 
			                   DisableControlAction(2, 25, false) 
			                   DisableControlAction(2, 263, false) 
			                   DisableControlAction(2, Keys['R'], false) 
			                   DisableControlAction(2, Keys['TOP'], false) 
			                   DisableControlAction(2, Keys['SPACE'], false)
			                   DisableControlAction(2, Keys['Q'], false) 
			                   DisableControlAction(2, Keys['TAB'], false) 
			                   DisableControlAction(2, Keys['F'], false) 
			                   DisableControlAction(2, Keys['F1'], false) 
			                   DisableControlAction(2, Keys['F2'], false) 
			                   DisableControlAction(2, Keys['F3'], false) 
			                   DisableControlAction(2, Keys['V'], false) 
			                   DisableControlAction(2, Keys['P'], false) 
			                   DisableControlAction(2, 59, false) 
			                   DisableControlAction(2, Keys['LEFTCTRL'], false) 
			                   DisableControlAction(0,21,false) 
			                   DisableControlAction(0, 47, false)  
			                   DisableControlAction(0, 264, false) 
			                   DisableControlAction(0, 257, false) 
			                   DisableControlAction(0, 140, false) 
			                   DisableControlAction(0, 141, false) 
			                   DisableControlAction(0, 142, false) 
			                   DisableControlAction(0, 143, false) 
			                   DisableControlAction(0, 75, false)  
			                   DisableControlAction(27, 75, false) 
			                   FreezeEntityPosition(lPed, false)
			                   SetEntityHealth(lPed, maxHealth)
					        end)
		    end
			
		end
	end,
	function(data, menu)
		menu.close()
	end
)
end

Citizen.CreateThread(function()
	while true do
		Wait(0)
		if IsControlJustReleased(0, 166) then
          openMenu() 
		end
	end
end)