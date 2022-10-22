TOOL.Name = "Get Self Pos and Angle"
TOOL.Category = "Dev Tools"

if CLIENT then
	language.Add( "tool.getposangself.name", "Get Self Pos and Angle" )
	language.Add( "tool.getposangself.desc", "Prints position and angle of yourself." )
	language.Add( "tool.getposangself.0", "Left-click: Get vector of yourself. Right-click: Get angle of yourself." )
end

function TOOL:LeftClick()
	if IsFirstTimePredicted() and CLIENT then
		DevTools_FormatVecAng( self:GetOwner():GetPos() )
	end
end

function TOOL:RightClick()
	if IsFirstTimePredicted() and CLIENT then
		DevTools_FormatVecAng( self:GetOwner():GetAngles() )
	end
end
