-- Libra.Ui.Timeline

local Libra = LibStub:GetLibrary('Libra-alpha', true)
if not Libra then return end

local MAJOR = "Libra-alpha.UI.Timeline"
local MINOR = 1

local Timeline = LibStub:NewLibrary(MAJOR, MINOR)
if not Timeline then return end

Libra.UI.Timeline = Timeline

local context = UI.CreateContext("Context")

--
-- Create a new countdown Timer
--
-- @param   int   duration      Timer duration in seconds
-- @returns Libra.UI.Timeline   Newly created timeline object
function Libra.UI.Timeline:Create(context)
	local new_timeline = Libra.UI.FrameManager:Create('Libra.UI.Timeline', context)
	new_timeline:SetBackgroundColor(0,0,0,0.4)
	
	new_timeline.Entries = {}
	
	new_timeline.multi_timeline = false
	
	new_timeline.border = {}
	new_timeline.border.size = 4
	
	new_timeline.background = Libra.UI.FrameManager:Create('Frame', new_timeline)
	new_timeline.background:SetBackgroundColor(0.2,0.2,0.2,0.9)
	
	new_timeline.max = 30
	new_timeline.min = 0

	--
	-- Add an entry to the timeline
	--	
	function new_timeline:AddEntry(identifier, payload, value, min, max)
		local new_entry = Libra.UI.FrameManager:Create('Libra.UI.Timeline: Entry', self.background)
		if min ~= nil and max ~= nil then
			new_entry.min = min
			new_entry.max = max
		end
		new_entry.value = value
		new_entry.payload = payload
		new_entry.payload:SetParent(new_entry)
		
		new_entry:SetPoint('TOPLEFT', self.background, 'TOPLEFT')
		new_entry:SetPoint('BOTTOMLEFT', self.background, 'BOTTOMLEFT')
		new_entry.payload:SetPoint('TOPRIGHT', new_entry, 'TOPRIGHT')
		
		function new_entry:SetValue(val)
			self.value = val
		end
		
		function new_entry:GetValue(val)
			return self.value
		end
			
		new_entry:SetVisible(true)
		
		self.Entries[identifier] = new_entry
	end

	--
	-- Remove and entry from the timeline
	--
	function new_timeline:RemoveEntry(id)
		if self.Entries[id] then
			self.Entries[id]:SetVisible(false)
			self.Entries[id] = nil
		end
	end
	
	--
	-- Refresh the timeline
	--
	function new_timeline:Refresh()
		self.background:SetPoint('TOPLEFT', self, 'TOPLEFT', self.border.size, self.border.size)
		self.background:SetPoint('BOTTOMRIGHT', self, 'BOTTOMRIGHT', -self.border.size, -self.border.size)
		
		for k, v in pairs(self.Entries) do
			local offset = 0
			if v.value then
				if v.min ~= nil and v.max ~= nil and self.multi_timeline then
					offset = (self.background:GetWidth() - v.payload:GetWidth()) - ((self.background:GetWidth() - v.payload:GetWidth()) * (v.value / v.max))
				else
					offset = (self.background:GetWidth() - v.payload:GetWidth()) - ((self.background:GetWidth() - v.payload:GetWidth()) * (v.value / self.max))
				end				
				v:SetPoint('TOPRIGHT', self.background, 'TOPRIGHT', -offset, 0)
				v:SetVisible(true)
				
				if v.value > self.max and not self.multi_timeline then
					v:SetVisible(false)
				end
			end
			
		end
	end
	
	--
	-- Resize the timeline
	--
	function new_timeline:Resize(width, height)
		if width < self.border.size * 2 then
			width = self.border.size * 2
		end
		if height < self.border.size * 2 then
			height = self.border.size * 2
		end
		new_timeline:SetWidth(width)
		new_timeline:SetHeight(height)
		self:Refresh()
	end
	
	--
	-- Set the max time
	--
	function new_timeline:SetMax(value)
		self.max = value
	end
	
	--
	-- Set the min time
	--
	function new_timeline:SetMin(value)
		self.min = value
	end
	
	---------------------------------
	-- Final Inits
	---------------------------------
	new_timeline:Resize(380, 38)
	
	return new_timeline
end