-- Libra.Utils.Callbacks

local Libra = LibStub:GetLibrary('Libra-alpha', true)
if not Libra then return end

local MAJOR = "Libra-alpha.Utils.Callbacks"
local MINOR = 1

local Callbacks = LibStub:NewLibrary(MAJOR, MINOR)
if not Callbacks then return end

Libra.Utils.Callbacks = Callbacks

Libra.Utils.Callbacks.callbacks = {}

--
-- Execute the callback
--   Adds the callback to a table and runs it on next frame
--   update via the _CallbackService(). This prevents the calling
--   Addon from needing to wait for the callback to complete.
--
-- @param   func    callback   Function to call back
function Libra.Utils.Callbacks:Execute(callback)
	table.insert(Libra.Utils.Callbacks.callbacks, callback)
end

--
-- Callback Service
--   Does the actual execution of the callbacks
--
function Libra.Utils.Callbacks:_CallbackService()
	for k, v in pairs(Libra.Utils.Callbacks.callbacks) do
		v()
		table.remove(Libra.Utils.Callbacks.callbacks, k)
	end
end

-- Listen for system updates and check the time
table.insert(Event.System.Update.Begin, {Libra.Utils.Callbacks._CallbackService, "Libra", "Libra.Utils.Callbacks"})