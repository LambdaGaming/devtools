
TOOL.Name = "Get Pos Relative To Trace Entity"
TOOL.Category = "Dev Tools"

if CLIENT then
	language.Add( "tool.getposlocal.name", "Get Pos Relative To Trace Entity" )
	language.Add( "tool.getposlocal.desc", "Prints position of your trace relative to the entity that the trace hit." )
	language.Add( "tool.getposlocal.0", "Left-click: Get vector of trace relative to trace entity." )
end

function TOOL:LeftClick( tr )
	if IsFirstTimePredicted() and CLIENT then
		local canclipboard = GetConVar( "DevTools_ShouldClipboard" ):GetBool()
		local canfancytext = GetConVar( "DevTools_ShouldFancyText" ):GetBool()
		if IsValid( tr.Entity ) then
			local trent = tr.Entity
			trent:SetParent( self.Owner )
			local pos = trent:GetLocalPos()
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
			trent:SetParent( nil )
		end
	end
end