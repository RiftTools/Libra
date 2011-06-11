-- Libra.UI.ProgressBar

local Libra = LibStub:GetLibrary('Libra-alpha', true)
if not Libra then return end

local MAJOR = "Libra-alpha.UI.ProgressBar"
local MINOR = 1

local ProgressBar = LibStub:NewLibrary(MAJOR, MINOR)
if not ProgressBar then return end

local context = UI.CreateContext("Context")

Libra.UI.ProgressBar = ProgressBar

function Libra.UI.ProgressBar:Create(owner)
	local pb = {}
	if owner then
		pb  = Libra.UI.FrameManager:Create('Libra.UI.Button: pb', owner)
	else
		pb  = Libra.UI.FrameManager:Create('Libra.UI.Button: pb', context)
	end	
	
	pb.min = 0
	pb.max = 100
	pb.value = 0
	
	pb.background  = Libra.UI.FrameManager:Create('Texture', pb)
	pb.texture     = Libra.UI.FrameManager:Create('Texture', pb.background)	
	pb.text        = {}
	pb.text.left   = Libra.UI.FrameManager:Create('Text', pb.background)
	pb.text.right  = Libra.UI.FrameManager:Create('Text', pb.background)

	pb.text.left:SetFontSize(13)
	pb.text.right:SetFontSize(13)
	pb.text.left:SetLayer(2)
	pb.text.right:SetLayer(2)
	
	pb.padding = 0
	
	pb.text.right.format = 'time'
	
	pb.border = {}
	pb.border.size = 1
	
	pb:SetBackgroundColor(0, 0, 0, 0.4)
	pb.background:SetBackgroundColor(0, 0.2, 0, 0.4)
	pb.texture:SetBackgroundColor(0, 0.6, 0, 0.4)
	pb:SetWidth(290)
	
	-- Refresh the button
	function pb:Refresh()
		self.text.right:SetText(string.format("%d", self.value))
		
		if self.text.right.format == 'time' then
			self.text.right:SetText(string.format("%d", self.value))
			if self.value > 3600 then
				self.text.right:SetText(string.format("%d:%02d:%02d", self.value / 3600, self.value / 60 % 60, self.value % 60))
			elseif self.value > 60 then
				self.text.right:SetText(string.format("%d:%02d", self.value / 60, self.value % 60))
			else
				self.text.right:SetText(string.format("%2d", self.value % 60))
			end
		end
	
		self.text.left:ResizeToText()
		self.text.right:ResizeToText()
		
		self:SetHeight(26)
		
		self.background:SetPoint('TOPLEFT', self, 'TOPLEFT', self.border.size, self.border.size)
		self.background:SetPoint('BOTTOMRIGHT', self, 'BOTTOMRIGHT', -self.border.size, -self.border.size)
		
		self.texture:SetPoint('TOPLEFT', self.background, 'TOPLEFT')
		self.texture:SetPoint('BOTTOMLEFT', self.background, 'BOTTOMLEFT')
		
		local bar_offset = (((self.value / self.max) * self.background:GetWidth() - self.background:GetWidth()))
		self.texture:SetPoint('BOTTOMRIGHT', self.background, 'BOTTOMRIGHT', bar_offset, 0)
		
		self.text.left:SetPoint('TOPLEFT', self.background, 'TOPLEFT', 5, (self.background:GetHeight() - self.text.left:GetHeight()) / 2)
		self.text.right:SetPoint('TOPRIGHT', self.background, 'TOPRIGHT', -3, (self.background:GetHeight() - self.text.left:GetHeight()) / 2)
	end
	
	--
	-- Set the current progress value
	--
	-- @param   number   New progress value
	function pb:SetValue(newvalue)
		if newvalue > self.max then
			newvalue = self.max
		end
		if newvalue < self.min then
			newvalue = self.min
		end
		self.value = newvalue
		
		self:Refresh()
	end
	
	--
	-- Returns the current progress value
	--
	-- @return   number   Current progress value
	function pb:GetValue()
		return self.value
	end
	
	pb:Refresh()
	
	return pb
end