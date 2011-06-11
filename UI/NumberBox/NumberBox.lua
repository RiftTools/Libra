-- Libra.UI.NumberBox

local Libra = LibStub:GetLibrary('Libra-alpha', true)
if not Libra then return end

local MAJOR = "Libra-alpha.UI.NumberBox"
local MINOR = 1

local NumberBox = LibStub:NewLibrary(MAJOR, MINOR)
if not NumberBox then return end

local context = UI.CreateContext("Context")

Libra.UI.NumberBox = NumberBox

function Libra.UI.NumberBox:Create(owner)
	local box = {}
	if owner then
		box = Libra.UI.FrameManager:Create('Frame', owner)
	else
		box = Libra.UI.FrameManager:Create('Frame', context)
	end	
	
	box.background = Libra.UI.FrameManager:Create('Texture', box)
	box:SetWidth(139)
	box:SetHeight(40)
	
	
	box.text_background = Libra.UI.FrameManager:Create('Texture', box.background)
	box.text_background:SetBackgroundColor(0.2,0.2,0.2,0.9)	
	box.text_background:SetWidth(45)
	
	box.text = Libra.UI.FrameManager:Create('Text', box.text_background)	
	box.text:SetFontSize(16)
	
	box.bt_1up = Libra.UI.FrameManager:Create('Texture', box.background)
	box.bt_10up = Libra.UI.FrameManager:Create('Texture', box.background)
	box.bt_100up = Libra.UI.FrameManager:Create('Texture', box.background)
	box.bt_1down = Libra.UI.FrameManager:Create('Texture', box.background)
	box.bt_10down = Libra.UI.FrameManager:Create('Texture', box.background)
	box.bt_100down = Libra.UI.FrameManager:Create('Texture', box.background)
	
	box.bt_1up:SetBackgroundColor(0,0,0,0.4)
	box.bt_10up:SetBackgroundColor(0,0,0,0.4)
	box.bt_100up:SetBackgroundColor(0,0,0,0.4)
	box.bt_1down:SetBackgroundColor(0,0,0,0.4)
	box.bt_10down:SetBackgroundColor(0,0,0,0.4)
	box.bt_100down:SetBackgroundColor(0,0,0,0.4)
	
	box.bt_1up:SetWidth(28)
	box.bt_10up:SetWidth(28)
	box.bt_100up:SetWidth(28)
	box.bt_1down:SetWidth(28)
	box.bt_10down:SetWidth(28)
	box.bt_100down:SetWidth(28)
	
	box.bt_1up:SetHeight(16)
	box.bt_10up:SetHeight(16)
	box.bt_100up:SetHeight(16)
	box.bt_1down:SetHeight(16)
	box.bt_10down:SetHeight(16)
	box.bt_100down:SetHeight(16)

	box.padding = 1
	
	box.border = {}
	box.border.size = 2
	
	box:SetBackgroundColor(0, 0, 0, 0.4)
	box.background:SetBackgroundColor(0.2, 0.2, 0.2, 0.9)
	
	box.background:SetPoint('TOPLEFT', box, 'TOPLEFT', box.border.size, box.border.size)
	box.background:SetPoint('BOTTOMRIGHT', box, 'BOTTOMRIGHT', -box.border.size, -box.border.size)
	box.text_background:SetPoint('TOPLEFT', box, 'TOPLEFT', box.padding + box.border.size, box.padding + box.border.size)
	box.text_background:SetPoint('BOTTOMLEFT', box, 'BOTTOMLEFT', box.padding + box.border.size, -(box.padding + box.border.size))
	
	box.bt_1up:SetPoint('TOPLEFT', box.text_background, 'TOPRIGHT', box.padding + 1, 0)
	box.bt_1down:SetPoint('TOPLEFT', box.bt_1up, 'BOTTOMLEFT', 0, box.padding + 1)
	
	box.bt_10up:SetPoint('TOPLEFT', box.bt_1up, 'TOPRIGHT', box.padding, 0)
	box.bt_10down:SetPoint('TOPLEFT', box.bt_10up, 'BOTTOMLEFT', 0, 2)
	
	box.bt_100up:SetPoint('TOPLEFT', box.bt_10up, 'TOPRIGHT', box.padding, 0)
	box.bt_100down:SetPoint('TOPLEFT', box.bt_100up, 'BOTTOMLEFT', 0, 2)
	
	box.bt_1up.text = Libra.UI.FrameManager:Create('Text', box.bt_1up)
	box.bt_10up.text = Libra.UI.FrameManager:Create('Text', box.bt_10up)
	box.bt_100up.text = Libra.UI.FrameManager:Create('Text', box.bt_100up)
	box.bt_1down.text = Libra.UI.FrameManager:Create('Text', box.bt_1down)
	box.bt_10down.text = Libra.UI.FrameManager:Create('Text', box.bt_10down)
	box.bt_100down.text = Libra.UI.FrameManager:Create('Text', box.bt_100down)	
	
	box.bt_1up.text:SetText('+1')
	box.bt_10up.text:SetText('+10')
	box.bt_100up.text:SetText('+100')
	box.bt_1down.text:SetText('-1')
	box.bt_10down.text:SetText('-10')
	box.bt_100down.text:SetText('-100')
	
	box.bt_1up.text:SetFontSize(11)
	box.bt_10up.text:SetFontSize(10)
	box.bt_100up.text:SetFontSize(9)
	box.bt_1down.text:SetFontSize(11)
	box.bt_10down.text:SetFontSize(10)
	box.bt_100down.text:SetFontSize(9)
	
		
	box.bt_1up.text:ResizeToText()
	box.bt_10up.text:ResizeToText()
	box.bt_100up.text:ResizeToText()
	box.bt_1down.text:ResizeToText()
	box.bt_10down.text:ResizeToText()
	box.bt_100down.text:ResizeToText()
	
	box.bt_1up.text:SetPoint('CENTER', box.bt_1up, 'CENTER')
	box.bt_10up.text:SetPoint('CENTER', box.bt_10up, 'CENTER')
	box.bt_100up.text:SetPoint('CENTER', box.bt_100up, 'CENTER')
	box.bt_1down.text:SetPoint('CENTER', box.bt_1down, 'CENTER')
	box.bt_10down.text:SetPoint('CENTER', box.bt_10down, 'CENTER')
	box.bt_100down.text:SetPoint('CENTER', box.bt_100down, 'CENTER')
	
	function box.bt_1up.Event:LeftDown()
		box:SetValue(box.value + 1)
	end
	function box.bt_10up.Event:LeftDown()
		box:SetValue(box.value + 10)
	end
	function box.bt_100up.Event:LeftDown()
		box:SetValue(box.value + 100)
	end
	function box.bt_1down.Event:LeftDown()
		box:SetValue(box.value - 1)
	end
	function box.bt_10down.Event:LeftDown()
		box:SetValue(box.value - 10)
	end
	function box.bt_100down.Event:LeftDown()
		box:SetValue(box.value - 100)
	end
	
	-- Other Init stuff
	box.value = false

	-- Refresh the box
	function box:Refresh()
		box.text:SetPoint('CENTER', box.text_background, 'CENTER')	
	end
	
	-- Set the box value
	function box:SetValue(newvalue)
		if newvalue > 9999 then
			newvalue = 9999
		elseif newvalue < -9999 then
			newvalue = -9999
		end
	
		self.value = newvalue
		self.text:SetText(tostring(newvalue))
		self.text:ResizeToText()
		self:Refresh()
	end
	
	-- Get the box value
	function box:GetValue()
		return self.value
	end
	
	box:SetValue(0)
	
	return box
end