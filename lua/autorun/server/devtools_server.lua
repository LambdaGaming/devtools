util.AddNetworkString( "DevTools_Clipboard" )
function DevTools_TryClipboard( ply, text )
	net.Start( "DevTools_Clipboard" )
	net.WriteString( text )
	net.Send( ply )
end
