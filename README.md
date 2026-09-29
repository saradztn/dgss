# DGS - Modern DirectX GUI System

**Version 4.0.0** — A comprehensive, modern, and performant GUI library for MTA:SA.

DGS (DirectX Graphic System) is a complete UI framework for Multi Theft Auto: San Andreas that provides a rich set of GUI components rendered using DirectX. This version features a completely redesigned visual system with multiple themes, modern components, and an enhanced design system.

---

## ✨ What's New in v4.0

### Design System
- **Centralized Design Tokens**: Colors, typography, spacing, radius, shadows, transitions all managed centrally
- **5 Built-in Themes**: Midnight (default), Dark, Light, Ocean, Emerald
- **Runtime Theme Switching**: Change themes without restarting resources
- **Semantic Color Tokens**: 70+ named color tokens for consistent UI

### New Components
- **Notification** — Toast-style notifications with auto-dismiss and stacking
- **Card** — Container component for grouping related content
- **Slider** — Modern range slider with thumb and track
- **Divider** — Visual separator with optional label
- **Badge** — Status indicator tags with variant colors

### Enhanced Components
- **Window** — Modern title bar, accent bar, focus indicator, thin borders
- **Button** — Color transitions, ghost/primary/danger variants
- **All Components** — Consistent spacing, typography, and visual language

### Performance
- Optimized rendering pipeline
- Reduced draw calls through caching
- Efficient animation system
- Lazy element data initialization

---

## 🚀 Quick Start

### Installation

1. Copy the `dgs` folder to your MTA:SA server's `resources` directory
2. Add `<resource src="dgs" />` to your server's `mtaserver.conf`
3. Start the resource: `start dgs`

### Basic Usage

```lua
-- Create a window
local window = dgsCreateWindow(200, 150, 400, 300, "My Window", false)

-- Add a button
local button = dgsCreateButton(20, 40, 120, 34, "Click Me", false, window)

-- Handle click
addEventHandler("onDgsMouseClick", button, function(button, state)
    if button == "left" and state == "up" then
        outputChatBox("Button clicked!")
    end
end)
```

### Using the New Components

```lua
-- Notifications
dgsCreateNotification("Operation successful!", "success", 4000, "topRight", "Done")

-- Cards
local card = dgsCreateCard(20, 20, 200, 120, false, parent, "Title", "Subtitle")
dgsSetData(card, "accentColor", tocolor(52, 199, 123, 255))

-- Slider
local slider = dgsCreateSlider(20, 160, 200, 20, false, parent, 0, 100, 50)
addEventHandler("onDgsSliderChange", slider, function(value)
    outputChatBox("Value: " .. value)
end)

-- Badges
local badge = dgsCreateBadge(20, 200, 60, 22, "NEW", false, parent, "primary")

-- Dividers
local divider = dgsCreateDivider(20, 230, 300, 2, false, parent)
```

---

## 🎨 Themes

### Available Themes

| Theme | Description |
|-------|-------------|
| **Midnight** | Premium dark theme with blue accents (default) |
| **Dark** | Classic dark theme |
| **Light** | Clean light theme |
| **Ocean** | Deep ocean-inspired dark blue |
| **Emerald** | Rich green-accented dark theme |

### Switching Themes

```lua
-- Switch theme at runtime
dgsSetTheme("ocean")
dgsSetTheme("emerald")
dgsSetTheme("light")

-- Get current theme
local current = dgsGetTheme()

-- List all available themes
local themes = dgsGetThemeList()
```

### Design Tokens

Access design tokens programmatically:

```lua
-- Get a color token
local bgSurface = dgsGetPaletteColor("bgSurface")
local accent = dgsGetPaletteColor("accentPrimary")
local success = dgsGetPaletteColor("success")

-- Get design values
local radius = dgsGetDesignToken("radius.md")
local spacing = dgsGetDesignToken("spacing.4")

-- Color utilities
local semiTransparent = dgsColorWithAlpha(accent, 0.5)
local interpolated = dgsColorLerp(color1, color2, 0.5)
```

---

## 📦 Components

### Core Components

| Component | Creation Function | Description |
|-----------|-------------------|-------------|
| Window | `dgsCreateWindow` | Draggable, resizable window |
| Button | `dgsCreateButton` | Clickable button with states |
| Label | `dgsCreateLabel` | Text display |
| Edit | `dgsCreateEdit` | Single-line text input |
| Memo | `dgsCreateMemo` | Multi-line text input |
| Checkbox | `dgsCreateCheckBox` | Boolean toggle with 3 states |
| RadioButton | `dgsCreateRadioButton` | Single selection from group |
| ComboBox | `dgsCreateComboBox` | Dropdown selection |
| GridList | `dgsCreateGridList` | Tabular data display |
| TabPanel | `dgsCreateTabPanel` | Tabbed container |
| ScrollBar | `dgsCreateScrollBar` | Scroll control |
| ScrollPane | `dgsCreateScrollPane` | Scrollable container |
| ProgressBar | `dgsCreateProgressBar` | Progress indicator |
| SwitchButton | `dgsCreateSwitchButton` | Toggle switch |
| Selector | `dgsCreateSelector` | Arrow-based selector |
| Image | `dgsCreateImage` | Image display |
| Menu | `dgsCreateMenu` | Context menu |
| Browser | `dgsCreateBrowser` | Web browser |

### New Components (v4.0)

| Component | Creation Function | Description |
|-----------|-------------------|-------------|
| Notification | `dgsCreateNotification` | Toast notifications |
| Card | `dgsCreateCard` | Content container |
| Slider | `dgsCreateSlider` | Range input |
| Divider | `dgsCreateDivider` | Visual separator |
| Badge | `dgsCreateBadge` | Status tag |

### Plugin Components

| Component | Creation Function | Description |
|-----------|-------------------|-------------|
| ToolTip | `dgsCreateToolTip` | Hover tooltips |
| ColorPicker | `dgsCreateColorPicker` | Color selection |
| BlurBox | `dgsCreateBlurBox` | Blur effect |
| Canvas | `dgsCreateCanvas` | Drawing canvas |
| SVG | `dgsCreateSVG` | SVG rendering |
| Chart | `dgsCreateChart` | Data visualization |
| NineSlice | `dgsCreateNineSlice` | 9-slice scaling |
| Gradient | `dgsCreateGradient` | Gradient fills |
| Circle | `dgsCreateCircle` | Circle shapes |
| Quad | `dgsCreateQuad` | Quad shapes |
| Mask | `dgsCreateMask` | Mask effects |
| Media | `dgsCreateMediaBrowser` | Video/audio player |
| RemoteImage | `dgsCreateRemoteImage` | Remote image loading |
| QRCode | `dgsRequestQRCode` | QR code generation |

---

## 🔧 API Reference

### Window

```lua
local window = dgsCreateWindow(x, y, w, h, title, relative, textColor, titleHeight, titleImage, titleColor, image, color, borderSize, noCloseButton)

-- Properties
dgsSetData(window, "movableView", true)      -- Enable/disable dragging
dgsSetData(window, "sizable", true)           -- Enable/disable resizing
dgsSetData(window, "accentBar", tocolor(...)) -- Add accent bar
dgsSetData(window, "radius", 6)              -- Border radius

-- Functions
dgsCloseWindow(window)
dgsWindowSetMovable(window, bool)
dgsWindowSetSizable(window, bool)
dgsWindowGetCloseButton(window)
```

### Button

```lua
local button = dgsCreateButton(x, y, w, h, text, relative, parent, textColor, scaleX, scaleY, normalImage, hoverImage, clickImage, normalColor, hoverColor, clickColor)

-- Properties
dgsSetData(button, "radius", 4)
dgsSetData(button, "borderColor", tocolor(...))
dgsSetData(button, "borderWidth", 1)
```

### Edit (Input)

```lua
local edit = dgsCreateEdit(x, y, w, h, text, relative, parent, ...)

-- Properties
dgsSetData(edit, "placeHolder", "Placeholder text...")
dgsSetData(edit, "radius", 4)
dgsSetData(edit, "borderColor", tocolor(...))
dgsSetData(edit, "focusBorderColor", tocolor(99, 132, 255, 255))
dgsSetData(edit, "maskText", "*")  -- For password fields
```

### Notification

```lua
-- Types: "success", "warning", "error", "info"
-- Positions: "topRight", "topLeft", "topCenter", "bottomRight", "bottomLeft", "bottomCenter"
local notif = dgsCreateNotification(message, type, duration, position, title)
dgsDismissNotification(notif)
```

### Slider

```lua
local slider = dgsCreateSlider(x, y, w, h, relative, parent, min, max, value, orientation)
dgsSliderGetValue(slider)
dgsSliderSetValue(slider, value, triggerEvent)
dgsSliderSetRange(slider, min, max)
dgsSliderSetStep(slider, step)

-- Events
addEventHandler("onDgsSliderChange", slider, function(newValue)
    -- Handle value change
end)
```

### Card

```lua
local card = dgsCreateCard(x, y, w, h, relative, parent, title, subtitle)
dgsCardSetTitle(card, "New Title")
dgsCardSetSubtitle(card, "New Subtitle")
dgsSetData(card, "accentColor", tocolor(99, 132, 255, 255))
dgsSetData(card, "accentPosition", "top")  -- top, left, bottom, right
```

### Badge

```lua
-- Variants: "default", "primary", "success", "warning", "error", "info"
local badge = dgsCreateBadge(x, y, w, h, text, relative, parent, variant)
dgsBadgeSetText(badge, "NEW")
dgsBadgeSetVariant(badge, "success")
```

---

## 🎬 Animation System

```lua
-- Animate any property
dgsAnimTo(element, "alpha", 0.5, "InOutQuad", 500)

-- Move with animation
dgsMoveTo(element, x, y, relative, "OutBack", 400)

-- Resize with animation
dgsSizeTo(element, w, h, relative, "InOutCubic", 300)

-- Alpha animation
dgsAlphaTo(element, 0, false, "InQuad", 300)

-- Check animation state
dgsIsAniming(element)
dgsIsMoving(element)
dgsStopAniming(element)
```

### Custom Easing Functions

```lua
dgsAddEasingFunction("myEasing", function(progress)
    return progress * progress * (3 - 2 * progress) -- Smoothstep
end)
```

---

## 📐 Scaling

DGS automatically handles scaling across different resolutions:

```lua
-- Relative positioning (0-1 range maps to screen)
local window = dgsCreateWindow(0.2, 0.2, 0.6, 0.6, "Scaled", true)

-- Absolute positioning (pixel values)
local window = dgsCreateWindow(200, 150, 600, 400, "Fixed", false)
```

---

## 🔄 Backward Compatibility

DGS v4.0 maintains backward compatibility with existing DGS scripts:

- All existing `dgsCreate*` functions work the same way
- Property system is unchanged
- Event system is unchanged
- Style manager API is preserved
- Old scripts will automatically use the Modern theme

To use the legacy Default theme:

```lua
-- In styleManager/styleMapper.lua
use = "Default"
```

---

## 📊 Events

### Common Events

```lua
"onDgsMouseClick"           -- Mouse click
"onDgsMouseClickDown"      -- Mouse button down
"onDgsMouseClickUp"        -- Mouse button up
"onDgsMouseEnter"          -- Mouse enters element
"onDgsMouseLeave"          -- Mouse leaves element
"onDgsMouseWheel"          -- Mouse scroll
"onDgsFocus"               -- Element receives focus
"onDgsBlur"                -- Element loses focus
"onDgsSizeChange"          -- Element size changed
"onDgsPositionChange"      -- Element position changed
"onDgsTextChange"          -- Text changed (edit/memo)
"onDgsWindowClose"         -- Window close requested
"onDgsTabSelect"           -- Tab selected
"onDgsGridListItemSelect"  -- Grid list item selected
"onDgsComboBoxSelect"      -- ComboBox item selected
"onDgsSliderChange"        -- Slider value changed
"onDgsNotificationDismiss" -- Notification dismissed
```

---

## 🛠 Development

### Demo

Press **F7** in-game to toggle the component showcase demo.

### Debugging

```lua
-- Enable DGS debug mode
/dgsdebug

-- Check render statistics
dgsGetRenderSetting("renderPriority")
```

### Custom Themes

Create custom themes by adding a new folder in `styleManager/`:

```
styleManager/
├── MyTheme/
│   ├── styleSettings.txt    -- Theme configuration
│   └── Images/              -- Theme-specific images
│       ├── checkbox/
│       ├── radiobutton/
│       └── ...
```

Then register in `styleManager/styleMapper.lua`:

```lua
MyTheme = "MyTheme",
```

---

## 📝 Requirements

- MTA:SA 1.6.0 or later
- Client version 9.21938+
- Server version 9.21938+

---

## 📄 License

This project is maintained by the DGS Community.
Originally created by thisdp.

---

## 🔗 Links

- [DGS Wiki](http://wiki.mtasa.com/Dgs/StyleManager)
- [MTA:SA Forums](https://forum.mtasa.com/)
- [GitHub Repository](https://github.com/thisdp/dgs/)
