
CreateClientConVar( "DevTools_ShouldClipboard", 1, true, false, "Should the text that a tool prints out be copied to your clipboard." )
CreateClientConVar( "DevTools_ShouldFancyText", 1, true, false, "Should the text that a tool prints out be formatted into a Lua function. (Ex: 0 0 0 gets formatted into Vector( 0, 0, 0 ))" )
hook.Add( "PopulateToolMenu", "DevToolsConfig", function()
    spawnmenu.AddToolMenuOption( "Options", "Dev Tools", "DevTools", "Config", "", "", function( panel )
		panel:CheckBox( "Copy output text to clipboard", "DevTools_ShouldClipboard" )
		panel:CheckBox( "Print text in a Lua format", "DevTools_ShouldFancyText" )
	end )
end )

concommand.Add( "DevTools_Workshop", function( ply, cmd, args )
	gui.OpenURL( "https://steamcommunity.com/sharedfiles/filedetails/?id=1614988605" )
end )