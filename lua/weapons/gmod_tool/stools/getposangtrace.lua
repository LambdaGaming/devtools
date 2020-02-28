
TOOL.Name = "Get Trace Pos and Angle"
TOOL.Category = "Dev Tools"

if CLIENT then
	language.Add( "tool.getposangtrace.name", "Get Trace Pos and Angle" )
	language.Add( "tool.getposangtrace.desc", "Prints position and angle of target entity." )
	language.Add( "tool.getposangtrace.0", "Left-click: Get vector of eye trace entity. Right-click: Get angle of eye trace entity." )
end

function TOOL:LeftClick( tr )
	if IsFirstTimePredicted() and CLIENT then
		local canfancytext = GetConVar( "DevTools_ShouldFancyText" ):GetBool()
		local canclipboard = GetConVar( "DevTools_ShouldClipboard" ):GetBool()
		if IsValid( tr.Entity ) then
			local pos = tr.Entity:GetPos()
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
end

function TOOL:RightClick( tr )
	if IsFirstTimePredicted() and CLIENT then
		local canfancytext = GetConVar( "DevTools_ShouldFancyText" ):GetBool()
		local canclipboard = GetConVar( "DevTools_ShouldClipboard" ):GetBool()
		if IsValid( tr.Entity ) then
			local ang = tr.Entity:GetAngles()
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
end