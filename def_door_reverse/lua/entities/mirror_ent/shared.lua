ENT.Type = "anim"
ENT.Base = "base_gmodentity"
ENT.PrintName = "Mirror"
ENT.Author = "Some NN"
ENT.Category = "Custom"
ENT.Spawnable = true
ENT.FadeTime = 5

function ENT:SetupDataTables()
	self:NetworkVar("Entity", 0, "owning_ent")
end