
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
		local canround = GetConVar( "DevTools_ShouldRoundDecimals" ):GetBool()
		if IsValid( tr.Entity ) then
			local trent = tr.Entity
			trent:SetParent( self.Owner )
			local pos = trent:GetLocalPos()
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
				finaltext = formattedpos
			end
			if canclipboard then
				SetClipboardText( finaltext )
			end
			trent:SetParent( nil )
		end
	end
end
