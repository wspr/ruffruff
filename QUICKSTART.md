# RuffRuff Quick Start Guide

Get started with the RuffRuff iOS app in 5 minutes!

## Prerequisites

- macOS computer with Xcode 15.0 or later
- iOS device or simulator running iOS 16.0+
- Ruff installed (optional for initial build, required for linting)

## Step 1: Install Ruff (Optional)

If you want the linting to work, install Ruff first:

```bash
# Using pip
pip install ruff

# Or using Homebrew
brew install ruff

# Verify installation
ruff --version
```

> **Note**: You can build and run the app without Ruff installed, but linting operations will fail. The app will still open files and display syntax-highlighted code.

## Step 2: Open the Project

```bash
# Navigate to the project directory
cd /path/to/ruffruff

# Open in Xcode
open App/RuffRuff.xcodeproj
```

Alternatively, double-click `App/RuffRuff.xcodeproj` in Finder.

## Step 3: Select a Target Device

In Xcode:
1. Look at the device selector at the top (next to the Run button)
2. Click it and choose:
   - An iOS Simulator (e.g., "iPhone 15")
   - Or your connected iOS device

## Step 4: Build and Run

Click the **Run** button (▶️) or press **⌘R**

The app will:
1. Compile (takes 10-30 seconds first time)
2. Launch in the simulator or on your device
3. Show the empty state screen

## Step 5: Open Your First File

1. Tap the **folder icon** (📁) in the top right
2. Navigate to a Python file on your device
3. Or use the included `sample.py` file
4. Tap to open it

The app will:
- Display the file with syntax highlighting
- Automatically run Ruff linting
- Show any warnings or errors

## Example: Using the Sample File

The repository includes a `sample.py` file with intentional issues for testing.

### On Simulator

1. The sample file is in the project folder on your Mac
2. Drag `sample.py` to the simulator window
3. It appears in the Files app
4. Open RuffRuff and navigate to Files → On My iPhone
5. Select `sample.py`

### On Device

1. Use AirDrop to send `sample.py` to your device
2. Save to Files app
3. Open RuffRuff and browse to the file

### Expected Results

You should see:
- **2 warnings** (⚠️) for long lines
- **1 error** (🔴) for an unused variable
- Syntax highlighting with purple keywords and green strings

## Step 6: Explore Settings

1. Tap the **Settings** tab (⚙️) at the bottom
2. Try adjusting the line length:
   - Tap **[+]** to increase to 120
3. Return to **Editor** tab
4. Tap the **play button** (▶️) to re-lint
5. Notice the long-line warnings disappear!

## Common First-Time Issues

### "Code signing failed"

**Solution:**
1. Select the RuffRuff project in Xcode navigator
2. Select the RuffRuff target
3. Go to "Signing & Capabilities" tab
4. Check "Automatically manage signing"
5. Select your Team (add Apple ID in Xcode preferences if needed)

### "No provisioning profiles found"

**Solution:**
- Use a simulator instead of a device for testing
- Or create a free Apple Developer account
- Add your Apple ID in Xcode → Preferences → Accounts

### "Unable to open file"

**Cause:** File access permissions

**Solution:**
- Make sure you're selecting files from accessible locations
- On simulator, use the Files app or drag-and-drop
- On device, ensure files are in iCloud Drive or On My iPhone

### "Ruff command not found"

**Cause:** Ruff not installed or not in PATH

**Solutions:**
1. Install Ruff: `pip install ruff` or `brew install ruff`
2. Verify: `which ruff` shows the path
3. If needed, edit `RuffService.swift` to use absolute path:
   ```swift
   process.executableURL = URL(fileURLWithPath: "/usr/local/bin/ruff")
   ```

### App crashes when opening file

**Debug:**
1. Check Xcode console for error messages
2. Verify file is valid UTF-8 encoded text
3. Try with the included `sample.py` first

## Understanding the Results

### Diagnostic Indicators

- **🔴 Red Circle**: Error that must be fixed
- **⚠️ Orange Triangle**: Warning that should be reviewed
- **Numbers in header**: Count of each type

### Rule Codes

Common codes you'll see:

- **E501**: Line too long
- **F841**: Unused variable
- **F401**: Imported but unused
- **E302**: Expected 2 blank lines
- **W292**: No newline at end of file

Tap any diagnostic icon to see the full message!

## Customizing Linting Rules

### Enable More Rules

1. Go to **Settings** tab
2. Tap **Selected Rules**
3. Tap any rule to enable it (shows ✓)
4. Popular additions:
   - **I** (isort) - Import sorting
   - **N** (pep8-naming) - Naming conventions
   - **D** (pydocstyle) - Docstring checks

### Ignore Specific Rules

1. Go to **Settings** tab
2. Tap **Ignored Rules**
3. Enter rule code (e.g., E501)
4. Tap [⊕] to add

## Tips & Tricks

### Quick Re-lint
- Tap the **play button** (▶️) after making changes in another app
- Or after changing settings

### Understanding Line Length
- Default is 88 (Black's standard)
- PEP 8 recommends 79
- Many projects use 100 or 120
- Adjust in Settings to match your project

### Viewing Long Lines
- Scroll horizontally to see full line
- Line wrapping may be added in future version

### Multiple Files
- Close current file with **×** button
- Open new file with **📁** button
- Current version handles one file at a time

## Next Steps

### Learn More About Ruff

Ruff is an extremely fast Python linter written in Rust:
- [Official Documentation](https://docs.astral.sh/ruff/)
- [Rule Reference](https://docs.astral.sh/ruff/rules/)
- [Configuration Guide](https://docs.astral.sh/ruff/configuration/)

### Customize the App

The app is open source! Check out:
- `App/RuffRuff/Views/` - UI components
- `App/RuffRuff/Models/` - Data structures
- `App/RuffRuff/Services/` - Ruff integration

### Report Issues

Found a bug or have a suggestion?
- Open an issue on GitHub
- Include iOS version and Xcode version
- Describe steps to reproduce

### Contribute

Contributions welcome:
- UI improvements
- Additional features
- Bug fixes
- Documentation

## Pro Tips for iOS Development

### Debugging

1. **View console output**: Xcode → View → Debug Area → Show Debug Area
2. **Set breakpoints**: Click line numbers in Xcode
3. **Inspect variables**: Hover over variables while paused

### Performance

- First build is slowest (10-30 seconds)
- Subsequent builds are faster (2-5 seconds)
- Clean build if needed: Product → Clean Build Folder

### Testing on Multiple Devices

Xcode makes it easy to test on different screen sizes:
- iPhone SE: Smallest screen
- iPhone 15: Standard size
- iPhone 15 Pro Max: Largest phone
- iPad: Tablet experience

## Troubleshooting Workflow

If something doesn't work:

1. **Check Xcode Console**
   - Look for error messages in red
   - Search for the error online

2. **Clean and Rebuild**
   ```
   Product → Clean Build Folder (⌘⇧K)
   Product → Build (⌘B)
   ```

3. **Restart Simulator**
   ```
   Device → Erase All Content and Settings
   ```

4. **Verify Ruff**
   ```bash
   which ruff
   ruff --version
   ```

5. **Check File Permissions**
   - Ensure Python files are readable
   - Try with sample.py first

## Advanced: Building for Distribution

### TestFlight (Beta Testing)

1. Archive: Product → Archive
2. Distribute App → App Store Connect
3. Upload to App Store Connect
4. Configure TestFlight settings
5. Invite testers via email

### App Store Submission

1. Complete app metadata in App Store Connect
2. Add screenshots (required for each device size)
3. Set pricing and availability
4. Submit for review
5. Typical review time: 1-3 days

## Resources

### Documentation
- [README.md](README.md) - Project overview
- [BUILDING.md](BUILDING.md) - Detailed build instructions
- [APP_DESIGN.md](APP_DESIGN.md) - UI/UX design documentation
- [SCREENSHOTS.md](SCREENSHOTS.md) - Visual preview of app

### External Links
- [Swift Documentation](https://swift.org/documentation/)
- [SwiftUI Tutorials](https://developer.apple.com/tutorials/swiftui)
- [iOS Human Interface Guidelines](https://developer.apple.com/design/human-interface-guidelines/ios)
- [Ruff Documentation](https://docs.astral.sh/ruff/)

### Community
- GitHub Issues for bug reports
- GitHub Discussions for questions
- Stack Overflow for technical help

## Summary

You now know how to:
- ✅ Build and run RuffRuff on iOS
- ✅ Open Python files in the app
- ✅ View lint results with diagnostics
- ✅ Configure Ruff settings
- ✅ Troubleshoot common issues

**Enjoy using RuffRuff for Python linting on iOS!** 🎉
