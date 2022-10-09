TOOL.Name = "Get Boundary"
TOOL.Category = "Dev Tools"

if CLIENT then
	language.Add( "tool.getboundary.name", "Get Boundary" )
	language.Add( "tool.getboundary.desc", "Spawns 2 blocks that you can manually place to create a boundary, and prints the upper and lower values of that boundary." )
	language.Add( "tool.getboundary.0", "Left-click: Spawn blocks. Right-click: Remove blocks. Reload: Print upper and lower values." )
end

function TOOL:LeftClick( tr )
	if IsFirstTimePredicted() and !self.Active then
		if SERVER then
			local ply = self:GetOwner()
			local e = ents.Create( "prop_physics" )
			e:SetPos( tr.HitPos )
			e:SetModel( "models/hunter/blocks/cube025x025x025.mdl" )
			e:Spawn()
			ply:SetNWEntity( "Block1", e )
			local e2 = ents.Create( "prop_physics" )
			e2:SetPos( tr.HitPos + Vector( 0, 0, 15 ) )
			e2:SetModel( "models/hunter/blocks/cube025x025x025.mdl" )
			e2:Spawn()
			ply:SetNWEntity( "Block2", e2 )
		else
			local color_green = Color( 0, 255, 0 )
			hook.Add( "PreDrawEffects", "DevTools_DrawBoundaryBox", function()
				local ply = LocalPlayer()
				if ply:GetNWEntity( "Block1" ) != NULL then
					local e = ply:GetNWEntity( "Block1" )
					local e2 = ply:GetNWEntity( "Block2" )
					local lerp = LerpVector( 0.5, e:WorldToLocal( e:GetPos() ), e2:WorldToLocal( e2:GetPos() ) )
					render.DrawWireframeBox( lerp, angle_zero, e:GetPos(), e2:GetPos(), color_green )
				end
			end )
		end
		self.Active = true
	end
end

function TOOL:RightClick( tr )
	if IsFirstTimePredicted() and self.Active then
		if SERVER then
			local ply = self:GetOwner()
			local e = ply:GetNWEntity( "Block1" )
			local e2 = ply:GetNWEntity( "Block2" )
			if IsValid( e ) then e:Remove() end
			if IsValid( e2 ) then e2:Remove() end
			ply:SetNWEntity( "Block1", NULL )
			ply:SetNWEntity( "Block2", NULL )
		else
			hook.Remove( "PreDrawEffects", "DevTools_DrawBoundaryBox" )
		end
		self.Active = false
	end
end

function TOOL:Reload()
	if IsFirstTimePredicted() and SERVER and self.Active then
		local ply = self:GetOwner()
		local e = ply:GetNWEntity( "Block1" )
		local e2 = ply:GetNWEntity( "Block2" )
		local pos1 = e:GetPos()
		local pos2 = e2:GetPos()
		local upper, lower
		if pos1.z >= pos2.z then
			upper = pos1
			lower = pos2
		else
			upper = pos2
			lower = pos1
		end
		local format1 = "Vector( "..math.Round( upper.x )..", "..math.Round( upper.y )..", "..math.Round( upper.z ).." )"
		local format2 = "Vector( "..math.Round( lower.x )..", "..math.Round( lower.y )..", "..math.Round( lower.z ).." )"
		ply:ChatPrint( "Upper: "..format1 )
		ply:ChatPrint( "Lower: "..format2 )
	end
end
