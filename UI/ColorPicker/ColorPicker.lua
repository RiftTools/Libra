-- Libra.UI.ColorPicker

local Libra = LibStub:GetLibrary('Libra-alpha', true)
if not Libra then return end

local MAJOR = "Libra-alpha.UI.ColorPicker"
local MINOR = 1

local ColorPicker = LibStub:NewLibrary(MAJOR, MINOR)
if not ColorPicker then return end

local context = UI.CreateContext("Context")

Libra.UI.ColorPicker = ColorPicker

function Libra.UI.ColorPicker:Create(owner)
	local frame = {}
	
	if owner then
		frame  = Libra.UI.FrameManager:Create('Libra.UI.ColorPicker: Frame', owner)
	else
		frame  = Libra.UI.FrameManager:Create('Libra.UI.ColorPicker: Frame', context)
	end	
	
	
	
	frame:SetBackgroundColor(0,0,0,0.4)
	
	frame.picker = Libra.UI.SmartGrid:Create(frame)
	picker = frame.picker
	

	-- Build the preview
	frame.preview = Libra.UI.FrameManager:Create('Frame', frame)
	frame.preview:SetHeight( 40 )
	frame.preview:SetWidth( 40 )
	
	frame:SetWidth( (picker.border.size * 2) + frame.preview:GetWidth() )
	frame:SetHeight( frame.preview:GetHeight() + (picker.border.size * 2) )
	
	frame.preview:SetPoint('TOPLEFT', frame, 'TOPLEFT', picker.border.size, picker.border.size)
	
	picker.border = {}
	picker.border.size = 4
	
	picker.value = {}
	picker.value.r = 1
	picker.value.g = 1
	picker.value.b = 1
	picker.value.a = 1
	picker:SetCellWidth(10)
	picker:SetCellHeight(10)
	picker.cell_spacing = 0
	
	-- Build Advanced options pane
	frame.adv_options = Libra.UI.FrameManager:Create('Frame', frame)
	frame.adv_options:SetBackgroundColor(0,0,0,0.4)
	frame.adv_options:SetLayer(500)
	
	frame.alpha = Libra.UI.NumberBox:Create(frame.adv_options)
	frame.red   = Libra.UI.NumberBox:Create(frame.adv_options)
	frame.green = Libra.UI.NumberBox:Create(frame.adv_options)
	frame.blue  = Libra.UI.NumberBox:Create(frame.adv_options)
	frame.alpha:SetValue(100)
	frame.red:SetValue(100)
	frame.green:SetValue(100)
	frame.blue:SetValue(100)
	
	frame.label = {}
	frame.label.alpha = Libra.UI.FrameManager:Create('Text', frame.adv_options)
	frame.label.red   = Libra.UI.FrameManager:Create('Text', frame.adv_options)
	frame.label.green = Libra.UI.FrameManager:Create('Text', frame.adv_options)
	frame.label.blue  = Libra.UI.FrameManager:Create('Text', frame.adv_options)
	frame.label.alpha:SetText('Alpha')
	frame.label.red:SetText('Red')
	frame.label.green:SetText('Green')
	frame.label.blue:SetText('Blue')
	frame.label.alpha:ResizeToText()
	frame.label.red:ResizeToText()
	frame.label.green:ResizeToText()
	frame.label.blue:ResizeToText()
	
	--frame.alpha:SetPoint('TOPRIGHT', frame, 'TOPRIGHT', -picker.border.size, picker.border.size)
	
	frame.alpha.min = 0
	frame.alpha.max = 100
	frame.red.min = 0
	frame.red.max = 100
	frame.green.min = 0
	frame.green.max = 100
	frame.blue.min = 0
	frame.blue.max = 100
	
	frame.mode = true -- true for adv mode, false otherwise
	frame.MODE_FASTPICKER = false
	frame.MODE_ADVANCED = true
	
	frame.preview:SetBackgroundColor(picker.value.r, picker.value.g, picker.value.b, picker.value.a)

	picker:SetBackgroundColor(0, 0, 0, 1)
	
	picker:SetBackgroundColor(0, 0, 0, 0.4)
	picker.background:SetBackgroundColor(0.2, 0.2, 0.2, 0.9)
	
	local x = 0	
	
	-- Reds
	for i = 0, 1.2, .2 do
		local new_color = Libra.UI.FrameManager:Create('Frame', picker.background)
		new_color:SetBackgroundColor(i, 0, 0, 1)		
		picker:AddCell(x, new_color)
		x = x + 1
	end
	for i = 0.2, 1.2, .2 do
		local new_color = Libra.UI.FrameManager:Create('Frame', picker.background)
		new_color:SetBackgroundColor(1, i, i, 1)
		picker:AddCell(x, new_color)
		x = x + 1
	end
	
	-- Oranges
	for i = 0, 1.2, .2 do
		local new_color = Libra.UI.FrameManager:Create('Frame', picker.background)
		new_color:SetBackgroundColor(i, i / 2, 0, 1)
		picker:AddCell(x, new_color)
		x = x + 1
	end
	for i = 0.2, 1.2, .2 do
		local new_color = Libra.UI.FrameManager:Create('Frame', picker.background)
		new_color:SetBackgroundColor(1, .5 + (i/2), i, 1)
		picker:AddCell(x, new_color)
		x = x + 1
	end
	
	-- Yellows
	for i = 0, 1.2, .2 do
		local new_color = Libra.UI.FrameManager:Create('Frame', picker.background)
		new_color:SetBackgroundColor(i, i * .94, 0, 1)
		picker:AddCell(x, new_color)
		x = x + 1
	end
	for i = 0.2, 1.2, .2 do
		local new_color = Libra.UI.FrameManager:Create('Frame', picker.background)
		new_color:SetBackgroundColor(1, 0.94 + (0.06 * i), i, 1)
		picker:AddCell(x, new_color)
		x = x + 1
	end
	
	-- Greens
	for i = 0, 1.2, .2 do
		local new_color = Libra.UI.FrameManager:Create('Frame', picker.background)
		new_color:SetBackgroundColor(0, i, 0, 1)
		picker:AddCell(x, new_color)
		x = x + 1
	end
	for i = 0.2, 1.2, .2 do
		local new_color = Libra.UI.FrameManager:Create('Frame', picker.background)
		new_color:SetBackgroundColor(i, 1, i, 1)
		picker:AddCell(x, new_color)
		x = x + 1
	end
	
	-- Blues
	for i = 0, 1.2, .2 do
		local new_color = Libra.UI.FrameManager:Create('Frame', picker.background)
		new_color:SetBackgroundColor(0, 0, i, 1)
		picker:AddCell(x, new_color)
		x = x + 1
	end
	for i = 0.2, 1.2, .2 do
		local new_color = Libra.UI.FrameManager:Create('Frame', picker.background)
		new_color:SetBackgroundColor(i, i, 1, 1)
		picker:AddCell(x, new_color)
		x = x + 1
	end
	
	-- Purples
	for i = 0, 1.2, .2 do
		local new_color = Libra.UI.FrameManager:Create('Frame', picker.background)
		new_color:SetBackgroundColor(i / 2, 0, i, 1)
		picker:AddCell(x, new_color)
		x = x + 1
	end
	for i = 0.2, 1.2, .2 do
		local new_color = Libra.UI.FrameManager:Create('Frame', picker.background)
		new_color:SetBackgroundColor(.5 + i / 2, i, 1, 1)
		picker:AddCell(x, new_color)
		x = x + 1
	end
	
	-- Pinks
	for i = 0, 1.2, .2 do
		local new_color = Libra.UI.FrameManager:Create('Frame', picker.background)
		new_color:SetBackgroundColor(i, 0, i, 1)
		picker:AddCell(x, new_color)
		x = x + 1
	end
	for i = 0.2, 1.2, .2 do
		local new_color = Libra.UI.FrameManager:Create('Frame', picker.background)
		new_color:SetBackgroundColor(1, i, 1, 1)
		picker:AddCell(x, new_color)
		x = x + 1
	end
	
	-- Greys
	for i = 0, 1, .1 do
		local new_color = Libra.UI.FrameManager:Create('Frame', picker.background)
		new_color:SetBackgroundColor(i, i, i, 1)
		picker:AddCell(x, new_color)
		x = x + 1
	end
	
	for k, v in pairs(picker.Cells) do
		function v.payload.Event:LeftDown()
			frame.preview:SetBackgroundColor(v.payload:GetBackgroundColor())
			picker.value.r, picker.value.g, picker.value.b, picker.value.a = v.payload:GetBackgroundColor()
			
			frame.alpha:SetValue(picker.value.a * 100)
			frame.red:SetValue(picker.value.r * 100)
			frame.green:SetValue(picker.value.g * 100)
			frame.blue:SetValue(picker.value.b * 100)
			
			picker:SetVisible(false)
			frame.adv_options:SetVisible(false)
		end
	end
	
	function frame.preview.Event:LeftDown()
		if frame.adv_options:GetVisible() or frame.picker:GetVisible() then
			picker:SetVisible(false)
			frame.adv_options:SetVisible(false)
		else
			frame:Refresh()
			frame.picker:SetPoint('TOPLEFT', frame, 'TOPLEFT', -picker:GetWidth(), 0)
			frame.adv_options:SetPoint('TOPLEFT', frame, 'TOPLEFT', -frame.adv_options:GetWidth(), 0)
			if frame.mode then
				frame.adv_options:SetVisible(true)
			else	
				frame.picker:SetVisible(true)
			end
		end
	end
	
	function frame:SetValue(r,g,b,a)
		picker.value.alpha = a
		picker.value.red = r
		picker.value.green = g
		picker.value.blue = b
		frame.alpha:SetValue(a * 100)
		frame.red:SetValue(r * 100)
		frame.green:SetValue(g * 100)
		frame.blue:SetValue(b * 100)
	end
	
	function frame:GetValue()
		return { r = picker.value.red, g = picker.value.green, b = picker.value.blue, a = picker.value.alpha }
	end
	
	function frame:SetMode(mode)
		if mode == true or mode == false then
			frame.mode = mode
		end
	end
	
	-- Refresh the picker
	function frame:Refresh()
		frame.adv_options:SetWidth( frame.alpha:GetWidth() + 50 + (picker.border.size * 2) )
		frame.adv_options:SetHeight( (frame.alpha:GetHeight() * 4) + (picker.border.size * 3) + (picker.border.size * 2) )
		
		frame.alpha:SetPoint('TOPRIGHT', frame.adv_options, 'TOPRIGHT', -frame.picker.border.size, frame.picker.border.size)
		frame.red:SetPoint('TOPRIGHT', frame.adv_options, 'TOPRIGHT', -frame.picker.border.size, (frame.picker.border.size * 2) + frame.red:GetHeight())
		frame.green:SetPoint('TOPRIGHT', frame.adv_options, 'TOPRIGHT', -frame.picker.border.size, (frame.picker.border.size * 3) + frame.red:GetHeight() + frame.green:GetHeight())
		frame.blue:SetPoint('TOPRIGHT', frame.adv_options, 'TOPRIGHT', -frame.picker.border.size, (frame.picker.border.size * 4) + frame.red:GetHeight() + frame.green:GetHeight() + frame.blue:GetHeight())		
		
		frame.label.alpha:SetPoint('TOPLEFT', frame.adv_options, 'TOPLEFT', frame.picker.border.size, frame.picker.border.size + ((frame.alpha:GetHeight() - frame.label.alpha:GetHeight()) / 2))
		frame.label.red:SetPoint('TOPLEFT', frame.adv_options, 'TOPLEFT', frame.picker.border.size, (frame.picker.border.size * 2) + frame.red:GetHeight() + ((frame.alpha:GetHeight() - frame.label.alpha:GetHeight()) / 2))
		frame.label.green:SetPoint('TOPLEFT', frame.adv_options, 'TOPLEFT', frame.picker.border.size, (frame.picker.border.size * 3) + frame.red:GetHeight() + frame.green:GetHeight() + ((frame.alpha:GetHeight() - frame.label.alpha:GetHeight()) / 2))
		frame.label.blue:SetPoint('TOPLEFT', frame.adv_options, 'TOPLEFT', frame.picker.border.size, (frame.picker.border.size * 4) + frame.red:GetHeight() + frame.green:GetHeight() + frame.blue:GetHeight() + ((frame.alpha:GetHeight() - frame.label.alpha:GetHeight()) / 2))	

		picker.value.alpha = frame.alpha:GetValue() / 100
		picker.value.red = frame.red:GetValue() / 100	
		picker.value.green = frame.green:GetValue() / 100	
		picker.value.blue = frame.blue:GetValue() / 100	
		
		--weird fix
		frame.preview:SetBackgroundColor(picker.value.red + 0.000000000001, picker.value.green + 0.000000000001, picker.value.blue + 0.000000000001, picker.value.alpha + 0.000000000001)
		
		--frame.picker:Refresh()	
	end
	
	table.insert(frame.alpha.OnChange, frame.Refresh)
	table.insert(frame.red.OnChange, frame.Refresh)
	table.insert(frame.green.OnChange, frame.Refresh)
	table.insert(frame.blue.OnChange, frame.Refresh)

	
	picker:SetGridCols(11)
	picker:Refresh()
	picker:SetVisible(false)
	frame.adv_options:SetVisible(false)
	
	return frame
end
