-- Libra.UI.Mover

local Libra = LibStub:GetLibrary('Libra-alpha', true)
if not Libra then return end

local MAJOR = "Libra-alpha.UI.Mover"
local MINOR = 1

local Mover = LibStub:NewLibrary(MAJOR, MINOR)
if not Mover then return end

local context = UI.CreateContext("Context")

Libra.UI.Mover = Mover
  
-- Creater for Mover
-- @params a table which should contain ["windowToMove"]

function Libra.UI.Mover:Create(params)
  local moverWindow = Libra.UI.FrameManager:Create('Libra.UI.Window', context)
  
  moverWindow:Resize(200,200)
  moverWindow:SetCenter()
  
  -- The button to move the window right
  local leftButton = Libra.UI.Button:Create(moverWindow) 
  leftButton:SetText("left")
  
  local upButton = Libra.UI.Button:Create(moverWindow)
  upButton:SetText("up")
  
  local rightButton = Libra.UI.Button:Create(moverWindow)  
  rightButton:SetText("right")
    
  local downButton = Libra.UI.Button:Create(moverWindow)
  downButton:SetText("down")
    
  return moverWindow
end