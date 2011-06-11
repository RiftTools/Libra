-- Libra.Utils.Timer

local Libra = LibStub:GetLibrary('Libra-alpha', true)
if not Libra then return end

local MAJOR = "Libra-alpha.UI.Timer"
local MINOR = 1

local Timer = LibStub:NewLibrary(MAJOR, MINOR)
if not Timer then return end

Libra.Utils.Timer = Timer

Libra.Utils.Timer.timers = {}

--
-- Create a new Timer
--
-- @param   int   duration   Timer duration in seconds
-- @param   func  callback   Function to callback
-- @returns timer new_timer  Newly created timer object
function Libra.Utils.Timer:Create(name, duration, callback)
	local new_timer = {}
	new_timer.duration = duration
	new_timer.callback = callback
	new_timer.end_time = Inspect.System.Time() + duration
	new_timer.remaining = duration

	table.insert(Libra.Utils.Timer.timers, new_timer)
	return new_timer
end

--
-- Monitors existing timers and fires off callback when needed
--
function Libra.Utils.Timer:_MonitorService()
	if Libra.Utils.Timer.timers then
		for k, v in pairs(Libra.Utils.Timer.timers) do
			v.remaining = v.end_time - Inspect.System.Time()
			if v.remaining < 0 then
				v.remaining = 0
			end
			if v.end_time <= Inspect.System.Time() then
				if v.callback then
					v.callback()
				end
				table.remove(Libra.Utils.Timer.timers, k)
			end
		end
	end
end

-- Listen for system updates and check the time
table.insert(Event.System.Update.Begin, {Libra.Utils.Timer._MonitorService, "Libra", "Libra.Utils.Timer"})