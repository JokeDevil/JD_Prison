RegisterCommand("jail", function(source, args, rawCommand)
if tablelength(args) > 0 then	
		local tPID = tonumber(args[1])
			local jT = Config.defaultsecs
			if tablelength(args) > 1 then
			if (args[2] ~= nil) then
				jT = tonumber(args[2])
			end
		end
		if jT > Config.maxsecs then
			jT = Config.maxsecs
		end
		if GetPlayerName(tPID) ~= nil then
			TriggerClientEvent("sendToJail", tPID, jT, source, 1)
		end
	end
	exports.JD_logs:discord('**'.. GetPlayerName(source) .. '**: ``/' .. rawCommand .. '``', source, 0 , '10592673', 'jail')
end)

RegisterCommand("unjail", function(source, args, rawCommand)
		CancelEvent()
		if IsPlayerAceAllowed(source, Config.staffAcePerm) then
			local tPID = tonumber(args[1])
			if GetPlayerName(tPID) ~= nil then
				--print("Unjailing ".. GetPlayerName(tPID).. " - cm entered by ".. GetPlayerName(source))
				TriggerClientEvent("unJail", tPID, GetPlayerName(source))
			end
			exports.JD_logs:discord('**'.. GetPlayerName(source) .. '**: ``/' .. rawCommand .. '``', source, 0 , '10592673', 'jail')
		else
				TriggerClientEvent('sendChatMessage', -1, "You don't have permissions to do this")
		end
end)

RegisterCommand("jailme", function(source, args, rawCommand)
	CancelEvent()
	local jT = Config.defaultsecs
	if args[1] ~= nil then
		jT = tonumber(args[1])				
	end
	if jT > Config.maxsecs then
		jT = Config.maxsecs
	end
	
		TriggerClientEvent("sendMeToJail", source, jT, source)
	exports.JD_logs:discord('**'.. GetPlayerName(source) .. '**: ``/' .. rawCommand .. '``', source, 0 , '10592673', 'jail')
end)

RegisterCommand("staffjail", function(source, args, rawCommand)
	CancelEvent()
	if IsPlayerAceAllowed(source, Config.staffAcePerm) then
		local jT = Config.defaultsecs
		if args[1] ~= nil then
			pP = tonumber(args[1])
			jT = tonumber(args[2])				
		end
		if tonumber(args[2]) ~= nil then
			if jT > Config.maxsecs then
				jT = Config.maxsecs
			end
			TriggerClientEvent("staffMeToJail", pP, jT, source)
			exports.JD_logs:discord('**'.. GetPlayerName(source) .. '**: ``/' .. rawCommand .. '``', source, 0 , '10592673', 'jail')
		else
			TriggerClientEvent('sendChatMessage', -1, "^*^1Use /staffjail [id] [time]^0^r")
		end	
	end
end)

RegisterNetEvent('getChatMessage')
AddEventHandler('getChatMessage', function(id, message)
	local _id = id
	local _message = message
    TriggerClientEvent('sendChatMessage', _id, _message)
end)

RegisterNetEvent('getGlobalChatMessage')
AddEventHandler('getGlobalChatMessage', function(message)
	local _message = message
    TriggerClientEvent('sendChatMessage', -1, _message)
end)

RegisterNetEvent('getGlobalChatMessageStaff')
AddEventHandler('getGlobalChatMessageStaff', function(message)
	local _message = message
    TriggerEvent('chat:addMessage', {color = { 230, 77, 67}, args = {"[Staff Jail]",message}})
end)

RegisterNetEvent('serverSendToJail')
AddEventHandler('serverSendToJail', function(id)
	local _id = id
    TriggerClientEvent('sendToJail', _id)
end)

RegisterNetEvent('ServerESCORT')
AddEventHandler('ServerESCORT', function(id)
	local _id = id
    TriggerClientEvent('EscortOut', _id)
end)


function tablelength(T)
  local count = 0
  for _ in pairs(T) do count = count + 1 end
  return count
end
