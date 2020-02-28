
TOOL.Name = "Get Entity Index"
TOOL.Category = "Dev Tools"

if CLIENT then
	language.Add( "tool.getentindex.name", "Get Entity Index" )
	language.Add( "tool.getentindex.desc", "Prints the index number of the target entity." )
	language.Add( "tool.getentindex.0", "Left-click: Get the index of the target entity. Right-click: Add index to a table of indexes. Reload: Print entire table of indexes to console. Also resets the table." )
end

local indexes = {}

function TOOL:LeftClick( tr )
	if IsFirstTimePredicted() and CLIENT then
		local canclipboard = GetConVar( "DevTools_ShouldClipboard" ):GetBool()
		if IsValid( tr.Entity ) then
			local ind = tr.Entity:EntIndex()
			chat.AddText( tostring( ind ) )
			if canclipboard then
				SetClipboardText( ind )
			end
		end
	end
end

function TOOL:RightClick( tr )
	if IsFirstTimePredicted() and CLIENT then
		if IsValid( tr.Entity ) then
			local ind = tr.Entity:EntIndex()
			table.insert( indexes, ind )
			chat.AddText( "Index "..ind.." from entity "..tr.Entity:GetClass().." added to table." )
		end
	end
end

function TOOL:Reload()
	if IsFirstTimePredicted() and CLIENT then
		if #indexes < 1 then chat.AddText( "No collected ent index values detected." ) return end
		for k,v in pairs( indexes ) do print( v ) end
		table.Empty( indexes )
		chat.AddText( "A table of collected ent indexes has been printed to your console." )
	end
end