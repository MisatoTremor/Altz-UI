﻿local T, C, L, G = unpack(select(2, ...))
local F = unpack(Aurora)

--====================================================--
--[[                -- Functions --                    ]]--
--====================================================--

local function ColorGradient(perc, ...)-- http://www.wowwiki.com/ColorGradient
    if (perc > 1) then
        local r, g, b = select(select('#', ...) - 2, ...) return r, g, b
    elseif (perc < 0) then
        local r, g, b = ... return r, g, b
    end

    local num = select('#', ...) / 3

    local segment, relperc = math.modf(perc*(num-1))
    local r1, g1, b1, r2, g2, b2 = select((segment*3)+1, ...)

    return r1 + (r2-r1)*relperc, g1 + (g2-g1)*relperc, b1 + (b2-b1)*relperc
end

local function CreateInfoButton(name, parent, t, width, height, justify)
	local Button = CreateFrame("Frame", G.uiname..parent:GetName()..name, parent)
	Button:SetSize(width, height)
	
	Button.text = T.createtext(Button, "OVERLAY", 12, "OUTLINE", justify)
	Button.text:SetPoint("CENTER")

	tinsert(t, Button)
	return Button
end

local function Skinbar(bar)
	if aCoreCDB["OtherOptions"]["style"] == 1 then
		bar.tex = bar:CreateTexture(nil, "ARTWORK")
		bar.tex:SetAllPoints()
		bar.tex:SetTexture(G.media.blank)
		bar.tex:SetGradient("VERTICAL", G.Ccolor.r, G.Ccolor.g, G.Ccolor.b, G.Ccolor.r/3, G.Ccolor.g/3, G.Ccolor.b/3)
		F.CreateSD(bar, 2, 0, 0, 0, 1, -1)
	else
		bar.tex = bar:CreateTexture(nil, "ARTWORK")
		bar.tex:SetAllPoints()
		bar.tex:SetTexture(G.media.ufbar)
		bar.tex:SetVertexColor(G.Ccolor.r, G.Ccolor.g, G.Ccolor.b)
		F.CreateSD(bar, 2, 0, 0, 0, 1, -1)
	end
end

local function Skinbg(bar)
	if aCoreCDB["OtherOptions"]["style"] ~= 1 then
		bar.tex = bar:CreateTexture(nil, "ARTWORK")
		bar.tex:SetAllPoints()
		bar.tex:SetTexture(G.media.blank)
		bar.tex:SetGradientAlpha("VERTICAL", .2,.2,.2,.15,.25,.25,.25,.6)
		F.CreateBD(bar, 1)
		F.CreateSD(bar, 2, 0, 0, 0, 1, -1)	
	end
end
--====================================================--
--[[                -- Shadow --                    ]]--
--====================================================--	
local PShadow = CreateFrame("Frame", G.uiname.."Backgroud Shadow", UIParent)
PShadow:SetFrameStrata("BACKGROUND")
PShadow:SetAllPoints()
PShadow:SetBackdrop({bgFile = "Interface\\AddOns\\AltzUI\\media\\shadow"})
PShadow:SetBackdropColor(0, 0, 0, 0.3)

--====================================================--
--[[                 -- Panels --                   ]]--
--====================================================--
toppanel = CreateFrame("Frame", G.uiname.."Top Long Panel", UIParent)
toppanel:SetFrameStrata("BACKGROUND")
toppanel:SetPoint("TOP", 0, 3)
toppanel:SetPoint("LEFT", UIParent, "LEFT", -8, 0)
toppanel:SetPoint("RIGHT", UIParent, "RIGHT", 8, 0)
toppanel:SetHeight(15)
toppanel.border = F.CreateBDFrame(toppanel, 0.6)
F.CreateSD(toppanel.border, 2, 0, 0, 0, 1, -1)

bottompanel = CreateFrame("Frame", G.uiname.."Bottom Long Panel", UIParent)
bottompanel:SetFrameStrata("BACKGROUND")
bottompanel:SetPoint("BOTTOM", 0, -3)
bottompanel:SetPoint("LEFT", UIParent, "LEFT", -8, 0)
bottompanel:SetPoint("RIGHT", UIParent, "RIGHT", 8, 0)
bottompanel:SetHeight(15)
bottompanel.border = F.CreateBDFrame(bottompanel, 0.6)
F.CreateSD(bottompanel.border, 2, 0, 0, 0, 1, -1)

local TLPanel = CreateFrame("Frame", G.uiname.."TLPanel", UIParent)
TLPanel:SetFrameStrata("BACKGROUND")
TLPanel:SetFrameLevel(2)
TLPanel:SetSize(G.screenwidth*2/9, 5)
TLPanel:SetPoint("TOPLEFT", UIParent, "TOPLEFT", 15, -10)
Skinbar(TLPanel)

local TRPanel = CreateFrame("Frame", G.uiname.."TRPanel", UIParent)
TRPanel:SetFrameStrata("BACKGROUND")
TRPanel:SetFrameLevel(2)
TRPanel:SetSize(G.screenwidth*2/9, 5)
TRPanel:SetPoint("TOPRIGHT", UIParent, "TOPRIGHT", -15, -10)
Skinbar(TRPanel)

local BLPanel = CreateFrame("Frame", G.uiname.."BLPanel", UIParent)
BLPanel:SetFrameStrata("BACKGROUND")
BLPanel:SetFrameLevel(2)
BLPanel:SetSize(G.screenwidth*2/9, 5)
BLPanel:SetPoint("BOTTOMLEFT", UIParent, "BOTTOMLEFT", 15, 10)
Skinbar(BLPanel)

local BRPanel = CreateFrame("Frame", G.uiname.."BRPanel", UIParent)
BRPanel:SetFrameStrata("BACKGROUND")
BRPanel:SetFrameLevel(2)
BRPanel:SetSize(G.screenwidth*2/9, 5)
BRPanel:SetPoint("BOTTOMRIGHT", UIParent, "BOTTOMRIGHT", -15, 10)
Skinbar(BRPanel)

--====================================================--
--[[                   -- Minimap --                ]]--
--====================================================--
local minimap_height = aCoreCDB["OtherOptions"]["minimapheight"]

-- 收缩和伸展的按钮
local minimap_pullback = CreateFrame("Frame", G.uiname.."minimap_pullback", UIParent) 
minimap_pullback:SetWidth(8)
minimap_pullback:SetHeight(minimap_height)
minimap_pullback:SetFrameStrata("BACKGROUND")
minimap_pullback:SetFrameLevel(5)
minimap_pullback.movingname = L["小地图缩放按钮"]
minimap_pullback.point = {
	healer = {a1 = "BOTTOMRIGHT", parent = "UIParent", a2 = "BOTTOMRIGHT", x = -5, y = 48},
	dpser = {a1 = "BOTTOMRIGHT", parent = "UIParent", a2 = "BOTTOMRIGHT", x = -5, y = 48},
}
minimap_pullback:SetPoint("BOTTOMRIGHT", UIParent, "BOTTOMRIGHT", -10, 40)
T.CreateDragFrame(minimap_pullback)
minimap_pullback.border = F.CreateBDFrame(minimap_pullback, 0.6)
F.CreateSD(minimap_pullback.border, 2, 0, 0, 0, 1, -1)

minimap_pullback:SetAlpha(.2)
minimap_pullback:HookScript("OnEnter", function(self) T.UIFrameFadeIn(self, .5, self:GetAlpha(), 1) end)
minimap_pullback:SetScript("OnLeave", function(self) T.UIFrameFadeOut(self, .5, self:GetAlpha(), 0.2) end)

local minimap_anchor = CreateFrame("Frame", nil, UIParent)
minimap_anchor:SetPoint("BOTTOMRIGHT", minimap_pullback, "BOTTOMLEFT", -5, 0)
minimap_anchor:SetWidth(minimap_height)
minimap_anchor:SetHeight(minimap_height)
minimap_anchor:SetFrameStrata("BACKGROUND")
minimap_anchor.border = F.CreateBDFrame(minimap_anchor, 0.6)
F.CreateSD(minimap_anchor.border, 2, 0, 0, 0, 1, -1)

Minimap:SetParent(minimap_anchor)
Minimap:SetPoint("CENTER")
Minimap:SetSize(minimap_height, minimap_height)
Minimap:SetFrameLevel(1)
Minimap:SetMaskTexture("Interface\\Buttons\\WHITE8x8")

local nowwidth, allwidth, all
local Updater = CreateFrame("Frame")
Updater.mode = "OUT"
Updater:Hide()

Updater:SetScript("OnUpdate",function(self,elapsed)
	if self.mode == "OUT" then
		if nowwidth < allwidth then
			nowwidth = nowwidth+allwidth/(all/0.2)/3
			minimap_anchor:SetPoint("BOTTOMRIGHT", minimap_pullback, "BOTTOMLEFT", nowwidth, 0)
		else
			minimap_anchor:SetPoint("BOTTOMRIGHT", minimap_pullback, "BOTTOMLEFT", allwidth, 0)
			minimap_pullback.border:SetBackdropColor(G.Ccolor.r, G.Ccolor.g, G.Ccolor.b)
			Updater:Hide()
			Updater.mode = "IN"
			Minimap:Hide()
		end
	elseif self.mode == "IN" then
		if nowwidth >0 then
			nowwidth = nowwidth-allwidth/(all/0.2)/3
			minimap_anchor:SetPoint("BOTTOMRIGHT", minimap_pullback, "BOTTOMLEFT", nowwidth, 0);	
		else
			minimap_anchor:SetPoint("BOTTOMRIGHT", minimap_pullback, "BOTTOMLEFT", -5, 0)
			minimap_pullback.border:SetBackdropColor(0, 0, 0, .6)
			Updater:Hide()
			Updater.mode = "OUT"
		end		
	end
end)

minimap_pullback:SetScript("OnMouseDown",function(self)
	if Updater.mode == "OUT" then
		nowwidth, allwidth, all = 0, minimap_height, 1
		T.UIFrameFadeOut(minimap_anchor, 1, minimap_anchor:GetAlpha(), 0)
		T.UIFrameFadeOut(Minimap, 1, Minimap:GetAlpha(), 0)
	elseif Updater.mode == "IN" then
		Minimap:Show()
		nowwidth, allwidth, all = minimap_height, minimap_height, 1
		T.UIFrameFadeIn(minimap_anchor, 1, minimap_anchor:GetAlpha(), 1)
		T.UIFrameFadeIn(Minimap, 1, Minimap:GetAlpha(), 1)
	end
	Updater:Show()
end)

local chatframe_pullback = CreateFrame("Frame", G.uiname.."chatframe_pullback", UIParent) 
chatframe_pullback:SetWidth(8)
chatframe_pullback:SetHeight(minimap_height)
chatframe_pullback:SetFrameStrata("BACKGROUND")
chatframe_pullback:SetFrameLevel(3)
chatframe_pullback.movingname = L["聊天框缩放按钮"]
chatframe_pullback.point = {
	healer = {a1 = "BOTTOMLEFT", parent = "UIParent", a2 = "BOTTOMLEFT", x = 10, y = 48},
	dpser = {a1 = "BOTTOMLEFT", parent = "UIParent", a2 = "BOTTOMLEFT", x = 10, y = 48},
}
chatframe_pullback:SetPoint("BOTTOMLEFT", UIParent, "BOTTOMLEFT", 10, 40)
T.CreateDragFrame(chatframe_pullback)
chatframe_pullback.border = F.CreateBDFrame(chatframe_pullback, 0.6)
F.CreateSD(chatframe_pullback.border, 2, 0, 0, 0, 1, -1)

chatframe_pullback:SetAlpha(.2)
chatframe_pullback:HookScript("OnEnter", function(self) T.UIFrameFadeIn(self, .5, self:GetAlpha(), 1) end)
chatframe_pullback:SetScript("OnLeave", function(self) T.UIFrameFadeOut(self, .5, self:GetAlpha(), 0.2) end)

local chatframe_anchor = CreateFrame("frame",nil,UIParent)
chatframe_anchor:SetPoint("BOTTOMLEFT", chatframe_pullback, "BOTTOMRIGHT", 5, 0)
chatframe_anchor:SetWidth(300)
chatframe_anchor:SetHeight(minimap_height)
chatframe_anchor:SetFrameStrata("BACKGROUND")

local cf = _G['ChatFrame1']
local dm = _G['GeneralDockManager']

--move chat
local MoveChat = function()
    FCF_SetLocked(cf, nil) 
    cf:ClearAllPoints()
    cf:SetPoint("BOTTOMLEFT", chatframe_anchor ,"BOTTOMLEFT", 3, 5)
    FCF_SavePositionAndDimensions(cf)
	FCF_SetLocked(cf, 1)
end

local nowwidth, allwidth, all
local Updater2 = CreateFrame("Frame")
Updater2.mode = "OUT"
Updater2:Hide()

Updater2:SetScript("OnUpdate",function(self,elapsed)
	if self.mode == "OUT" then
		if nowwidth > -375 then
			nowwidth = nowwidth-allwidth/(all/0.2)/4
			chatframe_anchor:SetPoint("BOTTOMLEFT", chatframe_pullback, "BOTTOMRIGHT", nowwidth, 0)
			MoveChat()
		else
			chatframe_anchor:SetPoint("BOTTOMLEFT", chatframe_pullback, "BOTTOMRIGHT", -375, 0)
			chatframe_pullback.border:SetBackdropColor(G.Ccolor.r, G.Ccolor.g, G.Ccolor.b)
			self:Hide()
			self.mode = "IN"
		end
	elseif self.mode == "IN" then
		if nowwidth <0 then
			nowwidth = nowwidth+allwidth/(all/0.2)/4
			chatframe_anchor:SetPoint("BOTTOMLEFT", chatframe_pullback, "BOTTOMRIGHT", nowwidth, 0)
			MoveChat()			
		else
			chatframe_anchor:SetPoint("BOTTOMLEFT", chatframe_pullback, "BOTTOMRIGHT", 5, 0)
			chatframe_pullback.border:SetBackdropColor(0, 0, 0, .6)			
			self:Hide()
			self.mode = "OUT"
		end		
	end
end)

chatframe_pullback:SetScript("OnMouseDown",function(self)
	if Updater2.mode == "OUT" then
		nowwidth, allwidth, all = 0, 375, 1
		T.UIFrameFadeOut(cf, 1, cf:GetAlpha(), 0)
		T.UIFrameFadeOut(dm, 1, dm:GetAlpha(), 0)
	elseif Updater2.mode == "IN" then
		nowwidth, allwidth, all = -375, 375, 1
		T.UIFrameFadeIn(cf, 1, cf:GetAlpha(), 1)
		T.UIFrameFadeIn(dm, 1, dm:GetAlpha(), 1)
	end
	Updater2:Show()
end)

for i = 1, NUM_CHAT_WINDOWS do
	_G['ChatFrame'..i..'EditBox']:HookScript("OnEditFocusGained", function(self)
		if Updater2.mode == "IN" then
			nowwidth, allwidth, all = -375, 375, 1
			T.UIFrameFadeIn(cf, 1, cf:GetAlpha(), 1)
			T.UIFrameFadeIn(dm, 1, dm:GetAlpha(), 1)
			Updater2:Show()
		end
	end)
end

-- 隐藏按钮
for _, hide in next,
	{MinimapBorder, MinimapBorderTop, MinimapZoomIn, MinimapZoomOut, MiniMapVoiceChatFrame, MiniMapTracking,  
	MiniMapWorldMapButton, MinimapBackdrop, MinimapCluster, GameTimeFrame, MiniMapInstanceDifficulty,} do
	hide:Hide()
end
MinimapNorthTag:SetAlpha(0)

-- 整合按钮
local buttons = {}
local BlackList = { 
	["MiniMapTracking"] = true,
	["MiniMapVoiceChatFrame"] = true,
	["MiniMapWorldMapButton"] = true,
	["MiniMapLFGFrame"] = true,
	["MinimapZoomIn"] = true,
	["MinimapZoomOut"] = true,
	["MiniMapMailFrame"] = true,
	["BattlefieldMinimap"] = true,
	["MinimapBackdrop"] = true,
	["GameTimeFrame"] = true,
	["TimeManagerClockButton"] = true,
	["FeedbackUIButton"] = true,
	["HelpOpenTicketButton"] = true,
	["MiniMapBattlefieldFrame"] = true,
	["QueueStatusMinimapButton"] = true,
	["MinimapButtonCollectFrame"] = true,
}

local MBCF = CreateFrame("Frame", "MinimapButtonCollectFrame", Minimap)
if aCoreCDB["OtherOptions"]["MBCFpos"] == "TOP" then
	MBCF:SetPoint("BOTTOMLEFT", Minimap, "TOPLEFT", 0, 5)
	MBCF:SetPoint("BOTTOMRIGHT", Minimap, "TOPRIGHT", 0, 5)
else
	MBCF:SetPoint("TOPLEFT", Minimap, "BOTTOMLEFT", 0, -5)
	MBCF:SetPoint("TOPRIGHT", Minimap, "BOTTOMRIGHT", 0, -5)
end
MBCF:SetHeight(20)
MBCF.bg = MBCF:CreateTexture(nil, "BACKGROUND")
MBCF.bg:SetTexture(G.media.blank)
MBCF.bg:SetAllPoints(MBCF)
MBCF.bg:SetGradientAlpha("HORIZONTAL", 0, 0, 0, .8, 0, 0, 0, 0)

T.CollectMinimapButtons = function(parent)
	if aCoreCDB["OtherOptions"]["collectminimapbuttons"] then
		for i, child in ipairs({Minimap:GetChildren()}) do
			if child:GetName() and not BlackList[child:GetName()] then
				if child:GetObjectType() == "Button" or strupper(child:GetName()):match("BUTTON") then
					if child:IsShown() or aCoreCDB["OtherOptions"]["collecthidingminimapbuttons"] then
						child:SetParent(parent)
						for j = 1, child:GetNumRegions() do
							local region = select(j, child:GetRegions())
							if region:GetObjectType() == "Texture" then
								local texture = region:GetTexture()
								if texture == "Interface\\CharacterFrame\\TempPortraitAlphaMask" or texture == "Interface\\Minimap\\MiniMap-TrackingBorder" or texture == "Interface\\Minimap\\UI-Minimap-Background" or texture == "Interface\\Minimap\\UI-Minimap-ZoomButton-Highlight" then
									region:Hide()
								end
							end
						end
						tinsert(buttons, child)
					end
				end
			end
		end
	end
	if #buttons == 0 then 
		parent:Hide() 
	else
		for _, child in ipairs(buttons) do
			child:HookScript("OnEnter", function()
				T.UIFrameFadeIn(parent, .5, parent:GetAlpha(), 1)
			end)
			child:HookScript("OnLeave", function()
				T.UIFrameFadeOut(parent, .5, parent:GetAlpha(), 0)
			end)
		end
	end
	for i =1, #buttons do
		buttons[i]:ClearAllPoints()
		if i == 1 then
			buttons[i]:SetPoint("LEFT", parent, "LEFT", 0, 0)
		else
			buttons[i]:SetPoint("LEFT", buttons[i-1], "RIGHT", 0, 0)
		end
		buttons[i].ClearAllPoints = T.dummy
		buttons[i].SetPoint = T.dummy
	end
end

MBCF:SetScript("OnEvent", function(self)
	T.CollectMinimapButtons(MBCF)
	self:SetAlpha(0)
	self:UnregisterEvent("PLAYER_ENTERING_WORLD")
end)

MBCF:RegisterEvent("PLAYER_ENTERING_WORLD")

MBCF:SetScript("OnEnter", function(self)
	T.UIFrameFadeIn(self, .5, self:GetAlpha(), 1)
end)

Minimap:HookScript("OnEnter", function()
	T.UIFrameFadeIn(MBCF, .5, MBCF:GetAlpha(), 1)
end)

MBCF:SetScript("OnLeave", function(self)
	T.UIFrameFadeOut(self, .5, self:GetAlpha(), 0)
end)

Minimap:HookScript("OnLeave", function()
	T.UIFrameFadeOut(MBCF, .5, MBCF:GetAlpha(), 0)
end)
	
-- 战网好友上线提示
--BNToastFrame:ClearAllPoints()
--BNToastFrame:SetPoint("BOTTOMLEFT", chatframe_pullback, "TOPLEFT", 0, 10)
--BNToastFrame:Show()
--BNToastFrame.Hide = BNToastFrame.Show
--BNToastFrame_UpdateAnchor = function() end

-- 排队的眼睛
QueueStatusMinimapButton:ClearAllPoints()
QueueStatusMinimapButton:SetParent(Minimap)
QueueStatusMinimapButton:SetPoint("BOTTOMRIGHT", Minimap, "BOTTOMRIGHT", 0, 0)
QueueStatusMinimapButtonBorder:Hide()
QueueStatusFrame:SetClampedToScreen(true)
QueueStatusFrame:ClearAllPoints()
QueueStatusFrame:SetPoint("TOPLEFT", Minimap, "TOPRIGHT", 9, -2)

-- 公会副本队伍
GuildInstanceDifficulty:ClearAllPoints()
GuildInstanceDifficulty:SetScale(.5)
GuildInstanceDifficulty:SetPoint("BOTTOMLEFT", Minimap, "BOTTOMLEFT", 2, 1)
GuildInstanceDifficulty:SetFrameStrata("HIGH")

-- 副本难度
local InstanceDifficulty = CreateFrame("Frame", nil, Minimap)
InstanceDifficulty:SetPoint("TOPLEFT", 8, -8)
InstanceDifficulty:SetSize(80, 20)

InstanceDifficulty.text = T.createtext(InstanceDifficulty, "OVERLAY", 12, "OUTLINE", "LEFT")
InstanceDifficulty.text:SetPoint"LEFT"
InstanceDifficulty.text:SetTextColor(G.Ccolor.r, G.Ccolor.g, G.Ccolor.b)

InstanceDifficulty:RegisterEvent("PLAYER_ENTERING_WORLD")
InstanceDifficulty:RegisterEvent("PLAYER_DIFFICULTY_CHANGED")
InstanceDifficulty:SetScript("OnEvent", function(self) self.text:SetText(select(4, GetInstanceInfo())) end)

-- 位置
MinimapZoneTextButton:SetParent(Minimap)
MinimapZoneTextButton:ClearAllPoints()
MinimapZoneTextButton:SetPoint("CENTER", 0, 20)
MinimapZoneTextButton:EnableMouse(false)
MinimapZoneTextButton:Hide()
MinimapZoneText:SetAllPoints(MinimapZoneTextButton)
MinimapZoneText:SetFont(G.norFont, 12, "OUTLINE") 
MinimapZoneText:SetShadowOffset(0, 0)
MinimapZoneText:SetJustifyH("CENTER")
Minimap:HookScript("OnEnter", function() MinimapZoneTextButton:Show() end)
Minimap:HookScript("OnLeave", function() MinimapZoneTextButton:Hide() end)

-- 新邮件图标
MiniMapMailFrame:SetParent(Minimap)
MiniMapMailFrame:ClearAllPoints()
MiniMapMailFrame:SetSize(16, 16)
MiniMapMailFrame:SetPoint("TOP", Minimap, "TOP", 0, -5)
MiniMapMailFrame:HookScript('OnEnter', function(self)
	GameTooltip:ClearAllPoints()
	GameTooltip:SetPoint("BOTTOM", MiniMapMailFrame, "TOP", 0, 5)
end)
MiniMapMailIcon:SetTexture('Interface\\Minimap\\TRACKING\\Mailbox')
MiniMapMailIcon:SetAllPoints(MiniMapMailFrame)
MiniMapMailBorder:Hide()

-- 时间
if not IsAddOnLoaded("Blizzard_TimeManager") then LoadAddOn("Blizzard_TimeManager") end
local clockFrame, clockTime = TimeManagerClockButton:GetRegions()
clockFrame:Hide()
clockTime:Hide()
TimeManagerClockButton:EnableMouse(false)

local clockframe = CreateFrame("Frame", G.uiname.."Clock", Minimap)
clockframe:SetPoint("BOTTOM", 0, 5)
clockframe:SetSize(40, 20)

clockframe.text = T.createtext(clockframe, "OVERLAY", 12, "OUTLINE", "CENTER")
clockframe.text:SetPoint("BOTTOM")

clockframe.t = 0
clockframe:SetScript("OnUpdate", function(self, e)
	self.t =  self.t + e
	if self.t > 5 then
		self.text:SetText(format("%s",date("%H:%M")))
		self.t = 0
	end
end)

clockframe:SetScript("OnMouseDown", function() ToggleCalendar() end)

-- 缩放小地图比例
Minimap:EnableMouseWheel(true)
Minimap:SetScript('OnMouseWheel', function(self, delta)
    if delta > 0 then
        MinimapZoomIn:Click()
    elseif delta < 0 then
        MinimapZoomOut:Click()
    end
end)

-- 右键打开追踪
Minimap:SetScript('OnMouseUp', function (self, button)
	if button == 'RightButton' then
		GameTooltip:Hide()
		ToggleDropDownMenu(1, nil, MiniMapTrackingDropDown, Minimap, (Minimap:GetWidth()+8), (Minimap:GetHeight()))
		DropDownList1:ClearAllPoints()
		if select(2, Minimap:GetCenter())/G.screenheight > .5 then -- In the upper part of the screen
			DropDownList1:SetPoint("TOPRIGHT", Minimap, "BOTTOMRIGHT", 0, -8)
		else
			DropDownList1:SetPoint("BOTTOMRIGHT", Minimap, "TOPRIGHT", 0, 8)
		end
	else
		Minimap_OnClick(self)
	end
end)

function GetMinimapShape() return 'SQUARE' end

-- 经验条
local xpbar = CreateFrame("StatusBar", G.uiname.."ExperienceBar", Minimap)
xpbar:SetWidth(5)
xpbar:SetOrientation("VERTICAL")
xpbar:SetStatusBarTexture(G.media.blank)
xpbar:SetStatusBarColor(.3, .4, 1)
xpbar:SetFrameLevel(Minimap:GetFrameLevel()+3)
xpbar:SetPoint("BOTTOMRIGHT", Minimap, "BOTTOMRIGHT", 0, 0)
xpbar:SetPoint("TOPRIGHT", Minimap, "TOPRIGHT", 0, 0)
xpbar.border = F.CreateBDFrame(xpbar, .8)

local function CommaValue(amount)
	local formatted = amount
	while true do  
		formatted, k = string.gsub(formatted, "^(-?%d+)(%d%d%d)", "%1,%2")
		if (k==0) then
			break
		end
	end
	return formatted
end

local _G = getfenv(0)
function xprptoolitp()
	GameTooltip:SetOwner(xpbar, "ANCHOR_NONE")
	GameTooltip:SetPoint("BOTTOMRIGHT", Minimap, "TOPRIGHT", -15, 10)
	
	local XP, maxXP = UnitXP("player"), UnitXPMax("player")
	local restXP = GetXPExhaustion()
	local name, rank, minRep, maxRep, value = GetWatchedFactionInfo()
	
	if UnitLevel("player") < MAX_PLAYER_LEVEL then
		GameTooltip:AddDoubleLine(L["当前经验"], string.format("%s/%s (%d%%)", CommaValue(XP), CommaValue(maxXP), (XP/maxXP)*100), G.Ccolor.r, G.Ccolor.g, G.Ccolor.b, 1, 1, 1)
		GameTooltip:AddDoubleLine(L["剩余经验"], string.format("%s", CommaValue(maxXP-XP)), G.Ccolor.r, G.Ccolor.g, G.Ccolor.b, 1, 1, 1)
		if restXP then GameTooltip:AddDoubleLine(L["双倍"], string.format("|cffb3e1ff%s (%d%%)", CommaValue(restXP), restXP/maxXP*100), G.Ccolor.r, G.Ccolor.g, G.Ccolor.b) end
	end
	
	if name and not UnitLevel("player") == MAX_PLAYER_LEVEL then
		GameTooltip:AddLine(" ")
	end

	if name then
		GameTooltip:AddLine(name.."  (".._G["FACTION_STANDING_LABEL"..rank]..")", G.Ccolor.r, G.Ccolor.g, G.Ccolor.b)
		GameTooltip:AddDoubleLine(L["声望"], string.format("%s/%s (%d%%)", CommaValue(value-minRep), CommaValue(maxRep-minRep), (value-minRep)/(maxRep-minRep)*100), G.Ccolor.r, G.Ccolor.g, G.Ccolor.b, 1, 1, 1)
		GameTooltip:AddDoubleLine(L["剩余声望"], string.format("%s", CommaValue(maxRep-value)), G.Ccolor.r, G.Ccolor.g, G.Ccolor.b, 1, 1, 1)
	end	
	
	GameTooltip:Show()
end

function xpbar:updateOnevent()
	local XP, maxXP = UnitXP("player"), UnitXPMax("player")
	local name, rank, minRep, maxRep, value = GetWatchedFactionInfo()
   	if UnitLevel("player") ~= MAX_PLAYER_LEVEL then
		xpbar:SetMinMaxValues(min(0, XP), maxXP)
		xpbar:SetValue(XP)
	else
		xpbar:SetMinMaxValues(minRep, maxRep)
		xpbar:SetValue(value)
	end
end

xpbar:SetScript("OnEnter", xprptoolitp)
xpbar:SetScript("OnLeave", function() GameTooltip:Hide() end)
xpbar:SetScript("OnEvent", xpbar.updateOnevent)

xpbar:RegisterEvent("PLAYER_XP_UPDATE")
xpbar:RegisterEvent("UPDATE_FACTION")
xpbar:RegisterEvent("PLAYER_LEVEL_UP")
xpbar:RegisterEvent("PLAYER_LOGIN")

-- 世界频道
local WorldChannelToggle = CreateFrame("Button", G.uiname.."World Channel Button", ChatFrame1)
WorldChannelToggle:SetPoint("TOPLEFT", -20, -5)
WorldChannelToggle:SetSize(25, 25)
WorldChannelToggle:SetNormalTexture("Interface\\HELPFRAME\\ReportLagIcon-Chat", "ADD")
WorldChannelToggle:GetNormalTexture():SetDesaturated(true)

WorldChannelToggle:SetScript("OnClick", function(self)
	local inchannel = false
	local channels = {GetChannelList()}
	for i = 1, #channels do
		if channels[i] == "大脚世界频道" then
			inchannel = true
			break
		end
	end
	if inchannel then
		LeaveChannelByName("大脚世界频道")
		print("|cffFF0000离开|r 大脚世界频道")  
	else
		JoinPermanentChannel("大脚世界频道",nil,1)
		ChatFrame_AddChannel(ChatFrame1,"大脚世界频道")
		ChatFrame_RemoveMessageGroup(ChatFrame1,"CHANNEL")
		print("|cff7FFF00加入|r 大脚世界频道")
	end
end)

WorldChannelToggle:SetScript("OnEvent", function(self, event)
	local channels = {GetChannelList()}
	WorldChannelToggle:GetNormalTexture():SetVertexColor(.3, 1, 1)
	for i = 1, #channels do
		if channels[i] == "大脚世界频道" then
			WorldChannelToggle:GetNormalTexture():SetVertexColor(1, 0, 0)
			break
		end
	end
	
	if event == "PLAYER_ENTERING_WORLD" then
		self:UnregisterEvent("PLAYER_ENTERING_WORLD")
	end
end)

WorldChannelToggle:RegisterEvent("PLAYER_ENTERING_WORLD")
WorldChannelToggle:RegisterEvent("CHANNEL_UI_UPDATE")

if G.Client == "zhCN" then WorldChannelToggle:Show() else WorldChannelToggle:Hide() end

--====================================================--
--[[                --  Info Bar --              ]]--
--====================================================--
local InfoFrame = CreateFrame("Frame", G.uiname.."Info Frame", UIParent)
InfoFrame:SetScale(aCoreCDB["OtherOptions"]["infobarscale"])
InfoFrame:SetFrameLevel(4)
InfoFrame:SetSize(160, 20)
InfoFrame:SetPoint("BOTTOM", 0, 5)

local InfoButtons = {}

-- 延迟和帧数
local Net_Stats = CreateInfoButton("Net_Stats", InfoFrame, InfoButtons, 80, 20, "RIGHT")

Net_Stats:SetScript("OnMouseDown", function()
	local AddonManager = _G[G.uiname.."AddonManager"]
	if AddonManager:IsShown() then
		AddonManager:Hide()
	else
		AddonManager:Show()
	end
end)

-- Format String
local memFormat = function(num)
	if num > 1024 then
		return format("%.2f mb", (num / 1024))
	else
		return format("%.1f kb", floor(num))
	end
end

Net_Stats.t = 0
Net_Stats:SetScript("OnUpdate", function(self, elapsed)
	self.t = self.t + elapsed
	if self.t > 1 then -- 每秒刷新一次
		fps = format("%d"..G.classcolor.."fps|r", GetFramerate())
		lag = format("%d"..G.classcolor.."ms|r", select(3, GetNetStats()))	
		self.text:SetText(fps.."  "..lag)
		self.t = 0
	end
end)

Net_Stats:SetScript("OnEnter", function(self) 
	local addons, total, nr, name = {}, 0, 0
	local memory, entry
	local BlizzMem = collectgarbage("count")
			
	GameTooltip:SetOwner(self, "ANCHOR_NONE")
	GameTooltip:SetPoint("BOTTOM", InfoFrame, "TOP", 0, 5)
	GameTooltip:AddLine(format(L["占用前 %d 的插件"], 20), G.Ccolor.r, G.Ccolor.g, G.Ccolor.b)
	GameTooltip:AddLine(" ")	
	
	UpdateAddOnMemoryUsage()
	for i = 1, GetNumAddOns() do
		if (GetAddOnMemoryUsage(i) > 0 ) then
			memory = GetAddOnMemoryUsage(i)
			entry = {name = GetAddOnInfo(i), memory = memory}
			table.insert(addons, entry)
			total = total + memory
		end
	end
	table.sort(addons, function(a, b) return a.memory > b.memory end)
	for _, entry in pairs(addons) do
	if nr < 20 then
			GameTooltip:AddDoubleLine(entry.name, memFormat(entry.memory), 1, 1, 1, ColorGradient(entry.memory / 1024, 0, 1, 0, 1, 1, 0, 1, 0, 0))
			nr = nr+1
		end
	end

	GameTooltip:AddLine(" ")
	GameTooltip:AddDoubleLine(L["自定义插件占用"], memFormat(total), 1, 1, 1, ColorGradient(total / (1024*20), 0, 1, 0, 1, 1, 0, 1, 0, 0))
	GameTooltip:AddDoubleLine(L["所有插件占用"], memFormat(BlizzMem), 1, 1, 1, ColorGradient(BlizzMem / (1024*50) , 0, 1, 0, 1, 1, 0, 1, 0, 0))
	GameTooltip:Show()
end)
Net_Stats:SetScript("OnLeave", function(self) GameTooltip:Hide() end)

Net_Stats:SetScript("OnEvent", function(self, event)
	T.LoadAddonManagerWindow()
end)
Net_Stats:RegisterEvent("PLAYER_LOGIN")

-- 耐久
local Durability = CreateInfoButton("Durability", InfoFrame, InfoButtons, 40, 20, "CENTER")

local SLOTS = {}
for _,slot in pairs({"Head", "Shoulder", "Chest", "Waist", "Legs", "Feet", "Wrist", "Hands", "MainHand", "SecondaryHand"}) do 
	SLOTS[slot] = GetInventorySlotInfo(slot .. "Slot")
end

Durability:SetScript("OnMouseDown", function() ToggleCharacter("PaperDollFrame") end)

Durability:SetScript("OnEvent", function(self, event)
	if event == "PLAYER_ENTERING_WORLD" then
		self:UnregisterEvent("PLAYER_ENTERING_WORLD")
	end
	local l = 1
	for slot,id in pairs(SLOTS) do
		local d, md = GetInventoryItemDurability(id)
		if d and md and md ~= 0 then
			l = math.min(d/md, l)
		end
	end
	self.text:SetText(format("%d"..G.classcolor.."dur|r", l*100))
end)

Durability:RegisterEvent("UPDATE_INVENTORY_DURABILITY")
Durability:RegisterEvent("PLAYER_ENTERING_WORLD")

-- 天赋
local Talent = CreateInfoButton("Talent", InfoFrame, InfoButtons, 40, 20, "LEFT")

local LootSpecMenu = CreateFrame("Frame", G.uiname.."LootSpecMenu", UIParent, "UIDropDownMenuTemplate")

local SpecList = {
	{ text = TALENTS_BUTTON, func = function() ToggleTalentFrame() end},
	{ text = SELECT_LOOT_SPECIALIZATION, hasArrow = 1,
		menuList = {
			{ text = LOOT_SPECIALIZATION_DEFAULT, specializationID = 0 },
			{ text = "spec1", specializationID = 0 },
			{ text = "spec2", specializationID = 0 },
			{ text = "spec3", specializationID = 0 },
			{ text = "spec4", specializationID = 0 },	
		}
	},
	{ text = L["切天赋"], func = function() 		
			local c = GetActiveSpecGroup(false,false)
			SetActiveSpecGroup(c == 1 and 2 or 1) 
		end
	},
}

local numspec = 4
if G.myClass ~= "DRUID" then
	tremove(SpecList[2]["menuList"], 5)
	numspec = 3
end

Talent:SetScript("OnMouseDown", function(self, button)
	if GetSpecialization() then
		EasyMenu(SpecList, LootSpecMenu, "cursor", 0, 0, "MENU", 2)
		DropDownList1:ClearAllPoints()
		DropDownList1:SetPoint("BOTTOMLEFT", self, "TOPLEFT", -5, 5)
	end
end)

Talent:SetScript("OnEvent", function(self, event)
	if event == "PLAYER_ENTERING_WORLD" then
		self:RegisterEvent("PLAYER_LOOT_SPEC_UPDATED")
		self:RegisterEvent("ACTIVE_TALENT_GROUP_CHANGED")
		self:UnregisterEvent("PLAYER_ENTERING_WORLD")
	end
	
	local specIndex = GetSpecialization()
	
	if specIndex then
		local specID, specName = GetSpecializationInfo(specIndex)
		
		self.text:SetText(format(G.classcolor.."%s|r", specName))
		
		local specPopupButton = SpecList[2]["menuList"][1]
		
		if specName then
			specPopupButton.text = format(LOOT_SPECIALIZATION_DEFAULT, specName)
			specPopupButton.func = function(self) SetLootSpecialization(0) end
			if GetLootSpecialization() == specPopupButton.specializationID then
				specPopupButton.checked = true
			else
				specPopupButton.checked = false
			end
		end

		for index = 2, numspec+1 do
			specPopupButton = SpecList[2]["menuList"][index]
			if specPopupButton then
				local id, name = GetSpecializationInfo(index-1)
				specPopupButton.specializationID = id
				specPopupButton.text = name
				specPopupButton.func = function(self) SetLootSpecialization(id) end
				if GetLootSpecialization() == specPopupButton.specializationID then
					specPopupButton.checked = true
				else
					specPopupButton.checked = false
				end
			end
		end	
	else
		self.text:SetText(G.classcolor.."No Talents|r")
	end
end)

Talent:RegisterEvent("PLAYER_ENTERING_WORLD")

for i = 1, #InfoButtons do
	if i == 1 then
		InfoButtons[i]:SetPoint("LEFT", InfoFrame, "LEFT")
	else
		InfoButtons[i]:SetPoint("LEFT", InfoButtons[i-1], "RIGHT", 0, 0)
	end
end

--====================================================--
--[[                  -- Micromenu --               ]]--
--====================================================--
local MicromenuBar = CreateFrame("Frame", G.uiname.."MicromenuBar", UIParent)
MicromenuBar:SetScale(aCoreCDB["OtherOptions"]["micromenuscale"])
MicromenuBar:SetFrameLevel(4)
MicromenuBar:SetSize(460, 20)
MicromenuBar:SetPoint("TOP", 0, -5)
Skinbg(MicromenuBar)

local MicromenuButtons = {}

local function CreateMicromenuButton(text, original)
	local Button = CreateFrame("Button", nil, MicromenuBar)
	Button:SetFrameLevel(5)
	Button:SetPushedTextOffset(1, -1)
	Button:SetSize(30, 22)
	
	Button.text = T.createtext(Button, "OVERLAY", 12, "OUTLINE", "CENTER")
	Button.text:SetText(text)
	Button.text:SetPoint("CENTER")
	
	Button.highlight = Button:CreateTexture(nil, "HIGHLIGHT")
	Button.highlight:SetPoint("TOPLEFT", -13, -1)
	Button.highlight:SetPoint("BOTTOMRIGHT", 11, -1)
	Button.highlight:SetVertexColor(G.Ccolor.r, G.Ccolor.g, G.Ccolor.b, .7)
	Button.highlight:SetTexture(G.media.buttonhighlight)
	Button.highlight:SetBlendMode("ADD")
	
	Button.highlight2 = Button:CreateTexture(nil, "HIGHLIGHT")
	Button.highlight2:SetPoint("TOPLEFT", Button, "BOTTOMLEFT", -15, 1)
	Button.highlight2:SetPoint("TOPRIGHT", Button, "BOTTOMRIGHT", 12, 1)
	Button.highlight2:SetHeight(20)
	Button.highlight2:SetVertexColor(G.Ccolor.r, G.Ccolor.g, G.Ccolor.b, .6)
	Button.highlight2:SetTexture(G.media.barhightlight)
	Button.highlight2:SetBlendMode("ADD")
	
	Button:SetScript("OnClick", function()
		if original == "RaidTool" then
			if _G[G.uiname.."RaidToolFrame"]:IsShown() then
				_G[G.uiname.."RaidToolFrame"]:Hide()
			else
				_G[G.uiname.."RaidToolFrame"]:Show()
			end
		elseif original == "Charcter" then
			ToggleCharacter("PaperDollFrame")
		elseif original == "System" then
			if GameMenuFrame:IsShown() then
				HideUIPanel(GameMenuFrame)
			else
				ShowUIPanel(GameMenuFrame)
			end
		elseif original == "Friends" then
			ToggleFriendsFrame(1)
		elseif original == "Guild" then
			if IsInGuild() then 
				if not GuildFrame then LoadAddOn("Blizzard_GuildUI") end 
				GuildFrame_Toggle()
				GuildFrame_TabClicked(GuildFrameTab2)
			else 
				if not LookingForGuildFrame then LoadAddOn("Blizzard_LookingForGuildUI") end 
				LookingForGuildFrame_Toggle() 
			end
		elseif original == "SpellbookMicroButton" then
			ToggleSpellBook("spell")			
		elseif original == "AchievementMicroButton" then	
			ToggleAchievementFrame()
		elseif original == "QuestLogMicroButton" then
			ToggleFrame(QuestLogFrame)
		elseif original == "PVPMicroButton" then
			if not PVPUIFrame then PVP_LoadUI() end 
			ToggleFrame(PVPUIFrame)
		elseif original == "LFDMicroButton" then
			PVEFrame_ToggleFrame("GroupFinderFrame", LFDParentFrame)
		elseif original == "CompanionsMicroButton" then
			if not IsAddOnLoaded("Blizzard_PetJournal") then LoadAddOn("Blizzard_PetJournal") end 
			ToggleFrame(PetJournalParent)
		elseif original == "EJMicroButton" then
			if not IsAddOnLoaded("Blizzard_EncounterJournal") then LoadAddOn("Blizzard_EncounterJournal") end 
			ToggleFrame(EncounterJournal)
		elseif original == "Bag" then
			if GameMenuFrame:IsShown() then
				HideUIPanel(GameMenuFrame)
			end
			ToggleAllBags()		
		end
	end)
	
	tinsert(MicromenuButtons, Button)
	return Button
end

MicromenuBar.Charcter = CreateMicromenuButton(L["角色"], "Charcter")
MicromenuBar.RaidTool = CreateMicromenuButton(L["团队"], "RaidTool")
MicromenuBar.Friends = CreateMicromenuButton(L["好友"], "Friends")
MicromenuBar.Guild = CreateMicromenuButton(L["公会"], "Guild")
MicromenuBar.Achievement = CreateMicromenuButton(L["成就"], "AchievementMicroButton")
MicromenuBar.EJ = CreateMicromenuButton(L["手册"], "EJMicroButton")
MicromenuBar.System = CreateMicromenuButton(G.classcolor.."AltzUI "..G.Version.."|r", "System")
MicromenuBar.System:SetSize(80, 25)
MicromenuBar.Pet = CreateMicromenuButton(L["宠物"], "CompanionsMicroButton")
MicromenuBar.PvP = CreateMicromenuButton(L["PVP"], "PVPMicroButton")
MicromenuBar.LFR = CreateMicromenuButton(L["LFG"], "LFDMicroButton")
MicromenuBar.Quests = CreateMicromenuButton(L["任务"], "QuestLogMicroButton")
MicromenuBar.Spellbook = CreateMicromenuButton(L["法术"], "SpellbookMicroButton")
MicromenuBar.Bag = CreateMicromenuButton(L["行囊"], "Bag")

for i = 1, #MicromenuButtons do
	if i == 1 then
		MicromenuButtons[i]:SetPoint("LEFT", MicromenuBar, "LEFT", 12, 0)
	else
		MicromenuButtons[i]:SetPoint("LEFT", MicromenuButtons[i-1], "RIGHT", 0, 0)
	end
end

local function OnHover(button)
	button.text:SetTextColor(G.Ccolor.r, G.Ccolor.g, G.Ccolor.b)
end

local function OnLeave(button)
	button.text:SetTextColor(1, 1, 1)
end

local function UpdateFade(frame, children, dbvalue)
	if aCoreCDB["OtherOptions"][dbvalue] then
		frame:SetAlpha(0)
		frame:SetScript("OnEnter", function(self) T.UIFrameFadeIn(self, .5, self:GetAlpha(), 1) end)
		frame:SetScript("OnLeave", function(self) T.UIFrameFadeOut(self, .5, self:GetAlpha(), 0) end)
		for i = 1, #children do
			children[i]:SetScript("OnEnter", function(self) OnHover(self) T.UIFrameFadeIn(frame, .5, frame:GetAlpha(), 1) end)
			children[i]:SetScript("OnLeave", function(self) OnLeave(self) T.UIFrameFadeOut(frame, .5, frame:GetAlpha(), 0) end)
		end
		T.UIFrameFadeOut(frame, .5, frame:GetAlpha(), 0)
	else
		frame:SetScript("OnEnter", nil)
		frame:SetScript("OnLeave", nil)
		for i = 1, #children do
			children[i]:SetScript("OnEnter", function(self) OnHover(self) end)
			children[i]:SetScript("OnLeave", function(self) OnLeave(self) end)
		end
		T.UIFrameFadeIn(frame, .5, frame:GetAlpha(), 1)
	end
end

MicromenuBar:SetScript("OnMouseDown", function(self)
	if aCoreCDB["OtherOptions"]["fademicromenu"] then
		aCoreCDB["OtherOptions"]["fademicromenu"] = false
	else
		aCoreCDB["OtherOptions"]["fademicromenu"] = true
	end
	UpdateFade(self, MicromenuButtons, "fademicromenu")
end)

MicromenuBar:SetScript("OnEvent", function(self) 
	UpdateFade(self, MicromenuButtons, "fademicromenu") 
end)

MicromenuBar:RegisterEvent("PLAYER_LOGIN")
--====================================================--
--[[                 -- Screen --                   ]]--
--====================================================--
local BOTTOMPANEL = CreateFrame("Frame", G.uiname.."AFK Bottompanel", WorldFrame)
BOTTOMPANEL:SetFrameStrata("FULLSCREEN")
BOTTOMPANEL:SetPoint("BOTTOMLEFT",WorldFrame,"BOTTOMLEFT",-5,-5)
BOTTOMPANEL:SetPoint("TOPRIGHT",WorldFrame,"BOTTOMRIGHT",5,40)
F.SetBD(BOTTOMPANEL)
BOTTOMPANEL:Hide()

BOTTOMPANEL.petmodelbutton = CreateFrame("PlayerModel", G.uiname.."AFKpetmodel", BOTTOMPANEL)
BOTTOMPANEL.petmodelbutton:SetSize(120,120)
BOTTOMPANEL.petmodelbutton:SetPosition(-0.5, 0, 0)
BOTTOMPANEL.petmodelbutton:SetPoint("CENTER", BOTTOMPANEL, "TOPRIGHT", -190, 0)

BOTTOMPANEL.petmodelbutton.text = T.createtext(BOTTOMPANEL.petmodelbutton, "OVERLAY", 13, "OUTLINE", "RIGHT")
BOTTOMPANEL.petmodelbutton.text:SetPoint("CENTER")
BOTTOMPANEL.petmodelbutton.text:SetText("AltzUI")

local function fadeout()
	Minimap:Hide()
	UIParent:SetAlpha(0)
	UIFrameFadeIn(BOTTOMPANEL, 3, BOTTOMPANEL:GetAlpha(), 1)
	BOTTOMPANEL.t = 0
	BOTTOMPANEL:EnableKeyboard(true)
end

local function fadein()
	Minimap:Show()
	UIFrameFadeIn(UIParent, 2, 0, 1)
	UIFrameFadeOut(BOTTOMPANEL, 2, BOTTOMPANEL:GetAlpha(), 0)
	BOTTOMPANEL:SetScript("OnUpdate",  function(self, e)
		self.t = self.t + e
		if self.t > .5 then
			self:Hide()
			self:SetScript("OnUpdate", nil)
			self.t = 0
		end
	end)
	BOTTOMPANEL:EnableKeyboard(false)
end

BOTTOMPANEL:SetScript("OnKeyDown", function(self, key) 
	fadein()
end)

BOTTOMPANEL:SetScript("OnMouseDown", function(self) 
	fadein()
end)

BOTTOMPANEL:SetScript("OnEvent",function(self, event) 
	if event == "PLAYER_ENTERING_WORLD" then
		if aCoreDB.meet then
			fadeout()
		end
		
		local PetNumber = max(C_PetJournal.GetNumPets(false), 5)
		local randomIndex = random(1 ,PetNumber)
		local randomID = select(11, C_PetJournal.GetPetInfoByIndex(randomIndex))
		if randomID then
			self.petmodelbutton:SetCreature(randomID)
		else
			self.petmodelbutton:SetCreature(53623) -- 塞纳里奥角鹰兽宝宝
		end
		
		hooksecurefunc("ToggleDropDownMenu", function(level, value, dropDownFrame, anchorName)
			if level == 2 and value == SELECT_LOOT_SPECIALIZATION then
				local listFrame = _G["DropDownList"..level]
				local point, anchor, relPoint, _, y = listFrame:GetPoint()
				listFrame:SetPoint(point, anchor, relPoint, 16, y)
			end
		end)
		
		self:UnregisterEvent("PLAYER_ENTERING_WORLD")
	elseif event == "PLAYER_FLAGS_CHANGED" then
		if UnitIsAFK("player") then
			fadeout()
		end
	end
end)

BOTTOMPANEL:RegisterEvent("PLAYER_ENTERING_WORLD")
BOTTOMPANEL:RegisterEvent("PLAYER_FLAGS_CHANGED")
