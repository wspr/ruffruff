# RuffRuff App Screenshots & UI Preview

Since this is a brand-new iOS app that needs to be built on macOS, here are detailed text-based representations of what the app will look like when running.

## Tab Bar Interface

The app has a standard iOS tab bar with two tabs:

### Tab 1: Editor 📄
Main interface for opening and viewing Python files with lint results

### Tab 2: Settings ⚙️
Configuration interface for Ruff linting parameters

---

## 1. Initial Launch Screen (Empty State)

When you first launch the app or when no file is open:

```
╔════════════════════════════════════════╗
║  Ruff Linter              [×] [📁]    ║
╠════════════════════════════════════════╣
║                                        ║
║                                        ║
║              🔍                        ║
║     (64pt search icon)                 ║
║                                        ║
║         No File Open                   ║
║         (Large Bold Text)              ║
║                                        ║
║  Open a Python file to start linting  ║
║         (Secondary Text)               ║
║                                        ║
║      ┌─────────────────────┐          ║
║      │  📁  Open File      │          ║
║      │  (Accent Color Btn) │          ║
║      └─────────────────────┘          ║
║                                        ║
║                                        ║
╠════════════════════════════════════════╣
║   [📄 Editor]     [ ⚙️ Settings]     ║
╚════════════════════════════════════════╝
```

**Elements:**
- Navigation bar with title "Ruff Linter"
- X button (disabled when no file open)
- Folder button to open file picker
- Large centered icon
- Helpful text
- Primary action button
- Tab bar at bottom

---

## 2. File Picker Interface

After tapping the folder icon or "Open File" button, iOS standard file picker appears:

```
╔════════════════════════════════════════╗
║  < Locations          [Cancel]         ║
╠════════════════════════════════════════╣
║  📱 On My iPhone                       ║
║  ☁️  iCloud Drive                      ║
║  📁 Downloads                          ║
║  📁 Documents                          ║
║  ⭐ Favorites                          ║
║                                        ║
║  Recent Files:                         ║
║  ┌─────────────────────────┐          ║
║  │ 📄 sample.py            │          ║
║  │ Modified: 2 hours ago   │          ║
║  └─────────────────────────┘          ║
║  ┌─────────────────────────┐          ║
║  │ 📄 test_script.py       │          ║
║  │ Modified: Yesterday     │          ║
║  └─────────────────────────┘          ║
║                                        ║
╚════════════════════════════════════════╝
```

---

## 3. Editor View with Code (No Errors)

After opening a clean Python file:

```
╔════════════════════════════════════════╗
║  Ruff Linter        [×] [▶️] [📁]    ║
╠════════════════════════════════════════╣
║  sample.py                 ✓ No Issues║
╠═══╦════════════════════════════════════╣
║   ║ """Sample Python module."""       ║
║ 1 ║                                    ║
║ 2 ║ import os                          ║
║ 3 ║ import sys                         ║
║ 4 ║                                    ║
║ 5 ║                                    ║
║ 6 ║ def greet(name):                   ║
║ 7 ║     """Greet the user."""          ║
║ 8 ║     print(f"Hello, {name}!")       ║
║ 9 ║     return True                    ║
║10 ║                                    ║
║11 ║                                    ║
║12 ║ if __name__ == "__main__":         ║
║13 ║     greet("World")                 ║
║14 ║                                    ║
║   ║                                    ║
╠═══╩════════════════════════════════════╣
║   [📄 Editor]     [ ⚙️ Settings]     ║
╚════════════════════════════════════════╝
```

**Key Features:**
- Play button (▶️) to re-run linting
- Green checkmark showing no issues
- Line numbers in left gutter (gray background)
- Syntax-highlighted code with:
  - Purple: `def`, `import`, `if`, `return`
  - Green: Strings like `"Hello, {name}!"`
  - Gray: Comments like `"""Greet the user."""`

---

## 4. Editor View with Errors and Warnings

When linting finds issues:

```
╔════════════════════════════════════════╗
║  Ruff Linter        [×] [▶️] [📁]    ║
╠════════════════════════════════════════╣
║  sample.py            ⚠️  2    🔴 1   ║
╠═══╦════════════════════════════════════╣
║   ║ import os                          ║
║ 1 ║ import sys                         ║
║ 2 ║                                    ║
║ 3 ║                                    ║
║⚠️ ║ def very_long_function_name_that...║
║ 4 ║     # This line is really long    ║
║ 5 ║     x = 1                          ║
║🔴║     unused = "This is never used"  ║
║ 6 ║     return x                       ║
║ 7 ║                                    ║
║⚠️ ║ def another_function():            ║
║ 8 ║     pass  # Missing docstring     ║
║ 9 ║                                    ║
║10 ║                                    ║
║   ║                                    ║
╠═══╩════════════════════════════════════╣
║ Found 3 issue(s)                       ║
╠════════════════════════════════════════╣
║   [📄 Editor]     [ ⚙️ Settings]     ║
╚════════════════════════════════════════╝
```

**Issue Indicators:**
- Header badge: `⚠️ 2` (2 warnings), `🔴 1` (1 error)
- Gutter icons:
  - ⚠️ (Orange triangle) for warnings
  - 🔴 (Red circle) for errors
- Lines with issues have subtle red background
- Bottom summary: "Found 3 issue(s)"

---

## 5. Editor View with Selected Diagnostic

When user taps on a diagnostic icon:

```
╔════════════════════════════════════════╗
║  Ruff Linter        [×] [▶️] [📁]    ║
╠════════════════════════════════════════╣
║  sample.py            ⚠️  2    🔴 1   ║
╠═══╦════════════════════════════════════╣
║   ║ import os                          ║
║ 1 ║ import sys                         ║
║ 2 ║                                    ║
║ 3 ║                                    ║
║⚠️ ║ def very_long_function_name_that...║
║ 4 ║     # This line exceeds 88 chars  ║
║ 5 ║     x = 1                          ║
║🔴║     unused = "This is never used"  ║
║ 6 ║     return x                       ║
║ 7 ║                                    ║
║   ║                                    ║
╠═══╩════════════════════════════════════╣
║  🔴 F841             Line 6, Column 5  ║
║                                        ║
║  Local variable 'unused' is assigned   ║
║  but never used                        ║
║                                        ║
╠════════════════════════════════════════╣
║   [📄 Editor]     [ ⚙️ Settings]     ║
╚════════════════════════════════════════╝
```

**Diagnostic Detail Panel (Expanded):**
- Red/Orange indicator with rule code (F841)
- Line and column location
- Full error message
- Color-coded background (light red for errors, light orange for warnings)

---

## 6. Settings Tab - Main View

```
╔════════════════════════════════════════╗
║  Settings                              ║
╠════════════════════════════════════════╣
║                                        ║
║  LINE LENGTH                           ║
║  ┌──────────────────────────────────┐ ║
║  │ Max Line Length        88  [−][+]│ ║
║  └──────────────────────────────────┘ ║
║                                        ║
║  RULE SELECTION                        ║
║  ┌──────────────────────────────────┐ ║
║  │ Selected Rules              〉    │ ║
║  │ E, F, W                          │ ║
║  └──────────────────────────────────┘ ║
║  ┌──────────────────────────────────┐ ║
║  │ Ignored Rules               〉    │ ║
║  │ None                             │ ║
║  └──────────────────────────────────┘ ║
║                                        ║
║  ABOUT                                 ║
║  ┌──────────────────────────────────┐ ║
║  │ Version                    1.0.0 │ ║
║  │ Ruff Documentation          〉   │ ║
║  └──────────────────────────────────┘ ║
║                                        ║
║  ┌──────────────────────────────────┐ ║
║  │ Reset to Defaults                │ ║
║  │ (Red text, centered)             │ ║
║  └──────────────────────────────────┘ ║
║                                        ║
╠════════════════════════════════════════╣
║   [ 📄 Editor]     [⚙️ Settings]     ║
╚════════════════════════════════════════╝
```

**Settings Sections:**
1. **Line Length**: Stepper control (40-120 range)
2. **Rule Selection**: Two navigation rows
3. **About**: Info and link to docs
4. **Reset**: Destructive action in red

---

## 7. Rule Selection Screen

When tapping "Selected Rules":

```
╔════════════════════════════════════════╗
║  〈 Select Rules                        ║
╠════════════════════════════════════════╣
║                                        ║
║  SELECTED RULES                        ║
║  ┌──────────────────────────────────┐ ║
║  │ E                         [⊖]    │ ║
║  │ F                         [⊖]    │ ║
║  │ W                         [⊖]    │ ║
║  └──────────────────────────────────┘ ║
║                                        ║
║  AVAILABLE RULES                       ║
║  ┌──────────────────────────────────┐ ║
║  │ E                          ✓     │ ║
║  │ Pycodestyle Error                │ ║
║  ├──────────────────────────────────┤ ║
║  │ F                          ✓     │ ║
║  │ Pyflakes                         │ ║
║  ├──────────────────────────────────┤ ║
║  │ W                          ✓     │ ║
║  │ Pycodestyle Warning              │ ║
║  ├──────────────────────────────────┤ ║
║  │ C90                              │ ║
║  │ McCabe Complexity                │ ║
║  ├──────────────────────────────────┤ ║
║  │ I                                │ ║
║  │ isort                            │ ║
║  ├──────────────────────────────────┤ ║
║  │ N                                │ ║
║  │ pep8-naming                      │ ║
║  └──────────────────────────────────┘ ║
║                                        ║
║  CUSTOM RULE                           ║
║  ┌──────────────────────────────────┐ ║
║  │ [Rule Code (e.g., E501)]   [⊕]  │ ║
║  └──────────────────────────────────┘ ║
║                                        ║
╚════════════════════════════════════════╝
```

**Features:**
- Back button (〈) to return to Settings
- List of currently selected rules with remove buttons
- Tappable list of available rules (checkmark when selected)
- Custom rule text field with add button

---

## 8. Ignored Rules Screen

When tapping "Ignored Rules":

```
╔════════════════════════════════════════╗
║  〈 Ignore Rules                        ║
╠════════════════════════════════════════╣
║                                        ║
║  IGNORED RULES                         ║
║  ┌──────────────────────────────────┐ ║
║  │ No rules ignored                 │ ║
║  │ (Secondary gray text)            │ ║
║  └──────────────────────────────────┘ ║
║                                        ║
║  ADD RULE TO IGNORE                    ║
║  ┌──────────────────────────────────┐ ║
║  │ [Rule Code (e.g., E501)]   [⊕]  │ ║
║  └──────────────────────────────────┘ ║
║                                        ║
║                                        ║
╚════════════════════════════════════════╝
```

---

## 9. iPad Layout (Landscape)

On iPad, the app takes advantage of larger screen:

```
╔════════════════════════════════════════════════════════════╗
║  Ruff Linter                          [×] [▶️] [📁]       ║
╠════════════════════════════════════════════════════════════╣
║  sample.py                                  ⚠️  2    🔴 1 ║
╠═════╦══════════════════════════════════════════════════════╣
║     ║                                                      ║
║   1 ║ import os                                            ║
║   2 ║ import sys                                           ║
║   3 ║                                                      ║
║ ⚠️  ║ def very_long_function_name_that_exceeds_the_max_... ║
║   4 ║     """This function demonstrates warnings."""      ║
║   5 ║     x = 1                                            ║
║ 🔴 ║     unused_variable = "This is never used"           ║
║   6 ║     return x                                         ║
║   7 ║                                                      ║
║     ║                                                      ║
╠═════╩══════════════════════════════════════════════════════╣
║  🔴 F841                               Line 6, Column 5   ║
║  Local variable 'unused_variable' is assigned but never   ║
║  used                                                      ║
╠════════════════════════════════════════════════════════════╣
║                [📄 Editor]     [⚙️ Settings]              ║
╚════════════════════════════════════════════════════════════╝
```

**iPad Advantages:**
- Wider code view
- More visible context
- Split-view support for multitasking
- All orientations supported

---

## Color Scheme

### Light Mode (Default)
- Background: White (#FFFFFF)
- Gutter: Light Gray (#F2F2F7)
- Text: Black (#000000)
- Secondary Text: Gray (#8E8E93)
- Keywords: Purple (#AF52DE)
- Strings: Green (#32D74B)
- Comments: Gray (#8E8E93)
- Error Background: Light Red (#FFEBEE)
- Warning Background: Light Orange (#FFF3E0)
- Error Icon: Red (#FF3B30)
- Warning Icon: Orange (#FF9500)
- Accent: Blue (#007AFF)

### Dark Mode (iOS Automatic)
- Background: Dark Gray (#1C1C1E)
- Gutter: Darker Gray (#2C2C2E)
- Text: White (#FFFFFF)
- Secondary Text: Light Gray (#8E8E93)
- Keywords: Light Purple (#BF5AF2)
- Strings: Light Green (#30D158)
- Comments: Gray (#8E8E93)
- Error Background: Dark Red (#4C1D1D)
- Warning Background: Dark Orange (#4C3319)
- Error Icon: Light Red (#FF453A)
- Warning Icon: Light Orange (#FF9F0A)
- Accent: Light Blue (#0A84FF)

---

## Animation & Transitions

1. **File Opening**
   - Fade in: 0.3s
   - Slide up: Code appears from bottom

2. **Linting**
   - Progress spinner during operation
   - Results fade in when complete

3. **Diagnostic Selection**
   - Detail panel slides up from bottom
   - Smooth 0.3s animation

4. **Tab Switching**
   - Standard iOS tab transition
   - Fade cross-dissolve

5. **Settings Changes**
   - Immediate visual feedback
   - Stepper value updates instantly

---

## Typography

- **Navigation Title**: SF Pro Display, 17pt, Bold
- **File Name**: SF Pro Display, 17pt, Semibold  
- **Code**: SF Mono, 14pt, Regular
- **Line Numbers**: SF Mono, 12pt, Regular
- **Diagnostic Code**: SF Pro Text, 17pt, Semibold
- **Diagnostic Message**: SF Pro Text, 15pt, Regular
- **Settings Labels**: SF Pro Text, 17pt, Regular
- **Settings Values**: SF Pro Text, 17pt, Regular (Gray)
- **Section Headers**: SF Pro Text, 13pt, Regular (Gray)

---

## Interaction States

### Buttons
- **Default**: Accent color
- **Pressed**: Darker accent (opacity 0.7)
- **Disabled**: Gray (opacity 0.3)

### List Items
- **Default**: White/Clear background
- **Pressed**: Light gray highlight
- **Selected**: Blue highlight (for rules)

### Diagnostic Icons
- **Default**: Red/Orange
- **Tapped**: Slightly larger (scale 1.1)
- **Selected**: Bold border around detail panel

---

## Accessibility Features

1. **VoiceOver Labels**
   - "Open file button"
   - "Line 5, Error: Local variable unused"
   - "Warning count: 2 warnings"
   - "Settings tab, 2 of 2"

2. **Dynamic Type**
   - All text scales with system settings
   - Minimum 12pt, Maximum 28pt

3. **Color Blind Support**
   - Icons in addition to colors
   - Patterns/shapes differentiate severity

4. **Reduced Motion**
   - Fade instead of slide animations
   - No parallax effects

---

This completes the visual documentation of the RuffRuff iOS app. The actual app will have these exact layouts when built and run on iOS devices or simulators on macOS with Xcode.
