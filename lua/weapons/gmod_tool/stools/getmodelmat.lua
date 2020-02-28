
TOOL.Name = "Get Model/Material"
TOOL.Category = "Dev Tools"

if CLIENT then
	language.Add( "tool.getmodelmat.name", "Get Model/Material" )
	language.Add( "tool.getmodelmat.desc", "Prints model and material path of target entity." )
	language.Add( "tool.getmodelmat.0", "Left-click: Get model path of target entity. Right-click: Get material path of target entity." )

	net.Receive( "ModelClipboard", function()
		local canclipboard = GetConVar( "DevTools_ShouldClipboard" ):GetBool()
		if canclipboard then
			local model = net.ReadString()
			SetClipboardText( model )
		end
	end )
end

if SERVER then
	util.AddNetworkString( "GetServerModel" ) --The client model path can sometimes differ from the server's, this is added to always print the server's model path
	util.AddNetworkString( "ModelClipboard" )
	net.Receive( "GetServerModel", function( len, ply )
		local ent = net.ReadEntity()
		local model = ent:GetModel()
		ply:ChatPrint( model )
		net.Start( "ModelClipboard" )
		net.WriteString( model )
		net.Send( ply )
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
		local canclipboard = GetConVar( "DevTools_ShouldClipboard" ):GetBool()
		if IsValid( tr.Entity ) then
			local material = tr.Entity:GetMaterial()
			if material == "" then
				chat.AddText( "No material override found for this entity." )
				return
			end
			chat.AddText( material )
			if canclipboard then
				SetClipboardText( material )
			end
		end
	end
end