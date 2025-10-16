# RuffRuff - iOS Linter App for Python

An iOS application that provides a beautiful, native front-end to the Python lint tool [Ruff](https://github.com/astral-sh/ruff) on iPhone and iPad.

## Features

### 📱 Tabbed Interface
- **Editor Tab**: Open and view Python files with syntax highlighting
- **Settings Tab**: Configure Ruff linting parameters

### 📂 File Management
- Open Python files using iOS standard file picker
- Support for file sharing from other apps
- Security-scoped file access for sandboxed operation

### 🎨 Syntax Highlighting
- Beautiful Python syntax highlighting
- Color-coded keywords, strings, and comments
- Monospaced font for code readability

### 🔍 Ruff Integration
- Real-time Python code linting with Ruff
- Visual diagnostic margin showing errors and warnings
- Line-by-line error/warning indicators
- Detailed error messages with line and column information
- Click on diagnostic icons to see full error details

### ⚙️ Configurable Settings
- Adjustable line length (40-120 characters)
- Select which Ruff rule categories to enable (E, F, W, etc.)
- Ignore specific rules
- Add custom rule codes
- Reset to defaults

## Requirements

- iOS 16.0 or later
- iPhone or iPad
- Ruff installed (for actual linting functionality)

## Project Structure

```
RuffRuff/
├── Package.swift              # Swift Package Manager configuration
├── App/
│   └── RuffRuff.xcodeproj/   # Xcode project for building iOS app
│       └── RuffRuff/          # App source files
│           ├── RuffRuffApp.swift
│           ├── Info.plist
│           ├── Assets.xcassets/
│           ├── Views/
│           │   ├── ContentView.swift
│           │   ├── EditorView.swift
│           │   ├── CodeEditorView.swift
│           │   └── SettingsView.swift
│           ├── Models/
│           │   ├── AppState.swift
│           │   ├── RuffConfiguration.swift
│           │   └── RuffDiagnostic.swift
│           └── Services/
│               └── RuffService.swift
└── Sources/
    └── RuffRuff/              # Shared source code
        └── (mirrors App structure)
```

## Building the App

### Using Xcode

1. Open `App/RuffRuff.xcodeproj` in Xcode
2. Select your target device (iPhone or iPad simulator)
3. Click the Run button or press Cmd+R

### Using Swift Package Manager

```bash
swift build
```

## Usage

### Opening a Python File

1. Launch RuffRuff
2. Tap the folder icon in the top-right corner
3. Navigate to your Python file using the file picker
4. Select the file to open it

### Viewing Lint Results

- The file is automatically linted when opened
- Tap the play button (▶️) in the toolbar to re-lint
- Error and warning counts appear in the header
- Red circles (🔴) indicate errors in the margin
- Orange triangles (⚠️) indicate warnings in the margin
- Tap any diagnostic icon to see the full error message
- Lines with issues are highlighted with a red background

### Configuring Ruff

1. Switch to the Settings tab
2. Adjust the maximum line length using the stepper
3. Tap "Selected Rules" to choose which rule categories to enable
4. Tap "Ignored Rules" to specify rules to ignore
5. Changes apply immediately to the next lint operation

## Ruff Rule Categories

Common rule categories you can enable:

- **E** - Pycodestyle Error
- **F** - Pyflakes
- **W** - Pycodestyle Warning
- **C90** - McCabe Complexity
- **I** - isort
- **N** - pep8-naming
- **D** - pydocstyle
- **UP** - pyupgrade
- **B** - flake8-bugbear
- **A** - flake8-builtins
- **C4** - flake8-comprehensions
- **T20** - flake8-print
- **SIM** - flake8-simplify

## Technical Details

### Architecture

- **SwiftUI** for the entire UI
- **Combine** for reactive state management
- **MVVM** architecture pattern
- Process-based execution of Ruff CLI
- JSON output parsing from Ruff

### Key Components

- **AppState**: Central application state management
- **RuffService**: Handles communication with Ruff CLI
- **PythonDocument**: Represents an opened Python file with lint results
- **RuffConfiguration**: Stores and manages Ruff settings
- **RuffDiagnostic**: Represents a single lint error or warning

## Notes

- This is a viewer and linter; editing capabilities are not included
- Ruff must be installed and accessible in the system PATH
- The app creates temporary files for linting operations
- All file access uses iOS security-scoped resources

## Future Enhancements

Potential improvements could include:
- Code editing capabilities
- Quick-fix suggestions from Ruff
- Multiple file support with tabs
- Dark mode support
- Export lint reports
- Integration with other Python tools

## License

See LICENSE file for details.

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.