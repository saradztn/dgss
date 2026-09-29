--[[
    DGS Card Component
    A modern container/card for grouping related content.
]]
dgsLogLuaMemory()
dgsRegisterType("dgs-dxcard", "dgsBasic", "dgsType2D")
dgsRegisterProperties("dgs-dxcard", {
    color = {"number"},
    hoverColor = {"number"},
    borderColor = {"number"},
    borderWidth = {"number"},
    radius = {"number"},
    padding = {"number"},
    title = {"string"},
    titleColor = {"number"},
    subtitle = {"string"},
    subtitleColor = {"number"},
    interactive = {"bool"},
    shadowSize = {"number"},
    accentColor = {"number"},
    accentPosition = {"string"},
    accentWidth = {"number"},
})

local dxDrawRectangle = dxDrawRectangle
local dxDrawLine = dxDrawLine
local dgsDrawText = dgsDrawText
local applyColorAlpha = applyColorAlpha
local createElement = createElement
local calculateGuiPositionSize = calculateGuiPositionSize
local type = type

function dgsCreateCard(...)
    local sRes = sourceResource or resource
    local x, y, w, h, relative, parent, title, subtitle
    
    if select("#", ...) == 1 and type(select(1, ...)) == "table" then
        local args = ...
        x = args.x or args[1]
        y = args.y or args[2]
        w = args.width or args.w or args[3]
        h = args.height or args.h or args[4]
        relative = args.relative or args.rlt or args[5]
        parent = args.parent or args.p or args[6]
        title = args.title or args[7] or ""
        subtitle = args.subtitle or args[8] or ""
    else
        x, y, w, h, relative, parent, title, subtitle = ...
    end
    
    local card = createElement("dgs-dxcard")
    dgsSetType(card, "dgs-dxcard")
    
    local res = sRes ~= resource and sRes or "global"
    local style = styleManager.styles[res]
    local using = style.using
    style = style.loaded[using]
    
    local sStyle = style.card or {}
    
    dgsElementData[card] = {
        renderBuffer = {},
        color = sStyle.bgColor or tocolor(26, 28, 35, 245),
        hoverColor = sStyle.hoverColor or tocolor(32, 35, 43, 245),
        borderColor = sStyle.borderColor or tocolor(40, 44, 55, 255),
        borderWidth = sStyle.borderWidth or 1,
        radius = sStyle.radius or 8,
        padding = sStyle.padding or 16,
        title = tostring(title or ""),
        titleColor = sStyle.titleColor or tocolor(240, 242, 248, 255),
        subtitle = tostring(subtitle or ""),
        subtitleColor = sStyle.subtitleColor or tocolor(165, 172, 188, 255),
        interactive = false,
        shadowSize = 0,
        accentColor = nil,
        accentPosition = "top",
        accentWidth = 3,
        font = "default",
        fontBold = "default-bold",
        hoverAnim = 0,
    }
    
    dgsSetParent(card, parent, true, true)
    calculateGuiPositionSize(card, x, y, relative or false, w, h, relative or false, true)
    dgsApplyGeneralProperties(card, sRes)
    onDGSElementCreate(card, sRes)
    
    return card
end

-- Card API functions
function dgsCardSetTitle(card, title)
    if dgsGetType(card) ~= "dgs-dxcard" then
        error(dgsGenAsrt(card, "dgsCardSetTitle", 1, "dgs-dxcard"))
    end
    dgsSetData(card, "title", tostring(title or ""))
end

function dgsCardGetTitle(card)
    if dgsGetType(card) ~= "dgs-dxcard" then
        error(dgsGenAsrt(card, "dgsCardGetTitle", 1, "dgs-dxcard"))
    end
    return dgsElementData[card].title
end

function dgsCardSetSubtitle(card, subtitle)
    if dgsGetType(card) ~= "dgs-dxcard" then
        error(dgsGenAsrt(card, "dgsCardSetSubtitle", 1, "dgs-dxcard"))
    end
    dgsSetData(card, "subtitle", tostring(subtitle or ""))
end

----------------------------------------------------------------
--------------------------Renderer------------------------------
----------------------------------------------------------------
dgsRenderer["dgs-dxcard"] = function(source, x, y, w, h, mx, my, cx, cy, enabledInherited, enabledSelf, eleData, parentAlpha, isPostGUI, rndtgt)
    local color = applyColorAlpha(eleData.color, parentAlpha)
    local borderColor = applyColorAlpha(eleData.borderColor, parentAlpha)
    local borderWidth = eleData.borderWidth or 1
    local radius = eleData.radius or 8
    local padding = eleData.padding or 16
    
    -- Check hover state for interactive cards
    local isHovered = eleData.interactive and mx >= x and mx <= x+w and my >= y and my <= y+h
    
    -- Hover animation
    if isHovered then
        eleData.hoverAnim = math.min(1, (eleData.hoverAnim or 0) + 0.08)
    else
        eleData.hoverAnim = math.max(0, (eleData.hoverAnim or 0) - 0.08)
    end
    
    -- Background
    local bgColor = color
    if eleData.interactive and eleData.hoverAnim > 0 then
        local hoverColor = applyColorAlpha(eleData.hoverColor, parentAlpha)
        bgColor = tocolor(
            math.floor(color and (fromcolor(color)) or 26 + ((fromcolor(hoverColor)) - (fromcolor(color))) * eleData.hoverAnim),
            math.floor(color and (select(2, fromcolor(color))) or 28 + ((select(2, fromcolor(hoverColor))) - (select(2, fromcolor(color)))) * eleData.hoverAnim),
            math.floor(color and (select(3, fromcolor(color))) or 35 + ((select(3, fromcolor(hoverColor))) - (select(3, fromcolor(color)))) * eleData.hoverAnim),
            math.floor((select(4, fromcolor(color)) or 245) * parentAlpha)
        )
    end
    
    -- Draw background
    dxDrawRectangle(x, y, w, h, bgColor, isPostGUI)
    
    -- Border
    if borderWidth > 0 then
        dxDrawLine(x, y, x + w, y, borderColor, borderWidth, isPostGUI) -- top
        dxDrawLine(x, y + h, x + w, y + h, borderColor, borderWidth, isPostGUI) -- bottom
        dxDrawLine(x, y, x, y + h, borderColor, borderWidth, isPostGUI) -- left
        dxDrawLine(x + w, y, x + w, y + h, borderColor, borderWidth, isPostGUI) -- right
    end
    
    -- Accent bar
    if eleData.accentColor then
        local accentColor = applyColorAlpha(eleData.accentColor, parentAlpha)
        local accentW = eleData.accentWidth or 3
        local pos = eleData.accentPosition or "top"
        
        if pos == "top" then
            dxDrawRectangle(x, y, w, accentW, accentColor, isPostGUI)
        elseif pos == "left" then
            dxDrawRectangle(x, y, accentW, h, accentColor, isPostGUI)
        elseif pos == "bottom" then
            dxDrawRectangle(x, y + h - accentW, w, accentW, accentColor, isPostGUI)
        elseif pos == "right" then
            dxDrawRectangle(x + w - accentW, y, accentW, h, accentColor, isPostGUI)
        end
    end
    
    -- Title and subtitle
    local title = eleData.title or ""
    local subtitle = eleData.subtitle or ""
    local textX = x + padding
    local textW = w - padding * 2
    
    if title ~= "" then
        local titleColor = applyColorAlpha(eleData.titleColor, parentAlpha)
        local titleY = y + padding
        local font = eleData.fontBold or "default-bold"
        dgsDrawText(title, textX, titleY, textX + textW, titleY + 18, titleColor, 1, 1, font, "left", "top", true, false, isPostGUI)
    end
    
    if subtitle ~= "" then
        local subtitleColor = applyColorAlpha(eleData.subtitleColor, parentAlpha)
        local subtitleY = y + padding + (title ~= "" and 22 or 0)
        local font = eleData.font or "default"
        dgsDrawText(subtitle, textX, subtitleY, textX + textW, subtitleY + 16, subtitleColor, 0.85, 0.85, font, "left", "top", true, false, isPostGUI)
    end
    
    -- Return content area for children
    local contentX = x + padding
    local contentY = y + padding + (title ~= "" and 24 or 0) + (subtitle ~= "" and 18 or 0)
    local contentW = w - padding * 2
    local contentH = h - padding * 2 - (title ~= "" and 24 or 0) - (subtitle ~= "" and 18 or 0)
    
    return rndtgt, false, mx, my, 0, 0, contentX, contentY, contentW, contentH
end
