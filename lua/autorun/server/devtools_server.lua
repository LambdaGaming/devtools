util.AddNetworkString( "DevTools_Clipboard" )
function DevTools_TryClipboard( ply, text )
	net.Start( "DevTools_Clipboard" )
	net.WriteString( text )
	net.Send( ply )
end

local version = "1.9.1"
MsgC( Color( 0, 255, 255 ), "Development Tool Collection v"..version.." by OPGman successfully loaded.\n" )
