local cJ = false
local eJE = false
local pP = GetPlayerPed(-1)
local pS = GetPlayerPed(source)
local nearpos = false


local function insidePolygon( point)
    local oddNodes = false
    for i = 1, #Config.Zones do
        local Zone = Config.Zones[i]
        local j = #Zone
        for i = 1, #Zone do
            if (Zone[i][2] < point.y and Zone[j][2] >= point.y or Zone[j][2] < point.y and Zone[i][2] >= point.y) then
                if (Zone[i][1] + ( point[2] - Zone[i][2] ) / (Zone[j][2] - Zone[i][2]) * (Zone[j][1] - Zone[i][1]) < point.x) then
                    oddNodes = not oddNodes;
                end
            end
            j = i;
        end
    end
    return oddNodes 
end

Citizen.CreateThread(function()
while true do
	Citizen.Wait(3)
	DrawMarker(29, Config.Desk[1], Config.Desk[2], Config.Desk[3], 0, 0, 0, 0, 0, 0, 1.0 ,1.0 ,1.0 ,11 ,102 ,35 ,100 ,false ,false ,false ,true )
		local playerLoc = GetEntityCoords(GetPlayerPed(-1))
		if GetDistanceBetweenCoords(playerLoc.x, playerLoc.y, playerLoc.z,  Config.Desk[1], Config.Desk[2], Config.Desk[3], true) < 1 then
			DisplayHelpText("~BLIP_INFO_ICON~ /bail [id] [price]")
		end
	end
end)

function DisplayHelpText(text)
    SetTextComponentFormat("STRING")
    AddTextComponentString(text)
    DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end

RegisterNetEvent("sendToJail")
AddEventHandler("sendToJail", function(jT, source)
	local pP = GetPlayerPed(-1)
	if cJ == true then
		return
	end
	station = false
	for i = 1, #Config.PoliceStation do
		local pL = GetEntityCoords(GetPlayerPed(-1), true)
		
		if GetDistanceBetweenCoords(Config.PoliceStation[i][1], Config.PoliceStation[i][2], Config.PoliceStation[i][3], pL['x'], pL['y'], pL['z']) < Config.PoliceStation[i][4] then
			station = true
		TriggerServerEvent('getGlobalChatMessage',GetPlayerName(PlayerId())..' got sentenced to '.. jT ..' secseconds in prison')
			if DoesEntityExist(pP) then
				
				Citizen.CreateThread(function()
					local playerOldLoc = GetEntityCoords(pP, true)
					SetEntityCoords(pP, Config.InPrison[1], Config.InPrison[2], Config.InPrison[3])
					cJ = true
					eJE = false
					while jT > 0 and not eJE do
						pP = GetPlayerPed(-1)
						RemoveAllPedWeapons(pP, true)
						SetEntityInvincible(pP, true)
						if IsPedInAnyVehicle(pP, false) then
							ClearPedTasksImmediately(pP)
						end
						Citizen.Wait(500)
						local pL = GetEntityCoords(pP, true)
						local inZone = insidePolygon(pL)
						if not inZone and jT ~= 0 then
							SetEntityCoords(pP, Config.InPrison[1], Config.InPrison[2], Config.InPrison[3])
							jT = jT + 60
							if jT ~= 0 then
								TriggerServerEvent('getChatMessage', GetPlayerServerId(PlayerId()), "Your jail time was extended for an unlawful escape attempt.")
							end
							if jT > 1500 then
								jT = 1500
							end
						end
						jT = jT - 0.5
					end
					TriggerServerEvent('getGlobalChatMessage',GetPlayerName(PlayerId()) .." was released from jail.")
					SetEntityCoords(pP,  Config.ReleasePrison[1], Config.ReleasePrison[2], Config.ReleasePrison[3])
					cJ = false
					SetEntityInvincible(pP, false)
				end)
				Citizen.CreateThread(function()
					eJE = false
					while jT > 0 and not eJE do
						Citizen.Wait(0)
						_jT = math.floor(jT)
						if not IsHudHidden() then
							DrawText(0.660, 1.378, 1.0,1.0,0.45, "~b~Time Left: ~w~" .._jT.. " seconds", 255, 255, 255, 255)
						end
					end
				end)
			end
		end
	end
	if not station then
		TriggerServerEvent('getChatMessage', source, GetPlayerName(PlayerId())..' needs to be at the PD in oder get transported to prison')
	end
end)

RegisterNetEvent("sendMeToJail")
AddEventHandler("sendMeToJail", function(jT, source)
	local pP = GetPlayerPed(-1)
	if cJ == true then
		return
	end
	TriggerServerEvent('getGlobalChatMessage',GetPlayerName(PlayerId())..' got sentenced to '.. jT ..' seconds in prison')
	if DoesEntityExist(pP) then
		
		Citizen.CreateThread(function()
			local playerOldLoc = GetEntityCoords(pP, true)
			SetEntityCoords(pP, Config.InPrison[1], Config.InPrison[2], Config.InPrison[3])
			cJ = true
			eJE = false
			while jT > 0 and not eJE do
				pP = GetPlayerPed(-1)
				RemoveAllPedWeapons(pP, true)
				SetEntityInvincible(pP, true)
				if IsPedInAnyVehicle(pP, false) then
					ClearPedTasksImmediately(pP)
				end
				Citizen.Wait(500)
				local pL = GetEntityCoords(pP, true)
				local inZone = insidePolygon(pL)
				if not inZone and jT ~= 0 then
					SetEntityCoords(GetPlayerPed(-1), Config.InPrison[1], Config.InPrison[2], Config.InPrison[3])
					jT = jT + 60
					if jT ~= 0 then
						TriggerServerEvent('getChatMessage', GetPlayerServerId(PlayerId()), "Your jail time was extended for an unlawful escape attempt.")
					end
					if jT > 1500 then
						jT = 1500
					end
				end
				jT = jT - 0.5
			end
			

			local pP = GetPlayerPed(-1)
			local point = GetEntityCoords(pP,true)
			local inZone = insidePolygon(point)
			if inZone then
				TriggerServerEvent('getGlobalChatMessage',GetPlayerName(PlayerId()) .." was released from jail.")
				SetEntityCoords(pP,  Config.ReleasePrison[1], Config.ReleasePrison[2], Config.ReleasePrison[3])
				cJ = false
				SetEntityInvincible(pP, false)
			else
				--
			end
		end)
		Citizen.CreateThread(function()
			eJE = false
			while jT > 0 and not eJE do
				Citizen.Wait(0)
				_jT = math.floor(jT)
				if not IsHudHidden() then
					DrawText(Config.TimeLeftX, Config.TimeLeftY, 1.0,1.0,0.45, "~b~Time Left: ~w~" .._jT.. " seconds", 255, 255, 255, 255)
				end
			end
		end)
	end
end)

RegisterNetEvent("staffMeToJail")
AddEventHandler("staffMeToJail", function(jT, source)
	local pP = GetPlayerPed(-1)
	if cJ == true then
		return
	end
	TriggerServerEvent('getGlobalChatMessage',"^*^1Staff Jail:^0^r "..GetPlayerName(PlayerId())..' got sentenced to '.. jT ..' seconds in prison')
	if DoesEntityExist(pP) then
		
		Citizen.CreateThread(function()
			local playerOldLoc = GetEntityCoords(pP, true)
			SetEntityCoords(pP, Config.InPrison[1], Config.InPrison[2], Config.InPrison[3])
			cJ = true
			eJE = false
			while jT > 0 and not eJE do
				pP = GetPlayerPed(-1)
				RemoveAllPedWeapons(pP, true)
				SetEntityInvincible(pP, true)
				if IsPedInAnyVehicle(pP, false) then
					ClearPedTasksImmediately(pP)
				end
				Citizen.Wait(500)
				local pL = GetEntityCoords(pP, true)
				local inZone = insidePolygon(pL)
				if not inZone and jT ~= 0 then
					SetEntityCoords(GetPlayerPed(-1), Config.InPrison[1], Config.InPrison[2], Config.InPrison[3])
					jT = jT + 60
					if jT ~= 0 then
						TriggerServerEvent('getChatMessage', GetPlayerServerId(PlayerId()), "Your jail time was extended for an unlawful escape attempt.")
					end
					if jT > 1500 then
						jT = 1500
					end
				end
				jT = jT - 0.5
			end
			

			local pP = GetPlayerPed(-1)
			local point = GetEntityCoords(pP,true)
			local inZone = insidePolygon(point)
			if inZone then
				TriggerServerEvent('getGlobalChatMessage',GetPlayerName(PlayerId()) .." was released from jail.")
				SetEntityCoords(pP,  Config.ReleasePrison[1], Config.ReleasePrison[2], Config.ReleasePrison[3])
				cJ = false
				SetEntityInvincible(pP, false)
			else
				--
			end
		end)
		Citizen.CreateThread(function()
			eJE = false
			while jT > 0 and not eJE do
				Citizen.Wait(0)
				_jT = math.floor(jT)
				if not IsHudHidden() then
					DrawText(Config.TimeLeftX, Config.TimeLeftY, 1.0,1.0,0.45, "~b~Time Left: ~w~" .._jT.. " seconds", 255, 255, 255, 255)
				end
			end
		end)
	end
end)

RegisterCommand("bail", function(source, args, rawCommand)
	local tPID = tonumber(args[1])
	local price = tonumber(args[2])
	local minBail = Config.minBail - 1
	local maxBail = Config.maxBail + 1
	local bprice = math.random(minBail,maxBail)
	local bprice2 = bprice + Config.overPayLimit
	local playerLoc = GetEntityCoords(GetPlayerPed(-1))
	local pP = GetPlayerPed(-1)
	local point = GetEntityCoords(GetPlayerPed(GetPlayerFromServerId(tPID)))
	local inZone = insidePolygon(point)
	if inZone then
		if GetDistanceBetweenCoords(playerLoc.x, playerLoc.y, playerLoc.z,  Config.Desk[1], Config.Desk[2], Config.Desk[3], true) < 3 then
			if GetPlayerName(GetPlayerFromServerId(tPID)) ~= nil and price ~= nil then
				if GetPlayerServerId(PlayerId()) ~= tPID then
					if price >= bprice and price < bprice2 and price < maxBail then
						TriggerServerEvent("serverSendToJail", tPID)
						TriggerServerEvent('getGlobalChatMessage',GetPlayerName(GetPlayerFromServerId(tPID)) ..' Has been Bailed! | Bailed by: '..GetPlayerName(PlayerId())..' for $'..price)
						TriggerServerEvent('getChatMessage', tPID,'Bail price was: $'..bprice..'. But '..GetPlayerName(PlayerId())..' paid $'..price)
						TriggerServerEvent('getChatMessage', GetPlayerServerId(PlayerId()),'Bail price was: $'..bprice..'. But you paid $'..price)
					else
						TriggerServerEvent('getChatMessage', tPID, GetPlayerName(PlayerId())..' tried to bail you out for $'..price..' and got laughed out of the prison.')
						TriggerServerEvent('getChatMessage', GetPlayerServerId(PlayerId()),'You tried to bail out '..GetPlayerName(GetPlayerFromServerId(tPID))..' for $'..price..' and you got escorted out of the prison.')
						TriggerEvent('EscortOut')
					end
				else
					TriggerServerEvent('getChatMessage', GetPlayerServerId(PlayerId()),"You can not bail yourself out")
				end
			else
				TriggerServerEvent('getChatMessage', GetPlayerServerId(PlayerId()),"Usage: /bail [ID] [price]")
			end
		else
			TriggerServerEvent('getChatMessage', GetPlayerServerId(PlayerId()),"You must be at the prison reception desk to use this command")
		end
	else
		TriggerServerEvent('getChatMessage', GetPlayerServerId(PlayerId()),"Person is not in the prison")
	end	
	exports.JD_logs:discord('**'.. GetPlayerName(source) .. '**: ``/' .. rawCommand .. '``', source, 0 , '10592673', 'jail')

end)

RegisterNetEvent("sendChatMessage")
AddEventHandler("sendChatMessage", function(message)
	TriggerEvent('chat:addMessage', {color = { 0, 100, 255}, args = {"[Jail]",message}})
end)

RegisterNetEvent("unJail")
AddEventHandler("unJail", function(tPID)
	eJE = true
	cJ = false
	local _tPID = tPID
	TriggerServerEvent('getGlobalChatMessage', GetPlayerName(PlayerId()) ..' Has been Unjailed! | Unjailed by: '.._tPID)
	Citizen.Wait(500)
	local pP = GetPlayerPed(-1)
	local point = GetEntityCoords(pP,true)
	local inZone = insidePolygon(point)
	if inZone then
	SetEntityCoords(pP, Config.ReleasePrison[1], Config.ReleasePrison[2], Config.ReleasePrison[3])
	else
	--	
	end
end)

RegisterNetEvent('EscortOut')
AddEventHandler('EscortOut', function()
	SetEntityCoords(pP, Config.EscortOut[1], Config.EscortOut[2], Config.EscortOut[3])
end)

function DrawText(x,y ,width,height,scale, text, r,g,b,a)
    if AOPLocation == 1 or AOPLocation == 4 then
        SetTextCentre(true)
    end
    SetTextFont(4)
    SetTextProportional(0)
    SetTextScale(scale, scale)
    SetTextColour(r, g, b, a)
    SetTextEdge(2, 0, 0, 0, 255)
    SetTextOutline()
    BeginTextCommandDisplayText("STRING")
    AddTextComponentSubstringPlayerName(text)
    EndTextCommandDisplayText(x - width/2, y - height/2 + 0.005)
end

