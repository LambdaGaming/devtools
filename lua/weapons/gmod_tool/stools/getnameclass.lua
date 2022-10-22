TOOL.Name = "Get Name/Class"
TOOL.Category = "Dev Tools"

if CLIENT then
	language.Add( "tool.getnameclass.name", "Get Name/Class" )
	language.Add( "tool.getnameclass.desc", "Prints the name and class of the target entity." )
	language.Add( "tool.getnameclass.0", "Left-click: Get class of target entity. Right-click: Get name of target entity." )
end

if SERVER then
	util.AddNetworkString( "GetEntityName" )
	net.Receive( "GetEntityName", function( len, ply )
		local ent = net.ReadEntity()
		local name = ent:GetName()
		if name == "" then
			ply:ChatPrint( "No name is assigned to this entity." )
			return
		end
		ply:ChatPrint( name )
		DevTools_TryClipboard( ply, name )
	end )
end

function TOOL:LeftClick( tr )
	if IsFirstTimePredicted() and CLIENT then
		if IsValid( tr.Entity ) then
			local class = tr.Entity:GetClass()
			chat.AddText( class )
			DevTools_TryClipboard( class )
		end
	end
end

function TOOL:RightClick( tr )
	if IsFirstTimePredicted() and CLIENT then
		if IsValid( tr.Entity ) then
			net.Start( "GetEntityName" )
			net.WriteEntity( tr.Entity )
			net.SendToServer()
		end
	end
end
