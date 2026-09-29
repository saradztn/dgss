--[[
    DGS Badge Component
    Small label/tag for status indicators, counts, etc.
]]
dgsLogLuaMemory()
dgsRegisterType("dgs-dxbadge", "dgsBasic", "dgsType2D")
dgsRegisterProperties("dgs-dxbadge", {
    text = {"string"},
    textColor = {"number"},
    color = {"number"},
    borderColor = {"number"},
    borderWidth = {"number"},
    radius = {"number"},
    variant = {"string"},
    size = {"string"},
})

local dxDrawRectangle = dxDrawRectangle
local dxDrawLine = dxDrawLine
local dgsDrawText = dgsDrawText
local applyColorAlpha = applyColorAlpha
local createElement = createElement
local calculateGuiPositionSize = calculateGuiPositionSize
local type = type

-- Variant colors
local badgeVariants = {
    default = {
        bg = tocolor(45, 50, 62, 255),
        text = tocolor(200, 205, 215, 255),
        border = tocolor(60, 65, 80, 255),
    },
    primary = {
        bg = tocolor(99, 132, 255, 255),
        text = tocolor(255, 255, 255, 255),
        border = tocolor(80, 112, 230, 255),
    },
    success = {
        bg = tocolor(52, 199, 123, 40),
        text = tocolor(52, 199, 123, 255),
        border = tocolor(52, 199, 123, 80),
    },
    warning = {
        bg = tocolor(255, 183, 77, 40),
        text = tocolor(255, 183, 77, 255),
        border = tocolor(255, 183, 77, 80),
    },
    error = {
        bg = tocolor(255, 82, 82, 40),
        text = tocolor(255, 82, 82, 255),
        border = tocolor(255, 82, 82, 80),
    },
    info = {
        bg = tocolor(77, 171, 247, 40),
        text = tocolor(77, 171, 247, 255),
        border = tocolor(77, 171, 247, 80),
    },
}

function dgsCreateBadge(...)
    local sRes = sourceResource or resource
    local x, y, w, h, text, relative, parent, variant
    
    if select("#", ...) == 1 and type(select(1, ...)) == "table" then
        local args = ...
        x = args.x or args[1]
        y = args.y or args[2]
        w = args.width or args.w or args[3]
        h = args.height or args.h or args[4]
        text = args.text or args[5] or ""
        relative = args.relative or args.rlt or args[6]
        parent = args.parent or args.p or args[7]
        variant = args.variant or args[8] or "default"
    else
        x, y, w, h, text, relative, parent, variant = ...
    end
    
    local badge = createElement("dgs-dxbadge")
    dgsSetType(badge, "dgs-dxbadge")
    
    local var = badgeVariants[variant or "default"] or badgeVariants.default
    
    dgsElementData[badge] = {
        renderBuffer = {},
        text = tostring(text or ""),
        textColor = var.text,
        color = var.bg,
        borderColor = var.border,
        borderWidth = 1,
        radius = 10,
        variant = variant or "default",
        size = "md",
        font = "default",
        padding = {6, 2},
    }
    
    dgsSetParent(badge, parent, true, true)
    calculateGuiPositionSize(badge, x, y, relative or false, w, h, relative or false, true)
    dgsApplyGeneralProperties(badge, sRes)
    onDGSElementCreate(badge, sRes)
    
    return badge
end

function dgsBadgeSetText(badge, text)
    if dgsGetType(badge) ~= "dgs-dxbadge" then
        error(dgsGenAsrt(badge, "dgsBadgeSetText", 1, "dgs-dxbadge"))
    end
    dgsSetData(badge, "text", tostring(text or ""))
end

function dgsBadgeSetVariant(badge, variant)
    if dgsGetType(badge) ~= "dgs-dxbadge" then
        error(dgsGenAsrt(badge, "dgsBadgeSetVariant", 1, "dgs-dxbadge"))
    end
    local var = badgeVariants[variant or "default"] or badgeVariants.default
    dgsSetData(badge, "textColor", var.text)
    dgsSetData(badge, "color", var.bg)
    dgsSetData(badge, "borderColor", var.border)
    dgsSetData(badge, "variant", variant)
end

----------------------------------------------------------------
--------------------------Renderer------------------------------
----------------------------------------------------------------
dgsRenderer["dgs-dxbadge"] = function(source, x, y, w, h, mx, my, cx, cy, enabledInherited, enabledSelf, eleData, parentAlpha, isPostGUI, rndtgt)
    local bgColor = applyColorAlpha(eleData.color, parentAlpha)
    local textColor = applyColorAlpha(eleData.textColor, parentAlpha)
    local borderColor = applyColorAlpha(eleData.borderColor, parentAlpha)
    local borderWidth = eleData.borderWidth or 1
    local radius = eleData.radius or 10
    local text = eleData.text or ""
    local font = eleData.font or "default"
    local padding = eleData.padding or {6, 2}
    
    -- Background
    dxDrawRectangle(x, y, w, h, bgColor, isPostGUI)
    
    -- Border
    if borderWidth > 0 then
        dxDrawLine(x, y, x + w, y, borderColor, borderWidth, isPostGUI)
        dxDrawLine(x, y + h, x + w, y + h, borderColor, borderWidth, isPostGUI)
        dxDrawLine(x, y, x, y + h, borderColor, borderWidth, isPostGUI)
        dxDrawLine(x + w, y, x + w, y + h, borderColor, borderWidth, isPostGUI)
    end
    
    -- Text
    if text ~= "" then
        local fontSize = eleData.size == "sm" and 0.8 or (eleData.size == "lg" and 1.1 or 0.9)
        dgsDrawText(text, x + padding[1], y + padding[2], x + w - padding[1], y + h - padding[2], textColor, fontSize, fontSize, font, "center", "center", true, false, isPostGUI)
    end
    
    return rndtgt, false, mx, my, 0, 0
end
