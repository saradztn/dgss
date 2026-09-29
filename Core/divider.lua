--[[
    DGS Divider Component
    A visual separator line for layout sections.
]]
dgsLogLuaMemory()
dgsRegisterType("dgs-dxdivider", "dgsBasic", "dgsType2D")
dgsRegisterProperties("dgs-dxdivider", {
    orientation = {"string"},
    color = {"number"},
    thickness = {"number"},
    style = {"string"},
    label = {"string"},
    labelColor = {"number"},
    margin = {"number"},
})

local dxDrawRectangle = dxDrawRectangle
local dxDrawLine = dxDrawLine
local dgsDrawText = dgsDrawText
local applyColorAlpha = applyColorAlpha
local createElement = createElement
local calculateGuiPositionSize = calculateGuiPositionSize
local type = type

function dgsCreateDivider(...)
    local sRes = sourceResource or resource
    local x, y, w, h, relative, parent, orientation
    
    if select("#", ...) == 1 and type(select(1, ...)) == "table" then
        local args = ...
        x = args.x or args[1]
        y = args.y or args[2]
        w = args.width or args.w or args[3]
        h = args.height or args.h or args[4]
        relative = args.relative or args.rlt or args[5]
        parent = args.parent or args.p or args[6]
        orientation = args.orientation or args[7] or "horizontal"
    else
        x, y, w, h, relative, parent, orientation = ...
    end
    
    local divider = createElement("dgs-dxdivider")
    dgsSetType(divider, "dgs-dxdivider")
    
    dgsElementData[divider] = {
        renderBuffer = {},
        orientation = orientation or "horizontal",
        color = tocolor(42, 46, 58, 255),
        thickness = 1,
        style = "solid",
        label = nil,
        labelColor = tocolor(130, 137, 155, 255),
        margin = 0,
        font = "default",
    }
    
    dgsSetParent(divider, parent, true, true)
    calculateGuiPositionSize(divider, x, y, relative or false, w, h, relative or false, true)
    dgsApplyGeneralProperties(divider, sRes)
    onDGSElementCreate(divider, sRes)
    
    return divider
end

function dgsDividerSetColor(divider, color)
    if dgsGetType(divider) ~= "dgs-dxdivider" then
        error(dgsGenAsrt(divider, "dgsDividerSetColor", 1, "dgs-dxdivider"))
    end
    dgsSetData(divider, "color", color)
end

function dgsDividerSetLabel(divider, text)
    if dgsGetType(divider) ~= "dgs-dxdivider" then
        error(dgsGenAsrt(divider, "dgsDividerSetLabel", 1, "dgs-dxdivider"))
    end
    dgsSetData(divider, "label", tostring(text or ""))
end

----------------------------------------------------------------
--------------------------Renderer------------------------------
----------------------------------------------------------------
dgsRenderer["dgs-dxdivider"] = function(source, x, y, w, h, mx, my, cx, cy, enabledInherited, enabledSelf, eleData, parentAlpha, isPostGUI, rndtgt)
    local color = applyColorAlpha(eleData.color, parentAlpha)
    local thickness = eleData.thickness or 1
    local orientation = eleData.orientation or "horizontal"
    local label = eleData.label
    
    if label and label ~= "" then
        -- Divider with centered label
        local labelColor = applyColorAlpha(eleData.labelColor or tocolor(130, 137, 155, 255), parentAlpha)
        local font = eleData.font or "default"
        local labelText = label
        local textW = dxGetTextWidth(labelText, 1, font)
        local gap = 10
        
        local centerX = x + w / 2
        local centerY = y + h / 2
        
        if orientation == "horizontal" then
            local lineY = centerY
            -- Left line
            dxDrawLine(x + eleData.margin, lineY, centerX - textW/2 - gap, lineY, color, thickness, isPostGUI)
            -- Right line
            dxDrawLine(centerX + textW/2 + gap, lineY, x + w - eleData.margin, lineY, color, thickness, isPostGUI)
            -- Label
            dgsDrawText(labelText, centerX - textW/2, centerY - 7, centerX + textW/2, centerY + 7, labelColor, 0.8, 0.8, font, "center", "center", false, false, isPostGUI)
        else
            local lineX = centerX
            -- Top line
            dxDrawLine(lineX, y + eleData.margin, lineX, centerY - 7 - gap, color, thickness, isPostGUI)
            -- Bottom line
            dxDrawLine(lineX, centerY + 7 + gap, lineX, y + h - eleData.margin, color, thickness, isPostGUI)
            -- Label (rotated not supported easily, just place it)
            dgsDrawText(labelText, centerX - 20, centerY - 7, centerX + 20, centerY + 7, labelColor, 0.7, 0.7, font, "center", "center", false, false, isPostGUI)
        end
    else
        -- Simple line
        if orientation == "horizontal" then
            local lineY = y + h / 2
            dxDrawLine(x + eleData.margin, lineY, x + w - eleData.margin, lineY, color, thickness, isPostGUI)
        else
            local lineX = x + w / 2
            dxDrawLine(lineX, y + eleData.margin, lineX, y + h - eleData.margin, color, thickness, isPostGUI)
        end
    end
    
    return rndtgt, false, mx, my, 0, 0
end
