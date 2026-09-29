--[[
    DGS Design System - Central Design Tokens
    Modern, Premium UI for MTA:SA
    
    This file defines all design tokens used throughout the library.
    All components reference these tokens for consistent visual language.
]]

-- Performance: Cache frequently used functions
local tocolor = tocolor
local mathFloor = math.floor
local mathMin = math.min
local mathMax = math.max

-- ==========================================
-- DESIGN TOKENS
-- ==========================================

DGSDesignSystem = {
    version = "2.0.0",
    
    -- ==========================================
    -- COLOR PALETTES
    -- ==========================================
    palettes = {
        -- Modern Dark Theme (Default)
        midnight = {
            name = "Midnight",
            description = "Premium dark theme with subtle blue undertones",
            
            -- Background layers (darkest to lightest)
            bgBase      = tocolor(15, 16, 20, 255),
            bgSurface   = tocolor(22, 24, 30, 255),
            bgElevated  = tocolor(30, 33, 40, 255),
            bgOverlay   = tocolor(38, 42, 52, 255),
            bgHover     = tocolor(45, 50, 62, 255),
            bgActive    = tocolor(52, 58, 72, 255),
            
            -- Borders
            borderSubtle  = tocolor(40, 44, 55, 255),
            borderDefault = tocolor(55, 60, 75, 255),
            borderStrong  = tocolor(70, 76, 95, 255),
            
            -- Text
            textPrimary   = tocolor(240, 242, 248, 255),
            textSecondary = tocolor(165, 172, 188, 255),
            textTertiary  = tocolor(110, 118, 135, 255),
            textDisabled  = tocolor(75, 80, 95, 255),
            textInverse   = tocolor(15, 16, 20, 255),
            
            -- Accent / Brand
            accentPrimary   = tocolor(99, 132, 255, 255),
            accentHover     = tocolor(115, 145, 255, 255),
            accentActive    = tocolor(80, 112, 230, 255),
            accentSubtle    = tocolor(99, 132, 255, 30),
            accentMuted     = tocolor(99, 132, 255, 15),
            
            -- Semantic Colors
            success     = tocolor(52, 199, 123, 255),
            successBg   = tocolor(52, 199, 123, 25),
            warning     = tocolor(255, 183, 77, 255),
            warningBg   = tocolor(255, 183, 77, 25),
            error       = tocolor(255, 82, 82, 255),
            errorBg     = tocolor(255, 82, 82, 25),
            info        = tocolor(77, 171, 247, 255),
            infoBg      = tocolor(77, 171, 247, 25),
            
            -- Special
            overlay     = tocolor(0, 0, 0, 160),
            scrim       = tocolor(0, 0, 0, 100),
            focusRing   = tocolor(99, 132, 255, 120),
            shadow      = tocolor(0, 0, 0, 100),
            
            -- Scrollbar
            scrollbarTrack    = tocolor(25, 27, 33, 200),
            scrollbarThumb    = tocolor(65, 70, 85, 220),
            scrollbarThumbHov = tocolor(85, 92, 110, 240),
            scrollbarThumbAct = tocolor(99, 132, 255, 240),
            
            -- Input
            inputBg       = tocolor(18, 20, 25, 255),
            inputBorder   = tocolor(50, 55, 68, 255),
            inputFocus    = tocolor(99, 132, 255, 255),
            inputText     = tocolor(235, 238, 245, 255),
            inputPlaceholder = tocolor(90, 96, 112, 255),
            
            -- Title bar
            titleBar      = tocolor(18, 20, 25, 245),
            titleBarBlur  = tocolor(12, 13, 16, 245),
            titleText     = tocolor(225, 228, 235, 255),
            
            -- Window
            windowBg      = tocolor(22, 24, 30, 248),
            windowBorder  = tocolor(42, 46, 58, 255),
            
            -- Button
            buttonDefault     = tocolor(45, 50, 62, 255),
            buttonDefaultHov  = tocolor(55, 60, 75, 255),
            buttonDefaultAct  = tocolor(40, 44, 55, 255),
            buttonPrimary     = tocolor(99, 132, 255, 255),
            buttonPrimaryHov  = tocolor(115, 148, 255, 255),
            buttonPrimaryAct  = tocolor(80, 115, 235, 255),
            buttonDanger      = tocolor(220, 50, 50, 255),
            buttonDangerHov   = tocolor(240, 65, 65, 255),
            buttonDangerAct   = tocolor(195, 40, 40, 255),
            buttonText        = tocolor(240, 242, 248, 255),
            buttonPrimaryText = tocolor(255, 255, 255, 255),
            
            -- Selection
            selectionBg     = tocolor(99, 132, 255, 35),
            selectionBorder = tocolor(99, 132, 255, 80),
            
            -- Tooltip
            tooltipBg   = tocolor(40, 44, 55, 240),
            tooltipText = tocolor(230, 232, 240, 255),
            
            -- Notification
            notifSuccess = tocolor(22, 35, 26, 245),
            notifWarning = tocolor(35, 30, 18, 245),
            notifError   = tocolor(35, 18, 18, 245),
            notifInfo    = tocolor(18, 28, 38, 245),
            
            -- Card
            cardBg       = tocolor(26, 28, 35, 245),
            cardBorder   = tocolor(40, 44, 55, 255),
            cardHover    = tocolor(32, 35, 43, 245),
            
            -- Progress
            progressTrack    = tocolor(30, 33, 40, 255),
            progressFill     = tocolor(99, 132, 255, 255),
            progressSuccess  = tocolor(52, 199, 123, 255),
            progressWarning  = tocolor(255, 183, 77, 255),
            progressError    = tocolor(255, 82, 82, 255),
            
            -- Tab
            tabBg        = tocolor(22, 24, 30, 255),
            tabActive    = tocolor(99, 132, 255, 255),
            tabInactive  = tocolor(40, 44, 55, 255),
            tabHover     = tocolor(50, 55, 68, 255),
            tabText      = tocolor(225, 228, 235, 255),
            tabTextInact = tocolor(130, 137, 155, 255),
        },
        
        -- Dark Theme
        dark = {
            name = "Dark",
            description = "Classic dark theme",
            
            bgBase      = tocolor(18, 18, 18, 255),
            bgSurface   = tocolor(25, 25, 28, 255),
            bgElevated  = tocolor(33, 33, 38, 255),
            bgOverlay   = tocolor(42, 42, 48, 255),
            bgHover     = tocolor(50, 50, 58, 255),
            bgActive    = tocolor(60, 60, 70, 255),
            
            borderSubtle  = tocolor(45, 45, 52, 255),
            borderDefault = tocolor(60, 60, 70, 255),
            borderStrong  = tocolor(80, 80, 92, 255),
            
            textPrimary   = tocolor(245, 245, 250, 255),
            textSecondary = tocolor(170, 170, 180, 255),
            textTertiary  = tocolor(115, 115, 128, 255),
            textDisabled  = tocolor(80, 80, 90, 255),
            textInverse   = tocolor(18, 18, 18, 255),
            
            accentPrimary   = tocolor(88, 166, 255, 255),
            accentHover     = tocolor(105, 178, 255, 255),
            accentActive    = tocolor(72, 148, 235, 255),
            accentSubtle    = tocolor(88, 166, 255, 30),
            accentMuted     = tocolor(88, 166, 255, 15),
            
            success   = tocolor(61, 200, 130, 255),
            successBg = tocolor(61, 200, 130, 25),
            warning   = tocolor(255, 180, 70, 255),
            warningBg = tocolor(255, 180, 70, 25),
            error     = tocolor(255, 75, 75, 255),
            errorBg   = tocolor(255, 75, 75, 25),
            info      = tocolor(70, 165, 245, 255),
            infoBg    = tocolor(70, 165, 245, 25),
            
            overlay   = tocolor(0, 0, 0, 160),
            scrim     = tocolor(0, 0, 0, 100),
            focusRing = tocolor(88, 166, 255, 120),
            shadow    = tocolor(0, 0, 0, 100),
            
            scrollbarTrack    = tocolor(22, 22, 25, 200),
            scrollbarThumb    = tocolor(65, 65, 75, 220),
            scrollbarThumbHov = tocolor(85, 85, 98, 240),
            scrollbarThumbAct = tocolor(88, 166, 255, 240),
            
            inputBg          = tocolor(12, 12, 14, 255),
            inputBorder      = tocolor(55, 55, 62, 255),
            inputFocus       = tocolor(88, 166, 255, 255),
            inputText        = tocolor(240, 240, 245, 255),
            inputPlaceholder = tocolor(90, 90, 100, 255),
            
            titleBar     = tocolor(12, 12, 14, 245),
            titleBarBlur = tocolor(8, 8, 10, 245),
            titleText    = tocolor(230, 230, 235, 255),
            
            windowBg     = tocolor(25, 25, 28, 248),
            windowBorder = tocolor(48, 48, 55, 255),
            
            buttonDefault     = tocolor(50, 50, 58, 255),
            buttonDefaultHov  = tocolor(62, 62, 72, 255),
            buttonDefaultAct  = tocolor(42, 42, 50, 255),
            buttonPrimary     = tocolor(88, 166, 255, 255),
            buttonPrimaryHov  = tocolor(105, 180, 255, 255),
            buttonPrimaryAct  = tocolor(72, 148, 235, 255),
            buttonDanger      = tocolor(220, 50, 50, 255),
            buttonDangerHov   = tocolor(240, 65, 65, 255),
            buttonDangerAct   = tocolor(195, 40, 40, 255),
            buttonText        = tocolor(240, 242, 248, 255),
            buttonPrimaryText = tocolor(255, 255, 255, 255),
            
            selectionBg     = tocolor(88, 166, 255, 35),
            selectionBorder = tocolor(88, 166, 255, 80),
            
            tooltipBg   = tocolor(45, 45, 52, 240),
            tooltipText = tocolor(235, 235, 240, 255),
            
            notifSuccess = tocolor(18, 30, 22, 245),
            notifWarning = tocolor(30, 26, 15, 245),
            notifError   = tocolor(30, 15, 15, 245),
            notifInfo    = tocolor(15, 24, 35, 245),
            
            cardBg     = tocolor(30, 30, 35, 245),
            cardBorder = tocolor(48, 48, 55, 255),
            cardHover  = tocolor(36, 36, 42, 245),
            
            progressTrack   = tocolor(35, 35, 40, 255),
            progressFill    = tocolor(88, 166, 255, 255),
            progressSuccess = tocolor(61, 200, 130, 255),
            progressWarning = tocolor(255, 180, 70, 255),
            progressError   = tocolor(255, 75, 75, 255),
            
            tabBg        = tocolor(25, 25, 28, 255),
            tabActive    = tocolor(88, 166, 255, 255),
            tabInactive  = tocolor(45, 45, 52, 255),
            tabHover     = tocolor(55, 55, 65, 255),
            tabText      = tocolor(230, 230, 235, 255),
            tabTextInact = tocolor(135, 135, 148, 255),
        },
        
        -- Light Theme
        light = {
            name = "Light",
            description = "Clean light theme",
            
            bgBase      = tocolor(248, 249, 252, 255),
            bgSurface   = tocolor(255, 255, 255, 255),
            bgElevated  = tocolor(245, 246, 250, 255),
            bgOverlay   = tocolor(240, 241, 246, 255),
            bgHover     = tocolor(232, 234, 240, 255),
            bgActive    = tocolor(220, 222, 230, 255),
            
            borderSubtle  = tocolor(225, 227, 235, 255),
            borderDefault = tocolor(210, 212, 222, 255),
            borderStrong  = tocolor(185, 188, 200, 255),
            
            textPrimary   = tocolor(20, 22, 30, 255),
            textSecondary = tocolor(80, 85, 100, 255),
            textTertiary  = tocolor(130, 135, 150, 255),
            textDisabled  = tocolor(180, 182, 192, 255),
            textInverse   = tocolor(255, 255, 255, 255),
            
            accentPrimary   = tocolor(67, 97, 238, 255),
            accentHover     = tocolor(82, 110, 245, 255),
            accentActive    = tocolor(55, 82, 218, 255),
            accentSubtle    = tocolor(67, 97, 238, 25),
            accentMuted     = tocolor(67, 97, 238, 12),
            
            success   = tocolor(30, 180, 100, 255),
            successBg = tocolor(30, 180, 100, 20),
            warning   = tocolor(235, 155, 45, 255),
            warningBg = tocolor(235, 155, 45, 20),
            error     = tocolor(230, 60, 60, 255),
            errorBg   = tocolor(230, 60, 60, 20),
            info      = tocolor(55, 150, 235, 255),
            infoBg    = tocolor(55, 150, 235, 20),
            
            overlay   = tocolor(0, 0, 0, 120),
            scrim     = tocolor(0, 0, 0, 60),
            focusRing = tocolor(67, 97, 238, 100),
            shadow    = tocolor(0, 0, 0, 50),
            
            scrollbarTrack    = tocolor(240, 241, 246, 200),
            scrollbarThumb    = tocolor(195, 198, 210, 220),
            scrollbarThumbHov = tocolor(170, 174, 190, 240),
            scrollbarThumbAct = tocolor(67, 97, 238, 240),
            
            inputBg          = tocolor(255, 255, 255, 255),
            inputBorder      = tocolor(210, 212, 222, 255),
            inputFocus       = tocolor(67, 97, 238, 255),
            inputText        = tocolor(25, 28, 35, 255),
            inputPlaceholder = tocolor(160, 165, 178, 255),
            
            titleBar     = tocolor(255, 255, 255, 248),
            titleBarBlur = tocolor(248, 248, 250, 248),
            titleText    = tocolor(25, 28, 35, 255),
            
            windowBg     = tocolor(255, 255, 255, 248),
            windowBorder = tocolor(215, 217, 225, 255),
            
            buttonDefault     = tocolor(235, 237, 242, 255),
            buttonDefaultHov  = tocolor(222, 225, 232, 255),
            buttonDefaultAct  = tocolor(210, 212, 220, 255),
            buttonPrimary     = tocolor(67, 97, 238, 255),
            buttonPrimaryHov  = tocolor(82, 110, 245, 255),
            buttonPrimaryAct  = tocolor(55, 82, 218, 255),
            buttonDanger      = tocolor(230, 60, 60, 255),
            buttonDangerHov   = tocolor(240, 75, 75, 255),
            buttonDangerAct   = tocolor(210, 50, 50, 255),
            buttonText        = tocolor(40, 44, 55, 255),
            buttonPrimaryText = tocolor(255, 255, 255, 255),
            
            selectionBg     = tocolor(67, 97, 238, 25),
            selectionBorder = tocolor(67, 97, 238, 70),
            
            tooltipBg   = tocolor(30, 32, 40, 235),
            tooltipText = tocolor(245, 246, 250, 255),
            
            notifSuccess = tocolor(235, 250, 240, 248),
            notifWarning = tocolor(252, 245, 230, 248),
            notifError   = tocolor(252, 235, 235, 248),
            notifInfo    = tocolor(232, 242, 252, 248),
            
            cardBg     = tocolor(255, 255, 255, 252),
            cardBorder = tocolor(220, 222, 230, 255),
            cardHover  = tocolor(248, 249, 252, 252),
            
            progressTrack   = tocolor(235, 237, 242, 255),
            progressFill    = tocolor(67, 97, 238, 255),
            progressSuccess = tocolor(30, 180, 100, 255),
            progressWarning = tocolor(235, 155, 45, 255),
            progressError   = tocolor(230, 60, 60, 255),
            
            tabBg        = tocolor(248, 249, 252, 255),
            tabActive    = tocolor(67, 97, 238, 255),
            tabInactive  = tocolor(230, 232, 240, 255),
            tabHover     = tocolor(238, 240, 246, 255),
            tabText      = tocolor(40, 44, 55, 255),
            tabTextInact = tocolor(130, 135, 150, 255),
        },
        
        -- Ocean Theme
        ocean = {
            name = "Ocean",
            description = "Deep ocean-inspired dark blue theme",
            
            bgBase      = tocolor(8, 18, 28, 255),
            bgSurface   = tocolor(12, 25, 38, 255),
            bgElevated  = tocolor(18, 32, 48, 255),
            bgOverlay   = tocolor(24, 40, 58, 255),
            bgHover     = tocolor(30, 48, 68, 255),
            bgActive    = tocolor(38, 58, 80, 255),
            
            borderSubtle  = tocolor(25, 42, 60, 255),
            borderDefault = tocolor(35, 55, 78, 255),
            borderStrong  = tocolor(50, 72, 98, 255),
            
            textPrimary   = tocolor(220, 238, 255, 255),
            textSecondary = tocolor(145, 180, 210, 255),
            textTertiary  = tocolor(90, 125, 160, 255),
            textDisabled  = tocolor(60, 85, 110, 255),
            textInverse   = tocolor(8, 18, 28, 255),
            
            accentPrimary   = tocolor(0, 180, 220, 255),
            accentHover     = tocolor(20, 195, 235, 255),
            accentActive    = tocolor(0, 160, 198, 255),
            accentSubtle    = tocolor(0, 180, 220, 30),
            accentMuted     = tocolor(0, 180, 220, 15),
            
            success   = tocolor(0, 200, 150, 255),
            successBg = tocolor(0, 200, 150, 25),
            warning   = tocolor(255, 190, 60, 255),
            warningBg = tocolor(255, 190, 60, 25),
            error     = tocolor(255, 75, 100, 255),
            errorBg   = tocolor(255, 75, 100, 25),
            info      = tocolor(0, 180, 220, 255),
            infoBg    = tocolor(0, 180, 220, 25),
            
            overlay   = tocolor(0, 5, 15, 170),
            scrim     = tocolor(0, 5, 15, 110),
            focusRing = tocolor(0, 180, 220, 120),
            shadow    = tocolor(0, 0, 0, 120),
            
            scrollbarTrack    = tocolor(10, 22, 34, 200),
            scrollbarThumb    = tocolor(40, 62, 85, 220),
            scrollbarThumbHov = tocolor(55, 80, 108, 240),
            scrollbarThumbAct = tocolor(0, 180, 220, 240),
            
            inputBg          = tocolor(5, 14, 22, 255),
            inputBorder      = tocolor(30, 50, 70, 255),
            inputFocus       = tocolor(0, 180, 220, 255),
            inputText        = tocolor(215, 235, 250, 255),
            inputPlaceholder = tocolor(70, 105, 140, 255),
            
            titleBar     = tocolor(5, 14, 22, 248),
            titleBarBlur = tocolor(4, 10, 16, 248),
            titleText    = tocolor(200, 225, 248, 255),
            
            windowBg     = tocolor(12, 25, 38, 248),
            windowBorder = tocolor(30, 52, 75, 255),
            
            buttonDefault     = tocolor(25, 42, 60, 255),
            buttonDefaultHov  = tocolor(35, 55, 78, 255),
            buttonDefaultAct  = tocolor(20, 35, 52, 255),
            buttonPrimary     = tocolor(0, 180, 220, 255),
            buttonPrimaryHov  = tocolor(20, 195, 235, 255),
            buttonPrimaryAct  = tocolor(0, 160, 198, 255),
            buttonDanger      = tocolor(220, 50, 70, 255),
            buttonDangerHov   = tocolor(240, 65, 82, 255),
            buttonDangerAct   = tocolor(195, 40, 60, 255),
            buttonText        = tocolor(215, 235, 250, 255),
            buttonPrimaryText = tocolor(255, 255, 255, 255),
            
            selectionBg     = tocolor(0, 180, 220, 30),
            selectionBorder = tocolor(0, 180, 220, 75),
            
            tooltipBg   = tocolor(30, 50, 70, 240),
            tooltipText = tocolor(215, 235, 250, 255),
            
            notifSuccess = tocolor(8, 30, 25, 245),
            notifWarning = tocolor(30, 25, 10, 245),
            notifError   = tocolor(30, 12, 15, 245),
            notifInfo    = tocolor(5, 22, 35, 245),
            
            cardBg     = tocolor(15, 28, 42, 245),
            cardBorder = tocolor(30, 52, 75, 255),
            cardHover  = tocolor(20, 35, 52, 245),
            
            progressTrack   = tocolor(18, 32, 48, 255),
            progressFill    = tocolor(0, 180, 220, 255),
            progressSuccess = tocolor(0, 200, 150, 255),
            progressWarning = tocolor(255, 190, 60, 255),
            progressError   = tocolor(255, 75, 100, 255),
            
            tabBg        = tocolor(12, 25, 38, 255),
            tabActive    = tocolor(0, 180, 220, 255),
            tabInactive  = tocolor(25, 42, 60, 255),
            tabHover     = tocolor(30, 50, 72, 255),
            tabText      = tocolor(200, 225, 248, 255),
            tabTextInact = tocolor(100, 135, 168, 255),
        },
        
        -- Emerald Theme
        emerald = {
            name = "Emerald",
            description = "Rich green-accented dark theme",
            
            bgBase      = tocolor(12, 18, 15, 255),
            bgSurface   = tocolor(18, 26, 22, 255),
            bgElevated  = tocolor(25, 35, 30, 255),
            bgOverlay   = tocolor(32, 44, 38, 255),
            bgHover     = tocolor(40, 54, 46, 255),
            bgActive    = tocolor(48, 65, 55, 255),
            
            borderSubtle  = tocolor(30, 42, 36, 255),
            borderDefault = tocolor(42, 58, 48, 255),
            borderStrong  = tocolor(58, 78, 65, 255),
            
            textPrimary   = tocolor(230, 248, 238, 255),
            textSecondary = tocolor(155, 195, 170, 255),
            textTertiary  = tocolor(100, 140, 118, 255),
            textDisabled  = tocolor(68, 95, 80, 255),
            textInverse   = tocolor(12, 18, 15, 255),
            
            accentPrimary   = tocolor(16, 185, 100, 255),
            accentHover     = tocolor(30, 200, 115, 255),
            accentActive    = tocolor(10, 168, 88, 255),
            accentSubtle    = tocolor(16, 185, 100, 30),
            accentMuted     = tocolor(16, 185, 100, 15),
            
            success   = tocolor(16, 185, 100, 255),
            successBg = tocolor(16, 185, 100, 25),
            warning   = tocolor(240, 180, 50, 255),
            warningBg = tocolor(240, 180, 50, 25),
            error     = tocolor(230, 60, 60, 255),
            errorBg   = tocolor(230, 60, 60, 25),
            info      = tocolor(50, 165, 220, 255),
            infoBg    = tocolor(50, 165, 220, 25),
            
            overlay   = tocolor(0, 5, 2, 170),
            scrim     = tocolor(0, 5, 2, 110),
            focusRing = tocolor(16, 185, 100, 120),
            shadow    = tocolor(0, 0, 0, 110),
            
            scrollbarTrack    = tocolor(15, 22, 18, 200),
            scrollbarThumb    = tocolor(45, 62, 52, 220),
            scrollbarThumbHov = tocolor(60, 82, 68, 240),
            scrollbarThumbAct = tocolor(16, 185, 100, 240),
            
            inputBg          = tocolor(8, 14, 11, 255),
            inputBorder      = tocolor(35, 50, 42, 255),
            inputFocus       = tocolor(16, 185, 100, 255),
            inputText        = tocolor(225, 245, 235, 255),
            inputPlaceholder = tocolor(75, 110, 92, 255),
            
            titleBar     = tocolor(8, 14, 11, 248),
            titleBarBlur = tocolor(6, 10, 8, 248),
            titleText    = tocolor(210, 240, 225, 255),
            
            windowBg     = tocolor(18, 26, 22, 248),
            windowBorder = tocolor(35, 52, 42, 255),
            
            buttonDefault     = tocolor(30, 42, 36, 255),
            buttonDefaultHov  = tocolor(40, 56, 46, 255),
            buttonDefaultAct  = tocolor(25, 36, 30, 255),
            buttonPrimary     = tocolor(16, 185, 100, 255),
            buttonPrimaryHov  = tocolor(30, 200, 115, 255),
            buttonPrimaryAct  = tocolor(10, 168, 88, 255),
            buttonDanger      = tocolor(230, 60, 60, 255),
            buttonDangerHov   = tocolor(240, 75, 75, 255),
            buttonDangerAct   = tocolor(210, 50, 50, 255),
            buttonText        = tocolor(225, 245, 235, 255),
            buttonPrimaryText = tocolor(255, 255, 255, 255),
            
            selectionBg     = tocolor(16, 185, 100, 30),
            selectionBorder = tocolor(16, 185, 100, 75),
            
            tooltipBg   = tocolor(35, 50, 42, 240),
            tooltipText = tocolor(225, 245, 235, 255),
            
            notifSuccess = tocolor(12, 30, 20, 245),
            notifWarning = tocolor(28, 28, 12, 245),
            notifError   = tocolor(28, 14, 14, 245),
            notifInfo    = tocolor(10, 24, 30, 245),
            
            cardBg     = tocolor(22, 32, 26, 245),
            cardBorder = tocolor(35, 52, 42, 255),
            cardHover  = tocolor(28, 40, 33, 245),
            
            progressTrack   = tocolor(25, 35, 30, 255),
            progressFill    = tocolor(16, 185, 100, 255),
            progressSuccess = tocolor(16, 185, 100, 255),
            progressWarning = tocolor(240, 180, 50, 255),
            progressError   = tocolor(230, 60, 60, 255),
            
            tabBg        = tocolor(18, 26, 22, 255),
            tabActive    = tocolor(16, 185, 100, 255),
            tabInactive  = tocolor(30, 42, 36, 255),
            tabHover     = tocolor(38, 52, 44, 255),
            tabText      = tocolor(210, 240, 225, 255),
            tabTextInact = tocolor(108, 148, 125, 255),
        },
    },
    
    -- ==========================================
    -- TYPOGRAPHY
    -- ==========================================
    typography = {
        fontFamilies = {
            default     = "default",          -- MTA built-in
            defaultBold = "default-bold",
            clear       = "default",           -- fallback to default
            clearBold   = "default-bold",
        },
        
        sizes = {
            xs   = 9,
            sm   = 10,
            base = 11,
            md   = 12,
            lg   = 14,
            xl   = 16,
            ["2xl"]  = 18,
            ["3xl"]  = 22,
            ["4xl"]  = 28,
        },
        
        weights = {
            normal = "default",
            medium = "default-bold",
            bold   = "default-bold",
        },
        
        lineHeights = {
            tight  = 1.2,
            normal = 1.4,
            relaxed = 1.6,
        },
    },
    
    -- ==========================================
    -- SPACING SCALE (in pixels, base 4px)
    -- ==========================================
    spacing = {
        [0]  = 0,
        [1]  = 2,
        [2]  = 4,
        [3]  = 6,
        [4]  = 8,
        [5]  = 10,
        [6]  = 12,
        [7]  = 16,
        [8]  = 20,
        [9]  = 24,
        [10] = 32,
        [11] = 40,
        [12] = 48,
        [13] = 64,
    },
    
    -- ==========================================
    -- BORDER RADIUS
    -- ==========================================
    radius = {
        none   = 0,
        sm     = 2,
        base   = 4,
        md     = 6,
        lg     = 8,
        xl     = 12,
        "2xl"  = 16,
        full   = 9999,
    },
    
    -- ==========================================
    -- SHADOWS (offsetX, offsetY, blur, color)
    -- ==========================================
    shadows = {
        none    = nil,
        sm      = {1, 1, 0, tocolor(0, 0, 0, 40)},
        base    = {2, 2, 0, tocolor(0, 0, 0, 55)},
        md      = {3, 4, 0, tocolor(0, 0, 0, 65)},
        lg      = {4, 6, 0, tocolor(0, 0, 0, 75)},
        xl      = {6, 10, 0, tocolor(0, 0, 0, 90)},
        inner   = {-1, -1, 0, tocolor(0, 0, 0, 30)},
    },
    
    -- ==========================================
    -- BORDERS
    -- ==========================================
    borders = {
        none   = 0,
        thin   = 1,
        base   = 1,
        medium = 2,
        thick  = 3,
    },
    
    -- ==========================================
    -- OPACITY
    -- ==========================================
    opacity = {
        disabled    = 0.45,
        placeholder = 0.55,
        muted       = 0.65,
        secondary   = 0.75,
        hover       = 0.85,
        full        = 1.0,
    },
    
    -- ==========================================
    -- TRANSITIONS / ANIMATION
    -- ==========================================
    transitions = {
        fast    = 100,    -- ms
        base    = 180,    -- ms
        slow    = 300,    -- ms
        slower  = 450,    -- ms
        
        easings = {
            default    = "InOutQuad",
            in         = "InQuad",
            out        = "OutQuad",
            inOut      = "InOutQuad",
            spring     = "OutBack",
            bounce     = "OutBounce",
            smooth     = "InOutCubic",
        },
    },
    
    -- ==========================================
    -- COMPONENT DEFAULTS
    -- ==========================================
    components = {
        window = {
            minWidth     = 200,
            minHeight    = 120,
            titleHeight  = 36,
            borderSize   = 1,
            radius       = 6,
            closeBtnSize = {28, 28},
            padding      = 12,
            shadowSize   = 4,
        },
        
        button = {
            height  = 32,
            radius  = 4,
            paddingH = 16,
            paddingV = 8,
            fontSize = 11,
            iconSize = 14,
        },
        
        input = {
            height   = 34,
            radius   = 4,
            paddingH = 10,
            paddingV = 8,
            fontSize = 11,
        },
        
        checkbox = {
            size     = 18,
            radius   = 3,
            spacing  = 8,
        },
        
        radio = {
            size     = 18,
            spacing  = 8,
        },
        
        switch = {
            width    = 40,
            height   = 22,
            thumbSize = 16,
            radius   = 11,
        },
        
        slider = {
            trackHeight = 4,
            thumbSize   = 16,
            radius      = 2,
        },
        
        scrollbar = {
            width  = 8,
            radius = 4,
            minThumb = 30,
        },
        
        tab = {
            height    = 36,
            paddingH  = 16,
            indicator = 2,
            fontSize  = 11,
        },
        
        card = {
            padding  = 16,
            radius   = 8,
            borderWidth = 1,
        },
        
        tooltip = {
            padding  = 8,
            radius   = 4,
            fontSize = 10,
            maxWidth = 250,
        },
        
        notification = {
            width    = 320,
            padding  = 12,
            radius   = 6,
            fontSize = 11,
        },
        
        progress = {
            height = 6,
            radius = 3,
        },
        
        badge = {
            height   = 20,
            radius   = 10,
            paddingH = 6,
            fontSize = 9,
        },
        
        avatar = {
            sizes = {
                xs = 24,
                sm = 32,
                md = 40,
                lg = 48,
                xl = 64,
            },
        },
    },
    
    -- ==========================================
    -- Z-INDEX LAYERS
    -- ==========================================
    zIndex = {
        base      = 0,
        dropdown  = 100,
        sticky    = 200,
        modal     = 1000,
        popover   = 1100,
        tooltip   = 1200,
        toast     = 1300,
    },
}

-- ==========================================
-- UTILITY FUNCTIONS
-- ==========================================

-- Get current active palette
local activePaletteName = "midnight"
local activePalette = DGSDesignSystem.palettes.midnight

function dgsGetDesignToken(path)
    -- e.g. "colors.bgSurface", "spacing.4", "radius.md"
    local parts = {}
    for part in path:gmatch("[^.]+") do
        parts[#parts + 1] = part
    end
    
    local current = DGSDesignSystem
    for i = 1, #parts do
        if current[parts[i]] == nil then return nil end
        current = current[parts[i]]
    end
    return current
end

function dgsSetTheme(themeName)
    if DGSDesignSystem.palettes[themeName] then
        activePaletteName = themeName
        activePalette = DGSDesignSystem.palettes[themeName]
        return true
    end
    return false
end

function dgsGetTheme()
    return activePaletteName
end

function dgsGetThemeList()
    local list = {}
    for name, data in pairs(DGSDesignSystem.palettes) do
        list[name] = data.name
    end
    return list
end

function dgsGetActivePalette()
    return activePalette
end

function dgsGetPaletteColor(tokenName)
    return activePalette[tokenName]
end

-- Color manipulation utilities
function dgsColorWithAlpha(color, alpha)
    local r, g, b, a = color and fromcolor(color) or 255, 255, 255, 255
    if type(color) == "number" then
        r, g, b, a = fromcolor(color)
    end
    return tocolor(r, g, b, mathFloor(alpha * 255))
end

function dgsColorLerp(color1, color2, t)
    local r1, g1, b1, a1 = fromcolor(color1)
    local r2, g2, b2, a2 = fromcolor(color2)
    return tocolor(
        mathFloor(r1 + (r2 - r1) * t),
        mathFloor(g1 + (g2 - g1) * t),
        mathFloor(b1 + (b2 - b1) * t),
        mathFloor(a1 + (a2 - a1) * t)
    )
end

-- ==========================================
-- DRAWING UTILITIES (Used by components)
-- ==========================================

local dxDrawRectangle = dxDrawRectangle
local dxDrawLine = dxDrawLine

-- Draw rounded rectangle (software approach using multiple rects)
function dgsDrawRoundedRect(x, y, w, h, radius, color, postGUI)
    if not color then return end
    if radius <= 0 then
        dxDrawRectangle(x, y, w, h, color, postGUI)
        return
    end
    
    radius = mathMin(radius, mathMin(w, h) / 2)
    
    -- Main body
    dxDrawRectangle(x + radius, y, w - radius * 2, h, color, postGUI)
    -- Left strip
    dxDrawRectangle(x, y + radius, radius, h - radius * 2, color, postGUI)
    -- Right strip
    dxDrawRectangle(x + w - radius, y + radius, radius, h - radius * 2, color, postGUI)
    
    -- Corners (approximated with small rects for smooth appearance)
    local steps = mathMax(4, mathFloor(radius / 2))
    for i = 0, steps do
        local angle = (i / steps) * (math.pi / 2)
        local ox = radius - mathFloor(math.cos(angle) * radius)
        local oy = radius - mathFloor(math.sin(angle) * radius)
        local sw = mathFloor(math.cos(angle) * radius) - mathFloor(math.cos((i+1)/steps * (math.pi/2)) * radius)
        local sh = mathFloor(math.sin((i+1)/steps * (math.pi/2)) * radius) - mathFloor(math.sin(angle) * radius)
        
        -- Top-left corner
        dxDrawRectangle(x + ox, y + oy, mathMax(1, sw), mathMax(1, sh), color, postGUI)
        -- Top-right corner
        dxDrawRectangle(x + w - radius - mathMax(0, sw - 1) + ox, y + oy, mathMax(1, sw), mathMax(1, sh), color, postGUI)
        -- Bottom-left corner
        dxDrawRectangle(x + ox, y + h - radius - mathMax(0, sh - 1) + oy, mathMax(1, sw), mathMax(1, sh), color, postGUI)
        -- Bottom-right corner
        dxDrawRectangle(x + w - radius - mathMax(0, sw - 1) + ox, y + h - radius - mathMax(0, sh - 1) + oy, mathMax(1, sw), mathMax(1, sh), color, postGUI)
    end
end

-- Simplified rounded rect using fill approach
function dgsDrawRoundedRectFill(x, y, w, h, r, color, postGUI)
    if not color then return end
    r = mathMin(r or 0, mathMin(w, h) / 2)
    if r <= 0 then
        dxDrawRectangle(x, y, w, h, color, postGUI)
        return
    end
    -- Cross shape
    dxDrawRectangle(x + r, y, w - r*2, h, color, postGUI)
    dxDrawRectangle(x, y + r, w, h - r*2, color, postGUI)
    -- Corner circles approximated
    -- Use 4 corner rectangles to fill gaps
    local corners = {
        {x, y}, {x + w - r, y}, {x, y + h - r}, {x + w - r, y + h - r}
    }
    for i = 1, 4 do
        dxDrawRectangle(corners[i][1], corners[i][2], r, r, color, postGUI)
    end
    -- Mask corners (draw bg-colored rects over corners to round them)
    -- This is a simplified approach - for MTA, we use the shader-based rounded rect when available
end

-- Draw border for a rect
function dgsDrawBorder(x, y, w, h, color, borderWidth, radius, postGUI)
    if not color then return end
    borderWidth = borderWidth or 1
    
    if radius and radius > 0 then
        -- Draw rounded border using lines at each edge
        -- Top
        dxDrawLine(x + radius, y, x + w - radius, y, color, borderWidth, postGUI)
        -- Bottom
        dxDrawLine(x + radius, y + h, x + w - radius, y + h, color, borderWidth, postGUI)
        -- Left
        dxDrawLine(x, y + radius, x, y + h - radius, color, borderWidth, postGUI)
        -- Right
        dxDrawLine(x + w, y + radius, x + w, y + h - radius, color, borderWidth, postGUI)
    else
        -- Simple rectangular border
        dxDrawLine(x, y, x + w, y, color, borderWidth, postGUI) -- Top
        dxDrawLine(x, y + h, x + w, y + h, color, borderWidth, postGUI) -- Bottom
        dxDrawLine(x, y, x, y + h, color, borderWidth, postGUI) -- Left
        dxDrawLine(x + w, y, x + w, y + h, color, borderWidth, postGUI) -- Right
    end
end

-- Draw a modern shadow effect (multiple layered rects)
function dgsDrawShadow(x, y, w, h, shadowSize, shadowColor, radius, postGUI)
    if not shadowSize or shadowSize <= 0 then return end
    shadowColor = shadowColor or tocolor(0, 0, 0, 60)
    
    for i = shadowSize, 1, -1 do
        local alpha = mathFloor((shadowSize - i + 1) / shadowSize * 40)
        local c = tocolor(0, 0, 0, alpha)
        dxDrawRectangle(x - i, y - i, w + i*2, h + i*2, c, postGUI)
    end
end
