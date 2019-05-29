
TOOL.Name = "Get Self Pos and Angle"
TOOL.Category = "Dev Tools"

if CLIENT then
	language.Add( "tool.getposang.name", "Get Self Pos and Angle" )
	language.Add( "tool.getposang.desc", "Prints position and angle of yourself." )
	language.Add( "tool.getposang.0", "Left-click: Get vector of yourself. Right-click: Get angle of yourself." )
end

local canfancytext = GetConVar( "DevTools_ShouldFancyText" ):GetBool()
local canclipboard = GetConVar( "DevTools_ShouldClipboard" ):GetBool()

function TOOL:LeftClick()
	if IsFirstTimePredicted() and CLIENT then
		local pos = self.Owner:GetPos()
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
				SetClipBoardText( pos )
			end
		end
	end
end

function TOOL:RightClick()
	if IsFirstTimePredicted() and CLIENT then
		local ang = self.Owner:GetAngles()
		local formattedpos = "Angle( "..ang.x..", "..ang.y..", "..ang.z.." )"
		if canfancytext then
			self.Owner:ChatPrint( formattedpos )
		else
			self.Owner:ChatPrint( pos )
		end
		if canclipboard then
			if canfancytext then
				SetClipboardText( formattedpos )
			else
				SetClipBoardText( pos )
			end
		end
	end
end