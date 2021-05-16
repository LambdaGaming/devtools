
TOOL.Name = "Find Entity"
TOOL.Category = "Dev Tools"

local OpenText
local EntityTable
local CurrentEntity = 1
if CLIENT then
	language.Add( "tool.findentity.name", "Find Entity" )
	language.Add( "tool.findentity.desc", "Teleports players to entities of the specified class." )
	language.Add( "tool.findentity.0", "Left-click: Teleport to the next found entity. Right-click: Teleport to the previous found entity. Reload: Open the " )

	local MenuColor = Color( 49, 53, 61, 200 )
	OpenText = function( ply )
		local mainframe = vgui.Create( "DFrame" )
		mainframe:SetTitle( "Class name input" )
		mainframe:SetSize( 200, 65 )
		mainframe:Center()
		mainframe:MakePopup()
		mainframe.Paint = function( self, w, h )
			draw.RoundedBox( 0, 0, 0, w, h, MenuColor )
		end
		mainframe.OnClose = function()
			ply.DevTextOpen = false
		end

		local txt = vgui.Create( "DTextEntry", mainframe )
		txt:Dock( LEFT )
		txt:SetSize( 180, 25 )
		txt:SetValue( "Enter entity class name" )
		txt.OnEnter = function( self )
			mainframe:Close()
			net.Start( "DevTools_FindEntity" )
			net.WriteString( self:GetValue() )
			net.SendToServer()
		end
		ply.DevTextOpen = true
	end
end

if SERVER then
	util.AddNetworkString( "DevTools_FindEntity" )
	local function FindEntity( len, ply )
		local ent = net.ReadString()
		local find = ents.FindByClass( ent )
		if #find == 0 then
			ply:ChatPrint( "No entities with the class name '"..ent.."' could be found on the map." )
			return
		end
		ply:ChatPrint( "Found "..#find.." entities with the specified class name on the map." )
		EntityTable = find
	end
	net.Receive( "DevTools_FindEntity", FindEntity )

	util.AddNetworkString( "DevTools_TeleTo" )
	local function TeleTo( len, ply )
		if EntityTable == nil or table.IsEmpty( EntityTable ) then
			ply:ChatPrint( "Please press reload and enter an entity name." )
			return
		end
		local forward = net.ReadBool()
		if forward then
			CurrentEntity = math.Clamp( CurrentEntity + 1, 1, #EntityTable )
		else
			CurrentEntity = math.Clamp( CurrentEntity - 1, 1, #EntityTable )
		end
		if IsValid( EntityTable[CurrentEntity] ) then
			ply:SetPos( EntityTable[CurrentEntity]:GetPos() )
			ply:ChatPrint( "Current Entity: "..CurrentEntity.." out of "..#EntityTable )
		else
			EntityTable[CurrentEntity] = nil
			ply:ChatPrint( "The selected entity doesn't exist anymore. Removing from list." )
		end
	end
	net.Receive( "DevTools_TeleTo", TeleTo )
end

function TOOL:LeftClick( tr )
	if IsFirstTimePredicted() and CLIENT then
		net.Start( "DevTools_TeleTo" )
		net.WriteBool( true )
		net.SendToServer()
	end
end

function TOOL:RightClick( tr )
	if IsFirstTimePredicted() and CLIENT then
		net.Start( "DevTools_TeleTo" )
		net.SendToServer()
	end
end

function TOOL:Reload( tr )
	if IsFirstTimePredicted() and CLIENT and !self.Owner.DevTextOpen then
		OpenText( self.Owner )
	end
end
