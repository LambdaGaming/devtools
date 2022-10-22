CreateClientConVar( "DevTools_ShouldClipboard", 1, true, false, "Should the text that a tool prints out be copied to your clipboard." )
CreateClientConVar( "DevTools_ShouldFancyText", 1, true, false, "Should the text that a tool prints out be formatted into a Lua function. (Ex: 0 0 0 gets formatted into Vector( 0, 0, 0 ))" )
CreateClientConVar( "DevTools_ShouldRoundDecimals", 1, true, false, "Should angles and vectors have their decimals removed. Only available if fancy text is enabled." )

hook.Add( "PopulateToolMenu", "DevToolsConfig", function()
    spawnmenu.AddToolMenuOption( "Options", "Dev Tools", "DevTools", "Config", "", "", function( panel )
		panel:CheckBox( "Copy output text to clipboard", "DevTools_ShouldClipboard" )
		panel:CheckBox( "Print text in a Lua format", "DevTools_ShouldFancyText" )
		panel:CheckBox( "Remove decimal places in angle and vector values.", "DevTools_ShouldRoundDecimals" )
	end )
end )

function DevTools_FormatVecAng( data )
	local name = isvector( data ) and "Vector" or "Angle"
	local canfancytext = GetConVar( "DevTools_ShouldFancyText" ):GetBool()
	local canround = GetConVar( "DevTools_ShouldRoundDecimals" ):GetBool()
	local formattedpos = "Vector( "..data.x..", "..data.y..", "..data.z.." )"
	local decimal = "Vector( "..math.Round( data.x )..", "..math.Round( data.y )..", "..math.Round( data.z ).." )"
	local finaltext
	if canfancytext then
		if canround then
			chat.AddText( decimal )
			finaltext = decimal
		else
			chat.AddText( formattedpos )
			finaltext = formattedpos
		end
	else
		chat.AddText( tostring( data ) )
		finaltext = tostring( data )
	end
	DevTools_TryClipboard( finaltext )
end

function DevTools_FormatVelocity( vel, type )
	local newvel
	local name
	local canfancytext = GetConVar( "DevTools_ShouldFancyText" ):GetBool()
	if type == 1 then
		newvel = vel * 0.056818181
		name = "MPH"
	elseif type == 2 then
		newvel = vel * 0.056818181 * 1.6093
		name = "KPH"
	else
		newvel = vel
		name = "Hammer Units / Sec"
	end

	local formattedvel = newvel.." "..name
	if canfancytext then
		chat.AddText( formattedvel )
	else
		chat.AddText( newvel )
	end
	
	local clipboard
	if canfancytext then
		clipboard = formattedvel
	else
		clipboard = newvel
	end
	DevTools_TryClipboard( clipboard )
end

function DevTools_TryClipboard( text )
	local canclipboard = GetConVar( "DevTools_ShouldClipboard" ):GetBool()
	if canclipboard then
		SetClipboardText( text )
	end
end

net.Receive( "DevTools_Clipboard", function()
	local text = net.ReadString()
	DevTools_TryClipboard( text )
end )
