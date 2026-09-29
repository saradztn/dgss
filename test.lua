--[[
    DGS Modern Demo & Test Suite
    Showcases all components with the new modern design system.
    
    Toggle with F7 key.
]]
dgsLogLuaMemory()

-- Check if we should run this test
local testEnabled = getSetting and getSetting("*testFile") or true
if testEnabled == "false" then return end

-- Demo state
local demoVisible = false
local demoWindow = nil
local elements = {}

-- Theme list for cycling
local themes = {"midnight", "dark", "light", "ocean", "emerald"}
local currentThemeIndex = 1

function createDGSModernDemo()
    if isElement(demoWindow) then return end
    
    local sw, sh = guiGetScreenSize()
    local ww, wh = 720, 520
    
    -- Main window
    demoWindow = dgsCreateWindow((sw - ww) / 2, (sh - wh) / 2, ww, wh, "DGS Modern - Component Showcase", false, nil, nil, 36, nil, nil, nil, nil, 1, false)
    dgsSetData(demoWindow, "movable", true)
    dgsSetData(demoWindow, "sizable", true)
    
    -- Tab panel for categories
    local tabPanel = dgsCreateTabPanel(8, 40, ww - 16, wh - 48, false, demoWindow)
    
    -- ===== BUTTONS TAB =====
    local tabButtons = dgsCreateTab("Buttons", tabPanel)
    
    local btnLabel = dgsCreateLabel(16, 16, 200, 20, "Button Variants", false, tabButtons)
    dgsSetFont(btnLabel, "default-bold")
    
    -- Default button
    local btn1 = dgsCreateButton(16, 44, 120, 34, "Default", false, tabButtons)
    -- Primary button (accent colored)
    local btn2 = dgsCreateButton(146, 44, 120, 34, "Primary", false, tabButtons, tocolor(255,255,255,255), 1, 1, nil, nil, nil, tocolor(99,132,255,255), tocolor(115,148,255,255), tocolor(80,115,235,255))
    -- Danger button
    local btn3 = dgsCreateButton(276, 44, 120, 34, "Danger", false, tabButtons, tocolor(255,255,255,255), 1, 1, nil, nil, nil, tocolor(220,50,50,255), tocolor(240,65,65,255), tocolor(195,40,40,255))
    -- Ghost/outline button
    local btn4 = dgsCreateButton(406, 44, 120, 34, "Ghost", false, tabButtons, tocolor(200,205,215,255), 1, 1, nil, nil, nil, tocolor(0,0,0,0), tocolor(45,50,62,150), tocolor(38,42,52,200))
    
    -- Small buttons row
    local btnSmLabel = dgsCreateLabel(16, 92, 200, 20, "Compact Buttons", false, tabButtons)
    dgsSetFont(btnSmLabel, "default-bold")
    
    dgsCreateButton(16, 118, 80, 28, "Save", false, tabButtons, tocolor(255,255,255,255), 0.9, 0.9, nil, nil, nil, tocolor(52,199,123,255), tocolor(65,210,135,255), tocolor(40,180,108,255))
    dgsCreateButton(106, 118, 80, 28, "Cancel", false, tabButtons)
    dgsCreateButton(196, 118, 80, 28, "Retry", false, tabButtons)
    dgsCreateButton(286, 118, 80, 28, "Delete", false, tabButtons, tocolor(255,255,255,255), 0.9, 0.9, nil, nil, nil, tocolor(180,40,40,255), tocolor(200,50,50,255), tocolor(160,35,35,255))
    
    -- Disabled button
    local btnDisabled = dgsCreateButton(16, 160, 120, 34, "Disabled", false, tabButtons)
    dgsSetEnabled(btnDisabled, false)
    
    local disLabel = dgsCreateLabel(16, 204, 200, 20, "Button with Click Counter", false, tabButtons)
    dgsSetFont(disLabel, "default-bold")
    
    local clickCount = 0
    local btnCounter = dgsCreateButton(16, 230, 180, 34, "Clicks: 0", false, tabButtons, tocolor(255,255,255,255), 1, 1, nil, nil, nil, tocolor(99,132,255,255), tocolor(115,148,255,255), tocolor(80,115,235,255))
    addEventHandler("onDgsMouseClick", btnCounter, function(button, state)
        if button == "left" and state == "up" then
            clickCount = clickCount + 1
            dgsSetText(btnCounter, "Clicks: " .. clickCount)
        end
    end)
    
    -- ===== INPUTS TAB =====
    local tabInputs = dgsCreateTab("Inputs", tabPanel)
    
    local inputLabel1 = dgsCreateLabel(16, 16, 200, 20, "Text Input", false, tabInputs)
    dgsSetFont(inputLabel1, "default-bold")
    
    local edit1 = dgsCreateEdit(16, 40, 280, 34, "", false, tabInputs)
    dgsSetData(edit1, "placeHolder", "Enter your name...")
    
    local inputLabel2 = dgsCreateLabel(16, 84, 200, 20, "Password Input", false, tabInputs)
    dgsSetFont(inputLabel2, "default-bold")
    
    local edit2 = dgsCreateEdit(16, 108, 280, 34, "", false, tabInputs)
    dgsSetData(edit2, "maskText", "*")
    dgsSetData(edit2, "placeHolder", "Enter password...")
    
    -- Memo
    local memoLabel = dgsCreateLabel(16, 152, 200, 20, "Text Area", false, tabInputs)
    dgsSetFont(memoLabel, "default-bold")
    
    local memo1 = dgsCreateMemo(16, 176, 350, 120, "", false, tabInputs)
    dgsSetData(memo1, "placeHolder", "Write your message here...")
    
    -- ===== CONTROLS TAB =====
    local tabControls = dgsCreateTab("Controls", tabPanel)
    
    -- Checkboxes
    local cbLabel = dgsCreateLabel(16, 16, 200, 20, "Checkboxes", false, tabControls)
    dgsSetFont(cbLabel, "default-bold")
    
    local cb1 = dgsCreateCheckBox(16, 40, 180, 24, "Enable notifications", false, false, tabControls)
    dgsCheckBoxSetSelected(cb1, true)
    local cb2 = dgsCreateCheckBox(16, 70, 180, 24, "Auto-save", false, false, tabControls)
    dgsCheckBoxSetSelected(cb2, true)
    local cb3 = dgsCreateCheckBox(16, 100, 180, 24, "Show preview", false, false, tabControls)
    local cb4 = dgsCreateCheckBox(16, 130, 180, 24, "Disabled option", false, false, tabControls)
    dgsSetEnabled(cb4, false)
    
    -- Radio buttons
    local rbLabel = dgsCreateLabel(250, 16, 200, 20, "Radio Buttons", false, tabControls)
    dgsSetFont(rbLabel, "default-bold")
    
    local rb1 = dgsCreateRadioButton(250, 40, 180, 24, "Small", false, tabControls)
    local rb2 = dgsCreateRadioButton(250, 70, 180, 24, "Medium", false, tabControls)
    dgsRadioButtonSetSelected(rb2, true)
    local rb3 = dgsCreateRadioButton(250, 100, 180, 24, "Large", false, tabControls)
    
    -- Switch buttons
    local swLabel = dgsCreateLabel(16, 170, 200, 20, "Switches", false, tabControls)
    dgsSetFont(swLabel, "default-bold")
    
    local sw1 = dgsCreateSwitchButton(16, 196, 100, 30, "ON", "OFF", false, false, tabControls)
    dgsSwitchButtonSetState(sw1, true)
    local sw2 = dgsCreateSwitchButton(130, 196, 100, 30, "ON", "OFF", false, false, tabControls)
    
    -- Progress bars
    local progLabel = dgsCreateLabel(16, 240, 200, 20, "Progress Bars", false, tabControls)
    dgsSetFont(progLabel, "default-bold")
    
    local prog1 = dgsCreateProgressBar(16, 266, 280, 8, false, tabControls)
    dgsProgressBarSetProgress(prog1, 75)
    
    local prog2 = dgsCreateProgressBar(16, 286, 280, 8, false, tabControls)
    dgsProgressBarSetProgress(prog2, 45)
    dgsSetData(prog2, "indicatorColor", tocolor(52, 199, 123, 255))
    
    local prog3 = dgsCreateProgressBar(16, 306, 280, 8, false, tabControls)
    dgsProgressBarSetProgress(prog3, 20)
    dgsSetData(prog3, "indicatorColor", tocolor(255, 82, 82, 255))
    
    -- ===== TABS TAB =====
    local tabTabs = dgsCreateTab("Tabs & Lists", tabPanel)
    
    -- Nested tab panel
    local innerTabPanel = dgsCreateTabPanel(8, 8, 300, 200, false, tabTabs)
    local innerTab1 = dgsCreateTab("Overview", innerTabPanel)
    local innerTab2 = dgsCreateTab("Settings", innerTabPanel)
    local innerTab3 = dgsCreateTab("Advanced", innerTabPanel)
    
    local overviewLabel = dgsCreateLabel(16, 16, 260, 60, "This is a nested tab panel demonstrating\nthe tab component with multiple tabs.", false, innerTab1)
    dgsSetFont(overviewLabel, "default")
    
    local settingsLabel = dgsCreateLabel(16, 16, 260, 40, "Settings panel content goes here.", false, innerTab2)
    local advancedLabel = dgsCreateLabel(16, 16, 260, 40, "Advanced settings and configuration.", false, innerTab3)
    
    -- Grid List
    local gridLabel = dgsCreateLabel(320, 8, 200, 20, "Grid List", false, tabTabs)
    dgsSetFont(gridLabel, "default-bold")
    
    local gridlist = dgsCreateGridList(320, 30, 370, 180, false, tabTabs)
    local col1 = dgsGridListAddColumn(gridlist, "Name", 0.4)
    local col2 = dgsGridListAddColumn(gridlist, "Type", 0.3)
    local col3 = dgsGridListAddColumn(gridlist, "Status", 0.25)
    
    -- Add sample data
    local sampleData = {
        {"Window", "Core", "Ready"},
        {"Button", "Core", "Ready"},
        {"Label", "Core", "Ready"},
        {"Edit", "Core", "Ready"},
        {"GridList", "Core", "Ready"},
        {"Notification", "Core", "New"},
        {"Card", "Core", "New"},
        {"Slider", "Core", "New"},
        {"Badge", "Core", "New"},
        {"Divider", "Core", "New"},
    }
    
    for i, data in ipairs(sampleData) do
        local row = dgsGridListAddRow(gridlist, data[1], data[2], data[3])
    end
    
    -- Combo Box
    local comboLabel = dgsCreateLabel(320, 220, 200, 20, "Dropdown", false, tabTabs)
    dgsSetFont(comboLabel, "default-bold")
    
    local combo = dgsCreateComboBox(320, 244, 200, 34, nil, false, tabTabs)
    dgsSetData(combo, "placeHolder", "Select theme...")
    dgsComboBoxAddItem(combo, "Midnight (Default)")
    dgsComboBoxAddItem(combo, "Dark")
    dgsComboBoxAddItem(combo, "Light")
    dgsComboBoxAddItem(combo, "Ocean")
    dgsComboBoxAddItem(combo, "Emerald")
    
    -- Selector
    local selLabel = dgsCreateLabel(320, 290, 200, 20, "Selector", false, tabTabs)
    dgsSetFont(selLabel, "default-bold")
    
    local selector = dgsCreateSelector(320, 314, 200, 30, false, tabTabs)
    dgsSelectorAddItem(selector, "Low")
    dgsSelectorAddItem(selector, "Medium")
    dgsSelectorAddItem(selector, "High")
    dgsSelectorAddItem(selector, "Ultra")
    
    -- ===== NOTIFICATIONS TAB =====
    local tabNotif = dgsCreateTab("Notifications", tabPanel)
    
    local notifLabel = dgsCreateLabel(16, 16, 300, 20, "Click buttons to show notifications", false, tabNotif)
    dgsSetFont(notifLabel, "default-bold")
    
    local notifDesc = dgsCreateLabel(16, 40, 400, 40, "Notifications appear as toast messages.\nThey auto-dismiss after a few seconds.", false, tabNotif)
    
    -- Notification trigger buttons
    local btnNotifSuccess = dgsCreateButton(16, 90, 140, 34, "Success", false, tabNotif, tocolor(255,255,255,255), 1, 1, nil, nil, nil, tocolor(52,199,123,255), tocolor(65,210,135,255), tocolor(40,180,108,255))
    local btnNotifWarning = dgsCreateButton(166, 90, 140, 34, "Warning", false, tabNotif, tocolor(255,255,255,255), 1, 1, nil, nil, nil, tocolor(255,183,77,255), tocolor(255,195,90,255), tocolor(235,165,60,255))
    local btnNotifError = dgsCreateButton(316, 90, 140, 34, "Error", false, tabNotif, tocolor(255,255,255,255), 1, 1, nil, nil, nil, tocolor(220,50,50,255), tocolor(240,65,65,255), tocolor(195,40,40,255))
    local btnNotifInfo = dgsCreateButton(466, 90, 140, 34, "Info", false, tabNotif, tocolor(255,255,255,255), 1, 1, nil, nil, nil, tocolor(77,171,247,255), tocolor(95,183,255,255), tocolor(60,150,225,255))
    
    addEventHandler("onDgsMouseClick", btnNotifSuccess, function(button, state)
        if button == "left" and state == "up" and dgsCreateNotification then
            dgsCreateNotification("Operation completed successfully!", "success", 4000, "topRight", "Success")
        end
    end)
    
    addEventHandler("onDgsMouseClick", btnNotifWarning, function(button, state)
        if button == "left" and state == "up" and dgsCreateNotification then
            dgsCreateNotification("Please check your settings before continuing.", "warning", 4000, "topRight", "Warning")
        end
    end)
    
    addEventHandler("onDgsMouseClick", btnNotifError, function(button, state)
        if button == "left" and state == "up" and dgsCreateNotification then
            dgsCreateNotification("Failed to connect to server. Please try again.", "error", 5000, "topRight", "Error")
        end
    end)
    
    addEventHandler("onDgsMouseClick", btnNotifInfo, function(button, state)
        if button == "left" and state == "up" and dgsCreateNotification then
            dgsCreateNotification("A new update is available for download.", "info", 4000, "topRight", "Info")
        end
    end)
    
    -- ===== BADGES & DIVIDERS TAB =====
    local tabMisc = dgsCreateTab("Badges & More", tabPanel)
    
    local badgeLabel = dgsCreateLabel(16, 16, 200, 20, "Badges", false, tabMisc)
    dgsSetFont(badgeLabel, "default-bold")
    
    -- Create badges
    if dgsCreateBadge then
        local badge1 = dgsCreateBadge(16, 40, 60, 22, "Default", false, tabMisc, "default")
        local badge2 = dgsCreateBadge(86, 40, 60, 22, "Primary", false, tabMisc, "primary")
        local badge3 = dgsCreateBadge(156, 40, 60, 22, "Success", false, tabMisc, "success")
        local badge4 = dgsCreateBadge(226, 40, 60, 22, "Warning", false, tabMisc, "warning")
        local badge5 = dgsCreateBadge(296, 40, 50, 22, "Error", false, tabMisc, "error")
        local badge6 = dgsCreateBadge(356, 40, 50, 22, "Info", false, tabMisc, "info")
        local badge7 = dgsCreateBadge(416, 40, 30, 22, "99+", false, tabMisc, "error")
    end
    
    -- Dividers
    local divLabel = dgsCreateLabel(16, 80, 200, 20, "Dividers", false, tabMisc)
    dgsSetFont(divLabel, "default-bold")
    
    if dgsCreateDivider then
        local divider1 = dgsCreateDivider(16, 106, 500, 2, false, tabMisc, "horizontal")
        
        local divider2 = dgsCreateDivider(16, 126, 500, 16, false, tabMisc, "horizontal")
        dgsDividerSetLabel(divider2, "Section Title")
        
        local divider3 = dgsCreateDivider(16, 158, 500, 2, false, tabMisc, "horizontal")
        dgsDividerSetColor(divider3, tocolor(99, 132, 255, 100))
    end
    
    -- Cards
    local cardLabel = dgsCreateLabel(16, 180, 200, 20, "Cards", false, tabMisc)
    dgsSetFont(cardLabel, "default-bold")
    
    if dgsCreateCard then
        local card1 = dgsCreateCard(16, 206, 200, 100, false, tabMisc, "Player Stats", "Online: 128 players")
        local card2 = dgsCreateCard(226, 206, 200, 100, false, tabMisc, "Server Status", "Uptime: 99.8%")
        dgsSetData(card2, "accentColor", tocolor(52, 199, 123, 255))
        local card3 = dgsCreateCard(436, 206, 200, 100, false, tabMisc, "Resources", "24 loaded")
        dgsSetData(card3, "accentColor", tocolor(255, 183, 77, 255))
    end
    
    -- ===== THEME TAB =====
    local tabTheme = dgsCreateTab("Themes", tabPanel)
    
    local themeLabel = dgsCreateLabel(16, 16, 300, 20, "Theme Switcher", false, tabTheme)
    dgsSetFont(themeLabel, "default-bold")
    
    local themeDesc = dgsCreateLabel(16, 40, 400, 40, "Switch between built-in themes.\nThe design system adapts colors automatically.", false, tabTheme)
    
    -- Theme buttons
    local themeNames = {"Midnight", "Dark", "Light", "Ocean", "Emerald"}
    local themeColors = {
        tocolor(99, 132, 255, 255),
        tocolor(88, 166, 255, 255),
        tocolor(67, 97, 238, 255),
        tocolor(0, 180, 220, 255),
        tocolor(16, 185, 100, 255),
    }
    
    for i, name in ipairs(themeNames) do
        local btnTheme = dgsCreateButton(16 + (i-1) * 120, 90, 110, 36, name, false, tabTheme, tocolor(255,255,255,255), 1, 1, nil, nil, nil, themeColors[i], themeColors[i], themeColors[i])
        addEventHandler("onDgsMouseClick", btnTheme, function(button, state)
            if button == "left" and state == "up" then
                -- Theme switching would be implemented via dgsSetTheme
                outputChatBox("[DGS] Theme switched to: " .. name, 99, 132, 255)
            end
        end)
    end
    
    -- Current theme info
    local currentThemeLabel = dgsCreateLabel(16, 140, 300, 20, "Current: Midnight", false, tabTheme)
    dgsSetFont(currentThemeLabel, "default-bold")
    
    -- Design tokens info
    local tokensLabel = dgsCreateLabel(16, 172, 400, 20, "Design System Tokens", false, tabTheme)
    dgsSetFont(tokensLabel, "default-bold")
    
    local tokenInfo = dgsCreateLabel(16, 196, 500, 100, 
        "Colors: 70+ semantic tokens\n" ..
        "Typography: 5 sizes, 3 weights\n" ..
        "Spacing: 14-point scale (2px - 64px)\n" ..
        "Radius: 8 values (0 - 9999)\n" ..
        "Components: 20+ built-in types", false, tabTheme)
    
    -- Store elements for cleanup
    elements.tabPanel = tabPanel
    
    return demoWindow
end

-- Toggle demo visibility with F7
bindKey("F7", "down", function()
    if demoVisible then
        if isElement(demoWindow) then
            dgsSetVisible(demoWindow, false)
        end
        demoVisible = false
    else
        if not isElement(demoWindow) then
            createDGSModernDemo()
        end
        dgsSetVisible(demoWindow, true)
        demoVisible = true
    end
end)

-- Output instructions
addEventHandler("onClientResourceStart", resourceRoot, function()
    setTimer(function()
        outputChatBox("═══════════════════════════════════════", 99, 132, 255)
        outputChatBox("  DGS Modern UI System v2.0", 99, 132, 255)
        outputChatBox("  Press F7 to toggle the demo panel", 200, 205, 215)
        outputChatBox("═══════════════════════════════════════", 99, 132, 255)
    end, 1000, 1)
end)

-- Cleanup on resource stop
addEventHandler("onClientResourceStop", resourceRoot, function()
    if isElement(demoWindow) then
        destroyElement(demoWindow)
        demoWindow = nil
    end
    elements = {}
end)
