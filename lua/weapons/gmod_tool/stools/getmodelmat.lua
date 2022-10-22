TOOL.Name = "Get Model/Material"
TOOL.Category = "Dev Tools"

if CLIENT then
	language.Add( "tool.getmodelmat.name", "Get Model/Material" )
	language.Add( "tool.getmodelmat.desc", "Prints model and material path of target entity." )
	language.Add( "tool.getmodelmat.0", "Left-click: Get model path of target entity. Right-click: Get material path of target entity." )
end

if SERVER then
	util.AddNetworkString( "GetServerModel" ) --The client model path can sometimes differ from the server's, this is added to always print the server's model path
	net.Receive( "GetServerModel", function( len, ply )
		local ent = net.ReadEntity()
		local model = ent:GetModel()
		ply:ChatPrint( model )
		DevTools_TryClipboard( ply, model )
	end )
end

function TOOL:LeftClick( tr )
	if IsFirstTimePredicted() and CLIENT then
		if IsValid( tr.Entity ) then
			net.Start( "GetServerModel" )
			net.WriteEntity( tr.Entity )
			net.SendToServer()
		end
	end
end

function TOOL:RightClick( tr )
	if IsFirstTimePredicted() and CLIENT then
		if IsValid( tr.Entity ) then
			local material = tr.Entity:GetMaterial()
			if material == "" then
				chat.AddText( "No material override found for this entity." )
				return
			end
			chat.AddText( material )
			DevTools_TryClipboard( material )
		end
	end
end
