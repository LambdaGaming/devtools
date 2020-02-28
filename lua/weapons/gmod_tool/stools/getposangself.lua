
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
		local pos = self.Owner:GetPos()
		local formattedpos = "Vector( "..pos.x..", "..pos.y..", "..pos.z.." )"
		if canfancytext then
			chat.AddText( formattedpos )
		else
			chat.AddText( tostring( pos ) )
		end
		if canclipboard then
			if canfancytext then
				SetClipboardText( formattedpos )
			else
				SetClipboardText( tostring( pos ) )
			end
		end
	end
end

function TOOL:RightClick()
	if IsFirstTimePredicted() and CLIENT then
		local canfancytext = GetConVar( "DevTools_ShouldFancyText" ):GetBool()
		local canclipboard = GetConVar( "DevTools_ShouldClipboard" ):GetBool()
		local ang = self.Owner:GetAngles()
		local formattedpos = "Angle( "..ang.x..", "..ang.y..", "..ang.z.." )"
		if canfancytext then
			chat.AddText( formattedpos )
		else
			chat.AddText( tostring( ang ) )
		end
		if canclipboard then
			if canfancytext then
				SetClipboardText( formattedpos )
			else
				SetClipboardText( tostring( ang ) )
			end
		end
	end
end