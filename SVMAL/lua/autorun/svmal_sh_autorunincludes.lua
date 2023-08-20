AddCSLuaFile()
local dir = "svmal/"
if SERVER then
	AddCSLuaFile(dir.."svmal_cl_func.lua")
	include(dir.."svmal_sv_func.lua")
else
	include(dir.."svmal_cl_func.lua")
end

/*
--[[
	制作这玩意的初衷仅仅是因为我懒得上传两个Addon的更新版本
	注意: 如果你要查文档,请移步doc.lua或doccn.lua,里面对func有较为细致的说明
	如果你执意要看这个文件,请准备好你的机翻
	(这东西通篇抄袭Armmelee,因为我懒得传了)
]]
--do return end

SAVEE_TEMP_SVMAL_RELATEDSHIT = SAVEE_TEMP_SVMAL_RELATEDSHIT

local NoViewModel
local AnimMdl = SAVEE_TEMP_SVMAL_RELATEDSHIT
local RECHECKED

local MDLForceLH = {
	["models/weapons/c_superphyscannon.mdl"] = true,
}

local PlyMeta = table.Copy(FindMetaTable("Player"))
local NewCSEntMeta = table.Copy(FindMetaTable("CSEnt"))
function NewCSEntMeta:AnimSetGestureSequence(...)
	--print(self)
	PlyMeta.AnimSetGestureSequence(self,...)
end
function NewCSEntMeta:IsPlayer()
	return true
end

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
local Cinema = !true

SVMAL = {
	_ValPlayingAnim = false,
	_ValCurrentAnimData = {},
}

function SVMAL.SetAnimPlaying(state)

	local OldStat = SVMAL._PlayingAnim
	SVMAL._ValPlayingAnim = state
	
	return OldStat

end
function SVMAL.GetAnimPlaying()

	return SVMAL._ValPlayingAnim

end

--SVMAL.SetAnimationPlaying(true)

function SVMAL.CreateAnimModel()

	if !IsValid(LocalPlayer()) then return end
	if IsValid(AnimMdl) then Error("[SVMAL] There's alreade a AnimModel!") end

	local p = IsValid(LocalPlayer():GetObserverTarget()) and LocalPlayer():GetObserverTarget() or LocalPlayer()
	--print("?2")
	if !p:IsPlayer() then return end

	SAVEE_TEMP_SVMAL_RELATEDSHIT = ClientsideModel(p:GetModel())
	AnimMdl = SAVEE_TEMP_SVMAL_RELATEDSHIT

	if AnimMdl:GetParent() != p then
		AnimMdl:SetTransmitWithParent(true)
		AnimMdl:DrawShadow(false)
		AnimMdl:SetParent(p)
		AnimMdl:AddEffects(EF_PARENT_ANIMATES)
		AnimMdl:SetPos(p:EyePos())
	end

	AnimMdl:DrawShadow(false)
	AnimMdl:SetMaterial("savee/transchand/invisiblemat/invisiblemat")
	AnimMdl.RenderOverride = function(self) 
		AnimMdl:SetRenderOrigin(p:EyePos()+p:GetAimVector())
		local EA=p:GetViewModel():GetAngles()
		AnimMdl:SetRenderAngles(Angle(EA.x-30,EA.y,0))
		--render.SetShadowsDisabled(true)
		AnimMdl:DrawModel()
	end

	if !IsValid(AnimMdl) then --保险(CLENT有最大上限,一过你就4辣)
		Error("[SVMAL] InValid Animation Model ! Maybe the clientside entity count reach the limit?") 
	end
	--print("?")
	debug.setmetatable(AnimMdl,NewCSEntMeta)
	--debug.setmetatable(any object, table metatable)
	return AnimMdl

end


function SVMAL.GetAnimModel()

	if !IsValid(AnimMdl) then
		AnimMdl = SVMAL.CreateAnimModel()
	end

	return AnimMdl

end

function SVMAL.ResetManipulateData()

	if !IsValid(AnimMdl) then
		AnimMdl = SVMAL.CreateAnimModel()
	end
	AnimMdl:SetupBones()
	for i=0,AnimMdl:GetBoneCount()-1 do
		AnimMdl:ManipulateBonePosition(i,Vector())
		AnimMdl:ManipulateBoneAngles(i,Angle())
		AnimMdl:ManipulateBoneScale(i,Vector(1,1,1))
		AnimMdl:ManipulateBoneJiggle(i,0)
	end

end

--[UNRECORDED]

function SVMAL.GetCurrentAnimData()
	--if !SVMAL.GetAnimPlaying() then return end
	return table.Copy(SVMAL._ValCurrentAnimData)
end

--[UNRECORDED]

function SVMAL.SetCurrentAnimData(Data)
	if !istable(Data) then Error("[SVMAL] Data is NOT a TABLE!") end
	local OldData = SVMAL.GetCurrentAnimData() --SVMAL._ValCurrentAnimData
	SVMAL._ValCurrentAnimData = Data
	return OldData
end

--[[
	>AnimationTable
	>>Anim String/Number,要执行的动作
	>>Model String,要换的模型
	>>OneHand Bool,左手执行动作
	>>Invert Bool,反转左右手(让左手干右手的活)
	>>PlaybackRate Num,播放速度(默认1)
	>>Offset_StartTime Num,开始时间偏移
	>>Offset_EndTime Num,结束时间偏移
	>>AllowOverride 是否允许被覆盖(String)
	>>OnFinish Function,在动画结束后做什么
	>>OnStart Function,在动画开始时做什么
	>>Queue Bool,是否排队执行(当它被设置时不管动画能否被覆写都将排队执行)
	>>KeepBoneData Bool,保留对骨骼的修改(换模型时无效..?)
	>>AutoDecideHands Bool,[Armmelee支持] 自动决定是否使用左手(OneHand设置时无效)

]]
local QueueTable = {}

function SVMAL.StartAnimation(animtbl)

	--基本设置(值)
	if !istable(animtbl) then return end


	-->矫正
	animtbl.PlaybackRate = animtbl.PlaybackRate or 1
	animtbl.Offset_StartTime = animtbl.Offset_StartTime or 0
	animtbl.Offset_EndTime = animtbl.Offset_EndTime or 0
	animtbl.AutoDecideHands = (animtbl.AutoDecideHands != nil and animtbl.AutoDecideHands or true)



	local Anim = animtbl.Anim
	local Mdl = animtbl.Model
	local OneHand = animtbl.OneHand
	local PBR = animtbl.PlaybackRate
	local Offset_StartTime = animtbl.Offset_StartTime
	local Offset_EndTime = animtbl.Offset_EndTime
	local AllowOverride = animtbl.AllowOverride
	local OnStart = animtbl.OnStart
	local OnFinish = animtbl.OnFinish
	local NeedQueue = animtbl.Queue
	local NoResetMod = animtbl.KeepBoneData
	local AutoDecideHands = animtbl.AutoDecideHands --Armmelee支持
	local OldAnimData = SVMAL.GetCurrentAnimData()

	--进阶检测(关键值是否存在)
	if !isnumber(Anim) and !isstring(Anim) then
		return
	end
	if !IsValid(AnimMdl) then
		AnimMdl = SVMAL.CreateAnimModel()
		--return
		--print("?")
	end

	--初始化
	animtbl.AnimStartTime = CurTime()
	if Mdl then AnimMdl:SetModel(Mdl) end
	AnimMdl:SetupBones()

	if !NoResetMod then
		SVMAL.ResetManipulateData()
	end

	if isstring(Anim) then
		Anim = AnimMdl:LookupSequence(Anim)
	end
	SVMAL.SetAnimPlaying(true)

	
	--正事
	if !NeedQueue and !OldAnimData.AllowOverride then

		SVMAL.SetCurrentAnimData(animtbl)
		AnimMdl:SetPlaybackRate(PBR)
		AnimMdl:ResetSequence(Anim)

		if isfunction(OnStart) then
			OnStart(OldAnimData)
		end

	end

end

hook.Add("PreDrawPlayerHands","savee_svmal_stuff",function(hand,vm,p) --干预恁的手

	--do return end
	--print(vm:GetModel())
	--AnimMdl:Remove()
	--local hand = p:GetHands()
	--AnimMdl:SetPredictable(true)
	if !SVMAL.GetAnimPlaying() then return end
	local w=p:GetActiveWeapon()
	if !IsValid(w) then
		return
	end
	local RHBI = vm:LookupBone("ValveBiped.Bip01_R_Hand")
	local RD = 0

	if RHBI then

		local matRH = vm:GetBoneMatrix( RHBI )
		if !matRH then return end
		RD = matRH:GetTranslation():DistToSqr(vm:LocalToWorld(Vector(3.190485,-21.364964,-30.849316)))

	end
	local AData = SVMAL.GetCurrentAnimData()
	local PBR=AData.PlaybackRate
	local Cycle = (CurTime()-AData.AnimStartTime+AData.Offset_StartTime)/AnimMdl:SequenceDuration()*PBR
	if Cycle >= 1.02 then
		SVMAL.SetAnimPlaying(false)
	end
	if !IsValid(AnimMdl) then
		AnimMdl = SVMAL.CreateAnimModel()
		return 
	end
	AnimMdl:SetCycle(Cycle)
	local curvm = vm
	--print(RD < ForceLH)
	--local PBR=Anim
	--AnimMdl:SetCycle((CurTime()-(p:GetNWFloat("savee_armmelee_lastmelee") or 0)+Anim[4])/AnimMdl:SequenceDuration()*PBR)
	--AnimMdl:SetCycle((CurTime()-(p:GetNWFloat("savee_armmelee_lastmelee") or 0)+Anim[4])/AnimMdl:SequenceDuration()*PBR)
	--AnimMdl:SetCycle(1)
	--AnimMdl:AddGesture(AnimMdl:GetSequenceActivity(AnimMdl:LookupSequence("gesture_signal_halt")))
				--print("EX?")
	--if p:GetNWBool("savee_armmelee_inmelee") then
	--	print(p:GetViewModel())
	--	--if !NoViewModel then
	--	--	p:GetViewModel():SetModel("models/weapons/cstrike/c_knife_t.mdl")
	--	--end
	--elseif NoViewModel then
	--	--
	--end
	--TFA Ins Shared Part,对,说你呢,你被解雇了
	--兼容这个,兼容那个
	--我杀你妈啊我日了
	--MWB现在在我的黑名单,因为它用renderoverride了
	--RIG很奇怪所以做不到(懒)
			--vm:ManipulateBoneAngles(0,Angle(500,1,5))
			--vm:ManipulateBonePosition(0,Vector(500,1,5))
	--for i=0,vm:GetBoneCount()-1 do

	--	if vm:GetBoneParent(i)==-1 then
	--		vm:ManipulateBoneAngles(i,Angle(500,1,5))
	--	end

	--end
	if hand:GetParent() != vm then
		hand:GetParent().savee_svmal_mybase = vm
		vm = hand:GetParent()
		--print("1")
	end
	if !isnumber(vm.savee_svmal_bonecallback) then
		local nb = vm:GetBoneCount()
		vm.savee_svmal_bonecallback = vm:AddCallback( "BuildBonePositions", function( vm, nb )
			
			--if curvm != vm then return end
			--print("CALLING")
			--print(vm)
			if !SVMAL.GetAnimPlaying() then return end
			local w=p:GetActiveWeapon()
			if !IsValid(w) then return end
			local am = AnimMdl
			if !IsValid(am) then
				AnimMdl = SVMAL.CreateAnimModel()
				return 
			end
			am:SetupBones()
			local amnb = am:GetBoneCount()
			--if hand:GetParent() != vm then
			--	hand:GetParent().savee_svmal_mybase = vm
			--	vm = hand:GetParent()
			--end
			--local RawBonePosAng = {}
			local amrhbi = am:LookupBone("ValveBiped.Bip01_R_UpperArm")
			local vmrhbi = vm:LookupBone("ValveBiped.Bip01_R_UpperArm") --or am:LookupBone("R_UpperArm")
			local amlhbi = am:LookupBone("ValveBiped.Bip01_L_UpperArm")
			local vmlhbi = vm:LookupBone("ValveBiped.Bip01_L_UpperArm") --or am:LookupBone("L_UpperArm")
			--print("Q1")
			--print("do return end")
			if (!amrhbi or !vmrhbi) and (!amlhbi or !vmlhbi) then return end
			local matamr = amrhbi and am:GetBoneMatrix( amrhbi ) or Matrix()
			local matvmr = vmrhbi and vm:GetBoneMatrix( vmrhbi ) or Matrix()
			--local matvmr2 = vmrhbi and vm:GetBoneMatrix( vmrhbi ) or Matrix()
			local mataml = amrhbi and am:GetBoneMatrix( amlhbi ) or Matrix()
			local matvml = vmlhbi and vm:GetBoneMatrix( vmlhbi ) or Matrix()
			if !matamr and !matvmr then return end


			local AData = SVMAL.GetCurrentAnimData()
			local PBR=AData.PlaybackRate
			--print("Q2")
			--print(WorldToLocal(matvmr:GetTranslation(),p:EyeAngles(),p:EyePos(),p:EyeAngles()))
			--local pos1 = matvmr:GetTranslation()
			--local pos2 = matvml:GetTranslation()
			--local pos3 = EyePos()
			local pos1 = LocalToWorld(Vector(5.04,-7.72,-12.25),Angle(),vm:GetPos(),p:EyeAngles())
			local pos2 = LocalToWorld(Vector(5.04,7.72,-12.25),Angle(),vm:GetPos(),p:EyeAngles())
			local deltaR = WorldToLocal(matamr:GetTranslation(),Angle(),pos1,Angle())
			local deltaL = WorldToLocal(mataml:GetTranslation(),Angle(),pos2,Angle())
			--delta.y = -1
			--local OLDVEC = {}
			--local NEWVEC = {}
			for i = 0, amnb - 1 do --矫正右手
				--print("EX?")
				local mat = am:GetBoneMatrix( i )
				if ( !mat ) then continue end
				--OLDVEC[i] = mat:GetTranslation()
				--NEWVEC[i] = mat:GetTranslation()-delta
				--delta:Rotate(Angle(0,0,0))
				if LeftArmBone[am:GetBoneName(i)] then
					mat:SetTranslation(mat:GetTranslation()-deltaL)
					--print(RightArmBone[am:GetBoneName(i)])
				else --if RD >= ForceLH then
					mat:SetTranslation(mat:GetTranslation()-deltaR)
					--mat:SetAngles(mat:GetAngles()+Angle(-15,15,0))
				end
				--mat:Rotate(Angle(0,90,0))
				am:SetBoneMatrix( i, mat )
			end
			--[[delta = WorldToLocal(NEWVEC[amlhbi],Angle(),matvml:GetTranslation(),Angle())
			local deltaa = (mataml:GetTranslation()-matvml:GetTranslation()):Angle()
			local amr_amlang = (mataml:GetTranslation()-matamr:GetTranslation()):Angle()
			local amr_vmlang = (matvml:GetTranslation()-matamr:GetTranslation()):Angle()
			--local deltaa = amr_amlang-amr_vmlang-am:GetManipulateBoneAngles(0)
			am:ManipulateBoneAngles(amrhbi,Angle(0,0,0))
			--print(matamr:GetAngles(),p:EyeAngles())
			local deltaa=matamr:GetAngles()-p:EyeAngles()
			--delta:Rotate(deltaa)
			--delta.z=0
			for i = 0, amnb - 1 do --重新矫正所有的手部骨骼
				local mat = am:GetBoneMatrix( i )
				if ( !mat ) then continue end
				--local WTL = WorldToLocal(mat:GetTranslation(),Angle(),matamr:GetTranslation(),Angle())
				----print(deltaa)
				--WTL:Rotate(Angle(0,0,0))
				--local LTWP,LTWA = LocalToWorld(WTL, Angle(), matamr:GetTranslation(),Angle())
				--mat:SetTranslation(LTWP)
				--mat:Rotate(deltaa)
				am:SetBoneMatrix( i, mat )
			end]]
			local RawBonePosAng = {}
			--local final = (p:GetNWFloat("savee_armmelee_lastmelee")+(am:SequenceDuration()-Anim[3]-Anim[4])/PBR)
			local final = (AData.AnimStartTime+(am:SequenceDuration()-AData.Offset_StartTime-AData.Offset_EndTime)/PBR)
			--if !IsValid(w) then return end
			--if !onehand[w:GetHoldType()] then
			--	am:ManipulateBoneAngles(am:LookupBone("ValveBiped.Bip01_L_Hand"),w:GetHoldType()=="smg" and Angle(0,0,0) or Angle(0,30,-45))
			--else
			--	am:ManipulateBoneAngles(am:LookupBone("ValveBiped.Bip01_L_Hand"),Angle(0,0,0))
			--end
			for i = 0, nb - 1 do
				local truevm = vm.savee_svmal_mybase or vm
				--print(vm.savee_svmal_mybase)
				local mat = vm:GetBoneMatrix( i )
				if ( !mat ) then continue end
				RawBonePosAng[i] = {
					pos = mat:GetTranslation(),
					ang = mat:GetAngles()
				}
				local name = vm:GetBoneName(i)
				--if IsValid(vm.savee_armmelee_mybase) then
				--	print(vm:GetBoneName(vm:GetBoneParent(vm:LookupBone(name))))
				--end
				local iAM = AnimMdl:LookupBone(name)
				--[[
					分2批次,先同步手骨,再同步武器骨骼
					这么做是为了避免骨骼优先级问题(如c_irifle,它将枪械骨骼放到了第一位,这意味着枪械骨骼将被优先读取)
				]]
				if iAM then
					local matAM = AnimMdl:GetBoneMatrix( iAM )
					--print(":1")
					--print(iAM)
					if !matAM --or 
						--(MDLForceLH[vm:GetModel()] and RightArmBone[AnimMdl:GetBoneName(AnimMdl:TranslatePhysBoneToBone(AnimMdl:TranslateBoneToPhysBone(iAM)))])
					then 
						continue
					end
					if CurTime() < final then
						mat:SetTranslation(LerpVector(math.min(1,(CurTime()-AData.AnimStartTime)*PBR*3),mat:GetTranslation(),matAM:GetTranslation()))
						mat:SetAngles(LerpAngle(math.min(1,(CurTime()-AData.AnimStartTime)*PBR*3),mat:GetAngles(),matAM:GetAngles()))
					else
						--print(CurTime()-final)
						mat:SetTranslation(LerpVector(math.Clamp((CurTime()-final)*3,0,1),matAM:GetTranslation(),mat:GetTranslation()))
						mat:SetAngles(LerpAngle(math.Clamp((CurTime()-final)*3,0,1),matAM:GetAngles(),mat:GetAngles()))
					end
					--mat:Invert()
					--mat:SetAngles(mat:GetAngles())
					--mat:SetTranslation(mat:GetTranslation())
					--print(math.min(1,(CurTime()-final)*3))
				end
				--local ang = mat:GetAngles()
				----print(ang)
				----ang.z = -ang.z
				----ang.x = -ang.
				--mat:SetAngles(ang)
				----mat:SetScale(-mat:GetScale())
				--if i==3 and Cinema then print(mat:GetAngles()) end
				--mat:SetTranslation(mat:GetTranslation())
				--mat:SetTranslation(Vector(0,0,0))
				vm:SetBoneMatrix( i, mat )
			end
			if IsValid(vm.savee_svmal_mybase) then
				--vm:SetupBones()
				nb = vm.savee_svmal_mybase:GetBoneCount()
				--print(nb)
			end
			local truevm = vm.savee_svmal_mybase or vm
			for i = 0, tonumber(nb) - 1 do
				--print("EX?")
				--local truevm = vm.savee_armmelee_mybase or vm
				local mat = truevm:GetBoneMatrix( i )
				--print(i,nb)
				if ( !mat ) then continue end
				--print(truevm:GetModel())
				--mat:SetTranslation(Vector(88,0,0))
				--if i==0 then
					--print(vm:GetBoneName(i))
				--mat:SetTranslation(Vector(88,0,80))
					--vm:ManipulateBonePosition(0,Vector(0,0,0))
				--end
				--local scale = mat:GetScale()
				local name = truevm:GetBoneName(i)
					--print(name,i,truevm:GetBoneCount())
				local iAM = AnimMdl:LookupBone(name)
					--print("CALL")
				--if !iAM then 
				--	iAM = AnimMdl:LookupBone("ValveBiped.Bip01_"..name)
				--end
				if !iAM then --找不到,强制同步到手骨
					--print("1")
					local RHBI = vm:LookupBone("ValveBiped.Bip01_R_Hand")
					local LHBI = vm:LookupBone("ValveBiped.Bip01_L_Hand")
					--print(RHBI)
					--local LD = 0
					local RD = 0

					if RHBI and RawBonePosAng[RHBI] then
						--local matRH = vm:GetBoneMatrix( RHBI )
						--if !matRH then return end
						RD = RawBonePosAng[RHBI].pos:DistToSqr(vm:LocalToWorld(Vector(3.190485,-21.364964,-30.849316)))
						--print(vm:WorldToLocal(matRH:GetTranslation()))
					end
					--print(RHBI)
					--print(vm:GetModel())
					--print(RD)
					if RawBonePosAng[RHBI] and RD >= ForceLH then
						--print(RD)
						local deltapos,deltaang = WorldToLocal(mat:GetTranslation(),mat:GetAngles(),RawBonePosAng[RHBI].pos,RawBonePosAng[RHBI].ang)
						--local deltaang = mat:GetAngles() - RawBonePosAng[RHBI].ang
						local matRH = vm:GetBoneMatrix( RHBI )
						if !matRH then return end
						--print(vm:GetBoneName(i),deltapos,deltaang)
						local ltwpos,ltwang = LocalToWorld(deltapos,deltaang,matRH:GetTranslation(),matRH:GetAngles())
						mat:SetTranslation(ltwpos)
						mat:SetAngles(ltwang)
						--truevm:ManipulateBoneAngles(i,ltwang)
						--truevm:ManipulateBonePosition(i,ltwpos)
						--print(ltwpos,mat:GetTranslation())
						--if name == "b_root" then
						--	print("1")
						--end
					--print("wow")
					elseif RawBonePosAng[LHBI] then

						local deltapos,deltaang = WorldToLocal(mat:GetTranslation(),mat:GetAngles(),RawBonePosAng[LHBI].pos,RawBonePosAng[LHBI].ang)
						--local deltaang = mat:GetAngles() - RawBonePosAng[RHBI].ang
						local matRH = vm:GetBoneMatrix( LHBI )
						if !matRH then return end
						--print(vm:GetBoneName(i),deltapos,deltaang)
						local ltwpos,ltwang = LocalToWorld(deltapos,deltaang,matRH:GetTranslation(),matRH:GetAngles())
						mat:SetTranslation(ltwpos)
						mat:SetAngles(ltwang)
						--print("LHIK")
					end
				end
				--mat:SetTranslation(Vector(0,0,0))
				truevm:SetBoneMatrix( i, mat )
			end
			--truevm:SetRenderOrigin(Vector(0,0,0))
			--truevm:SetRenderAngles(Angle(0,0,0))
			--truevm:DrawModel()
		end )
	elseif !RECHECKED then
		vm:RemoveCallback("BuildBonePositions",vm.savee_svmal_bonecallback)
		vm.savee_svmal_bonecallback = nil
		RECHECKED = true
	end
	--vm:AddEffects(EF_PARENT_ANIMATES)
	--vm:AddEffects(EF_BONEMERGE)
	--vm:SetParent(AnimMdl)
end)
concommand.Add("svmal_debug_playanim",function(p,_,a)
	SVMAL.StartAnimation({
		Anim = a[1] or "jump_AR",
		Offset_StartTime = a[2] or 0,
		Offset_EndTime = a[3] or 0,
		Model = a[4],
	})
end)
concommand.Add("svmal_debug_playanimL",function(p,_,a)
	SVMAL.StartAnimation({
		Anim = a[1] or "jump_AR",
		Offset_StartTime = a[2] or 0,
		Offset_EndTime = a[3] or 0,
	})
end)


