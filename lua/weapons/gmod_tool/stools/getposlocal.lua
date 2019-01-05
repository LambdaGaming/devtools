
TOOL.Name = "Get Pos Relative To Trace Entity"
TOOL.Category = "Dev Tools"

if CLIENT then
	language.Add( "tool.getposlocal.name", "Get Pos Relative To Trace Entity" )
	language.Add( "tool.getposlocal.desc", "Prints position of your trace relative to the entity that the trace hit." )
	language.Add( "tool.getposlocal.0", "Left-click: Get vector of trace relative to trace entity." )
end

local canclipboard = GetConVar( "DevTools_ShouldClipboard" ):GetBool()
local canfancytext = GetConVar( "DevTools_ShouldFancyText" ):GetBool()

function TOOL:LeftClick( tr )
	if IsFirstTimePredicted() and CLIENT then
		if IsValid( tr.Entity ) then
			local trent = tr.Entity
			trent:SetParent( self.Owner )
			local pos = trent:GetLocalPos()
			local formattedpos = "Vector( "..pos.x..", "..pos.y..", "..pos.z.." )"
			if canfancytext then
				self.Owner:ChatPrint( formattedpos )
			else
				self.Owner:ChatPrint( pos )
			end
			if canclipboard then
				if canfancytext then
					SetClipboardText( formattedpos )
				else
					SetClipboardText( pos )
				end
			end
		end
	end
end