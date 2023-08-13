--do return end
AddCSLuaFile()
local Animation = {
	--前三个:客户端,剩下的都是服务端
	--SEQ,倍速,提前结束(恢复)时间,提前执行,总时长,WM,造成伤害的时间
	{"seq_baton_swing",1.18,0.65,0.2,1.1,"range_melee_shove_1hand",0.3},
	{"seq_meleeattack01",1.15,0.35,0.2,0.9,"range_melee_shove_2hand",0.4}
}
local BlackList = {
	["fist"] = true,
}
local onehand = {
	["physgun"] = true, --不支持
	["melee"] = true,
	["melee2"] = true,
	["knife"] = true,
	["grenade"] = true,
	["pistol"] = true,
	["camera"] = true,
	["magic"] = true,
	["revolver"] = true,
	["slam"] = true,
	[""] = true,
}
local melee = {
	["melee"] = true,
	["melee2"] = true,
	["knife"] = true,
	["grenade"] = true,
}

--local ForceLRModel = {}

hook.Add("StartCommand","savee_armmelee_sh_startcommand",function(p,cmd)

	if p:GetNWBool("savee_armmelee_inmelee") and p:Alive() then
		cmd:RemoveKey(IN_ATTACK)
		cmd:RemoveKey(IN_ATTACK2)
		cmd:RemoveKey(IN_RELOAD)
		cmd:RemoveKey(IN_USE)
		if IsValid(p:GetActiveWeapon()) then
			cmd:SelectWeapon(p:GetActiveWeapon())
		end
	end

end)
CreateConVar("savee_armmelee_enabled",1,{FCVAR_ARCHIVE,FCVAR_PROTECTED,FCVAR_REPLICATED})
CreateConVar("savee_armmelee_disableactdec",1,{FCVAR_ARCHIVE,FCVAR_PROTECTED,FCVAR_REPLICATED})
CreateConVar("savee_armmelee_damage",30,{FCVAR_ARCHIVE,FCVAR_PROTECTED,FCVAR_REPLICATED})
CreateConVar("savee_armmelee_damageoffset",5,{FCVAR_ARCHIVE,FCVAR_PROTECTED,FCVAR_REPLICATED})
CreateConVar("savee_armmelee_enableviewpunch",1,{FCVAR_ARCHIVE,FCVAR_PROTECTED,FCVAR_REPLICATED})
CreateConVar("savee_armmelee_nomelee",1,{FCVAR_ARCHIVE,FCVAR_PROTECTED,FCVAR_REPLICATED})

if SERVER then
	
	util.AddNetworkString("savee_armmelee_sv_meleenet") --没更好的想法了

	local BlockedAct = {
		[ACT_VM_PRIMARYATTACK] = true,
		[ACT_VM_SECONDARYATTACK] = true,
		[ACT_VM_DRYFIRE] = true,
		[ACT_VM_RELOAD] = true,
		[ACT_VM_DRAW] = true,
	}

	net.Receive("savee_armmelee_sv_meleenet",function(_,p)
		--if GetConVar("savee_armmelee_enabled"):GetInt()==0 then return end
		if GetConVar("savee_armmelee_enabled"):GetInt()==0 or !IsValid(p) then return end
		--print(p:GetViewModel():GetModel())
		local w=p:GetActiveWeapon()
		if !p:GetNWBool("savee_armmelee_inmelee") and IsValid(w) and !BlackList[w:GetHoldType()] and (!BlockedAct[w:GetActivity()] or GetConVar("savee_armmelee_disableactdec"):GetInt()!=0) and !p:InVehicle()
		and (!melee[w:GetHoldType()] or GetConVar("savee_armmelee_nomelee"):GetInt()==0) then
			local Anim = onehand[w:GetHoldType()] and Animation[1] or Animation[2]
			p:SetNWBool("savee_armmelee_inmelee", true)
			p:SetNWFloat("savee_armmelee_lastmelee",CurTime())
			--p.savee_armmelee_layer=p:AddLayeredSequence(p:LookupSequence(Anim[6]),1)
			--p:SetLayerSequence(p.savee_armmelee_layer,p:LookupSequence("seq_baton_swing"))
			--p:SetLayerCycle(p.savee_armmelee_layer,0)
			--p:SetLayerPriority(p.savee_armmelee_layer,8)
			--p:SetLayerPriority(p.savee_armmelee_layer,8)
			net.Start("savee_armmelee_sv_meleenet")
				net.WriteEntity(p)
				net.WriteBool(onehand[w:GetHoldType()])
			net.Broadcast()
			timer.Create("Savee_Armmelee_PlayerMelee_"..p:EntIndex().."_Melee",(Anim[7]-Anim[4])/Anim[2],1,function()
				if !IsValid(p) or !p:GetNWBool("savee_armmelee_inmelee") or !p:Alive() or !IsValid(w) or w!=p:GetActiveWeapon() or p:InVehicle() then 
					if IsValid(p) then 
						p:SetNWBool("savee_armmelee_inmelee", false)
						--p:SetNWFloat("savee_armmelee_lastmelee",-1)
					end
					return 
				end
				local tr=util.TraceHull({
					start = p:GetShootPos(),
					endpos = p:GetShootPos()+p:GetAimVector()*75,
					filter = p,
					mins = Vector(-5,-5,-5),
					maxs = Vector(5,5,5)
				})
				if IsValid(tr.Entity) then
					local di=DamageInfo()
					di:SetAttacker(p)
					di:SetInflictor(p)
					di:SetDamagePosition(tr.HitPos)
					di:SetDamageForce(p:GetAimVector()*6500+p:GetVelocity())
					local dmg,dmgr = GetConVar("savee_armmelee_damage"):GetFloat(),GetConVar("savee_armmelee_damageoffset"):GetFloat()
					di:SetDamage(math.random(dmg-dmgr,dmg+dmgr))
					di:SetDamageType(DMG_CLUB)
					tr.Entity:TakeDamageInfo(di)
					--tr.Entity:TakeDamage(1000,p,w)
					p:EmitSound("physics/body/body_medium_impact_hard"..math.random(1,6)..".wav")
				elseif tr.Hit then
					p:EmitSound("physics/body/body_medium_impact_hard"..math.random(1,6)..".wav")
				else
					p:EmitSound("weapons/slam/throw.wav")
				end
				--p:SetNWBool("savee_armmelee_inmelee", false)

			end)
			timer.Create("Savee_Armmelee_PlayerMelee_"..p:EntIndex().."_End",(Anim[5]-Anim[4])/Anim[2],1,function()

				if !IsValid(p) or !p:GetNWBool("savee_armmelee_inmelee") then 
					return 
				end
				p:SetNWBool("savee_armmelee_inmelee", false)
				--p:SetNWFloat("savee_armmelee_lastmelee",-1)

			end)
		end
	end)
	hook.Add("PlayerSpawn","savee_armmelee_sv_playerspawn",function(p)
		
		timer.Remove("Savee_Armmelee_PlayerMelee_"..p:EntIndex().."_End")
		timer.Remove("Savee_Armmelee_PlayerMelee_"..p:EntIndex().."_Melee")
		p:SetNWBool("savee_armmelee_inmelee", false)
		p:SetNWFloat("savee_armmelee_lastmelee",-1)
	
	end)
	hook.Add("PlayerSwitchWeapon","savee_armmelee_sv_antiswitch", function(p)
		--print(p)
		if p:GetNWBool("savee_armmelee_inmelee") then return true end
	end)

else

	SAVEE_TEMP_ARMMELEE_RELATEDSHIT = SAVEE_TEMP_ARMMELEE_RELATEDSHIT

	local NoViewModel
	local AnimMdl = SAVEE_TEMP_ARMMELEE_RELATEDSHIT
	local RECHECKED

	local MDLForceLH = {
		["models/weapons/c_superphyscannon.mdl"] = true,
	}
	--我放弃了
	local LeftArmBone = {
		["ValveBiped.Bip01_L_UpperArm"] = true,
		["ValveBiped.Bip01_L_Forearm"] = true,
		["ValveBiped.Bip01_L_Hand"] = true,
		["ValveBiped.Bip01_L_Ulna"] = true,
		["ValveBiped.Bip01_L_Wrist"] = true,
		["ValveBiped.Bip01_L_Elbow"] = true,
		["ValveBiped.Bip01_L_Bicep"] = true,
		["ValveBiped.Bip01_L_Shoulder"] = true,
		["ValveBiped.Bip01_L_Trapezius"] = true,
		["ValveBiped.Bip01_L_Finger0"] = true,
		["ValveBiped.Bip01_L_Finger01"] = true,
		["ValveBiped.Bip01_L_Finger02"] = true,
		["ValveBiped.Bip01_L_Finger1"] = true,
		["ValveBiped.Bip01_L_Finger11"] = true,
		["ValveBiped.Bip01_L_Finger12"] = true,
		["ValveBiped.Bip01_L_Finger2"] = true,
		["ValveBiped.Bip01_L_Finger21"] = true,
		["ValveBiped.Bip01_L_Finger22"] = true,
		["ValveBiped.Bip01_L_Finger3"] = true,
		["ValveBiped.Bip01_L_Finger31"] = true,
		["ValveBiped.Bip01_L_Finger32"] = true,
		["ValveBiped.Bip01_L_Finger4"] = true,
		["ValveBiped.Bip01_L_Finger41"] = true,
		["ValveBiped.Bip01_L_Finger42"] = true,
	}
	local RightArmBone = {
		["ValveBiped.Bip01_R_UpperArm"] = true,
		["ValveBiped.Bip01_R_Forearm"] = true,
		["ValveBiped.Bip01_R_Hand"] = true,
		["ValveBiped.Bip01_R_Ulna"] = true,
		["ValveBiped.Bip01_R_Wrist"] = true,
		["ValveBiped.Bip01_R_Elbow"] = true,
		["ValveBiped.Bip01_R_Bicep"] = true,
		["ValveBiped.Bip01_R_Shoulder"] = true,
		["ValveBiped.Bip01_R_Trapezius"] = true,
		["ValveBiped.Bip01_R_Finger0"] = true,
		["ValveBiped.Bip01_R_Finger01"] = true,
		["ValveBiped.Bip01_R_Finger02"] = true,
		["ValveBiped.Bip01_R_Finger1"] = true,
		["ValveBiped.Bip01_R_Finger11"] = true,
		["ValveBiped.Bip01_R_Finger12"] = true,
		["ValveBiped.Bip01_R_Finger2"] = true,
		["ValveBiped.Bip01_R_Finger21"] = true,
		["ValveBiped.Bip01_R_Finger22"] = true,
		["ValveBiped.Bip01_R_Finger3"] = true,
		["ValveBiped.Bip01_R_Finger31"] = true,
		["ValveBiped.Bip01_R_Finger32"] = true,
		["ValveBiped.Bip01_R_Finger4"] = true,
		["ValveBiped.Bip01_R_Finger41"] = true,
		["ValveBiped.Bip01_R_Finger42"] = true,
	}

	--LocalPlayer():SetEyeAngles((Vector(0,0,0)-LocalPlayer():EyePos()):Angle())
	local ForceLH = 225
	local LastSelectLH,Selected
	
	concommand.Add("savee_armmelee_melee",function(p)
		--AnimMdl:SetModel("models/player/breen.mdl")
		if !SVMAL then 
			Error("[SVMAL] Where's SVMAL :(")
			return 
		end
		local w=p:GetActiveWeapon()
		if GetConVar("savee_armmelee_enabled"):GetInt()==0 or !IsValid(w) or BlackList[w:GetHoldType()] or (GetConVar("savee_armmelee_nomelee"):GetInt()!=0 and melee[w:GetHoldType()]) or SVMAL.GetAnimPlaying() then return end
		local Anim = (onehand[w:GetHoldType()]) and Animation[1] or Animation[2]
		SVMAL.StartAnimation({
			Anim = Anim[1],--"seq_baton_swing",
			Model = p:GetModel(),
			PlaybackRate = Anim[2],
			Offset_StartTime = Anim[4],
			Offset_EndTime = Anim[3],
			AutoDecideHands = true,
			--OneHand = true,
		})
		local w=p:GetActiveWeapon()
		if !p:GetNWBool("savee_armmelee_inmelee") and IsValid(w) and !BlackList[w:GetHoldType()] then
			net.Start("savee_armmelee_sv_meleenet")
			net.SendToServer()
		end
	end)
	net.Receive("savee_armmelee_sv_meleenet",function()
		if GetConVar("savee_armmelee_enabled"):GetInt()==0 then return end
		local p,oh=net.ReadEntity(),net.ReadBool()
		local Anim = oh and Animation[1] or Animation[2]
		p:AnimRestartGesture(GESTURE_SLOT_ATTACK_AND_RELOAD,p:GetSequenceActivity(p:LookupSequence(Anim[6])),true)
	end)
		--AnimMdl:SetupBones()
		--AnimMdl:SetCycle(0)
end