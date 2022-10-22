TOOL.Name = "Get Pos Relative To Trace Entity"
TOOL.Category = "Dev Tools"

if CLIENT then
	language.Add( "tool.getposlocal.name", "Get Pos Relative To Trace Entity" )
	language.Add( "tool.getposlocal.desc", "Prints position of your trace relative to the entity that the trace hit." )
	language.Add( "tool.getposlocal.0", "Left-click: Get vector of trace relative to trace entity." )
end

function TOOL:LeftClick( tr )
	if IsFirstTimePredicted() and CLIENT then
		if IsValid( tr.Entity ) then
			local trent = tr.Entity
			local pos = trent:WorldToLocal( tr.HitPos )
			DevTools_FormatVecAng( pos )
		end
	end
end
