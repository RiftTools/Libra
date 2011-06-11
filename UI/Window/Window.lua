-- Libra.UI.Button

local Libra = LibStub:GetLibrary('Libra-alpha', true)
if not Libra then return end

local MAJOR = "Libra-alpha.UI.Window"
local MINOR = 1

local Window = LibStub:NewLibrary(MAJOR, MINOR)
if not Window then return end

local context = UI.CreateContext("Context")

Libra.UI.Window = Window

function Libra.UI.Window:Create(params)
	local window = Libra.UI.FrameManager:Create('Libra.UI.Window: Frame', context)
	
    -----------------------
    -- Build the Window
    -----------------------
	window:SetBackgroundColor(0, 0, 0, 0)
	window:SetPoint("TOPLEFT", UIParent, "TOPLEFT")
    
    -- Build the background
    window.background = Libra.UI.FrameManager:Create('Texture', window)
    window.background:SetPoint("TOPLEFT", window, "TOPLEFT")
    window.background:SetPoint("BOTTOMRIGHT", window, "BOTTOMRIGHT")
    window.background:SetBackgroundColor(0, 0, 0, 0)
    window.background:SetLayer(-1)
        
	-- Build the title bar
	window.title = Libra.UI.FrameManager:Create('Text', window)
    window.title:SetText(".") 
    window.title:SetFontSize(14)
    window.title:SetHeight(window.title:GetFullHeight())
    window.title:SetBackgroundColor(0.2, 0.2, 0.2, 0.9)
    window.title.isVisible = true;
    
    window.title.background = Libra.UI.FrameManager:Create('Texture', window)
    window.title.background:SetLayer(-1)

    -- Shows or hides the title bar
    --
    -- @param   bool   show   True/False title flag
    function window:ShowTitle(show)
    	if show then
    		self.title.isVisible = true
    		self.title:SetVisible(true)
    		self.controlbox.close:SetVisible(true)
    		self.content:SetPoint("TOPLEFT", window.title, "BOTTOMLEFT") 		
    	else
    		self.title.isVisible = false
    		self.title:SetVisible(false)
    		self.controlbox.close:SetVisible(false)
    		self.content:SetPoint('TOPLEFT', self.border.topleft, 'BOTTOMRIGHT')   		
    	end    	
    end
    
    -- Build the control box
    window.controlbox = {}
    window.controlbox.close = UI.CreateFrame("Texture", "Libra.UI.Window: Control Box [Close]", window);
    window.controlbox.close:SetPoint('TOPLEFT', window.title, 'TOPRIGHT')
    window.controlbox.close:SetTexture('Libra', 'close.tga')
    window.controlbox.close:SetWidth(window.title:GetFullHeight())
    window.controlbox.close:SetHeight(window.title:GetFullHeight())
    
    -- Build the border
    window.border = {}
    window.border.size         = 5
    window.border.color = {}
    window.border.color.r        = 0
    window.border.color.g        = 0
    window.border.color.b        = 0
    window.border.color.a        = 0.4
    window.border.topleft      = Libra.UI.FrameManager:Create('Texture', window)
    window.border.topcenter    = Libra.UI.FrameManager:Create('Texture', window)
    window.border.topright     = Libra.UI.FrameManager:Create('Texture', window)
    window.border.midleft      = Libra.UI.FrameManager:Create('Texture', window)
    window.border.midright     = Libra.UI.FrameManager:Create('Texture', window)
    window.border.bottomleft   = Libra.UI.FrameManager:Create('Texture', window)
    window.border.bottomcenter = Libra.UI.FrameManager:Create('Texture', window)
    window.border.bottomright  = Libra.UI.FrameManager:Create('Texture', window)
    
    window:SetHeight(window.title:GetFullHeight() + (window.border.size * 2))
    
    window.title:SetPoint("TOPLEFT", window.border.topleft, "BOTTOMRIGHT")    
    window.controlbox.close:SetPoint('TOPRIGHT', window.border.topright, 'BOTTOMLEFT')
    
    window.border.topleft:SetPoint("TOPLEFT", window, "TOPLEFT")
    window.border.topcenter:SetPoint("TOPLEFT", window.border.topleft, "TOPRIGHT")
    window.border.topright:SetPoint("TOPRIGHT", window, "TOPRIGHT")
    window.border.topcenter:SetPoint("BOTTOMRIGHT", window.border.topright, "BOTTOMLEFT")    
    window.border.midleft:SetPoint("TOPLEFT", window.border.topleft, "BOTTOMLEFT")
    window.border.midleft:SetPoint("BOTTOMRIGHT", window.border.bottomleft, "TOPRIGHT")
    window.border.midright:SetPoint("TOPLEFT", window.border.topright, "BOTTOMLEFT")
    window.border.midright:SetPoint("BOTTOMRIGHT", window.border.bottomright, "TOPRIGHT")
    window.border.bottomleft:SetPoint("BOTTOMLEFT", window, "BOTTOMLEFT")
    window.border.bottomright:SetPoint("BOTTOMRIGHT", window, "BOTTOMRIGHT")
    window.border.bottomcenter:SetPoint("TOPLEFT", window.border.bottomleft, "TOPRIGHT")
    window.border.bottomcenter:SetPoint("BOTTOMRIGHT", window.border.bottomright, "BOTTOMLEFT")
    
    window.title.background:SetPoint('BOTTOMLEFT', window.title, 'BOTTOMLEFT')
    window.title.background:SetPoint('TOPRIGHT', window.border.topright, 'BOTTOMLEFT')
    
    -- Build the content area
    window.content = UI.CreateFrame("Texture", "Libra.UI.Window: Content Frame", window);
    window.content.padding = 10
    --window.content:SetTexture('Libra', 'Media/bg.jpg')
    window.content:SetPoint("TOPLEFT", window.title, "BOTTOMLEFT")
    window.content:SetPoint("BOTTOMRIGHT", window.border.bottomcenter, "TOPRIGHT")
    window.content:SetBackgroundColor(0.1, 0.1, 0.1, 0.95)
    
    --------------------------
    -- Apply Object Structure
    --------------------------

    -- Resizes the Window, maintaining structural spacing
    --
    -- @param   int   height   Desired height for the window
    -- @param   int   height   Desired width for the window
    function window:Resize(height, width)
    	if height then
    		if height < 0 then
    			height = self.title:GetFullHeight() + (self.border.size * 2)
    		else
    			height = height + self.title:GetFullHeight() + (self.border.size * 2)
    		end
    		self:SetHeight(height)
    	end
    	if width then
    		self.title:SetWidth(width - (self.border.size * 2) - self.title:GetFullHeight())
    		self:SetWidth(width)
    	end
    end
    
    -- Sets the Window title bar text
    --
    -- @param   String   title   Text to be set as the window title
    function window:SetTitle(newtitle)
    	self.title:SetText(' ' .. newtitle)
    	self.title:SetHeight(window.title:GetFullHeight())
    end
    
    -- Applys content to the window
    --
    --
    function window:SetContent(newcontent)
    	newcontent:SetParent(self.content)
    	newcontent:SetPoint('TOPLEFT', self.content, 'TOPLEFT', self.content.padding, self.content.padding)
    	newcontent:SetPoint('TOPRIGHT', self.content, 'TOPRIGHT', -self.content.padding, self.content.padding)
    end

    -- Sets the Window's border size
    --
    -- @param   int   size   Border size in pixels
    function window:SetBorderSize(size)
    	self.border.topleft:SetWidth(size)
    	self.border.topleft:SetHeight(size)
    	self.border.topright:SetWidth(size)
    	self.border.topright:SetHeight(size)
    	self.border.bottomleft:SetWidth(size)
    	self.border.bottomleft:SetHeight(size)
    	self.border.bottomcenter:SetHeight(size)
    	self.border.bottomright:SetWidth(size)
    	self.border.bottomright:SetHeight(size)
    end

    -- Sets the Window's border size
    --
    -- @param   String   color   Border color hex [0xFF000000] = Black Full Alpha
    function window:SetBorderColor(r, g, b, a)
    	self.border.topleft:SetBackgroundColor(r, g, b, a)
    	self.border.topcenter:SetBackgroundColor(r, g, b, a)
    	self.border.topright:SetBackgroundColor(r, g, b, a)
    	self.border.midright:SetBackgroundColor(r, g, b, a)
    	self.border.midleft:SetBackgroundColor(r, g, b, a)
    	self.border.bottomleft:SetBackgroundColor(r, g, b, a)
    	self.border.bottomcenter:SetBackgroundColor(r, g, b, a)
    	self.border.bottomright:SetBackgroundColor(r, g, b, a)
    end
        
    --------------------------------------
    -- Apply any required event bindings
    --------------------------------------
    
    -- Bind control box close clicks
    function window.controlbox.close.Event:LeftDown()
    	window:SetVisible(false)
    end
    
    --------------------------------------
    -- Show/Hide/Destroy Methods
    --------------------------------------
    function window:Show()
    	window:SetVisible(true)
    end
    
    function window:Hide()
    	window:SetVisible(false)
    end
    
    function window:Destroy()
    	window:SetVisible(false) -- TODO: enable frame recycling
    end
        
    --------------------------------------
    -- Finalize initial settings
    --------------------------------------
    window:SetBorderSize(window.border.size)
    window:SetBorderColor(window.border.color.r, window.border.color.g, window.border.color.b, window.border.color.a)
    window:Resize(0, window.title:GetFullWidth())
    
    window:SetVisible(false)
    
    return window
end