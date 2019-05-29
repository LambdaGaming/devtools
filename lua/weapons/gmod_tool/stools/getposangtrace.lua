
TOOL.Name = "Get Trace Pos and Angle"
TOOL.Category = "Dev Tools"

if CLIENT then
	language.Add( "tool.getposang.name", "Get Trace Pos and Angle" )
	language.Add( "tool.getposang.desc", "Prints position and angle of target entity." )
	language.Add( "tool.getposang.0", "Left-click: Get vector of eye trace entity. Right-click: Get angle of eye trace entity." )
end

local canfancytext = GetConVar( "DevTools_ShouldFancyText" ):GetBool()
local canclipboard = GetConVar( "DevTools_ShouldClipboard" ):GetBool()

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
					SetClipBoardText( pos )
				end
			end
		end
	end
end

function TOOL:RightClick( tr )
	if IsFirstTimePredicted() and CLIENT then
		if IsValid( tr.Entity ) then
			local ang = tr.Entity:GetAngles()
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
end