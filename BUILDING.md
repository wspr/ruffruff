# Building RuffRuff iOS App

This document provides instructions for building the RuffRuff iOS application.

## Prerequisites

### Required Software

1. **macOS** - iOS development requires macOS
2. **Xcode 15.0+** - Download from the Mac App Store or Apple Developer website
3. **iOS 16.0+ SDK** - Included with Xcode
4. **Ruff** - The Python linter (optional for development, required for runtime)

### Installing Ruff

Install Ruff using pip:

```bash
pip install ruff
```

Or using Homebrew:

```bash
brew install ruff
```

## Building with Xcode

### Option 1: Using Xcode IDE (Recommended)

1. Open the project:
   ```bash
   open App/RuffRuff.xcodeproj
   ```

2. In Xcode:
   - Select a target device (iPhone or iPad simulator, or a physical device)
   - Click the Run button (▶️) or press `Cmd+R`
   - The app will build and launch

### Option 2: Using Command Line

1. List available simulators:
   ```bash
   xcrun simctl list devices
   ```

2. Build and run on a simulator:
   ```bash
   xcodebuild -project App/RuffRuff.xcodeproj \
              -scheme RuffRuff \
              -sdk iphonesimulator \
              -destination 'platform=iOS Simulator,name=iPhone 15,OS=latest' \
              build
   ```

3. Run the app:
   ```bash
   xcrun simctl boot "iPhone 15"  # If not already booted
   xcrun simctl install booted App/build/Release-iphonesimulator/RuffRuff.app
   xcrun simctl launch booted com.example.RuffRuff
   ```

## Building for Physical Device

### Prerequisites

1. Apple Developer Account (free or paid)
2. Device registered in your developer account
3. Provisioning profile configured

### Steps

1. Open the project in Xcode
2. Select your project in the navigator
3. Select the RuffRuff target
4. Go to "Signing & Capabilities" tab
5. Select your Team from the dropdown
6. Connect your iOS device via USB
7. Select your device from the device list
8. Click Run (▶️)

## Configuration

### Code Signing

If you encounter code signing issues:

1. In Xcode, go to Preferences → Accounts
2. Add your Apple ID
3. Download Manual Profiles if using a paid developer account
4. In the project settings, ensure "Automatically manage signing" is checked

### Bundle Identifier

The default bundle identifier is `com.example.RuffRuff`. You should change this to your own:

1. Select the project in Xcode
2. Select the RuffRuff target
3. Change the Bundle Identifier under "General" tab

## Troubleshooting

### "Command CodeSign failed with a nonzero exit code"

This usually means code signing is not properly configured. See the Code Signing section above.

### "No such module 'SwiftUI'"

This means you're trying to build on a non-macOS system. iOS apps can only be built on macOS with Xcode.

### "Unable to boot device"

If you get simulator errors:
```bash
# Reset the simulator
xcrun simctl erase all

# Or shutdown and restart
xcrun simctl shutdown all
```

### Ruff Not Found

The app looks for `ruff` in the system PATH. If you installed it in a non-standard location:

1. Find where ruff is installed: `which ruff`
2. Update the `RuffService.swift` to use the absolute path
3. Or add ruff's location to the PATH environment variable

## Testing on Simulator vs Device

### Simulator Limitations

- File system access works but uses simulated sandbox
- Cannot test actual file sharing from other apps effectively
- Performance may differ from real devices

### Device Testing

- Full file system integration
- Real-world performance
- Actual file sharing between apps
- Requires developer account for installation

## Project Structure Notes

- The Xcode project is in `App/RuffRuff.xcodeproj`
- Source files are in `App/RuffRuff/`
- Shared source is also in `Sources/RuffRuff/` for the Swift Package Manager
- The Swift Package Manager setup is for code organization and potential future macOS support

## Advanced Configuration

### Debug vs Release Builds

Debug builds include additional diagnostics and have some optimizations disabled.

To build a Release version:
```bash
xcodebuild -project App/RuffRuff.xcodeproj \
           -scheme RuffRuff \
           -configuration Release \
           -sdk iphonesimulator \
           build
```

### Changing iOS Deployment Target

The app targets iOS 16.0+. To change this:

1. Open the project in Xcode
2. Select the project → RuffRuff target
3. In the "General" tab, change "Minimum Deployments"
4. Note: Changing to an older iOS version may require adjusting SwiftUI code

## Distribution

### TestFlight (Beta Testing)

1. Archive the app: Product → Archive
2. Upload to App Store Connect
3. Add to TestFlight
4. Invite beta testers

### App Store

1. Archive the app
2. Upload to App Store Connect
3. Fill in app metadata
4. Submit for review

## Continuous Integration

Example GitHub Actions workflow for building (requires macOS runner):

```yaml
name: Build iOS App

on: [push, pull_request]

jobs:
  build:
    runs-on: macos-latest
    
    steps:
    - uses: actions/checkout@v3
    
    - name: Build
      run: |
        xcodebuild -project App/RuffRuff.xcodeproj \
                   -scheme RuffRuff \
                   -sdk iphonesimulator \
                   -destination 'platform=iOS Simulator,name=iPhone 15,OS=latest' \
                   build
```

## Additional Resources

- [Apple Developer Documentation](https://developer.apple.com/documentation/)
- [SwiftUI Tutorials](https://developer.apple.com/tutorials/swiftui)
- [Ruff Documentation](https://docs.astral.sh/ruff/)
