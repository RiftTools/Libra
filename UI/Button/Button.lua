-- Libra.UI.Button

local Libra = LibStub:GetLibrary('Libra-alpha', true)
if not Libra then return end

local MAJOR = "Libra-alpha.UI.Button"
local MINOR = 1

local Button = LibStub:NewLibrary(MAJOR, MINOR)
if not Button then return end

local context = UI.CreateContext("Context")

Libra.UI.Button = Button

function Libra.UI.Button:Create(owner)
	local button = {}
	if owner then
		button  = Libra.UI.FrameManager:Create('Libra.UI.Button: Button', owner)
	else
		button  = Libra.UI.FrameManager:Create('Libra.UI.Button: Button', context)
	end	
	button.background = Libra.UI.FrameManager:Create('Texture', button)
	button.text       = Libra.UI.FrameManager:Create('Text', button.background)
	--button.text:SetBackgroundColor(0,1,0,1)
	button.text:SetFontSize(16)
	
	button.vpadding = 4
	button.hpadding = 12
	
	button.border = {}
	button.border.size = 1
	
	button:SetBackgroundColor(0, 0, 0, 0.4)
	button.background:SetBackgroundColor(0.2, 0.2, 0.2, 0.9)
	
	-- Refresh the button
	function button:Refresh()
		self.text:ResizeToText()
		self:SetWidth(self.text:GetFullWidth() + (button.hpadding * 2))
		self:SetHeight(self.text:GetFullHeight() + (button.vpadding * 2))
		self.background:SetPoint('TOPLEFT', self, 'TOPLEFT', self.border.size, self.border.size)
		self.background:SetPoint('BOTTOMRIGHT', self, 'BOTTOMRIGHT', -self.border.size, -self.border.size)
		self.text:SetPoint('TOPLEFT', self, 'TOPLEFT', self.hpadding, self.vpadding)
		self.text:SetPoint('BOTTOMRIGHT', self, 'BOTTOMRIGHT', -self.hpadding, -self.vpadding)	
	end
	
	--
	-- Set the button text
	--
	function button:SetText(newtext)
		self.text:SetText(newtext)
		self:Refresh()
	end
	
	-- Set the button font size
	function button:SetFontSize(newsize)
		self.text:SetFontSize(newsize)
		self.text:ResizeToText()
		self:Refresh()
	end
	
	button.text:SetText('Button')
	
	return button
end