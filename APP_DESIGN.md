# RuffRuff App Design & Features

## App Overview

RuffRuff is an iOS app that provides a native, user-friendly interface for linting Python code using the Ruff linter on iPhone and iPad.

## User Interface

### Tab Bar Navigation

The app uses a standard iOS tab bar with two main sections:

```
┌────────────────────────────────────────┐
│           RuffRuff                     │
│  ┌──────────────────────────────────┐ │
│  │                                  │ │
│  │       Main Content Area          │ │
│  │                                  │ │
│  │                                  │ │
│  └──────────────────────────────────┘ │
│                                        │
│  ┌──────────┬──────────┐              │
│  │ 📄 Editor │ ⚙️ Settings│              │
│  └──────────┴──────────┘              │
└────────────────────────────────────────┘
```

## Editor Tab

### Empty State (No File Open)

```
┌──────────────────────────────────────────┐
│  Ruff Linter              🗂️ 📁         │
├──────────────────────────────────────────┤
│                                          │
│                                          │
│              🔍                          │
│          (Large Icon)                    │
│                                          │
│          No File Open                    │
│                                          │
│    Open a Python file to start linting  │
│                                          │
│    ┌────────────────────┐               │
│    │  📁 Open File      │               │
│    └────────────────────┘               │
│                                          │
│                                          │
└──────────────────────────────────────────┘
```

### File Open with Code

```
┌──────────────────────────────────────────┐
│  Ruff Linter         ▶️ 🗂️ 📁          │
├──────────────────────────────────────────┤
│  sample.py      ⚠️ 2    🔴 1            │
├────┬─────────────────────────────────────┤
│    │ import os                           │
│  1 │ import sys                          │
│  2 │                                     │
│  3 │                                     │
│ ⚠️ │ def very_long_function_name_that... │
│  4 │     """Docstring."""                │
│  5 │     x = 1                           │
│ 🔴 │     unused_var = "never used"       │
│  6 │     return x                        │
│  7 │                                     │
│    │                                     │
├────┴─────────────────────────────────────┤
│ 🔴 E501: Line too long (120 > 88)       │
│ Line 4, Column 1                         │
└──────────────────────────────────────────┘
```

### Key Features in Editor View

1. **Navigation Bar**
   - Title: "Ruff Linter"
   - X button: Close current file (left)
   - Play button: Re-run linting (center-right)
   - Folder button: Open new file (right)

2. **File Header**
   - Shows filename
   - Warning count with icon (⚠️)
   - Error count with icon (🔴)

3. **Code Display Area**
   - **Left Margin (Gutter)**
     - Line numbers (right-aligned)
     - Diagnostic indicators (⚠️ for warnings, 🔴 for errors)
     - Tappable icons to show details
   - **Code Area**
     - Syntax-highlighted Python code
     - Monospaced font
     - Lines with issues have red tinted background
     - Scrollable horizontally and vertically

4. **Diagnostic Detail Panel (Bottom)**
   - Shows when a diagnostic icon is tapped
   - Displays:
     - Severity icon and code (e.g., "E501")
     - Line and column number
     - Full error message
     - Color-coded by severity (red for errors, orange for warnings)

### Syntax Highlighting Colors

- **Keywords** (def, class, import, return, etc.): Purple
- **Strings** ("text", 'text'): Green
- **Comments** (# comment): Gray
- **Default text**: System text color

## Settings Tab

### Settings View

```
┌──────────────────────────────────────────┐
│  Settings                                 │
├──────────────────────────────────────────┤
│                                          │
│  LINE LENGTH                             │
│  ┌────────────────────────────────────┐ │
│  │ Max Line Length      88  [- +]     │ │
│  └────────────────────────────────────┘ │
│                                          │
│  RULE SELECTION                          │
│  ┌────────────────────────────────────┐ │
│  │ Selected Rules              >      │ │
│  │ E, F, W                            │ │
│  └────────────────────────────────────┘ │
│  ┌────────────────────────────────────┐ │
│  │ Ignored Rules               >      │ │
│  │ None                               │ │
│  └────────────────────────────────────┘ │
│                                          │
│  ABOUT                                   │
│  ┌────────────────────────────────────┐ │
│  │ Version                     1.0.0  │ │
│  │ Ruff Documentation          >      │ │
│  └────────────────────────────────────┘ │
│                                          │
│  ┌────────────────────────────────────┐ │
│  │ Reset to Defaults                  │ │
│  └────────────────────────────────────┘ │
│                                          │
└──────────────────────────────────────────┘
```

### Rule Selection Screen

```
┌──────────────────────────────────────────┐
│  < Select Rules                          │
├──────────────────────────────────────────┤
│                                          │
│  SELECTED RULES                          │
│  ┌────────────────────────────────────┐ │
│  │ E                           ⊖      │ │
│  │ F                           ⊖      │ │
│  │ W                           ⊖      │ │
│  └────────────────────────────────────┘ │
│                                          │
│  AVAILABLE RULES                         │
│  ┌────────────────────────────────────┐ │
│  │ E                           ✓      │ │
│  │ Pycodestyle Error                  │ │
│  ├────────────────────────────────────┤ │
│  │ F                           ✓      │ │
│  │ Pyflakes                           │ │
│  ├────────────────────────────────────┤ │
│  │ W                           ✓      │ │
│  │ Pycodestyle Warning                │ │
│  ├────────────────────────────────────┤ │
│  │ C90                                │ │
│  │ McCabe Complexity                  │ │
│  ├────────────────────────────────────┤ │
│  │ I                                  │ │
│  │ isort                              │ │
│  └────────────────────────────────────┘ │
│                                          │
│  CUSTOM RULE                             │
│  ┌────────────────────────────────────┐ │
│  │ [Rule Code (e.g., E501)]    ⊕     │ │
│  └────────────────────────────────────┘ │
└──────────────────────────────────────────┘
```

### Settings Features

1. **Line Length Configuration**
   - Stepper control (- / +)
   - Range: 40-120 characters
   - Default: 88 (Black's default)

2. **Rule Selection**
   - View and modify selected rule categories
   - Common rules with descriptions
   - Add custom rules by code
   - Remove rules with minus button

3. **Ignored Rules**
   - Similar interface to selected rules
   - Add rules to ignore
   - Remove ignored rules

4. **About Section**
   - App version display
   - Link to Ruff documentation

5. **Reset Button**
   - Returns all settings to defaults
   - Red color to indicate caution

## File Integration

### Opening Files

Users can open Python files through multiple methods:

1. **File Picker (Primary Method)**
   - Tap folder icon in navigation bar
   - Browse file system
   - Select .py or .pyw files
   - Files open immediately with automatic linting

2. **Share Sheet (iOS Native)**
   - From Files app: Share → RuffRuff
   - From other apps with Python files
   - From iCloud Drive, Dropbox, etc.

3. **Drag and Drop (iPad)**
   - Drag Python file from Files app
   - Drop onto RuffRuff app icon or window

### Supported File Types

- `.py` - Python scripts
- `.pyw` - Python Windows scripts
- Plain text files (with manual selection)

## Interactions

### Gestures

1. **Tap**
   - Diagnostic icons: Show error details
   - Buttons: Activate function
   - Links: Navigate

2. **Scroll**
   - Vertical: Navigate through code
   - Horizontal: View long lines

3. **Pull to Refresh** (Future)
   - Re-lint current file

### Visual Feedback

1. **Colors**
   - Red: Errors
   - Orange: Warnings
   - Purple: Keywords
   - Green: Strings
   - Gray: Comments

2. **Backgrounds**
   - Light red tint: Lines with issues
   - Gray: Gutter/margin
   - White/System: Code area

3. **Icons**
   - 🔴 / xmark.circle.fill: Errors
   - ⚠️ / exclamationmark.triangle.fill: Warnings
   - 📁 / folder: Open file
   - ⚙️ / gear: Settings
   - ▶️ / play.circle: Run lint
   - ❌ / xmark.circle: Close file

## Workflow Example

1. User launches RuffRuff
2. Sees empty state with "Open File" button
3. Taps "Open File" or folder icon
4. Selects a Python file from Files app
5. File opens with syntax highlighting
6. Ruff automatically lints the file
7. Results appear:
   - Header shows count: "⚠️ 2  🔴 1"
   - Margin shows icons on problem lines
   - Problem lines have red background
8. User taps a diagnostic icon (e.g., ⚠️ on line 4)
9. Bottom panel shows: "W505: Line too long (95 > 88)"
10. User switches to Settings tab
11. Adjusts line length to 120
12. Returns to Editor tab
13. Taps play button to re-lint
14. Warning on line 4 disappears
15. Header updates to "🔴 1"

## Accessibility

- VoiceOver support for all interactive elements
- Dynamic Type support for text scaling
- High contrast mode compatible
- Haptic feedback for interactions
- Descriptive labels for icons and buttons

## Platform Support

- **iPhone**: Portrait and landscape
- **iPad**: All orientations, split-view compatible
- **iOS 16.0+**: Required minimum version

## Performance Considerations

- Asynchronous linting (doesn't block UI)
- Progress indicator during lint operations
- Temporary files cleaned up automatically
- Memory-efficient text rendering
- Lazy loading for large files (future enhancement)

## Future Enhancements

Potential features not in v1.0:

1. Code editing capabilities
2. Quick-fix application from Ruff
3. Multiple file tabs
4. Dark mode customization
5. Export lint reports as text/JSON
6. Comparison before/after fixes
7. Integration with Git
8. Custom color schemes
9. Line wrapping options
10. Search and replace in code
