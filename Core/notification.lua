--[[
    DGS Modern Notification System
    Toast-style notifications with auto-dismiss and stacking.
]]
dgsLogLuaMemory()
dgsRegisterType("dgs-notification", "dgsBasic", "dgsType2D")
dgsRegisterProperties("dgs-notification", {
    notificationType = {"string"},
    title = {"string"},
    message = {"string"},
    duration = {"number"},
    position = {"string"},
    dismissible = {"bool"},
    iconType = {"string"},
    progressBar = {"bool"},
})

local dxDrawRectangle = dxDrawRectangle
local dxDrawLine = dxDrawLine
local dgsDrawText = dgsDrawText
local applyColorAlpha = applyColorAlpha
local createElement = createElement
local type = type
local tonumber = tonumber

-- Active notifications tracker
local activeNotifications = {
    topLeft = {},
    topRight = {},
    bottomLeft = {},
    bottomRight = {},
    topCenter = {},
    bottomCenter = {},
}

-- Notification type colors (reference design system)
local notifColors = {
    success = {
        bg = tocolor(22, 35, 26, 245),
        accent = tocolor(52, 199, 123, 255),
        icon = "✓",
    },
    warning = {
        bg = tocolor(35, 30, 18, 245),
        accent = tocolor(255, 183, 77, 255),
        icon = "⚠",
    },
    error = {
        bg = tocolor(35, 18, 18, 245),
        accent = tocolor(255, 82, 82, 255),
        icon = "✕",
    },
    info = {
        bg = tocolor(18, 28, 38, 245),
        accent = tocolor(77, 171, 247, 255),
        icon = "ℹ",
    },
}

function dgsCreateNotification(...)
    local sRes = sourceResource or resource
    local message, notifType, duration, position, title
    
    if select("#", ...) == 1 and type(select(1, ...)) == "table" then
        local args = ...
        message = args.message or args.text or args[1]
        notifType = args.type or args.notificationType or args[2] or "info"
        duration = args.duration or args.time or args[3] or 4000
        position = args.position or args[4] or "topRight"
        title = args.title or args[5] or ""
    else
        message, notifType, duration, position, title = ...
    end
    
    notifType = notifType or "info"
    duration = tonumber(duration) or 4000
    position = position or "topRight"
    title = title or ""
    
    local notif = createElement("dgs-notification")
    dgsSetType(notif, "dgs-dxnotification")
    
    local colors = notifColors[notifType] or notifColors.info
    
    dgsElementData[notif] = {
        notificationType = notifType,
        title = title,
        message = tostring(message or ""),
        duration = duration,
        position = position,
        dismissible = true,
        iconType = notifType,
        progressBar = duration > 0,
        createTime = getTickCount(),
        alpha = 0,
        -- Visual
        bgColor = colors.bg,
        accentColor = colors.accent,
        icon = colors.icon,
        titleColor = tocolor(240, 242, 248, 255),
        messageColor = tocolor(165, 172, 188, 255),
        iconColor = colors.accent,
        -- Layout
        width = 320,
        padding = 14,
        radius = 6,
        accentWidth = 3,
        gap = 8,
        font = "default",
        fontBold = "default-bold",
    }
    
    -- Add to position queue
    local queue = activeNotifications[position]
    if queue then
        table.insert(queue, notif)
    end
    
    dgsSetParent(notif, nil, true, true)
    dgsApplyGeneralProperties(notif, sRes)
    onDGSElementCreate(notif, sRes)
    
    -- Auto dismiss
    if duration > 0 then
        setTimer(function()
            if isElement(notif) then
                dgsDismissNotification(notif)
            end
        end, duration, 1)
    end
    
    return notif
end

function dgsDismissNotification(notif)
    if not isElement(notif) then return false end
    if dgsElementData[notif]._dismissing then return false end
    
    dgsElementData[notif]._dismissing = true
    dgsTriggerEvent("onDgsNotificationDismiss", notif)
    
    -- Fade out then destroy
    setTimer(function()
        if isElement(notif) then
            -- Remove from queue
            local pos = dgsElementData[notif].position
            local queue = activeNotifications[pos]
            if queue then
                for i = #queue, 1, -1 do
                    if queue[i] == notif then
                        table.remove(queue, i)
                        break
                    end
                end
            end
            destroyElement(notif)
        end
    end, 300, 1)
    
    return true
end

function dgsNotificationGetPosition(notif, index, screenHeight, screenWidth)
    local position = dgsElementData[notif].position or "topRight"
    local notifW = dgsElementData[notif].width or 320
    local notifH = dgsElementData[notif]._renderHeight or 60
    local padding = 12
    local offset = (index - 1) * (notifH + padding)
    
    if position == "topRight" then
        return screenWidth - notifW - 16, 16 + offset
    elseif position == "topLeft" then
        return 16, 16 + offset
    elseif position == "topCenter" then
        return (screenWidth - notifW) / 2, 16 + offset
    elseif position == "bottomRight" then
        return screenWidth - notifW - 16, screenHeight - 16 - notifH - offset
    elseif position == "bottomLeft" then
        return 16, screenHeight - 16 - notifH - offset
    elseif position == "bottomCenter" then
        return (screenWidth - notifW) / 2, screenHeight - 16 - notifH - offset
    end
    
    return screenWidth - notifW - 16, 16 + offset
end

----------------------------------------------------------------
--------------------------Renderer------------------------------
----------------------------------------------------------------
dgsRenderer["dgs-dxnotification"] = function(source, x, y, w, h, mx, my, cx, cy, enabledInherited, enabledSelf, eleData, parentAlpha, isPostGUI, rndtgt)
    local sw, sh = guiGetScreenSize()
    
    -- Find index in queue
    local position = eleData.position or "topRight"
    local queue = activeNotifications[position] or {}
    local index = 1
    for i, n in ipairs(queue) do
        if n == source then
            index = i
            break
        end
    end
    
    -- Calculate position
    local notifW = eleData.width or 320
    local px, py = dgsNotificationGetPosition(source, index, sh, sw)
    
    -- Animation: fade in
    local tick = getTickCount()
    local createTime = eleData.createTime or tick
    local elapsed = tick - createTime
    local alpha = math.min(255, math.floor(elapsed / 200 * 255))
    
    if eleData._dismissing then
        alpha = math.max(0, alpha - 100)
    end
    
    eleData.alpha = alpha
    local globalAlpha = alpha / 255
    
    -- Calculate height
    local pad = eleData.padding or 14
    local accentW = eleData.accentWidth or 3
    local contentW = notifW - pad * 2 - accentW
    local title = eleData.title or ""
    local message = eleData.message or ""
    
    local titleH = title ~= "" and 18 or 0
    local msgH = message ~= "" and 16 or 0
    local notifH = pad * 2 + titleH + (titleH > 0 and msgH > 0 and 4 or 0) + msgH
    notifH = math.max(notifH, 56)
    
    eleData._renderHeight = notifH
    x, y = px, py
    w, h = notifW, notifH
    
    -- Background
    local bgColor = applyColorAlpha(eleData.bgColor, globalAlpha)
    dxDrawRectangle(x, y, w, h, bgColor, isPostGUI)
    
    -- Accent bar (left)
    local accentColor = applyColorAlpha(eleData.accentColor, globalAlpha)
    dxDrawRectangle(x, y, accentW, h, accentColor, isPostGUI)
    
    -- Icon area
    local iconX = x + accentW + pad
    local iconY = y + (h - 20) / 2
    local icon = eleData.icon or "ℹ"
    local iconColor = applyColorAlpha(eleData.iconColor, globalAlpha)
    dgsDrawText(icon, iconX, iconY, iconX + 20, iconY + 20, iconColor, 1.2, 1.2, "default", "center", "center", false, false, isPostGUI)
    
    -- Text content
    local textX = iconX + 26
    local textW = w - (textX - x) - pad
    local textY = y + pad
    
    if title ~= "" then
        local titleColor = applyColorAlpha(eleData.titleColor, globalAlpha)
        dgsDrawText(title, textX, textY, textX + textW, textY + titleH, titleColor, 1, 1, "default-bold", "left", "top", true, false, isPostGUI)
        textY = textY + titleH + 4
    end
    
    if message ~= "" then
        local msgColor = applyColorAlpha(eleData.messageColor, globalAlpha)
        dgsDrawText(message, textX, textY, textX + textW, textY + msgH, msgColor, 0.9, 0.9, "default", "left", "top", true, false, isPostGUI)
    end
    
    -- Progress bar (time remaining)
    if eleData.progressBar and eleData.duration > 0 then
        local progress = 1 - (elapsed / eleData.duration)
        progress = math.max(0, math.min(1, progress))
        local barH = 2
        local barY = y + h - barH
        local barW = (w - accentW) * progress
        
        local barBg = tocolor(255, 255, 255, math.floor(10 * globalAlpha))
        local barColor = applyColorAlpha(eleData.accentColor, globalAlpha * 0.6)
        
        dxDrawRectangle(x + accentW, barY, w - accentW, barH, barBg, isPostGUI)
        dxDrawRectangle(x + accentW, barY, barW, barH, barColor, isPostGUI)
    end
    
    -- Close button area (check click)
    if eleData.dismissible then
        local closeX = x + w - 28
        local closeY = y + 4
        local closeW = 24
        local closeH = 20
        
        if mx >= closeX and mx <= closeX + closeW and my >= closeY and my <= closeY + closeH then
            local closeBg = tocolor(255, 255, 255, math.floor(15 * globalAlpha))
            dxDrawRectangle(closeX, closeY, closeW, closeH, closeBg, isPostGUI)
        end
        
        local closeColor = tocolor(165, 172, 188, math.floor(180 * globalAlpha))
        dgsDrawText("×", closeX, closeY, closeX + closeW, closeY + closeH, closeColor, 1.1, 1.1, "default-bold", "center", "center", false, false, isPostGUI)
    end
    
    return rndtgt, false, mx, my, 0, 0
end
