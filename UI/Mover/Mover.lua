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
-- @associatedWindow Libra.UI.Window the window this mover should associate with

function Libra.UI.Mover:Create(associatedWindow)
  
  local params = {
    ["titletext"]="Mover Window for: "..associatedWindow.title:GetText(), 
    ["size"]={["height"]=100,
    ["width"]=200},
    ["movable"]=false}
  local moverWindow = Libra.UI.Window:Create(params)
  local moverWindowContentFrame = Libra.UI.FrameManager:Create("mover Content Frame", moverWindow)
  moverWindow:SetLayer(associatedWindow:GetLayer()+1)
  moverWindowContentFrame:SetLayer(moverWindow:GetLayer()+1)
  
  moverWindow:Resize(200,200)
  moverWindow:SetToCenter()
  
  -- The buttons to move the window
  local upButton = Libra.UI.Button:Create(moverWindow)
  upButton:SetText("up")
  upButton:SetPoint("TOPCENTER",moverWindowContentFrame, "TOPCENTER")
  upButton:SetLayer(11)
  
  local leftButton = Libra.UI.Button:Create(moverWindow) 
  leftButton:SetText("left")
  leftButton:SetPoint("TOPRIGHT",upButton, "BOTTOMLEFT",-1,1)
  leftButton:SetLayer(11)
  
  local rightButton = Libra.UI.Button:Create(moverWindow)  
  rightButton:SetText("right")
  rightButton:SetPoint("TOPLEFT",upButton, "BOTTOMRIGHT",1,1)
  rightButton:SetLayer(1)
  
  local downButton = Libra.UI.Button:Create(moverWindow)
  downButton:SetText("down")
  downButton:SetPoint("TOPCENTER",upButton, "BOTTOMCENTER",1,rightButton:GetHeight()+2)
  downButton:SetLayer(11)       
  
  -- The NumberBoxes for the current position
  
  
  moverWindow:SetContent(moverWindowContentFrame)
  
  function upButton.Event:LeftUp()
    print("I move my associated window up")
    associatedWindow:MoveRelative(0,-10)
  end
  function leftButton.Event:LeftUp()
    print("I move my associated window left")
    associatedWindow:MoveRelative(-10,0)
  end
  function rightButton.Event:LeftUp()
    print("I move my associated window right")
    associatedWindow:MoveRelative(10,0)
  end
  function downButton.Event:LeftUp()
    print("I move my associated window down")
    associatedWindow:MoveRelative(0,10)
  end     
  
  return moverWindow
end