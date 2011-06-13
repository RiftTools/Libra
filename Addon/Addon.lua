-- Libra.Addon

local Libra = LibStub:GetLibrary('Libra-alpha', true)
if not Libra then return end

local MAJOR = "Libra-alpha.Addon"
local MINOR = 1

local Addon = LibStub:NewLibrary(MAJOR, MINOR)
if not Addon then return end

Libra.Addon = Addon


--
-- Create a new addon
--
-- @param   String      name       Addon name
-- @returns Libra.Addon new_timer  Newly created timer object
function Libra.Addon:Create(name)
	local addon = {}
	
	------------------------------------------------
	-- Construct the new addon object
	------------------------------------------------
	
	-- The addons identifier name.  Must match ToC
	addon.Name = name
	
	-- Register a slash command for the addon
	--
	-- @param    String    name      Name for the slash command [Example: 'Config']
	-- @param    String    cmd       Text to be used for the slash command
	-- @param    func      callback  Function to be called back when the command is used
	-- @param    Sttring   desc      Description of the commands synax
	function addon.RegisterSlashCommand(name, cmd, callback, desc)
		-- TODO: Add to a registry
		table.insert(Command.Slash.Register("SlickTimers"), { callback, self.Name, 'config' })
	end
	
	-- 
	
	return addon
end