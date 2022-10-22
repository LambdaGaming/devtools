TOOL.Name = "Get Velocity"
TOOL.Category = "Dev Tools"

if CLIENT then
	language.Add( "tool.getvelocity.name", "Get Velocity" )
	language.Add( "tool.getvelocity.desc", "Prints velocity of target entity." )
	language.Add( "tool.getvelocity.0", "Left-click: Get velocity in MPH. Right-click: Get velocity in KPH. Reload: Get velocity in hammer units." )
end

function TOOL:LeftClick( tr )
	if IsFirstTimePredicted() and CLIENT then
		if IsValid( tr.Entity ) then
			DevTools_FormatVelocity( tr.Entity:GetVelocity():Length(), 1 )
		end
	end
end

function TOOL:RightClick( tr )
	if IsFirstTimePredicted() and CLIENT then
		if IsValid( tr.Entity ) then
			DevTools_FormatVelocity( tr.Entity:GetVelocity():Length(), 2 )
		end
	end
end

function TOOL:Reload( tr )
	if IsFirstTimePredicted() and CLIENT then
		if IsValid( tr.Entity ) then
			DevTools_FormatVelocity( tr.Entity:GetVelocity():Length(), 3 )
		end
	end
end
