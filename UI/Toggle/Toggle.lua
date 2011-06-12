-- Libra.UI.Toggle

local Libra = LibStub:GetLibrary('Libra-alpha', true)
if not Libra then return end

local MAJOR = "Libra-alpha.UI.Toggle"
local MINOR = 1

local Toggle = LibStub:NewLibrary(MAJOR, MINOR)
if not Toggle then return end

local context = UI.CreateContext("Context")

Libra.UI.Toggle = Toggle

function Libra.UI.Toggle:Create(owner)
	local toggle = {}
	if owner then
		toggle  = Libra.UI.FrameManager:Create('Libra.UI.Button: Toggle', owner)
	else
		toggle  = Libra.UI.FrameManager:Create('Libra.UI.Button: Toggle', context)
	end	
	
	toggle.state = true
	
	toggle.background = Libra.UI.FrameManager:Create('Texture', toggle)	
	toggle.text        = {}
	toggle.text.on     = Libra.UI.FrameManager:Create('Text', toggle.background)
	toggle.text.off    = Libra.UI.FrameManager:Create('Text', toggle.background)
	toggle.text.on.bg  = Libra.UI.FrameManager:Create('Texture', toggle.background)
	toggle.text.off.bg = Libra.UI.FrameManager:Create('Texture', toggle.background)
	toggle.text.on:SetParent(toggle.text.on.bg)
	toggle.text.off:SetParent(toggle.text.off.bg)
	toggle.text.on:SetFontSize(16)
	toggle.text.off:SetFontSize(16)
	
	toggle.padding = 0
	
	toggle.border = {}
	toggle.border.size = 1
	
	toggle.divider = {}
	toggle.divider.size = 1
	
	toggle:SetBackgroundColor(0, 0, 0, 0.4)
	--toggle.background:SetBackgroundColor(0, 1, 0, 1)
	
	toggle.text.on:SetText('ON')
	toggle.text.off:SetText('OFF')
	
	-- Refresh the button
	function toggle:Refresh()
		self.text.on:ResizeToText()
		self.text.off:ResizeToText()
		self.text.on.bg:SetWidth(50)
		self.text.on.bg:SetHeight(26)
		self.text.off.bg:SetWidth(50)
		self.text.off.bg:SetHeight(26)		
		self:SetWidth((self.text.on.bg:GetWidth() * 2) + (self.border.size * 2) + self.divider.size + (self.padding * 2))
		self:SetHeight((self.text.on.bg:GetHeight()) + (self.border.size * 2) + (self.padding * 2))
		
		self.background:SetPoint('TOPLEFT', self, 'TOPLEFT', self.border.size, self.border.size)
		self.background:SetPoint('BOTTOMRIGHT', self, 'BOTTOMRIGHT', -self.border.size, -self.border.size)
		self.text.on.bg:SetPoint('TOPLEFT', self.background, 'TOPLEFT', self.padding, self.padding)
		self.text.off.bg:SetPoint('TOPRIGHT', self.background, 'TOPRIGHT', -self.padding, self.padding)
		self.text.on:SetPoint('CENTER', self.text.on.bg, 'CENTER')
		self.text.off:SetPoint('CENTER', self.text.off.bg, 'CENTER')
	end
	
	function toggle:Toggle(newstate)
		if newstate == nil then
			newstate = self.state
		end
		
		local on = true
		if newstate == true then
			on = true
		elseif newstate == false then
			on = false
		end
		
		if on then
			self.text.on.bg:SetBackgroundColor(0,0.8,0,0.8)
			self.text.off.bg:SetBackgroundColor(0.3,0,0,0.8)
		else
			self.text.on.bg:SetBackgroundColor(0,0.3,0,0.8)
			self.text.off.bg:SetBackgroundColor(0.8,0,0,0.8)
		end
		
		self.state = newstate
		
		self:Refresh()
	end
	
	function toggle.text.on.bg.Event:LeftDown()
		toggle:Toggle(true)
	end
	
	function toggle.text.off.bg.Event:LeftDown()
		toggle:Toggle(false)
	end
	
	function toggle:GetValue()
		return self.state
	end
	
	toggle:Toggle(toggle.state)
	
	return toggle
end