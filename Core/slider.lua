--[[
    DGS Modern Slider Component
    A sleek slider/track input with thumb and optional range support.
]]
dgsLogLuaMemory()
dgsRegisterType("dgs-dxslider", "dgsBasic", "dgsType2D")
dgsRegisterProperties("dgs-dxslider", {
    value = {"number"},
    minValue = {"number"},
    maxValue = {"number"},
    step = {"number"},
    orientation = {"string"},
    trackColor = {"number"},
    trackFillColor = {"number"},
    trackHeight = {"number"},
    thumbColor = {"number"},
    thumbColorHover = {"number"},
    thumbColorActive = {"number"},
    thumbSize = {"number"},
    disabled = {"bool"},
    showValue = {"bool"},
    valueFormat = {"string"},
})

local dxDrawRectangle = dxDrawRectangle
local dxDrawLine = dxDrawLine
local applyColorAlpha = applyColorAlpha
local createElement = createElement
local calculateGuiPositionSize = calculateGuiPositionSize
local type = type
local tonumber = tonumber
local mathFloor = math.floor
local mathMin = math.min
local mathMax = math.max

function dgsCreateSlider(...)
    local sRes = sourceResource or resource
    local x, y, w, h, relative, parent, minValue, maxValue, value, orientation
    
    if select("#", ...) == 1 and type(select(1, ...)) == "table" then
        local args = ...
        x = args.x or args[1]
        y = args.y or args[2]
        w = args.width or args.w or args[3]
        h = args.height or args.h or args[4]
        relative = args.relative or args.rlt or args[5]
        parent = args.parent or args.p or args[6]
        minValue = args.min or args.minValue or args[7] or 0
        maxValue = args.max or args.maxValue or args[8] or 100
        value = args.value or args[9] or 0
        orientation = args.orientation or args[10] or "horizontal"
    else
        x, y, w, h, relative, parent, minValue, maxValue, value, orientation = ...
    end
    
    local slider = createElement("dgs-dxslider")
    dgsSetType(slider, "dgs-dxslider")
    
    local res = sRes ~= resource and sRes or "global"
    local style = styleManager.styles[res]
    local using = style.using
    style = style.loaded[using]
    
    local sStyle = style.slider or {}
    
    dgsElementData[slider] = {
        renderBuffer = {},
        value = tonumber(value) or 0,
        minValue = tonumber(minValue) or 0,
        maxValue = tonumber(maxValue) or 100,
        step = 1,
        orientation = orientation or "horizontal",
        trackColor = sStyle.trackColor or tocolor(30, 33, 40, 255),
        trackFillColor = sStyle.trackFillColor or tocolor(99, 132, 255, 255),
        trackHeight = sStyle.trackHeight or 4,
        thumbColor = sStyle.thumbColor or tocolor(240, 242, 248, 255),
        thumbColorHover = sStyle.thumbColorHover or tocolor(255, 255, 255, 255),
        thumbColorActive = sStyle.thumbColorActive or tocolor(220, 225, 240, 255),
        thumbSize = sStyle.thumbSize or 14,
        disabled = false,
        showValue = false,
        valueFormat = "%.0f",
        -- Internal
        _dragging = false,
        _hovering = false,
        _thumbAnim = 0,
        font = "default",
    }
    
    dgsSetParent(slider, parent, true, true)
    calculateGuiPositionSize(slider, x, y, relative or false, w, h, relative or false, true)
    dgsApplyGeneralProperties(slider, sRes)
    onDGSElementCreate(slider, sRes)
    
    return slider
end

function dgsSliderGetValue(slider)
    if dgsGetType(slider) ~= "dgs-dxslider" then
        error(dgsGenAsrt(slider, "dgsSliderGetValue", 1, "dgs-dxslider"))
    end
    return dgsElementData[slider].value
end

function dgsSliderSetValue(slider, value, triggerEvent)
    if dgsGetType(slider) ~= "dgs-dxslider" then
        error(dgsGenAsrt(slider, "dgsSliderSetValue", 1, "dgs-dxslider"))
    end
    
    local minV = dgsElementData[slider].minValue or 0
    local maxV = dgsElementData[slider].maxValue or 100
    local step = dgsElementData[slider].step or 1
    
    value = tonumber(value) or 0
    value = mathMax(minV, mathMin(maxV, value))
    
    if step > 0 then
        value = mathFloor((value - minV) / step + 0.5) * step + minV
        value = mathMax(minV, mathMin(maxV, value))
    end
    
    local old = dgsElementData[slider].value
    dgsElementData[slider].value = value
    
    if triggerEvent ~= false and value ~= old then
        dgsTriggerEvent("onDgsSliderChange", slider, value, old)
    end
    
    return value
end

function dgsSliderSetRange(slider, minV, maxV)
    if dgsGetType(slider) ~= "dgs-dxslider" then
        error(dgsGenAsrt(slider, "dgsSliderSetRange", 1, "dgs-dxslider"))
    end
    dgsSetData(slider, "minValue", tonumber(minV) or 0)
    dgsSetData(slider, "maxValue", tonumber(maxV) or 100)
    
    -- Clamp current value
    local val = dgsElementData[slider].value
    dgsSliderSetValue(slider, val, false)
end

function dgsSliderSetStep(slider, step)
    if dgsGetType(slider) ~= "dgs-dxslider" then
        error(dgsGenAsrt(slider, "dgsSliderSetStep", 1, "dgs-dxslider"))
    end
    dgsSetData(slider, "step", tonumber(step) or 1)
end

----------------------------------------------------------------
-- Event Handlers
----------------------------------------------------------------
addEventHandler("onDgsMouseClick", root, function(button, state, x, y)
    if source and isElement(source) and dgsGetType(source) == "dgs-dxslider" then
        if button == "left" and state == "down" then
            dgsElementData[source]._dragging = true
            
            -- Calculate value from click position
            local absX, absY = dgsGetPosition(source, false)
            local absW, absH = dgsGetSize(source, false)
            local eleData = dgsElementData[source]
            local orientation = eleData.orientation or "horizontal"
            local thumbSize = eleData.thumbSize or 14
            
            local ratio
            if orientation == "horizontal" then
                local trackStart = thumbSize / 2
                local trackEnd = absW - thumbSize / 2
                local trackLen = trackEnd - trackStart
                if trackLen > 0 then
                    ratio = (x - absX - trackStart) / trackLen
                end
            else
                local trackStart = thumbSize / 2
                local trackEnd = absH - thumbSize / 2
                local trackLen = trackEnd - trackStart
                if trackLen > 0 then
                    ratio = (y - absY - trackStart) / trackLen
                end
            end
            
            if ratio then
                ratio = mathMax(0, mathMin(1, ratio))
                local minV = eleData.minValue or 0
                local maxV = eleData.maxValue or 100
                local newValue = minV + (maxV - minV) * ratio
                dgsSliderSetValue(source, newValue, true)
            end
        end
    end
end)

addEventHandler("onDgsMouseClick", root, function(button, state)
    if source and isElement(source) and dgsGetType(source) == "dgs-dxslider" then
        if button == "left" and state == "up" then
            dgsElementData[source]._dragging = false
        end
    end
end)

----------------------------------------------------------------
--------------------------Renderer------------------------------
----------------------------------------------------------------
dgsRenderer["dgs-dxslider"] = function(source, x, y, w, h, mx, my, cx, cy, enabledInherited, enabledSelf, eleData, parentAlpha, isPostGUI, rndtgt)
    local orientation = eleData.orientation or "horizontal"
    local trackH = eleData.trackHeight or 4
    local thumbSize = eleData.thumbSize or 14
    
    local minV = eleData.minValue or 0
    local maxV = eleData.maxValue or 100
    local value = eleData.value or 0
    local range = maxV - minV
    local ratio = range > 0 and (value - minV) / range or 0
    ratio = mathMax(0, mathMin(1, ratio))
    
    -- Hover detection
    local isHovered = mx >= x and mx <= x + w and my >= y and my <= y + h
    eleData._hovering = isHovered
    
    -- Thumb animation
    if eleData._dragging then
        eleData._thumbAnim = mathMin(1, (eleData._thumbAnim or 0) + 0.15)
    elseif isHovered then
        eleData._thumbAnim = mathMin(0.6, (eleData._thumbAnim or 0) + 0.1)
    else
        eleData._thumbAnim = mathMax(0, (eleData._thumbAnim or 0) - 0.1)
    end
    
    local anim = eleData._thumbAnim or 0
    local enabled = enabledInherited and enabledSelf
    
    if orientation == "horizontal" then
        local centerY = y + h / 2
        local trackStart = x + thumbSize / 2
        local trackEnd = x + w - thumbSize / 2
        local trackLen = trackEnd - trackStart
        local thumbX = trackStart + trackLen * ratio
        
        -- Track background
        local trackColor = applyColorAlpha(eleData.trackColor, parentAlpha)
        local trackY = centerY - trackH / 2
        dxDrawRectangle(trackStart, trackY, trackLen, trackH, trackColor, isPostGUI)
        
        -- Track fill
        local fillColor = applyColorAlpha(eleData.trackFillColor, parentAlpha)
        dxDrawRectangle(trackStart, trackY, thumbX - trackStart, trackH, fillColor, isPostGUI)
        
        -- Thumb
        local thumbColor
        if eleData._dragging then
            thumbColor = applyColorAlpha(eleData.thumbColorActive, parentAlpha)
        elseif isHovered then
            thumbColor = applyColorAlpha(eleData.thumbColorHover, parentAlpha)
        else
            thumbColor = applyColorAlpha(eleData.thumbColor, parentAlpha)
        end
        
        local thumbR = thumbSize / 2 + anim * 2
        local thumbCX = thumbX
        local thumbCY = centerY
        
        -- Draw thumb as circle approximation
        dxDrawRectangle(thumbCX - thumbR, thumbCY - thumbR, thumbR * 2, thumbR * 2, thumbColor, isPostGUI)
        
        -- Glow ring when hovering/dragging
        if anim > 0.1 then
            local glowAlpha = mathFloor(anim * 40)
            local glowColor = tocolor(99, 132, 255, glowAlpha)
            local glowR = thumbR + 4
            dxDrawRectangle(thumbCX - glowR, thumbCY - glowR, glowR * 2, glowR * 2, glowColor, isPostGUI)
        end
        
    else
        -- Vertical
        local centerX = x + w / 2
        local trackStart = y + thumbSize / 2
        local trackEnd = y + h - thumbSize / 2
        local trackLen = trackEnd - trackStart
        local thumbY = trackStart + trackLen * ratio
        
        local trackColor = applyColorAlpha(eleData.trackColor, parentAlpha)
        local trackX = centerX - trackH / 2
        dxDrawRectangle(trackX, trackStart, trackH, trackLen, trackColor, isPostGUI)
        
        local fillColor = applyColorAlpha(eleData.trackFillColor, parentAlpha)
        dxDrawRectangle(trackX, trackStart, trackH, thumbY - trackStart, fillColor, isPostGUI)
        
        local thumbColor
        if eleData._dragging then
            thumbColor = applyColorAlpha(eleData.thumbColorActive, parentAlpha)
        elseif isHovered then
            thumbColor = applyColorAlpha(eleData.thumbColorHover, parentAlpha)
        else
            thumbColor = applyColorAlpha(eleData.thumbColor, parentAlpha)
        end
        
        local thumbR = thumbSize / 2 + anim * 2
        dxDrawRectangle(centerX - thumbR, thumbY - thumbR, thumbR * 2, thumbR * 2, thumbColor, isPostGUI)
    end
    
    -- Show value tooltip
    if eleData.showValue then
        local valueText = string.format(eleData.valueFormat or "%.0f", value)
        local textColor = applyColorAlpha(tocolor(200, 205, 215, 255), parentAlpha)
        dgsDrawText(valueText, x, y + h + 2, x + w, y + h + 16, textColor, 0.8, 0.8, "default", "center", "top", false, false, isPostGUI)
    end
    
    return rndtgt, false, mx, my, 0, 0
end
