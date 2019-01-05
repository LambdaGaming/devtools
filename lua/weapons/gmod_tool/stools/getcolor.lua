
TOOL.Name = "Get Color"
TOOL.Category = "Dev Tools"

if CLIENT then
	language.Add( "tool.getcolor.name", "Get Color" )
	language.Add( "tool.getcolor.desc", "Prints color of target entity." )
	language.Add( "tool.getcolor.0", "Left-click: Get color of target entity." )
end

local canfancytext = GetConVar( "DevTools_ShouldFancyText" ):GetBool()
local canclipboard = GetConVar( "DevTools_ShouldClipboard" ):GetBool()

function TOOL:LeftClick( tr )
	if IsFirstTimePredicted() and CLIENT then
		if IsValid( tr.Entity ) then
			local color = tr.Entity:GetColor()
			local formattedcolor = "Color( "..color.r..", "..color.g..", "..color.b..", "..color.a.." )"
			if canfancytext then
				self.Owner:ChatPrint( formattedcolor )
			else
				self.Owner:ChatPrint( color )
			end
			if canclipboard then
				if canfancytext then
					SetClipboardText( formattedcolor )
				else
					SetClipboardText( color )
				end
			end
		end
	end
end