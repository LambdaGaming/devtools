
TOOL.Name = "Get Pos Relative To World"
TOOL.Category = "Dev Tools"

if CLIENT then
	language.Add( "tool.getposworld.name", "Get Pos Relative To World" )
	language.Add( "tool.getposworld.desc", "Prints position of specified object relative to the world." )
	language.Add( "tool.getposworld.0", "Left-click: Get vector of eye trace entity. Right-click: Get vector of your position (Origin at feet). Reload: Get vector of your position (Origin at eyes)." )
end

local canclipboard = GetConVar( "DevTools_ShouldClipboard" ):GetBool()
local canfancytext = GetConVar( "DevTools_ShouldFancyText" ):GetBool()

function TOOL:LeftClick( tr )
	if IsFirstTimePredicted() and CLIENT then
		if IsValid( tr.Entity ) then
			local pos = tr.Entity:GetPos()
			local formattedpos = "Vector( "..pos.x..", "..pos.y..", "..pos.z.." )"
			if canfancytext then
				self.Owner:ChatPrint( formattedpos )
			else
				self.Owner:ChatPrint( pos )
			end
			if canclipboard then
				if canfancytext then
					SetClipboardText( formattedpos )
				else
					SetClipboardText( pos )
				end
			end
		end
	end
end

function TOOL:RightClick( tr )
	if IsFirstTimePredicted() and CLIENT then
		if IsValid( self.Owner ) then
			local pos = self.Owner:GetPos()
			local formattedpos = "Vector( "..pos.x..", "..pos.y..", "..pos.z.." )"
			self.Owner:ChatPrint( formattedpos )
			if canclipboard then
				SetClipboardText( formattedpos )
			end
		end
	end
end

function TOOL:Reload()
	if IsFirstTimePredicted() and CLIENT then
		if IsValid( self.Owner ) then
			local pos = self.Owner:EyePos()
			local formattedpos = "Vector( "..pos.x..", "..pos.y..", "..pos.z.." )"
			self.Owner:ChatPrint( formattedpos )
			if canclipboard then
				SetClipboardText( formattedpos )
			end
		end
	end
end