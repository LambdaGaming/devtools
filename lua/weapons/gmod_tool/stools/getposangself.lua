
TOOL.Name = "Get Self Pos and Angle"
TOOL.Category = "Dev Tools"

if CLIENT then
	language.Add( "tool.getposangself.name", "Get Self Pos and Angle" )
	language.Add( "tool.getposangself.desc", "Prints position and angle of yourself." )
	language.Add( "tool.getposangself.0", "Left-click: Get vector of yourself. Right-click: Get angle of yourself." )
end

function TOOL:LeftClick()
	if IsFirstTimePredicted() and CLIENT then
		local canfancytext = GetConVar( "DevTools_ShouldFancyText" ):GetBool()
		local canclipboard = GetConVar( "DevTools_ShouldClipboard" ):GetBool()
		local canround = GetConVar( "DevTools_ShouldRoundDecimals" ):GetBool()
		local pos = self.Owner:GetPos()
		local formattedpos = "Vector( "..pos.x..", "..pos.y..", "..pos.z.." )"
		local decimal = "Vector( "..math.Round( pos.x )..", "..math.Round( pos.y )..", "..math.Round( pos.z ).." )"
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
			chat.AddText( tostring( pos ) )
			finaltext = tostring( pos )
		end
		if canclipboard then
			SetClipboardText( finaltext )
		end
	end
end

function TOOL:RightClick()
	if IsFirstTimePredicted() and CLIENT then
		local canfancytext = GetConVar( "DevTools_ShouldFancyText" ):GetBool()
		local canclipboard = GetConVar( "DevTools_ShouldClipboard" ):GetBool()
		local canround = GetConVar( "DevTools_ShouldRoundDecimals" ):GetBool()
		local ang = self.Owner:GetAngles()
		local formattedpos = "Angle( "..ang.x..", "..ang.y..", "..ang.z.." )"
		local decimal = "Angle( "..math.Round( ang.x )..", "..math.Round( ang.y )..", "..math.Round( ang.z ).." )"
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
			chat.AddText( tostring( ang ) )
			finaltext = tostring( ang )
		end
		if canclipboard then
			SetClipboardText( finaltext )
		end
	end
end
