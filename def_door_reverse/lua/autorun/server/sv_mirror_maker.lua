local blockedmodels = {
    ["models/props_building_details/storefront_template001a_bars.mdl"] = true,
}

local mat = ""
local color_door = Color(0 , 0 ,0 , 0)

MirrorENT = MirrorENT or {}


util.AddNetworkString("MirrorENT:Make")
net.Receive("MirrorENT:Make", function(len, ply)
    if ply.MirrorENT then DarkRP.notify(ply, 1, 3, "You have the maximum mirrors amount!") return end


    local ent = ply:GetEyeTrace().Entity
    if not IsValid(ent) then return end
    if blockedmodels[ent:GetModel()] then return end

    if ent:CPPIGetOwner() ~= ply then return end

    local MirrorENT = ents.Create("mirror_ent")
    MirrorENT:CPPISetOwner(ply)
    MirrorENT:Spawn()
    MirrorENT:SetModel(ent:GetModel())
    MirrorENT:SetAngles(ent:GetAngles())
    MirrorENT:SetPos(ent:GetPos())
    MirrorENT:SetMaterial(mat)
    MirrorENT:SetColor(color_door)
    ply.Mirror = true
    ent:Remove()
end)
