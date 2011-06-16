-- Libra.Ui.SmartGrid

local Libra = LibStub:GetLibrary('Libra-alpha', true)
if not Libra then return end

local MAJOR = "Libra-alpha.UI.SmartGrid"
local MINOR = 1

local SmartGrid = LibStub:NewLibrary(MAJOR, MINOR)
if not SmartGrid then return end

Libra.UI.SmartGrid = SmartGrid

local context = UI.CreateContext("Context")

--
-- Create a new countdown Timer
--
-- @param   int   duration      Timer duration in seconds
-- @returns Libra.UI.SmartGrid   Newly created SmartGrid object
function Libra.UI.SmartGrid:Create(context)
	local grid = Libra.UI.FrameManager:Create('Libra.UI.SmartGrid', context)
	grid:SetBackgroundColor(0,0,0,0.4)
	
	grid.Entries = {}
	
	grid.border = {}
	grid.border.size = 3
	
	grid.background = Libra.UI.FrameManager:Create('Frame', grid)
	grid.background:SetBackgroundColor(0.2,0.2,0.2,0.9)
	
	grid.max = 30
	grid.min = 0
	
	grid.rows = false
	grid.cols = false
	
	grid.Cells = {}	
	grid.cell_count = 0
	grid.cell_width = 24
	grid.cell_height = 24
	grid.cell_spacing = 1
	
	function grid:AddCell(id, payload)
		for k, v in pairs(self.Cells) do
			if v.id == id then
				return false
			end
		end
		
		local new_cell = {
			frame = Libra.UI.FrameManager:Create('Libra.UI.SmartGrid: Cell', self),
			payload = payload,
			id = id
		}
		
		new_cell.frame:SetParent(self.background)
	
		--new_cell.payload:SetParent(new_cell.frame)
		new_cell.payload:SetAllPoints(new_cell.frame)
				
		grid.Cells[id] = new_cell
		
		self.cell_count = self.cell_count + 1
		
		--new_cell.frame:SetVisible(false)
		
		self:Refresh()
	end
	
	function grid:GetCell(id)
		local result = false
		for k, v in pairs(self.Cells) do
			if v.id == id then
				result = v
			end
		end
		return result
	end
	
	function grid:RemoveCell(id)
		if self.Cells[id] then
			if v.frame then
				v.frame:SetVisible(false)
				Libra.UI.FrameManager:Recycle(v.frame)
				v.frame = nil
			end
			if v.payload then
				Libra.UI.FrameManager:Recycle(v.payload)
				v.payload = nil
			end		
			
			self.cell_count = self.cell_count - 1
			self.Cells[id] = nil
		end
	end
	
	function grid:SetCellHeight(value)
		self.cell_height = value
	end
	
	function grid:SetCellWidth(value)
		self.cell_width = value
	end
	
	function grid:SetGridRows(value)
		self.rows = value
		self.cols = false
	end
	
	function grid:SetGridCols(value)
		self.cols = value
		self.rows = false
	end
	
	function grid:Refresh()
		local cols, rows = 0, 0
		
		self.background:SetPoint('TOPLEFT', self, 'TOPLEFT', self.border.size, self.border.size)
		self.background:SetPoint('BOTTOMRIGHT', self, 'BOTTOMRIGHT', -self.border.size, -self.border.size)
	
		-- Calc rows & cols				
		if not self.rows and not self.cols then
			cols = self.cell_count
			rows = 1
		end
		
		if self.cols then
			if self.cell_count < self.cols then
				cols = self.cell_count
			else
				cols = self.cols
			end
			rows = math.ceil(self.cell_count / cols)
		end
		
		if self.rows then
			if self.cell_count < self.rows then
				rows = self.cell_count
			else
				rows = self.rows
			end
			cols = math.ceil(self.cell_count / rows)
		end
	
		-- Calc width/height before borders and padding
		local width = (cols * self.cell_width)
		local height = (rows * self.cell_height)
		
		-- Calc borders
		width = width + (self.border.size * 2)
		height = height + (self.border.size * 2)
		
		-- Calc padding
		width = width + (self.cell_spacing * (cols - 1))
		height = height + (self.cell_spacing * (rows - 1))
		
		-- Set the final dimensions
		self:SetWidth(math.floor(width))
		self:SetHeight(math.floor(height))
		
		-- Set all the cell frame sizes
		local rowi, coli = 1, 1
		for k, v in pairs(self.Cells) do
			v.frame:SetHeight(self.cell_height)
			v.frame:SetWidth(self.cell_width)
			
			local xoffset = self.border.size + (self.cell_spacing * (coli - 1)) + (self.cell_width * (coli - 1))
			local yoffset = self.border.size + (self.cell_spacing * (rowi - 1)) + (self.cell_height * (rowi - 1))
			v.frame:SetPoint('TOPLEFT', self, 'TOPLEFT', math.floor(xoffset), math.floor(yoffset))

			v.payload:SetVisible(true)
			
			--print('**********************************')
			--print('COLI: ' .. coli)
			--print('ROWI: ' .. rowi)
			--print('XOFFSET: ' .. xoffset)
			--print('YOFFSET: ' .. yoffset)
			--print('**********************************')
			
			coli = coli + 1
			
			if coli > cols then
				coli = 1
				rowi = rowi + 1
			end
			
		end
		
		--[[print('==================================')
		print('==================================')
		print('==================================')
		print(' TOTAL CELLS: ' .. self.cell_count)
		print(' FRAME WIDTH: ' .. width)
		print('FRAME HEIGHT: ' .. height)
		print(' CELL HEIGHT: ' .. self.cell_height)
		print('  CELL WIDTH: ' .. self.cell_width)
		print('        ROWS: ' .. tostring(self.rows))
		print('        COLS: ' .. tostring(self.cols))
		print('   REAL ROWS: ' .. rows)
		print('   REAL COLS: ' .. cols)
		print('==================================')
		print('==================================')
		print('==================================')]]
		
	end
	
	return grid	
end
