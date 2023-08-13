--[[
	制作这玩意的初衷仅仅是因为我懒得上传两个Addon的更新版本
	注意: 如果你要查文档,请移步doc.lua或doccn.lua,里面对func有较为细致的说明
	如果你执意要看这个文件,请准备好你的机翻
	(这东西通篇抄袭Armmelee,因为我懒得传了)
	哦对了这个文件有制表符(TAB,或者四个空格)
	所以当你看不到制表符的时候请换用VSC(Visual Studio Code)
	(如果还不行那我没办法了)
]]
--[[
	WARNING: Prepare ur machine translate cuz this file is not 4 u (maybe)
	but if u want to check how daz this shitt stuffffffff work,feel free to view it
	(but not to edit it and put it to workshop,report bugs to me instead :) )
	(You can edit it for ur server or urself,but don't forget that this shit is made by me)
	(Don't say some idiotic things like "Oh shit why there Chinese commit no no no I don't want it fuuuuuuuuuuu",remeber this file is NOT for YOU)

	警告: 准备好你的机械翻译(如果有英文.jpg),这个文件其实不是给你看的(大概)
	但是如果你执意想看也不是不行.jpg
	但是别编辑它然后发到创意工坊,如果有Bug请报给我 :)
	(服务器改造: 可以,但是别忘了这是我做的)
	(别说一些像"哦泻为毛有中文注释"的傻逼话,因为这个文件 不 是 给 你 的 (划重点))

]]
--do return end

local LerpVector = LerpVector
local LerpAngle = LerpAngle
--local function LerpVector(cyc,from,to)
--	return from
--end
--local function LerpAngle(cyc,from,to)
--	return from
--end

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

local InvertTable = { --过时辣
	["ValveBiped.Bip01_R_UpperArm"] = "ValveBiped.Bip01_L_UpperArm",
	["ValveBiped.Bip01_R_Forearm"] = "ValveBiped.Bip01_L_Forearm",
	["ValveBiped.Bip01_R_Hand"] = "ValveBiped.Bip01_L_Hand",
	["ValveBiped.Bip01_R_Ulna"] = "ValveBiped.Bip01_L_Ulna",
	["ValveBiped.Bip01_R_Wrist"] = "ValveBiped.Bip01_L_Wrist",
	["ValveBiped.Bip01_R_Elbow"] = "ValveBiped.Bip01_L_Elbow",
	["ValveBiped.Bip01_R_Bicep"] = "ValveBiped.Bip01_L_Bicep",
	["ValveBiped.Bip01_R_Shoulder"] = "ValveBiped.Bip01_L_Shoulder",
	["ValveBiped.Bip01_R_Trapezius"] = "ValveBiped.Bip01_L_Trapezius",
	["ValveBiped.Bip01_R_Finger0"] = "ValveBiped.Bip01_L_Finger0",
	["ValveBiped.Bip01_R_Finger01"] = "ValveBiped.Bip01_L_Finger01",
	["ValveBiped.Bip01_R_Finger02"] = "ValveBiped.Bip01_L_Finger02",
	["ValveBiped.Bip01_R_Finger1"] = "ValveBiped.Bip01_L_Finger1",
	["ValveBiped.Bip01_R_Finger11"] = "ValveBiped.Bip01_L_Finger11",
	["ValveBiped.Bip01_R_Finger12"] = "ValveBiped.Bip01_L_Finger12",
	["ValveBiped.Bip01_R_Finger2"] = "ValveBiped.Bip01_L_Finger2",
	["ValveBiped.Bip01_R_Finger21"] = "ValveBiped.Bip01_L_Finger21",
	["ValveBiped.Bip01_R_Finger22"] = "ValveBiped.Bip01_L_Finger22",
	["ValveBiped.Bip01_R_Finger3"] = "ValveBiped.Bip01_L_Finger3",
	["ValveBiped.Bip01_R_Finger31"] = "ValveBiped.Bip01_L_Finger31",
	["ValveBiped.Bip01_R_Finger32"] = "ValveBiped.Bip01_L_Finger32",
	["ValveBiped.Bip01_R_Finger4"] = "ValveBiped.Bip01_L_Finger4",
	["ValveBiped.Bip01_R_Finger41"] = "ValveBiped.Bip01_L_Finger41",
	["ValveBiped.Bip01_R_Finger42"] = "ValveBiped.Bip01_L_Finger42",
	["ValveBiped.Bip01_R_UpperArm"] = "ValveBiped.Bip01_L_UpperArm",
	["ValveBiped.Bip01_R_Forearm"] = "ValveBiped.Bip01_L_Forearm",

	["ValveBiped.Bip01_L_Hand"] = "ValveBiped.Bip01_R_Hand",
	["ValveBiped.Bip01_L_Ulna"] = "ValveBiped.Bip01_R_Ulna",
	["ValveBiped.Bip01_L_Wrist"] = "ValveBiped.Bip01_R_Wrist",
	["ValveBiped.Bip01_L_Elbow"] = "ValveBiped.Bip01_R_Elbow",
	["ValveBiped.Bip01_L_Bicep"] = "ValveBiped.Bip01_R_Bicep",
	["ValveBiped.Bip01_L_Shoulder"] = "ValveBiped.Bip01_R_Shoulder",
	["ValveBiped.Bip01_L_Trapezius"] = "ValveBiped.Bip01_R_Trapezius",
	["ValveBiped.Bip01_L_Finger0"] = "ValveBiped.Bip01_R_Finger0",
	["ValveBiped.Bip01_L_Finger01"] = "ValveBiped.Bip01_R_Finger01",
	["ValveBiped.Bip01_L_Finger02"] = "ValveBiped.Bip01_R_Finger02",
	["ValveBiped.Bip01_L_Finger1"] = "ValveBiped.Bip01_R_Finger1",
	["ValveBiped.Bip01_L_Finger11"] = "ValveBiped.Bip01_R_Finger11",
	["ValveBiped.Bip01_L_Finger12"] = "ValveBiped.Bip01_R_Finger12",
	["ValveBiped.Bip01_L_Finger2"] = "ValveBiped.Bip01_R_Finger2",
	["ValveBiped.Bip01_L_Finger21"] = "ValveBiped.Bip01_R_Finger21",
	["ValveBiped.Bip01_L_Finger22"] = "ValveBiped.Bip01_R_Finger22",
	["ValveBiped.Bip01_L_Finger3"] = "ValveBiped.Bip01_R_Finger3",
	["ValveBiped.Bip01_L_Finger31"] = "ValveBiped.Bip01_R_Finger31",
	["ValveBiped.Bip01_L_Finger32"] = "ValveBiped.Bip01_R_Finger32",
	["ValveBiped.Bip01_L_Finger4"] = "ValveBiped.Bip01_R_Finger4",
	["ValveBiped.Bip01_L_Finger41"] = "ValveBiped.Bip01_R_Finger41",
	["ValveBiped.Bip01_L_Finger42"] = "ValveBiped.Bip01_R_Finger42",
}

local AutoDecideHoldTypes = {
	["duel"] = true,
	["melee"] = true,
	["melee2"] = true,
	["knife"] = true,
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
	if IsValid(AnimMdl) then Error("[SVMAL] There's already a AnimModel!") return end

	local p = IsValid(LocalPlayer():GetObserverTarget()) and LocalPlayer():GetObserverTarget() or LocalPlayer()
	--print("?2")
	if !p:IsPlayer() then return end

	SAVEE_TEMP_SVMAL_RELATEDSHIT = ClientsideModel(p:GetModel())
	AnimMdl = SAVEE_TEMP_SVMAL_RELATEDSHIT

	if AnimMdl:GetParent() != p:GetViewModel() then
		AnimMdl:SetTransmitWithParent(true)
		AnimMdl:DrawShadow(false)
		AnimMdl:SetParent(p:GetViewModel())
		AnimMdl:AddEffects(EF_PARENT_ANIMATES)
		AnimMdl:SetPos(p:EyePos())
		AnimMdl:SetAngles(p:EyeAngles())
	end

	AnimMdl:SetNoDraw(true)
	AnimMdl:DrawShadow(false)
	AnimMdl:SetMaterial("savee/transchand/invisiblemat/invisiblemat")
	--AnimMdl:AddEffects(E)
	AnimMdl.RenderOverride = function(self,fl) 
		render.SetShadowsDisabled(true)
		self:DrawShadow(false)
		self:SetRenderOrigin(p:EyePos()+p:GetAimVector()*5)
		self:MarkShadowAsDirty()
		self:DrawModel(fl)
	end

	if !IsValid(AnimMdl) then --保险(CLENT有最大上限,一过你就4辣)
		Error("[SVMAL] InValid Animation Model ! Maybe the clientside entity count reach the limit?") 
		return
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

function SVMAL.GetCurrentAnimData()
	--if !SVMAL.GetAnimPlaying() then return end
	return table.Copy(SVMAL._ValCurrentAnimData)
end

function SVMAL.SetCurrentAnimData(Data)
	if !istable(Data) then Error("[SVMAL] Data is NOT a TABLE!") end
	local OldData = SVMAL.GetCurrentAnimData() --SVMAL._ValCurrentAnimData
	SVMAL._ValCurrentAnimData = Data
	return OldData
end

--[[
	>AnimationTable
	>>Anim String/Number,要执行的动作 --好了
	>>Model String,要换的模型 --好了
	>>OneHand Bool,左手执行动作 --好了
	-->>Invert Bool,反转左右手(让左手干右手的活) --没好 --OBS?
	>>PlaybackRate Num,播放速度(默认1) --好了
	>>Offset_StartTime Num,开始时间偏移 --好了
	>>Offset_EndTime Num,结束时间偏移 --好了
	>>AllowOverride 是否允许被覆盖(String) 没做
	>>OnFinish Function,在动画结束后做什么 --好了
	>>OnStart Function,在动画开始时做什么 没做
	>>Queue Bool,是否排队执行(当它被设置时不管动画能否被覆写都将排队执行) 没做
	>>KeepBoneData Bool,保留对骨骼的修改(换模型时无效..?) 好了
	-->>AffectView Bool,是否干预玩家视野
	>>AutoDecideHands Bool,[Armmelee支持] 自动决定是否使用左手(OneHand设置时无效) (默认开)?
	>>RotateAng Angle,旋转角度
	>>NoPitch bool,上下看时视觉模型不会跟着转

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
	--animtbl.RotateAng = animtbl.RotateAng and animtbl.RotateAng-Angle(30,0,0) or Angle(-30,0,0)



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
	local RotateAng = animtbl.RotateAng
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

--[[
	>WMAnimationTable
	>>Anim String/Number,要执行的动作 --好了
	>>Model String,要换的模型 --好了
	>>OneHand Bool,左手执行动作 --好了
	>>PlaybackRate Num,播放速度(默认1) --好了
	>>Offset_StartTime Num,开始时间偏移 --好了
	>>Offset_EndTime Num,结束时间偏移 --好了
	>>AllowOverride 是否允许被覆盖(String) 没做
	>>KeepBoneData Bool,保留对骨骼的修改(换模型时无效..?)(默认开) 好了
	>>RotateAng Angle,旋转角度
	>>NoPitch bool,上下看时视觉模型不会跟着转
	>>Spine bool,动画包括腰部(和头部) --没做
	>>Fullbody bool,全身动画 --没做
	-->>Invert Bool,反转左右手(让左手干右手的活) --没好 --OBS?
	-->>AffectView Bool,是否干预玩家视野
	-->>Queue Bool,是否排队执行(当它被设置时不管动画能否被覆写都将排队执行) 没做
	-->>OnFinish Function,在动画结束后做什么 --好了
	-->>OnStart Function,在动画开始时做什么 没做

]]

--未记录

function SVMAL.StartWMAnimation(p,animtbl)

	--基本设置(值)
	if !IsValid(p) or !istable(animtbl) then return end
	--print("?")
	local AnimMdl = p.SWMAL_AnimModel

	if !IsValid(AnimMdl) then
		p.SWMAL_AnimModel = ClientsideModel(p:GetModel())
		p.SWMAL_AnimModel:DrawShadow(false)
		p.SWMAL_AnimModel:SetMaterial("savee/transchand/invisiblemat/invisiblemat")
		p.SWMAL_AnimModel:SetNoDraw(true)
		AnimMdl = p.SWMAL_AnimModel
	end

	-->矫正
	animtbl.PlaybackRate = animtbl.PlaybackRate or 1
	animtbl.Offset_StartTime = animtbl.Offset_StartTime or 0
	animtbl.Offset_EndTime = animtbl.Offset_EndTime or 0
	animtbl.KeepBoneData = (animtbl.KeepBoneData != nil and animtbl.KeepBoneData or true)
	--animtbl.RotateAng = animtbl.RotateAng and animtbl.RotateAng-Angle(30,0,0) or Angle(-30,0,0)



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
	local RotateAng = animtbl.RotateAng
	local OldAnimData = SVMAL.GetCurrentAnimData()

	--进阶检测(关键值是否存在)
	if !isnumber(Anim) and !isstring(Anim) then
		return
	end

	--初始化
	animtbl.AnimStartTime = CurTime()
	if Mdl then AnimMdl:SetModel(Mdl) end
	AnimMdl:SetupBones()

	--[[if !NoResetMod then
		SVMAL.ResetManipulateData()
	end]]

	if isstring(Anim) then
		Anim = AnimMdl:LookupSequence(Anim)
	end
	--SVMAL.SetAnimPlaying(true)

	
	--正事
	if !NeedQueue and !OldAnimData.AllowOverride then

		--SVMAL.SetCurrentAnimData(animtbl)
		p.SWMAL_AnimData = animtbl
		AnimMdl:SetPlaybackRate(PBR)
		AnimMdl:ResetSequence(Anim)

		--[[if isfunction(OnStart) then
			OnStart(OldAnimData)
		end]]

	end

end

hook.Add("Think","savee_svmal_stuff",function()
	if !IsValid(AnimMdl) then return end
	local AData = SVMAL.GetCurrentAnimData()
		--print(#AData)
	--PrintTable(AData)
	if !AData.AnimStartTime then return end
	local PBR=AData.PlaybackRate
	local Cycle = (CurTime()-AData.AnimStartTime+AData.Offset_StartTime)/AnimMdl:SequenceDuration()*PBR
	if Cycle >= 1.02 then
		SVMAL.SetAnimPlaying(false)
		if !AData._ValFinishCalled and AData.OnFinish then 
			AData.OnFinish(AData) 
			AData._ValFinishCalled = true
		end
	end
end)

--[[
	测试功能区域
]]

local function TestFunction(p,fl)


	local nb = p:GetBoneCount()
	local TargetBone = p:LookupBone("ValveBiped.Bip01_Spine")
	local ChildBone = {
		[TargetBone] = true
	}
	local mat = p:GetBoneMatrix(TargetBone)
	if !mat then return end
	local AngDelta = Angle(10,0)
	
	for i=0,nb-1 do

		if !ChildBone[p:GetBoneParent(i)] then continue end
		ChildBone[i] = true
		local bmat = p:GetBoneMatrix(i)
		local Delta,DAng = WorldToLocal(bmat:GetTranslation(),bmat:GetAngles(),mat:GetTranslation(),mat:GetAngles())
		local LPos,LAng = LocalToWorld(Delta,DAng,mat:GetTranslation(),mat:GetAngles()-Angle(0,200,0))
		--Delta:Rotate(AngDelta)
		bmat:SetTranslation(LPos)
		bmat:SetAngles(LAng)
		p:SetBoneMatrix(i, bmat)

	end


end

--[[
	设置模型->比对模型骨骼间距离(反正就左右手)->自动在动画上应用->泰裤辣

	比对每个骨骼的距离(继承自他们父骨骼)
	父骨骼到我的距离 -->?
	比对父骨骼到子骨骼的距离?
	父骨骼WTL子骨骼,然后应用新系统再LTW回去?

	Tails我的Tails嘿嘿嘿...(smjb)
	(给小模型做兼容,毕竟我不想看到Miku被强制变为面筋Miku)
	WorldToLocal(pos1,pos2)
	pos2到pos1需要移动的距离
]]

hook.Add("PrePlayerDraw","savee_svmal_tpvanim",function(p,fl)
	--do return end
	--local p=Entity(1)
	--TestFunction(p,fl)


	if !istable(p.SWMAL_AnimData) then return end


	
	p:SetupBones()
	--p:SetLOD(0)
	--if !p.SWMAL_AnimData then return end
	--TPV动画模型
	--do return end
	if !IsValid(p.SWMAL_AnimModel) then
		p.SWMAL_AnimModel = ClientsideModel(p:GetModel())
		p.SWMAL_AnimModel:DrawShadow(false)
		p.SWMAL_AnimModel:SetMaterial("savee/transchand/invisiblemat/invisiblemat")
		p.SWMAL_AnimModel:SetNoDraw(true)
	end
	--我自己->比对
	if !IsValid(SWMAL_AnimModelCompare) then --为不便深表抱歉,因为必须做小模型的兼容
		SWMAL_AnimModelCompare = ClientsideModel(p:GetModel())
		SWMAL_AnimModelCompare:DrawShadow(false)
		p.SWMAL_AnimModel:SetMaterial("savee/transchand/invisiblemat/invisiblemat")
		SWMAL_AnimModelCompare:SetNoDraw(true)
	end
	--[[for i=0,p:GetBoneCount()-1 do
		local mat=p:GetBoneMatrix(i)
		if !mat then continue end
		mat:SetScale(mat:GetScale()*0.5)
		p:SetBoneMatrix(i,mat)
	end]]

	--基本值
	local MyBonePosition = {}
	--local AMBonePosition = {}
	local BoneDelta = {}


	--设置模型
	--初始化模型,设置模型动作为默认动作(比对用)
	local am = p.SWMAL_AnimModel
	local amc = SWMAL_AnimModelCompare
	--am:SetSequence(0)
	local AData = p.SWMAL_AnimData
	local PBR=AData.PlaybackRate
	local Cycle = (CurTime()-AData.AnimStartTime+AData.Offset_StartTime)/am:SequenceDuration()*PBR
	
	if Cycle > 1.02 then
		p.SWMAL_AnimData = nil
	end
	amc:SetAngles(p:EyeAngles())
	amc:SetModel(p:GetModel())
	amc:SetSequence(0) --通常为APose
	amc:SetupBones()
	--[[
		比对每个骨骼的距离(继承自他们父骨骼)
		父骨骼到我的距离 -->?
		比对父骨骼到子骨骼的距离?
		父骨骼WTL子骨骼,然后应用新系统再LTW回去 ->
		WorldToLocal(pos1,pos2)
		pos2到pos1需要移动的距离
		(后记: 你不应该设置Angles的)
	]]
	--记录原模型(玩家当前使用的模型)的骨骼数据
	for i=0,amc:GetBoneCount()-1 do
		local mtx = amc:GetBoneMatrix(i)
		local pbi = amc:GetBoneParent(i)
		local mtxp = amc:GetBoneMatrix(pbi)
		if !mtx or !mtxp then continue end
		--print(AM:GetBoneName(i))
		--[[
			目标是测出父骨骼到子骨骼的位置要动弹多少地方
			而不是子骨骼->父骨骼
			因为Boneindex肯定是先定义再Parent,万年不变的老把戏
		]]
		local WTLP,WTLA = WorldToLocal(mtx:GetTranslation(),mtx:GetAngles(),mtxp:GetTranslation(),mtxp:GetAngles())
		local name = amc:GetBoneName(i)
		MyBonePosition[name] = {
			--ParentPos = mtxp:GetTranslation(),
			--ParentAng = mtxp:GetAngles(),
			Pos = WTLP,
			Ang = WTLA,
			--index = pbi,
		}
	end
	--PrintTable(MyBonePosition)
	--print("1")
	--[[for i=0,amnb-1 do

		local name = amc2:GetBoneName(i)
		if !MyBonePosition[name] then continue end

		local mtx = amc2:GetBoneMatrix(i)
		if !mtx then continue end
		local pos,ang = mtx:GetTranslation(),mtx:GetAngles()
		local wtlpos,wtlang = WorldToLocal(MyBonePosition[name].Pos,MyBonePosition[name].Ang,pos,ang)
		--local wtlpos,_ = WorldToLocal(MyBonePosition[name].Pos,Angle(),pos,Angle())
		--local _,wtlang = WorldToLocal(Vector(),MyBonePosition[name].Ang,Vector(),ang)
		BoneDelta[i] = {
			Pos = wtlpos,
			Ang = wtlang,
		}
		--print(pos,ang,LocalToWorld(wtlpos,wtlang,pos,ang))
		--mtx:SetTranslation(MyBonePosition[name].Pos)
		--mtx:SetAngles(MyBonePosition[name].Ang)
		--am:SetBoneMatrix(i,mtx)

	end]]

	--初始化动画播放数据

	local LerpVal = math.min(1,(CurTime()-AData.AnimStartTime)*PBR*3)
	local final = (AData.AnimStartTime+(am:SequenceDuration()-AData.Offset_StartTime-AData.Offset_EndTime)/PBR)
	if CurTime() >= final then
		LerpVal = 1-math.min((CurTime()-final)*3,1)
	end
	--local Invert = AData.Invert
	local finalang = p:EyeAngles()+Angle(-30,0,0)
	if AData.NoPitch then
		finalang.p = -30
	end
	if AData.RotateAng then
		--print("CINEMAR")
		finalang = finalang+AData.RotateAng
	end
	am:SetAngles(finalang)


	--初始化动画模型+动画执行
	--print("Q2")
	--print(WorldToLocal(matvmr:GetTranslation(),p:EyeAngles(),p:EyePos(),p:EyeAngles()))
	am:SetModel(AData.Model)
	am:SetupBones()
	--am:SetPlaybackRate(PBR)
	am:SetCycle(Cycle)
	am:ResetSequence(AData.Anim)
	--am:SetSequence(0)

	--预处理
	--[[for i = 0, amnb - 1 do
		if !BoneDelta[i] then continue end
		local mtx = am:GetBoneMatrix(i)
		if !mtx then continue end
		--local OldLPos,OldLAng = WorldToLocal(RawBonePosAng[i].pos,RawBonePosAng[i].ang,RawBonePosAng[pbi].pos,RawBonePosAng[pbi].ang)
		local pos,ang = mtx:GetTranslation(),mtx:GetAngles()
		local LPos,LAng = LocalToWorld(BoneDelta[i].Pos,BoneDelta[i].Ang,pos,ang)
		--local LPos,_ = LocalToWorld(BoneDelta[i].Pos,Angle(),pos,Angle())
		--local _,LAng = LocalToWorld(Vector(),BoneDelta[i].Ang,Vector(),ang)
		--mtx:SetTranslation(pos+BoneDelta[i].Pos)
		mtx:SetTranslation(LPos)
		mtx:SetAngles(LAng)
		--mtx:SetAngles(LAng)
		am:SetBoneMatrix(i,mtx)
	end]]
	local amnb = am:GetBoneCount()
	--开始应用原骨骼数据(小模型兼容)
	for i = 0, amnb - 1 do
		
		local name = am:GetBoneName(i)

		if !MyBonePosition[name] then continue end

		local mtx = am:GetBoneMatrix(i)
		local mtxp = am:GetBoneMatrix(am:GetBoneParent(i))

		if !mtx or !mtxp then continue end

		local pos,ang = mtxp:GetTranslation(),mtxp:GetAngles()
		local LPos = LocalToWorld(MyBonePosition[name].Pos,MyBonePosition[name].Ang,pos,ang)
		--mtx:SetTranslation(pos)
		--mtx:SetAngles(ang)
		mtx:SetTranslation(LPos)
		--mtx:SetAngles(LAng)
		--print("??")
		am:SetBoneMatrix(i,mtx)

	end

	--原SVMAL

	local amrhbi = am:LookupBone("ValveBiped.Bip01_R_UpperArm")
	local vmrhbi = p:LookupBone("ValveBiped.Bip01_R_UpperArm") --or am:LookupBone("R_UpperArm")
	local amlhbi = am:LookupBone("ValveBiped.Bip01_L_UpperArm")
	local vmlhbi = p:LookupBone("ValveBiped.Bip01_L_UpperArm") --or am:LookupBone("L_UpperArm")
	--am:ManipulateBoneAngles(amrhbi,Angle(0))
	--am:ManipulateBoneAngles(am:LookupBone("ValveBiped.Bip01_R_ForeArm"),Angle(0,0,0))

	if (!amrhbi or !vmrhbi) and (!amlhbi or !vmlhbi) then return end
	local matamr = amrhbi and am:GetBoneMatrix( amrhbi ) or Matrix()
	local matvmr = vmrhbi and p:GetBoneMatrix( vmrhbi ) or Matrix()
	--local matvmr2 = vmrhbi and vm:GetBoneMatrix( vmrhbi ) or Matrix()
	local mataml = amrhbi and am:GetBoneMatrix( amlhbi ) or Matrix()
	local matvml = vmlhbi and p:GetBoneMatrix( vmlhbi ) or Matrix()

	if !matamr and !matvmr then return end

	local pos1 = matvmr:GetTranslation()
	local pos2 = matvml:GetTranslation()





	--am:SetRenderAngles(p:EyeAngles())
	--am:SetMaterial("")
	am:SetMaterial("savee/transchand/invisiblemat/invisiblemat")
	am:SetRenderOrigin(p:GetPos())
	local ang = p:EyeAngles()
	local ClampVal = AData.Spine and 45 or 70
	ang.p = math.Clamp(ang.p, -ClampVal, ClampVal)
	if AData.NoPitch then
		ang.p = 0
	end
	if AData.RotateAng then
		ang = ang + AData.RotateAng
	end
	am:SetRenderAngles(ang)
	am:DrawModel()

	--deltaL:Rotate(Angle(0,0,0))
	if AData.Spine then --矫正腰
		--[[local nb = p:GetBoneCount() --设置部分
		local TargetBone = p:LookupBone("ValveBiped.Bip01_Spine")
		local ChildBone = {
			[TargetBone] = true
		}
		local mat = p:GetBoneMatrix(TargetBone)
		if !mat then return end
		local AngDelta = Angle(10,0)

		for i=0,nb-1 do 

			if !ChildBone[p:GetBoneParent(i)] then continue end
			ChildBone[i] = true
			local bmat = p:GetBoneMatrix(i)
			local Delta,DAng = WorldToLocal(bmat:GetTranslation(),bmat:GetAngles(),mat:GetTranslation(),mat:GetAngles())
			local LPos,LAng = LocalToWorld(Delta,DAng,mat:GetTranslation(),mat:GetAngles()-Angle(0,200,0))
			--Delta:Rotate(AngDelta)
			bmat:SetTranslation(LPos)
			bmat:SetAngles(LAng)
			p:SetBoneMatrix(i, bmat)

		end]]
		--WSSB
		local TargetBone = p:LookupBone("ValveBiped.Bip01_Spine")
		local TargetBoneAM = am:LookupBone("ValveBiped.Bip01_Spine")
		local mat = p:GetBoneMatrix(TargetBone)
		local matAM = am:GetBoneMatrix(TargetBoneAM)
		if !mat or !matAM then return end
		local ChildBone = {
			[TargetBoneAM] = true
		}
		local delta = WorldToLocal(matAM:GetTranslation(),Angle(),mat:GetTranslation(),Angle())
		for i = 0, amnb - 1 do
			--print("EX?")
			if !ChildBone[am:GetBoneParent(i)] then continue end
			ChildBone[i] = true
			local mat = am:GetBoneMatrix( i )
			if ( !mat ) then continue end
			mat:SetTranslation(mat:GetTranslation()-delta)
			am:SetBoneMatrix( i, mat )
		end

	else --矫正手
		local deltaR = WorldToLocal(matamr:GetTranslation(),Angle(),pos1,Angle())
		local deltaL = WorldToLocal(mataml:GetTranslation(),Angle(),pos2,Angle())
		for i = 0, amnb - 1 do
			--print("EX?")
			local mat = am:GetBoneMatrix( i )
			if ( !mat ) then continue end
			if LeftArmBone[am:GetBoneName(i)] then
				mat:SetTranslation(mat:GetTranslation()-deltaL)
			elseif !AData.OneHand then
				mat:SetTranslation(mat:GetTranslation()-deltaR)
			end
			am:SetBoneMatrix( i, mat )
		end
	end
	--local Parent = {}
	local RawBonePosAng = {}
	if AData.Spine then
		
		local nb = p:GetBoneCount() --设置部分

		local TargetBone = p:LookupBone("ValveBiped.Bip01_Spine")
		local ChildBone = {
			[TargetBone] = true
		}
		
		local Spinemat = p:GetBoneMatrix(TargetBone)
		--local SpinematAM = am:GetBoneMatrix(am:LookupBone("ValveBiped.Bip01_Spine"))
		--if !Spinemat or !SpinematAM then return end
		if !Spinemat then return end
		for i=0,nb-1 do
			local name = p:GetBoneName(i)
			--print(AName,name)
			local mtx = p:GetBoneMatrix(i)
			if ( !mtx ) then continue end
			RawBonePosAng[i] = {
				pos = mtx:GetTranslation(),
				ang = mtx:GetAngles()
			}
			if !ChildBone[p:GetBoneParent(i)] then continue end
			ChildBone[i] = true
			local iAM = am:LookupBone(name)
			local AName = iAM and am:GetBoneName(iAM)
			if iAM and AName != "__INVALIDBONE__" and (AData.Spine or !AData.OneHand or !RightArmBone[name]) then
				local Imtx = am:GetBoneMatrix(iAM)
				if !mtx or !Imtx then continue end
				mtx:SetTranslation(LerpVector(LerpVal,mtx:GetTranslation(),Imtx:GetTranslation()))
				mtx:SetAngles(LerpAngle(LerpVal,mtx:GetAngles(),Imtx:GetAngles()))
				local Delta,DAng = WorldToLocal(mtx:GetTranslation(),mtx:GetAngles(),Spinemat:GetTranslation(),Spinemat:GetAngles())
				--local LPos,LAng = LocalToWorld(Delta,DAng,Spinemat:GetTranslation(),(RawBonePosAng[TargetBone].ang-SpinematAM:GetAngles())/2)
				local LPos,LAng = LocalToWorld(Delta,DAng,Spinemat:GetTranslation(),Spinemat:GetAngles())
				--Delta:Rotate(AngDelta)
				mtx:SetTranslation(LPos)
				mtx:SetAngles(LAng)
				--print(name,AName,p:GetBoneCount())
				--PrintTable(p:GetChildBones(i))

				--print("DRAW")
			elseif !iAM or AName == "__INVALIDBONE__" then
				local pbi = p:GetBoneParent(i)
				local ParentMatrix = p:GetBoneMatrix(pbi)
				if !ParentMatrix then continue end
				local OldLPos,OldLAng = WorldToLocal(RawBonePosAng[i].pos,RawBonePosAng[i].ang,RawBonePosAng[pbi].pos,RawBonePosAng[pbi].ang)
				local LPos,LAng = LocalToWorld(OldLPos,OldLAng,ParentMatrix:GetTranslation(),ParentMatrix:GetAngles())
				mtx:SetTranslation(LPos)
				mtx:SetAngles(LAng)
			end
			--mtx:SetTranslation(mtx:GetTranslation()+Vector(0,0,10))
			--mtx:Rotate(Angle(0,0,10))
			p:SetBoneMatrix(i,mtx)
			p:SetBonePosition(i,mtx:GetTranslation(),mtx:GetAngles())
		end
		

		--[[for i=0,nb-1 do 

			local iAM = am:LookupBone(name)
			local AName = iAM and am:GetBoneName(iAM)
			if !ChildBone[p:GetBoneParent(i)] or !iAM or AName == "__INVALIDBONE__" then continue end
			ChildBone[i] = true
			local bmat = p:GetBoneMatrix(i)
			local Delta,DAng = WorldToLocal(bmat:GetTranslation(),bmat:GetAngles(),Spinemat:GetTranslation(),Spinemat:GetAngles())
			local LPos,LAng = LocalToWorld(Delta,DAng,Spinemat:GetTranslation(),Spinemat:GetTranslation()-(SpineMat:GetAngles()-am:GetBoneMatrix()))
			--Delta:Rotate(AngDelta)
			bmat:SetTranslation(LPos)
			bmat:SetAngles(LAng)
			p:SetBoneMatrix(i, bmat)

		end]]
		
	else
		for i=0,p:GetBoneCount()-1 do
			local name = p:GetBoneName(i)
			--print(AName,name)
			local mtx = p:GetBoneMatrix(i)
			if ( !mtx ) then continue end
			RawBonePosAng[i] = {
				pos = mtx:GetTranslation(),
				ang = mtx:GetAngles()
			}
			if (AData.OneHand or !RightArmBone[name]) and !LeftArmBone[name] then continue end
			local iAM = am:LookupBone(name)
			local AName = iAM and am:GetBoneName(iAM)
			if iAM and AName != "__INVALIDBONE__" and (!AData.OneHand or !RightArmBone[name]) then
				local Imtx = am:GetBoneMatrix(iAM)
				if !mtx or !Imtx then continue end
				mtx:SetTranslation(LerpVector(LerpVal,mtx:GetTranslation(),Imtx:GetTranslation()))
				mtx:SetAngles(LerpAngle(LerpVal,mtx:GetAngles(),Imtx:GetAngles()))
				--print(name,AName,p:GetBoneCount())
				--PrintTable(p:GetChildBones(i))

				--print("DRAW")
			elseif !iAM or AName == "__INVALIDBONE__" then
				local pbi = p:GetBoneParent(i)
				local ParentMatrix = p:GetBoneMatrix(pbi)
				if !ParentMatrix then continue end
				local OldLPos,OldLAng = WorldToLocal(RawBonePosAng[i].pos,RawBonePosAng[i].ang,RawBonePosAng[pbi].pos,RawBonePosAng[pbi].ang)
				local LPos,LAng = LocalToWorld(OldLPos,OldLAng,ParentMatrix:GetTranslation(),ParentMatrix:GetAngles())
				mtx:SetTranslation(LPos)
				mtx:SetAngles(LAng)
			end
			--mtx:SetTranslation(mtx:GetTranslation()+Vector(0,0,10))
			--mtx:Rotate(Angle(0,0,10))
			p:SetBoneMatrix(i,mtx)
			p:SetBonePosition(i,mtx:GetTranslation(),mtx:GetAngles())
		end
	end
	--p:SetupBones()


	--return true

end)

hook.Add("PreDrawPlayerHands","savee_svmal_stuff",function(hand,vm,p) --干预恁的手

	--do return end
	--print(vm:GetModel())
	--AnimMdl:Remove()
	--AnimMdl:SetPredictable(true)
	--function vm:RenderOverride()
	--	self:DrawModel()
	--	for i=0,vm:GetBoneCount()-1 do --then
	--		local mtx = vm:GetBoneMatrix(i)
	--		if !mtx then continue end
	--		mtx:SetTranslation(Vector())
	--		vm:SetBoneMatrix(i,mtx)
	--	end
	--end
	if !SVMAL.GetAnimPlaying() then return end
	--local hand = p:GetHands()
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
		if !AData._ValFinishCalled and AData.OnFinish then 
			AData.OnFinish(AData) 
			AData._ValFinishCalled = true
		end
	end
	if !IsValid(AnimMdl) then
		AnimMdl = SVMAL.CreateAnimModel()
		return 
	end
	--[[if AnimMdl:GetParent() != vm then
		AnimMdl:SetParent(vm)
	end]]
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
	--vm:ManipulateBonePosition(0,Vector(0,0,0))
	--print(hand:GetParent() , vm)
	--if hand:GetParent() != vm then
	--	hand:GetParent().savee_svmal_mybase = vm
	--	vm = hand:GetParent()
	--	--print("wocinemar")
	--end
	if !isnumber(vm.savee_svmal_bonecallback) then
		local nb = vm:GetBoneCount()
		vm.savee_svmal_bonecallback = vm:AddCallback( "BuildBonePositions", function( vm, nb )
			
			--if curvm != vm then return end
			--print("CALLING")
			--print(vm)
			--for i=0,vm:GetBoneCount()-1 do
			--	vm:ManipulateBonePosition(i,Vector(0,0,0))
			--end
			if !SVMAL.GetAnimPlaying() then return end
			if !IsValid(vm) then return end
			local w=p:GetActiveWeapon()
			if !IsValid(w) then return end
			local am = AnimMdl
			if !IsValid(am) then
				AnimMdl = SVMAL.CreateAnimModel()
				return 
			end
			am:SetupBones()
			local amnb = am:GetBoneCount()
			if !IsValid(hand) then hand = p:GetHands() end
			if hand:GetParent() != vm then
				hand:GetParent().savee_svmal_mybase = vm
				vm = hand:GetParent()
			end
		---	print(vm)
			--local RawBonePosAng = {}
			if !IsValid(hand) or !IsValid(vm) then return end
			local amrhbi = am:LookupBone("ValveBiped.Bip01_R_UpperArm")
			local vmrhbi = vm:LookupBone("ValveBiped.Bip01_R_UpperArm") --or am:LookupBone("R_UpperArm")
			local amlhbi = am:LookupBone("ValveBiped.Bip01_L_UpperArm")
			local vmlhbi = vm:LookupBone("ValveBiped.Bip01_L_UpperArm") --or am:LookupBone("L_UpperArm")
			--print("Q1")
			--print("do return end")
			--print((!amrhbi or !vmrhbi))
			if (!amrhbi or !vmrhbi) and (!amlhbi or !vmlhbi) then return end
			local matamr = amrhbi and am:GetBoneMatrix( amrhbi ) or Matrix()
			local matvmr = vmrhbi and vm:GetBoneMatrix( vmrhbi ) or Matrix()
			--local matvmr2 = vmrhbi and vm:GetBoneMatrix( vmrhbi ) or Matrix()
			local mataml = amrhbi and am:GetBoneMatrix( amlhbi ) or Matrix()
			local matvml = vmlhbi and vm:GetBoneMatrix( vmlhbi ) or Matrix()
			if !matamr and !matvmr then return end


			local AData = SVMAL.GetCurrentAnimData()
			local PBR=AData.PlaybackRate
			local Invert = AData.Invert
			local finalang = p:EyeAngles()+Angle(-30,0,0)
			if AData.NoPitch then
				finalang.p = -30
			end
			if AData.RotateAng then
				--print("CINEMAR")
				finalang = finalang+AData.RotateAng
			end
			am:SetAngles(finalang)



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
			--am:SetAngles(Angle(0,0,0))
			for i = 0, amnb - 1 do --矫正右手
				--print("EX?")
				local mat = am:GetBoneMatrix( i )
				if ( !mat ) then continue end
				--OLDVEC[i] = mat:GetTranslation()
				--NEWVEC[i] = mat:GetTranslation()-delta
				--delta:Rotate(Angle(0,0,0))
				if LeftArmBone[am:GetBoneName(i)] then
					mat:SetTranslation(mat:GetTranslation()-deltaL)
					--mat:SetAngles(ang2)
					--print(RightArmBone[am:GetBoneName(i)])
				elseif !AData.OneHand then
					mat:SetTranslation(mat:GetTranslation()-deltaR)
					--mat:SetAngles(ang1)
					--mat:SetAngles(mat:GetAngles()+Angle(-15,15,0))
				end
				if Invert then
					local CurDeltaP,CurDeltaA = WorldToLocal(mat:GetTranslation(),mat:GetAngles(),vm:GetPos(),vm:GetAngles())
					CurDeltaP.y=-CurDeltaP.y
					CurDeltaA.y=-CurDeltaA.y
					CurDeltaA.z=180-CurDeltaA.z
					--CurDeltaA.z=CurDeltaA.z
					--CurDeltaA.p=-CurDeltaA.p
					CurDeltaA:Normalize()
					local NewP,NewA=LocalToWorld(CurDeltaP,CurDeltaA,vm:GetPos(),vm:GetAngles())
					--print(NewP)
					mat:SetTranslation(NewP)
					mat:SetAngles(NewA)
					--mat:Invert()
				end
				--if AData.RotateAng then
				--	local CurDeltaP,CurDeltaA = WorldToLocal(mat:GetTranslation(),mat:GetAngles(),vm:GetPos(),p:EyeAngles())
				--	local NewP,NewA=LocalToWorld(CurDeltaP,CurDeltaA+AData.RotateAng,vm:GetPos(),p:EyeAngles())
				--	--print(NewP)
				--	mat:SetTranslation(NewP)
				--	mat:SetAngles(NewA)
				--	--mat:Invert()
				--end
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
			local RHBI = vm:LookupBone("ValveBiped.Bip01_R_Hand")
			local LHBI = vm:LookupBone("ValveBiped.Bip01_L_Hand")
			--if !RHBI or !LHBI then return end
			local RHMat = RHBI and vm:GetBoneMatrix(RHBI)
			local LHMat = LHBI and vm:GetBoneMatrix(LHBI)
			if !RHMat and !LHMat then return end
			local LerpVal = math.min(1,(CurTime()-AData.AnimStartTime)*PBR*3)
			if CurTime() >= final then
				LerpVal = 1-math.min((CurTime()-final)*3,1)
			end
			for i = 0, nb - 1 do
					--do break end
				--local truevm = vm.savee_svmal_mybase or vm
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
				--print(name,i,iAM,AnimMdl:GetModel(),(iAM and AnimMdl:GetBoneName(iAM)=="__INVALIDBONE__"))
				--国民护卫队模型支持
				local AName = iAM and AnimMdl:GetBoneName(iAM)
				if iAM and AName != "__INVALIDBONE__" and (!AData.OneHand or !RightArmBone[name]) then
					--print(name,i)
					local matAM = AnimMdl:GetBoneMatrix( iAM )
					--print(":1")
					--print(iAM)
					if !matAM --or 
						--(MDLForceLH[vm:GetModel()] and RightArmBone[AnimMdl:GetBoneName(AnimMdl:TranslatePhysBoneToBone(AnimMdl:TranslateBoneToPhysBone(iAM)))])
					then 
						continue
					end
					--print(!AData.OneHand , !RightArmBone[name])
					mat:SetTranslation(LerpVector(LerpVal,mat:GetTranslation(),matAM:GetTranslation()))
					mat:SetAngles(LerpAngle(LerpVal,mat:GetAngles(),matAM:GetAngles()))
					--mat:Invert()
					--mat:SetAngles(mat:GetAngles())
					--mat:SetTranslation(mat:GetTranslation())
					--print(math.min(1,(CurTime()-final)*3))
				elseif !iAM or AName == "__INVALIDBONE__" then --同步没有的骨骼
					--print(name,i)
					local pbi = vm:GetBoneParent(i)
					local ParentMatrix = vm:GetBoneMatrix(pbi)
					if !ParentMatrix then continue end
					local OldLPos,OldLAng = WorldToLocal(RawBonePosAng[i].pos,RawBonePosAng[i].ang,RawBonePosAng[pbi].pos,RawBonePosAng[pbi].ang)
					local LPos,LAng = LocalToWorld(OldLPos,OldLAng,ParentMatrix:GetTranslation(),ParentMatrix:GetAngles())
					mat:SetTranslation(LPos)
					mat:SetAngles(LAng)
				end
				vm:SetBoneMatrix( i, mat )
			end
			if IsValid(vm.savee_svmal_mybase) then
				--vm:SetupBones()
				nb = vm.savee_svmal_mybase:GetBoneCount()
				--print(nb)
			end
			local truevm = vm.savee_svmal_mybase or vm
			--print("cinema3")
			for i = 0, tonumber(nb) - 1 do
				--do break end
				--print("EX?") --未来科技不养闲人!!!
				local pbi = truevm:GetBoneParent(i)
				--print(pbi,truevm:GetBoneName(i))
				if pbi >= 0 then continue end
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
				--print("cinema2")
				if !iAM then --找不到,强制同步到手骨
					--print("1")
					--print(RHBI)
					--local LD = 0
					local RD = 0
					local ForceRH = true
					--print(name)

					if RHBI and RawBonePosAng[RHBI] then
						--local matRH = vm:GetBoneMatrix( RHBI )
						--if !matRH then return end
						RD = RawBonePosAng[RHBI].pos:DistToSqr(vm:LocalToWorld(Vector(3.190485,-21.364964,-30.849316)))
						--print(vm:WorldToLocal(matRH:GetTranslation()))
					end

					if AData.AutoDecideHands and AutoDecideHoldTypes[w:GetHoldType()] and RHBI and LHBI and RawBonePosAng[LHBI] and RawBonePosAng[LHBI] then

						local tran = RawBonePosAng[i].pos
						ForceRH = RawBonePosAng[RHBI].pos:DistToSqr(tran) <= RawBonePosAng[LHBI].pos:DistToSqr(tran)
						--print(RawBonePosAng[RHBI].pos:DistToSqr(tran) >= RawBonePosAng[LHBI].pos:DistToSqr(tran))

					end
					--print(RHBI)
					--print(vm:GetModel())
					--print(RD)
					local MyAwsomeParentTable = {[i] = true}
					--print(i)
					if RawBonePosAng[RHBI] and (ForceRH and RD >= ForceLH) then
						--print(RD)
						local deltapos,deltaang = WorldToLocal(mat:GetTranslation(),mat:GetAngles(),RawBonePosAng[RHBI].pos,RawBonePosAng[RHBI].ang)
						--local deltaang = mat:GetAngles() - RawBonePosAng[RHBI].ang
						local matRH = vm:GetBoneMatrix( RHBI )
						if !matRH then return end
						--print(vm:GetBoneName(i),deltapos,deltaang)
						local ltwpos,ltwang = LocalToWorld(deltapos,deltaang,matRH:GetTranslation(),matRH:GetAngles())
						mat:SetTranslation(ltwpos)
						mat:SetAngles(ltwang)
						--print("SB")
						--print("cinema")
						--truevm:ManipulateBonePosition(i,ltwpos)
						--truevm:ManipulateBoneAngles(i,ltwang)
						--truevm:ManipulateBonePosition(i,Vector())
						--truevm:ManipulateBoneAngles(i,Angle())
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
					truevm:SetBoneMatrix( i, mat )
					for i=0,nb-1 do
						local pbi = truevm:GetBoneParent(i)
						if !MyAwsomeParentTable[pbi] then continue end
						--print(pbi)
						MyAwsomeParentTable[i] = true
						--print(truevm:GetBoneName(i),truevm:GetBoneName(pbi))
						local mat = truevm:GetBoneMatrix(i)
						local ParentMatrix = truevm:GetBoneMatrix(pbi)
						if !mat or !ParentMatrix then continue end
						local OldLPos,OldLAng = WorldToLocal(RawBonePosAng[i].pos,RawBonePosAng[i].ang,RawBonePosAng[pbi].pos,RawBonePosAng[pbi].ang)
						local LPos,LAng = LocalToWorld(OldLPos,OldLAng,ParentMatrix:GetTranslation(),ParentMatrix:GetAngles())
						mat:SetTranslation(LPos)
						mat:SetAngles(LAng)
						truevm:SetBoneMatrix(i,mat)
					end
				end
				--mat:SetTranslation(Vector(0,0,0))
			end

			--truevm:SetRenderOrigin(Vector(0,0,0))
			--truevm:SetRenderAngles(Angle(0,0,0))
			--truevm:DrawModel()
		end )
		
		--for i = 0, nb - 1 do
	elseif !RECHECKED then
		vm:RemoveCallback("BuildBonePositions",vm.savee_svmal_bonecallback)
		vm.savee_svmal_bonecallback = nil
		RECHECKED = true
	end

	--do return end
	local nb = vm:GetBoneCount()
	local am = AnimMdl
	local amnb = am:GetBoneCount()
	if hand:GetParent() != vm then
		hand:GetParent().savee_svmal_mybase = vm
		vm = hand:GetParent()
	end
	local AData = SVMAL.GetCurrentAnimData()
	local Invert = AData.Invert
	--[[if AData.NoPitch then
		local ang = vm:GetAngles()
		ang.p = 0
		vm:SetAngles(ang)
	end
	if AData.RotateAng then
		vm:SetAngles(vm:GetAngles()+AData.RotateAng)
	end]]
		--print(vm)
	--local RawBonePosAng = {}
	--am:SetupBones()
	local amlhbi = am:LookupBone("ValveBiped.Bip01_L_UpperArm")
	local vmlhbi = vm:LookupBone("ValveBiped.Bip01_L_UpperArm")

	if (!amlhbi or !vmlhbi) then return end
	--local matvmr2 = vmrhbi and vm:GetBoneMatrix( vmrhbi ) or Matrix()
	local mataml = amlhbi and am:GetBoneMatrix( amlhbi )
	local matvml = vmlhbi and vm:GetBoneMatrix( vmlhbi ) or hand:GetBoneMatrix(hand:LookupBone("ValveBiped.Bip01_L_UpperArm"))
	if !mataml or !matvml then return end
	local PBR=AData.PlaybackRate

	local pos2 = LocalToWorld(Vector(5.04,7.72,-12.25),Angle(),vm:GetPos(),p:EyeAngles())
	local deltaL = WorldToLocal(mataml:GetTranslation(),Angle(),pos2,Angle())

	for i = 0, amnb - 1 do
		--print("EX?")
		local mat = am:GetBoneMatrix( i )
		if ( !mat ) then continue end
		--OLDVEC[i] = mat:GetTranslation()
		--NEWVEC[i] = mat:GetTranslation()-delta
		--delta:Rotate(Angle(0,0,0))
		if LeftArmBone[am:GetBoneName(i)] or LeftArmBone[am:GetBoneName(am:GetBoneParent(i))] then
			mat:SetTranslation(mat:GetTranslation()-deltaL)
			--print(deltaL)
			am:SetBoneMatrix( i, mat )
			--print(RightArmBone[am:GetBoneName(i)])
		end
		--mat:Rotate(Angle(0,90,0))
	end
	local RawBonePosAng = {}
	--local final = (p:GetNWFloat("savee_armmelee_lastmelee")+(am:SequenceDuration()-Anim[3]-Anim[4])/PBR)
	local final = (AData.AnimStartTime+(am:SequenceDuration()-AData.Offset_StartTime-AData.Offset_EndTime)/PBR)

	local LerpVal = math.min(1,(CurTime()-AData.AnimStartTime)*PBR*3)
	if CurTime() >= final then
		LerpVal = 1-math.min((CurTime()-final)*3,1)
	end
	for i = 0, nb - 1 do
			--do break end
		local truevm = vm.savee_svmal_mybase or vm
		--print(vm.savee_svmal_mybase)
		local mat = vm:GetBoneMatrix( i )
		if ( !mat ) then continue end
		RawBonePosAng[i] = {
			pos = mat:GetTranslation(),
			ang = mat:GetAngles()
		}
		local name = vm:GetBoneName(i)
		--LeftA
		if !LeftArmBone[name] and !LeftArmBone[vm:GetBoneName(vm:GetBoneParent(i))] then continue end
		--print(name)
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
			--print("你存在吗")
			mat:SetTranslation(LerpVector(LerpVal,mat:GetTranslation(),matAM:GetTranslation()))
			mat:SetAngles(LerpAngle(LerpVal,mat:GetAngles(),matAM:GetAngles()))
			--mat:Invert()
			--mat:SetAngles(mat:GetAngles())
			--mat:SetTranslation(mat:GetTranslation())
			--print(math.min(1,(CurTime()-final)*3))
		else
			local pbi = truevm:GetBoneParent(i)
			local ParentMatrix = truevm:GetBoneMatrix(pbi)
			if !ParentMatrix then continue end
			local OldLPos,OldLAng = WorldToLocal(RawBonePosAng[i].pos,RawBonePosAng[i].ang,RawBonePosAng[pbi].pos,RawBonePosAng[pbi].ang)
			local LPos,LAng = LocalToWorld(OldLPos,OldLAng,ParentMatrix:GetTranslation(),ParentMatrix:GetAngles())
			mat:SetTranslation(LPos)
			mat:SetAngles(LAng)
		end
		truevm:SetBoneMatrix(i,mat)

	end
	--vm:AddEffects(EF_PARENT_ANIMATES)
	--vm:AddEffects(EF_BONEMERGE)
	--vm:SetParent(AnimMdl)
end)
hook.Add("CalcView","svmal_hook_calcview",function(p,pos,ang,fov)

	do return end
	local view = {
		origin = pos - ( ang:Forward() * 100 ),
		angles = ang,
		fov = fov,
		drawviewer = false
	}
	return view
	
end)
concommand.Add("svmal_debug_playanim",function(p,_,a)
	SVMAL.StartAnimation({
		Anim = a[1] or "jump_AR",
		Offset_StartTime = a[2] or 0,
		Offset_EndTime = a[3] or 0,
		Model = (a[4] and #a[4] > 0 and a[4]) or p:GetModel(),
		OneHand = tobool(a[5]),
		NoPitch = tobool(a[6]),
		RotateAng = Angle(0,tonumber(a[7]),0),
	})
end)
concommand.Add("svmal_debug_playanimL",function(p,_,a)
	SVMAL.StartAnimation({
		Anim = a[1] or "jump_AR",
		Offset_StartTime = a[2] or 0,
		Offset_EndTime = a[3] or 0,
	})
end)
concommand.Add("swmal_debug_playanimL",function(p,_,a)
	SVMAL.StartWMAnimation(p,{
		Anim = "barrelpush",
		Offset_StartTime = 0.15,
		Offset_EndTime = 0.45,
		Model = "models/Police.mdl",
		OneHand = false,
		NoPitch = false,
		RotateAng = Angle(0,0,0),
	})
end)
concommand.Add("swmal_debug_playanimSL",function(p,_,a)
	for _,p in pairs(player.GetAll()) do
		SVMAL.StartWMAnimation(p,{
			Anim = "barrelpush",
			Offset_StartTime = 0.15,
			Offset_EndTime = 0.45,
			Model = "models/Police.mdl",
			OneHand = false,
			NoPitch = false,
			Spine = !false,
			RotateAng = Angle(0,0,0),
		})
	end
end)

