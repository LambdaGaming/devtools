TOOL.Name = "Get Trace Pos and Angle"
TOOL.Category = "Dev Tools"

if CLIENT then
	language.Add( "tool.getposangtrace.name", "Get Trace Pos and Angle" )
	language.Add( "tool.getposangtrace.desc", "Prints position and angle of target entity." )
	language.Add( "tool.getposangtrace.0", "Left-click: Get vector of eye trace entity. Right-click: Get angle of eye trace entity." )
end

function TOOL:LeftClick( tr )
	if IsFirstTimePredicted() and CLIENT then
		if IsValid( tr.Entity ) then
			DevTools_FormatVecAng( tr.Entity:GetPos() )
		end
	end
end

function TOOL:RightClick( tr )
	if IsFirstTimePredicted() and CLIENT then
		if IsValid( tr.Entity ) then
			DevTools_FormatVecAng( tr.Entity:GetAngles() )
		end
	end
end
