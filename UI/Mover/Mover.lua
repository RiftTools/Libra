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
-- @param associatedWindow Libra.UI.Window the window this mover should associate with
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
  
  -- The 
  moverWindow:Resize(200,200)
  moverWindow:SetToCenter()
  
  ----------------------------------
  -- The buttons to move the window 
  ----------------------------------
  local upButton = Libra.UI.Button:Create(moverWindowContentFrame)
  upButton:SetText("up")
  upButton:SetPoint("TOPCENTER",moverWindowContentFrame, "TOPCENTER")
  upButton:SetLayer(11)
  function upButton.Event:LeftUp()
     print(print(string.format("moving %s up",associatedWindow.title:GetText())
     associatedWindow:MoveRelative(0,-10)
   end
  
  local leftButton = Libra.UI.Button:Create(moverWindowContentFrame) 
  leftButton:SetText("left")
  leftButton:SetPoint("TOPRIGHT",upButton, "BOTTOMLEFT",-1,1)
  leftButton:SetLayer(11)
  function leftButton.Event:LeftUp()
    print(print(string.format("moving %s left",associatedWindow.title:GetText())
    associatedWindow:MoveRelative(-10,0)
  end
  
  local rightButton = Libra.UI.Button:Create(moverWindowContentFrame)  
  rightButton:SetText("right")
  rightButton:SetPoint("TOPLEFT",upButton, "BOTTOMRIGHT",1,1)
  rightButton:SetLayer(1)
  function rightButton.Event:LeftUp()
    print(print(string.format("moving %s right",associatedWindow.title:GetText())
    associatedWindow:MoveRelative(10,0)
  end
  
  local downButton = Libra.UI.Button:Create(moverWindowContentFrame)
  downButton:SetText("down")
  downButton:SetPoint("TOPCENTER",upButton, "BOTTOMCENTER",1,rightButton:GetHeight()+2)
  downButton:SetLayer(11)
  function downButton.Event:LeftUp()
     print(print(string.format("moving %s down",associatedWindow.title:GetText())
     associatedWindow:MoveRelative(0,10)
  end       
  
  --------------------------------------------
  -- The NumberBoxes for the current position
  --------------------------------------------  
  
  local xNumbBox = Libra.UI.NumberBox:Create(moverWindowContentFrame)
  xNumbBox:SetValue(associatedWindow:GetLeft())
  xNumbBox:SetPoint("TOPCENTER",leftButton, "BOTTOMCENTER",0,downButton:GetHeight()+5)
  
  local yNumbBox = Libra.UI.NumberBox:Create(moverWindow)
  yNumbBox:SetValue(associatedWindow:GetTop())
  yNumbBox:SetPoint("TOPCENTER",rightButton, "BOTTOMCENTER",0,downButton:GetHeight()+5)

  -- now add the contentFrame with all the buttons
  -- and numberboxes to the moverWindow
  moverWindow:SetContent(moverWindowContentFrame)
  
  return moverWindow
end