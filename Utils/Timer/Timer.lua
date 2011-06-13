-- Libra.Utils.Timer

local Libra = LibStub:GetLibrary('Libra-alpha', true)
if not Libra then return end

local MAJOR = "Libra-alpha.Utils.Timer"
local MINOR = 1

local Timer = LibStub:NewLibrary(MAJOR, MINOR)
if not Timer then return end

Libra.Utils.Timer = Timer

Libra.Utils.Timer.timers = {}

Libra.Utils.Timer.next_timepoint = 0

--
-- Create a new countdown Timer
--
-- @param   int   duration   Timer duration in seconds
-- @param   func  callback   Function to callback
-- @returns timer new_timer  Newly created timer object
function Libra.Utils.Timer:Create(name, duration, callback, params)
	local new_timer = {}
	new_timer.duration = duration
	new_timer.callback = callback
	new_timer.params   = params
	new_timer.end_time = Inspect.System.Time() + duration
	new_timer.remaining = duration

	Libra.Utils.Timer.timers[name] = new_timer
	Libra.Utils.Timer:calculate_timepoint()
	
	print('New Timer: ' .. tostring(name))
	
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
		local i = 0
		for k, v in pairs(self.timers) do
			if v.end_time > self.next_timepoint then
				self.next_timepoint = v.end_time
			end
			i = i + 1
		end
		if i == 0 then
			self.next_timepoint = 0
		end
	end
end

--
-- Monitors existing timers and fires off callback when needed
--
function Libra.Utils.Timer:_MonitorService()
	
	if Libra.Utils.Timer.next_timepoint > 0 then
		if Libra.Utils.Timer.timers then
			for k, v in pairs(Libra.Utils.Timer.timers) do
				v.remaining = v.end_time - Inspect.System.Time()
				if v.remaining < 0 then
					v.remaining = 0
				end
				if v.end_time <= Inspect.System.Time() then
				
					print('Timer Up!: ' .. tostring(k) .. '  --  ' .. tostring(v.callback))
					
					if v.callback and v.params then
						print('Sending timer callback: ' .. tostring(k))
						Libra.Utils.Callbacks:Execute(v.callback, v.params)
					elseif v.callback then
						print('Sending timer callback: ' .. tostring(k))
						Libra.Utils.Callbacks:Execute(v.callback)
					end
					Libra.Utils.Timer.timers[k] = nil
					Libra.Utils.Timer:calculate_timepoint()
				end
			end
		end
	end
end

-- Listen for system updates and check the time
table.insert(Event.System.Update.Begin, {Libra.Utils.Timer._MonitorService, "Libra", "Libra.Utils.Timer"})