-- Libra.Utils.Registry

local Libra = LibStub:GetLibrary('Libra-alpha', true)
if not Libra then return end

local MAJOR = "Libra-alpha.Utils.Registry"
local MINOR = 1

local Registry = LibStub:NewLibrary(MAJOR, MINOR)
if not Registry then return end

Libra.Utils.Registry = Registry

Libra.Utils.Registry.Entries = {}

function Libra.Utils.Registry.Entries:Set(major, minor, value)
	if not Libra.Utils.Registry.Entries[major] then
		Libra.Utils.Registry.Entries[major] = {}
	end
	Libra.Utils.Registry.Entries[major][minor] = value
end

function Libra.Utils.Registry.Entries:Get(major, minor)
	if Libra.Utils.Registry.Entries[major] and Libra.Utils.Registry.Entries[major][minor] then
		return Libra.Utils.Registry.Entries[major][minor]
	else
		return false
	end
end