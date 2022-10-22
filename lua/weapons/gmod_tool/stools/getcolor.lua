TOOL.Name = "Get Color"
TOOL.Category = "Dev Tools"

if CLIENT then
	language.Add( "tool.getcolor.name", "Get Color" )
	language.Add( "tool.getcolor.desc", "Prints color of target entity." )
	language.Add( "tool.getcolor.0", "Left-click: Get color of target entity." )
end

function TOOL:LeftClick( tr )
	if IsFirstTimePredicted() and CLIENT then
		local canfancytext = GetConVar( "DevTools_ShouldFancyText" ):GetBool()
		if IsValid( tr.Entity ) then
			local color = tr.Entity:GetColor()
			local formattedcolor = "Color( "..color.r..", "..color.g..", "..color.b..", "..color.a.." )"
			if canfancytext then
				chat.AddText( formattedcolor )
			else
				chat.AddText( string.FromColor( color ) )
			end

			local clipboard
			if canfancytext then
				clipboard = formattedcolor
			else
				clipboard = string.FromColor( color )
			end
			DevTools_TryClipboard( clipboard )
		end
	end
end
