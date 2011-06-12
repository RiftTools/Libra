-- Libra.Utils.Timer

local Libra = LibStub:GetLibrary('Libra-alpha', true)
if not Libra then return end

local MAJOR = "Libra-alpha.UI.Timer"
local MINOR = 1

local Timer = LibStub:NewLibrary(MAJOR, MINOR)
if not Timer then return end

Libra.Utils.Timer = Timer

Libra.Utils.Timer.timers = {}

Libra.Utils.Timer.next_timepoint = false

--
-- Create a new countdown Timer
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
	Libra.Utils.Timer:calculate_timepoint()
	return new_timer
end

--
-- Create a stopwatch timer
-- 
function Libra.Utils.Timer:Start(name)
	local new_timer = {}
	new_timer.duration = false
	new_timer.start_time = Inspect.System.Time()
	new_timer.remaining = false
	
	function new_timer:Stop()
		new_timer.duration = Inspect.System.Time() - new_timer.start_time
		return new_timer.duration
	end

	return new_timer
end

--
-- Looks through the countdown timers and sets the next_timepoint at our next needed time
--
function Libra.Utils.Timer:calculate_timepoint()
	if self.timers then
		for k, v in pairs(self.timers) do
			if v.end_time > self.next_timepoint then
				self.next_timepoint
			end
		end
	end
end

--
-- Monitors existing timers and fires off callback when needed
--
function Libra.Utils.Timer:_MonitorService()
	if Libra.Utils.Timer.next_timepoint and Inspect.System.Time() >= Libra.Utils.Timer.next_timepoint then
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
					Libra.Utils.Timer:calculate_timepoint()
				end
			end
		end
	end
end

-- Listen for system updates and check the time
table.insert(Event.System.Update.Begin, {Libra.Utils.Timer._MonitorService, "Libra", "Libra.Utils.Timer"})