TOOL.Name = "Get Entity IDs"
TOOL.Category = "Dev Tools"

if CLIENT then
	language.Add( "tool.getentindex.name", "Get Entity IDs" )
	language.Add( "tool.getentindex.desc", "Prints the index and creation IDs of the target entity." )
	language.Add( "tool.getentindex.0", "Left-click: Get the index of target entity. Right-click: Get creation ID of target entity. Reload: Get map creation ID of target entity." )
end

if SERVER then
	util.AddNetworkString( "DevTools_GetEntIDs" )
	util.AddNetworkString( "DevTools_SendEntIDs" )
	net.Receive( "DevTools_GetEntIDs", function( len, ply )
		local ent = net.ReadEntity()
		local num = net.ReadInt( 3 )
		local value
		if num == 1 then
			value = ent:EntIndex()
		elseif num == 2 then
			value = ent:GetCreationID()
		else
			value = ent:MapCreationID()
		end
		ply:ChatPrint( value )
		DevTools_TryClipboard( ply, value )
	end )
end

function TOOL:LeftClick( tr )
	if IsFirstTimePredicted() and CLIENT then
		if IsValid( tr.Entity ) then
			net.Start( "DevTools_GetEntIDs" )
			net.WriteEntity( tr.Entity )
			net.WriteInt( 1, 3 )
			net.SendToServer()
		end
	end
end

function TOOL:RightClick( tr )
	if IsFirstTimePredicted() and CLIENT then
		if IsValid( tr.Entity ) then
			net.Start( "DevTools_GetEntIDs" )
			net.WriteEntity( tr.Entity )
			net.WriteInt( 2, 3 )
			net.SendToServer()
		end
	end
end

function TOOL:Reload( tr )
	if IsFirstTimePredicted() and CLIENT then
		if IsValid( tr.Entity ) then
			net.Start( "DevTools_GetEntIDs" )
			net.WriteEntity( tr.Entity )
			net.WriteInt( 3, 3 )
			net.SendToServer()
		end
	end
end
