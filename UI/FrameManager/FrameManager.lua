-- Libra:Frame Manager
-- --------------------------------------------------------------------
-- Rift is currently unable to remove frames.
--   FrameManager provides a method of recycling frames before
--   creating new frames.

local Libra = LibStub:GetLibrary('Libra-alpha', true)
if not Libra then return end

local MAJOR = "Libra-alpha.UI.FrameManager"
local MINOR = 1

local FrameManager = LibStub:NewLibrary(MAJOR, MINOR)
if not FrameManager then return end

local context = UI.CreateContext("Context")

Libra.UI.FrameManager = FrameManager

Libra.UI.FrameManager.frames = {}
Libra.UI.FrameManager.free_frames = {}

-- Rift is currently unable to remove frames. As such, FrameManager provides
-- a method of recycling frames before creating new frames.
--
-- @param     String   type    A type name for the frame [Default: generic]
-- @param     UI.Frame parent  Parent ui element                          
-- @returns   Object   frame   Returns a UI.Frame object
function Libra.UI.FrameManager:Create(frame_type, parent)
	local frame, old_frame
	
	-- Set a default type
	if not frame_type or frame_type == '' then
		frame_type = 'generic' 
	end
	
	-- If we have some frames laying around, assign one
	local type_frames = self:GetFreeByType(frame_type)
	if type_frames then
		old_frame = table.remove(type_frames)
	end		
	if old_frame then
		frame = old_frame
		frame:SetParent(parent)
	else
		if frame_type == 'Frame' then
			frame = UI.CreateFrame('Frame', "Libra.FrameManager Frame", parent)
		elseif frame_type == 'Text' then
			frame = UI.CreateFrame('Text', "Libra.FrameManager Text", parent)
		elseif frame_type == 'Texture' then
			frame = UI.CreateFrame('Texture', "Libra.FrameManager Texture", parent)
		else
			frame = UI.CreateFrame('Frame', "Libra.FrameManager Frame", parent)
		end
		frame.type = frame_type
	end
	
	table.insert(self:GetFramesByType(frame_type), frame)
	
	return frame
end

--
-- Returns a frame/object to the pool
--
-- @param    UI.Frame   frame_type   The frame to be recycled
function Libra.UI.FrameManager:Recycle(frame)
	if frame.type then
		for k, v in pairs(self:GetFramesByType(frame.type)) do
			if v == frame then
				local tmp_frame = table.remove(self:GetFramesByType(frame.type), k)
				table.insert(self:GetFreeByType(frame.type), tmp_frame)
			end
		end
	end
end

--
-- Returns the list of free frames of this frame type
--
-- @param    string   frame_type   The frame type requested
-- @returns  table                 Table of free frames
function Libra.UI.FrameManager:GetFreeByType(frame_type)
	local result = false
	for k, v in pairs(self.free_frames) do
		if v.type then
			if v.type == frame_type then
				result = v
				break
			end
		end
	end
	
	if not result then
		result = {}
		result.type = frame_type
		table.insert(self.frames, result)
	end
	
	return result
end

--
-- Returns the list of in-use frames of this frame type
--
-- @param    string   frame_type   The frame type requested
-- @returns  table                 Table of in-use frames
function Libra.UI.FrameManager:GetFramesByType(frame_type)
	local result = false
	for k, v in pairs(self.frames) do
		if v.type then
			if v.type == frame_type then
				result = v
				break
			end
		end
	end
	
	if not result then
		result = {}
		result.type = frame_type
		table.insert(self.frames, result)
	end
	
	return result
end