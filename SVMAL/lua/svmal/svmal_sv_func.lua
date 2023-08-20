util.AddNetworkString("SWMAL_BROADCASTANIMATIONINFO")
net.Receive("SWMAL_BROADCASTANIMATIONINFO",function(_,p)

	local Table = net.ReadTable()
	net.Start("SWMAL_BROADCASTANIMATIONINFO",true) --没必要给客户端太多压力
		net.WriteEntity(p)
		net.WriteTable(Table)
	net.Broadcast()
	
end)