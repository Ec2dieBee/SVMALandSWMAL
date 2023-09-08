--[[
	TRANSLATOR: Savee14702
	TRANSLATE LEVEL: MACHINE TRANSLATE AND BAD ENGLISH(INCLUDING GRAMMAR ISSUES LMAO)
	FROM: SChinese
	TO: English



	SAY FIRST
	The reason of why I made this addon is not to upload 2 addons at once 
	Fixs with TFA INS:S will appear in future
	Also,take care of ctrl+f(it's useful)
	(Who don't like offline document)
	And if you don't know some meanings of functions,check doccn.lua for more information(prepare ur machine translate)

	What should this Addon do?
	This Addon's Mission is ONLY to make VM use WM's animation and move it's weapon
	It can't compare with VManip,but it can MOVE weapon
	Check Armmelee for animation examples

	TODO
	Fix TFA INS:S --Nop,I'm too lazy
	Fix queue system of VM
	


	--Please add "SVMAL" before function name like SVMAL.Example(idk)
	
	Value explain(May wrong)
	>Boolean
	>>Bool(true,false)

	>Int
	>>Integer
	
	>Float
	>>Float Number

	>Number/Num
	>>Numbers(Includes Int and Float)

	>Entity
	>>Entities(like player)

	>Clientside Entity/CSEnt
	>>CLientside Entities
	>>Not like Entity,it ONLY exists on clientside,that means only clientsides CAN see them(just something cool on your computer and only you can see lol)

	>Table
	>>Table

	Funcs

	>Function SVMAL.AddQueuedData(Table AnimationData)
	>Use carefully
	>Description
	>>Add an animation in the queue system(Check Enums->AnimationTable for structs)

	>Function SVMAL.CreateAnimModel()
	>This is a safe check in codes,you shouldn't use it in normal condition
	>Description
	>>Create a model for playing anims
	>Returns
	>>Entity new AnimMdl

	>Function SVMAL.CreateAnimModelDelta()
	>This is a safe check in codes,you shouldn't use it in normal condition
	>Description
	>>Create a deltamodel(nop,it's just connect anims)
	>Returns
	>>Entity new DELTAAnimMdl

	>Function SVMAL.GetAnimPlaying()
	>Description
	>>Check if an animation is playing
	>>WARNIMG-It will return TRUE if the animation is LOOPED
	>Returns
	>>Boolean Is there an animation playing?

	>Function SVMAL.GetAnimModel()
	>Description
	>>Returns current AnimModel(Animation Model)
	>>Pro-Tip: You can just use SAVEE_TEMP_SVMAL_RELATEDSHIT,it is AnimModel
	>Returns 
	>>CSEnt AnimModel(Animation Model)

	>Function SVMAL.GetAnimModelDelta()
	>Description
	>>Returns current DeltaAnimModel(Animation Model)
	>>Pro-Tip: You can just use SAVEE_TEMP_SVMAL_RELATEDSHITCMP,it is AnimModelDelta
	>>(CMP is Compare in it's fullname ,but the truth is it's meaning ISN'T "smooth" or sth)
	>Returns
	>>CSEnt Delta AnimModel(Animation Model)

	>Function SVMAL.GetCurrentAnimData()
	>Bug
	>>Doesn't support #Table,IDK why
	>Description
	>>Return current animation data
	>Returns
	>>Table A copy of the animation table

	>Function SVMAL.GetQueueTable()
	>Description
	>>Get the animation queue table
	>returns
	>>Table The queue table

	>Function SVMAL.ResetManipulateData()
	>Description
	>>Reset manipulates on AnimModel(可以这么理解)

	>Function SVMAL.RemoveQueueTableData(Number Index)
	>Description
	>>Remove an animation data in QueueTable(Index def: 1)

	>Function SVMAL.SetAnimPlaying(Boolean state)
	>Description
	>>Set the state of animation system(is it running?)
	>>(You SHOULDN'T touch it in normal condititon cuz it will set automatically when u start an animation)
	>>WARNIMG-Random using this function will cause performance issues
	>Returns
	>>Boolean State before
	>Automatically call in
	>>SVMAL.StartAnimation

	>Function SVMAL.SetCurrentAnimData(Table AnimationData)
	>Use carefully
	>Description
	>>Set current animation data
	>Returns
	>>Table Current Data,Table Old Data

	>Function SVMAL.StartAnimation(Table AnimationTable)
	>Description
	>>Play an animation
	>>Anim MUST be setted,it can be index and sequence
	>>Check Enums->AnimationTable for more information
	>Returns
	>>Table RawAnimationData(可修改,如果排队则返还nil)

	>Function SVMAL.StartWMAnimation(Entity Player,Table AnimationData)
	>WARNIMG
	>>Won't Network automatically
	>>It works bad
	>>It shouldn't be in SVMAL
	>Description
	>>Let a player plays an animation in their world model

	>Function SVMAL.TryQueue()
	>Description
	>>(Force)Play next animation in the queue table

	Enums

	>AnimationTable
	>>Anim String/Number,Animation to play
	>>Model String,Model to change
	>>OneHand Bool,Play animation only in left hand
	>>PlaybackRate Num,Speed mult(Def: 1)
	>>Offset_StartTime Num,Animation start time offset(In second)
	>>Offset_EndTime Num,Animation end time offset(In second)
	>>AllowOverride Allow to be overwritted(String)
	>>OnFinish Function,What should it do when it finished
	>>OnStart Function,What should it do when it started
	>>[UNFINISHED]Queue Bool,Should it queue?(Will force queue when it set)
	>>KeepBoneData Bool,Save bone manipulation datas(Won't work when changing model..?)
	>>AutoDecideHands Bool,[Armmelee Support] Decide automatically to use left hand or not (Won't work if OneHand is setted) (def: on)?
	>>RotateAng Angle,Rotate angles
	>>NoPitch bool,Lock pitch into one value(just use RotateAng with this)

	>WMAnimationTable
	>>Anim String/Number,Animation to play
	>>Model String,Model to change
	>>OneHand Bool,Play animation only in left hand
	>>PlaybackRate Num,Speed mult(Def: 1)
	>>Offset_StartTime Num,Animation start time offset(In second)
	>>Offset_EndTime Num,Animation end time offset(In second)
	>>AllowOverride Allow to be overwritted(String)
	>>KeepBoneData Bool,Save bone manipulation datas(Won't work when changing model..?)(def: on)
	>>RotateAng Angle,Rotate angles
	>>NoPitch bool,Lock pitch into one value(just use RotateAng with this)
	>>Spine bool,Will play the animation with spines(and head)
	>>[UNFINISHED]Fullbody bool,Play it with fullbody movement,YAY!

]]