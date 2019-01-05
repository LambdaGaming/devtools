
TOOL.Name = "Get Velocity"
TOOL.Category = "Dev Tools"

if CLIENT then
	language.Add( "tool.getvelocity.name", "Get Velocity" )
	language.Add( "tool.getvelocity.desc", "Prints velocity of target entity." )
	language.Add( "tool.getvelocity.0", "Left-click: Get velocity in MPH. Right-click: Get velocity in KPH. Reload: Get velocity in hammer units." )
end

local canfancytext = GetConVar( "DevTools_ShouldFancyText" ):GetBool()
local canclipboard = GetConVar( "DevTools_ShouldClipboard" ):GetBool()

function TOOL:LeftClick( tr )
	if IsFirstTimePredicted() and CLIENT then
		if IsValid( tr.Entity ) then
			local vel = tr.Entity:GetVelocity():Length() * 0.056818181
			local formattedvel = vel.." MPH"
			if canfancytext then
				self.Owner:ChatPrint( formattedvel )
			else
				self.Owner:ChatPrint( vel )
			end
			if canclipboard then
				if canfancytext then
					SetClipboardText( formattedvel )
				else
					SetClipboardText( vel )
				end
			end
		end
	end
end

function TOOL:RightClick( tr )
	if IsFirstTimePredicted() and CLIENT then
		if IsValid( tr.Entity ) then
			local vel = tr.Entity:GetVelocity():Length() * 0.056818181
			local velkph = vel * 1.6093
			local formattedvel = velkph.." KPH"
			if canfancytext then
				self.Owner:ChatPrint( formattedvel )
			else
				self.Owner:ChatPrint( vel )
			end
			if canclipboard then
				if canfancytext then
					SetClipboardText( formattedvel )
				else
					SetClipboardText( vel )
				end
			end
		end
	end
end

function TOOL:Reload( tr )
	if IsFirstTimePredicted() and CLIENT then
		if IsValid( tr.Entity ) then
			local vel = tr.Entity:GetVelocity():Length()
			local formattedvel = vel.." Hammer Units / Sec"
			if canfancytext then
				self.Owner:ChatPrint( formattedvel )
			else
				self.Owner:ChatPrint( vel )
			end
			if canclipboard then
				if canfancytext then
					SetClipboardText( formattedvel )
				else
					SetClipboardText( vel )
				end
			end
		end
	end
end