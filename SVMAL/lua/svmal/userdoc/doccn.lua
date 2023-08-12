--[[
	写在前面
	我做这玩意纯因为不想上传两个模组
	针对TFA叛乱沙暴(个人粗翻)武器的修复会在以后进行
	哦对了,善用ctrl+f
	(谁不喜欢离线文档呢)

	你说得对,但是下次请写TODO,不然某人喝醉了忘了事就不好了 -Savee30296

	该Addon定位
	该Addon的目标仅仅是想办法在让VM应用WM动作的同时移动武器,肯定比不上VManip但是能移动武器
	具体动画应用参见Armmelee

	TODO
	解决针对叛乱沙暴武器包的铸币问题
	


	--所有func请在前面接上SVMAL.,如SVMAL.Example(idk)
	
	值解释(可能有误)
	>Boolean
	>>布尔值(true,false)

	>Int
	>>整数
	
	>Float
	>>浮点数

	>Number/Num
	>>数字(包含Int和Float)

	>Entity
	>>实体(如玩家)

	>Clientside Entity/CSEnt
	>>客户端实体
	>>和Entity不同,客户端实体只存在于客户端,这意味着它们只有客户端能看到(比如只有你能看到的神必东西)

	>Table
	>>表

	Funcs

	>Function SVMAL.SetAnimPlaying(Boolean state)
	>介绍
	>>设置是否进行动画
	>>(通常情况下你不应该碰它,执行动作时会自己设置)
	>>警告-胡乱使用该function可能会导致性能问题
	>返还
	>>Boolean 之前的State
	>自动应用于
	>>SVMAL.StartAnimation

	>Function SVMAL.GetAnimPlaying()
	>介绍
	>>查看现在是否在执行一个动画
	>>警告-如果作者特殊设置该动作仍在结束执行,这玩意也会返还true
	>返还
	>>Boolean 当前是否执行动画

	>Function SVMAL.GetAnimModel()
	>介绍
	>>返还现在的AnimModel(动画实体)
	>>Pro-Tip: 你可以直接调用SAVEE_TEMP_SVMAL_RELATEDSHIT,它就是AnimModel
	>返还
	>>CSEnt AnimModel(动画实体)

	>Function SVMAL.CreateAnimModel()
	>这是在代码内部应用的保险机制,通常情况下你不应该使用
	>介绍
	>>创建执行动画用的模型
	>返还
	>>Entity 新AnimMdl

	>Function SVMAL.ResetManipulateData()
	>介绍
	>>重置AnimModel的骨骼修改(可以这么理解)

	>Function SVMAL.StartAnimation(Table AnimationTable)
	>介绍
	>>执行动画
	>>表中的结构必须有Anim-动画,可以是index,也可以是sequence
	>>具体参见下面的格式
	>AnimationTable
	>>Anim String/Number,要执行的动作
	>>Model String,要换的模型
	>>OneHand Bool,左手执行动作
	>>PlaybackRate Num,播放速度(默认1)
	>>Offset_StartTime Num,开始时间偏移
	>>Offset_EndTime Num,结束时间偏移
	>>AllowOverride 是否允许被覆盖(String) 没做
	>>OnFinish Function,在动画结束后做什么
	>>OnStart Function,在动画开始时做什么 没做
	>>Queue Bool,是否排队执行(当它被设置时不管动画能否被覆写都将排队执行)
	>>KeepBoneData Bool,保留对骨骼的修改(换模型时无效..?) 好了
	>>AutoDecideHands Bool,[Armmelee支持] 自动决定是否使用左手(OneHand设置时无效) (默认开)?
	>>RotateAng Angle,旋转角度
	>>NoPitch bool,上下看时视觉模型不会跟着转

	>Function SVMAL.SetCurrentAnimData(Table AnimationData)
	>小心使用
	>介绍
	>>设置当前动画的数据
	>返还
	>>Table OldData,老动画数据

	>Function SVMAL.SetCurrentAnimData(Table AnimationData)
	>Bug
	>>不支持#Table,不知道为什么
	>介绍
	>>获取当前动画的数据
	>返还
	>>Table 一个当前动画数据Table的拷贝

	>Function SVMAL.StartWMAnimation(Entity Player,Table AnimationData)
	>警告
	>>不会自己Network
	>>制作较为粗糙
	>>被错误的归类于SVMAL
	>介绍
	>>让一个玩家开始第三人称动画




]]