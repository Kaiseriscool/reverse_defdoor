AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

function ENT:Initialize()
	self:SetModel("models/props_c17/Lockers001a.mdl")
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)
	self:GetPhysicsObject():Wake()
	self:SetUseType(SIMPLE_USE)
	self:GetPhysicsObject():EnableMotion(false)
end

local function FadeDoor(ent, seconds)
	if not IsValid(ent) or not seconds then return end

	local oldCollision, color, mat = ent:GetCollisionGroup() or COLLISION_GROUP_NONE, ent:GetColor() or color_white, ent:GetMaterial()

	ent:SetCollisionGroup(COLLISION_GROUP_WORLD)
	ent:SetMaterial("models/shadertest/shader3")
	ent:SetColor(color_white)

	timer.Simple(seconds, function()
		if not IsValid(ent) then return end
		ent:SetCollisionGroup(oldCollision)
		ent:SetMaterial(mat)
		ent:SetColor(color)
		ent.Faded = false
	end)
end

function ENT:Use(ply)
	if self.Faded then return end
	if self:CPPIGetOwner() ~= ply then return end

	self.Faded = true
	FadeDoor(self, self.FadeTime)
end

function ENT:Destruct()
    local vPoint = self:GetPos()
    local effectdata = EffectData()
    effectdata:SetStart(vPoint)
    effectdata:SetOrigin(vPoint)
    effectdata:SetScale(1)
    util.Effect("Explosion", effectdata)
	self:Remove()
end

function ENT:OnTakeDamage(dmginfo)
	local ply = dmginfo:GetAttacker()
	if not IsValid(ply) then return end
    if self:CPPIGetOwner() == ply then return end
	ply:TakeDamage(dmginfo:GetDamage())
end

function ENT:OnRemove()
	local ply = self:CPPIGetOwner()
	if not IsValid(ply) then return end
	ply.Mirror = false
end