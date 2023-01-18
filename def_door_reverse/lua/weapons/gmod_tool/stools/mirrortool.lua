AddCSLuaFile()


TOOL.Category = "Construction"
TOOL.Name = "Mirror Maker"
TOOL.Command = nil

function TOOL:LeftClick(trace)
	if SERVER then return end
	net.Start("MirrorENT:Make")
	net.SendToServer()
end

function TOOL:RightClick(trace)
end

function TOOL:Deploy()
end

function TOOL:Holster()
end

function TOOL.BuildCPanel(CPanel)
end