# Frequently Asked Questions (FAQ)

## General Questions

### Q: What is RuffRuff?
**A:** RuffRuff is an iOS app that provides a native front-end to the Python linting tool Ruff on iPhone and iPad. It allows you to open Python files, view them with syntax highlighting, and see linting errors and warnings in a visual margin.

### Q: Do I need to know how to program to use this app?
**A:** The app is designed for Python developers who want to lint their code on iOS devices. Some familiarity with Python and code linting concepts is helpful, but the app is straightforward to use even for beginners.

### Q: Is RuffRuff free?
**A:** Yes, RuffRuff is open source and free to use under the MIT License.

### Q: Can I edit Python files in RuffRuff?
**A:** Currently, RuffRuff is a viewer and linter only. Code editing capabilities may be added in a future version. For now, you can view your code, see lint issues, and then edit the file in another app.

## Installation & Setup

### Q: How do I install RuffRuff?
**A:** Currently, you need to build the app from source using Xcode on a Mac. In the future, it may be available on the App Store.

To build from source:
1. Clone the repository
2. Open `App/RuffRuff.xcodeproj` in Xcode
3. Build and run on your device or simulator

See [BUILDING.md](BUILDING.md) for detailed instructions.

### Q: Do I need to install Ruff separately?
**A:** Yes, Ruff needs to be installed on the system where you're building/running the app. Install it with:
```bash
pip install ruff
# or
brew install ruff
```

### Q: Can I use RuffRuff without installing Ruff?
**A:** The app will run and let you open and view Python files with syntax highlighting, but the linting functionality requires Ruff to be installed.

### Q: What iOS version do I need?
**A:** RuffRuff requires iOS 16.0 or later.

### Q: Does it work on iPad?
**A:** Yes! RuffRuff is a universal app that works on both iPhone and iPad, with layouts optimized for each device size.

## Using the App

### Q: How do I open a Python file?
**A:** 
1. Tap the folder icon (📁) in the top right
2. Navigate to your Python file in the file picker
3. Tap the file to open it

You can also use the Share menu from other apps to share Python files to RuffRuff.

### Q: What file types are supported?
**A:** RuffRuff supports `.py` and `.pyw` (Python Windows) files. You can also open plain text files and view them as Python code.

### Q: How do I run the linter?
**A:** The file is automatically linted when you open it. To re-lint after making changes elsewhere, tap the play button (▶️) in the top right.

### Q: What do the colored icons mean?
**A:**
- 🔴 Red circle = Error (must be fixed)
- ⚠️ Orange triangle = Warning (should be reviewed)

Tap any icon to see the full error message.

### Q: Can I configure which rules Ruff checks?
**A:** Yes! Go to the Settings tab and tap "Selected Rules" to choose which rule categories to enable. Common ones include:
- E (Pycodestyle errors)
- F (Pyflakes)
- W (Pycodestyle warnings)

### Q: How do I change the line length limit?
**A:** Go to Settings tab → Use the [-] and [+] buttons next to "Max Line Length". The default is 88 characters (Black's standard).

### Q: Can I ignore specific rules?
**A:** Yes! In Settings → Ignored Rules, you can add rule codes that you want Ruff to skip. For example, add "E501" to ignore line-too-long warnings.

## Features

### Q: Does RuffRuff have syntax highlighting?
**A:** Yes! Python keywords, strings, and comments are color-coded for better readability.

### Q: Can I open multiple files at once?
**A:** Currently, only one file can be open at a time. Close the current file (×) before opening another. Multi-file support may be added in the future.

### Q: Does RuffRuff support Dark Mode?
**A:** RuffRuff respects iOS system appearance settings. If your device is in Dark Mode, the app will use dark colors automatically.

### Q: Can I export the lint results?
**A:** Not currently. This feature may be added in a future version. You can take screenshots of the results for now.

### Q: Does RuffRuff work offline?
**A:** Yes! All linting happens locally on your device. No internet connection is required.

## Troubleshooting

### Q: The app crashes when I try to open a file. What's wrong?
**A:** This could be due to:
- File encoding issues (ensure file is UTF-8)
- Very large files (current version loads entire file into memory)
- File permission issues

Try with the included `sample.py` first to verify the app works.

### Q: Linting doesn't show any results. Why?
**A:** Check if:
1. Ruff is installed: Run `which ruff` in Terminal
2. Ruff is in your PATH
3. The file is valid Python code

If Ruff isn't found, you may need to edit `RuffService.swift` to use the absolute path to Ruff.

### Q: The app says "No such module 'SwiftUI'" when building
**A:** This means you're trying to build on Linux or another non-macOS system. iOS apps can only be built on macOS with Xcode.

### Q: I get "Code signing failed" in Xcode
**A:** 
1. Go to Xcode → Preferences → Accounts
2. Add your Apple ID
3. In project settings, select your team under "Signing & Capabilities"
4. Enable "Automatically manage signing"

For testing, you can use the iOS Simulator without code signing.

### Q: The file picker doesn't show my Python files
**A:** Ensure your files are in an accessible location:
- iCloud Drive
- On My iPhone/iPad
- Files app locations

Files in app-specific sandboxes may not be visible.

### Q: Syntax highlighting looks wrong
**A:** The current version has basic Python syntax highlighting. Some complex cases may not be perfectly highlighted. This is a known limitation that may be improved in future versions.

## Technical Questions

### Q: What technology is RuffRuff built with?
**A:** 
- Language: Swift 5.9+
- UI Framework: SwiftUI
- Architecture: MVVM
- State Management: Combine

See [ARCHITECTURE.md](ARCHITECTURE.md) for details.

### Q: How does RuffRuff execute Ruff?
**A:** RuffRuff creates a temporary file with your Python code, then executes Ruff as a subprocess with the `--output-format=json` flag. It parses the JSON output to extract diagnostics.

### Q: Is my code sent to any servers?
**A:** No. All processing happens locally on your device. RuffRuff never sends your code anywhere.

### Q: Can I use RuffRuff with other linters?
**A:** Currently, only Ruff is supported. The architecture could be extended to support other linters in the future.

### Q: Does RuffRuff support ruff.toml configuration files?
**A:** Not yet. Currently, you configure Ruff settings through the app's Settings screen. Support for `ruff.toml` or `pyproject.toml` may be added in the future.

### Q: How much storage does RuffRuff use?
**A:** The app itself is small (< 5MB). Temporary files are created during linting but cleaned up immediately.

### Q: Does RuffRuff work with Python 2 or only Python 3?
**A:** RuffRuff is a viewer and doesn't execute Python code. It works with both Python 2 and 3 syntax for linting purposes, though Ruff itself focuses on Python 3.

## Development

### Q: Can I contribute to RuffRuff?
**A:** Yes! Contributions are welcome. See [CONTRIBUTING.md](CONTRIBUTING.md) for guidelines.

### Q: Where can I report bugs?
**A:** Open an issue on the GitHub repository with:
- iOS version
- Device model
- Steps to reproduce
- Expected vs actual behavior

### Q: How can I request a feature?
**A:** Open an issue on GitHub with:
- Description of the feature
- Use case / why it's needed
- Any relevant examples

### Q: Is there a roadmap for future features?
**A:** Priority features for future versions include:
- Code editing capabilities
- Quick-fix suggestions
- Multiple file tabs
- Dark mode enhancements
- Export lint reports
- Better syntax highlighting

## Privacy & Security

### Q: Does RuffRuff collect any data?
**A:** No. RuffRuff doesn't collect, store, or transmit any user data, analytics, or telemetry.

### Q: Is it safe to open sensitive code in RuffRuff?
**A:** Yes. All processing is local, and the app runs in iOS's security sandbox. Temporary files are cleaned up immediately. However, as with any app, be mindful of your organization's security policies.

### Q: Can RuffRuff access my other files?
**A:** No. RuffRuff only has access to files you explicitly open through the file picker. It cannot browse or access other files on your device without permission.

## Comparison with Other Tools

### Q: How is RuffRuff different from running Ruff in a terminal?
**A:** RuffRuff provides:
- Visual, touch-friendly interface
- Syntax highlighting
- Visual diagnostic indicators
- No need for terminal access
- Native iOS integration

### Q: Can I use RuffRuff instead of my desktop IDE?
**A:** RuffRuff is designed for quick checks and reviews on iOS devices. For full development workflows, a desktop IDE with integrated linting is still recommended.

### Q: How does RuffRuff compare to Python editors on iOS?
**A:** RuffRuff focuses specifically on code linting with a clean, dedicated interface. It's not a full Python IDE but excels at showing lint results clearly.

## Miscellaneous

### Q: Why is it called "RuffRuff"?
**A:** It's a playful combination of "Ruff" (the linter) with the sound a dog makes, since "ruff" sounds similar. Plus, it's memorable and fun!

### Q: Can I rename the app?
**A:** Yes! It's open source. You can fork the repository and rename it however you like. Just update the bundle identifier and display name in Xcode.

### Q: Will RuffRuff be available on the App Store?
**A:** That depends on community interest and Apple's review process. Currently, you need to build from source.

### Q: Does RuffRuff support landscape mode?
**A:** Yes, on both iPhone and iPad. The layout adapts to the screen orientation.

### Q: Can I use RuffRuff in Split View on iPad?
**A:** Yes! RuffRuff supports iPad multitasking, including Split View and Slide Over.

### Q: Is there a Mac version?
**A:** Not currently, but the code could be adapted for macOS with some modifications. SwiftUI makes this relatively straightforward.

## Getting Help

### Q: Where can I get help with RuffRuff?
**A:**
1. Check this FAQ
2. Read the [README.md](README.md)
3. See [QUICKSTART.md](QUICKSTART.md)
4. Open a GitHub Discussion
5. Check existing GitHub Issues

### Q: Where can I learn more about Ruff itself?
**A:** Visit the [Ruff documentation](https://docs.astral.sh/ruff/) for comprehensive information about the linter, its rules, and configuration options.

### Q: I found a bug. Should I fix it or report it?
**A:** Either or both! You can:
- Report it as a GitHub Issue
- Fix it and submit a Pull Request
- Both report and fix it

See [CONTRIBUTING.md](CONTRIBUTING.md) for contribution guidelines.

## Still Have Questions?

If your question isn't answered here:
1. Search existing GitHub Issues
2. Check GitHub Discussions
3. Open a new Discussion or Issue

We're happy to help!
