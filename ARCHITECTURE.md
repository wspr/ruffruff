# RuffRuff Architecture

This document describes the technical architecture of the RuffRuff iOS application.

## Technology Stack

- **Language**: Swift 5.9+
- **UI Framework**: SwiftUI
- **Minimum iOS**: 16.0
- **Architecture Pattern**: MVVM (Model-View-ViewModel)
- **State Management**: Combine + ObservableObject
- **Build System**: Xcode Project + Swift Package Manager

## High-Level Architecture

```
┌─────────────────────────────────────────────────────────┐
│                    RuffRuff App                         │
├─────────────────────────────────────────────────────────┤
│                                                          │
│  ┌──────────────┐              ┌──────────────┐        │
│  │  Views (UI)  │              │   Models     │        │
│  │  - SwiftUI   │◄────────────►│  - Structs   │        │
│  │  - Tabs      │              │  - Classes   │        │
│  │  - Lists     │              │  - Enums     │        │
│  └──────┬───────┘              └───────▲──────┘        │
│         │                              │                │
│         │                              │                │
│         ▼                              │                │
│  ┌──────────────────────────────────────┐              │
│  │         AppState                     │              │
│  │   (Central State Management)         │              │
│  │   @Published properties              │              │
│  └──────────────┬───────────────────────┘              │
│                 │                                       │
│                 ▼                                       │
│  ┌──────────────────────────────────────┐              │
│  │          Services                    │              │
│  │    - RuffService (Linting)          │              │
│  │    - FileManager (I/O)              │              │
│  └──────────────┬───────────────────────┘              │
│                 │                                       │
│                 ▼                                       │
│  ┌──────────────────────────────────────┐              │
│  │       External Systems               │              │
│  │   - Ruff CLI (Process)              │              │
│  │   - iOS File System                 │              │
│  │   - iOS File Picker                 │              │
│  └──────────────────────────────────────┘              │
│                                                          │
└─────────────────────────────────────────────────────────┘
```

## Component Breakdown

### 1. Views (Presentation Layer)

#### RuffRuffApp.swift
- Entry point using `@main`
- Creates `WindowGroup` scene
- Initializes `AppState` as environment object

#### ContentView.swift
- Root view with `TabView`
- Manages tab selection
- Provides tabs for Editor and Settings

#### EditorView.swift
- Main file editing interface
- Handles file picker presentation
- Manages toolbar buttons
- Coordinates linting operations
- Shows empty state when no file open

#### CodeEditorView.swift
- Displays opened file content
- Shows line numbers and diagnostic gutter
- Renders syntax-highlighted code
- Displays diagnostic details
- Handles diagnostic selection

#### SettingsView.swift
- Configuration interface
- Line length stepper
- Navigation to rule selection
- Reset functionality
- About information

#### RuleSelectionView.swift
- Manage enabled Ruff rules
- Add/remove rules
- Show available rules with descriptions

#### RuleIgnoreView.swift
- Manage ignored Ruff rules
- Add/remove ignored rules

### 2. Models (Data Layer)

#### AppState.swift
```swift
class AppState: ObservableObject {
    @Published var openedDocument: PythonDocument?
    @Published var ruffConfiguration: RuffConfiguration
}
```
- Central state container
- Observable object for reactive updates
- Shared across all views via `@EnvironmentObject`

#### PythonDocument.swift
```swift
struct PythonDocument: Identifiable {
    let id: UUID
    let url: URL
    var content: String
    var lintResults: [RuffDiagnostic]
}
```
- Represents an opened Python file
- Contains file content and lint results
- Identifiable for SwiftUI lists

#### RuffConfiguration.swift
```swift
struct RuffConfiguration: Codable {
    var lineLength: Int
    var selectRules: [String]
    var ignoreRules: [String]
    var excludePatterns: [String]
}
```
- Stores user preferences
- Converts to Ruff CLI arguments
- Codable for future persistence

#### RuffDiagnostic.swift
```swift
struct RuffDiagnostic: Identifiable, Codable {
    let line: Int
    let column: Int
    let code: String
    let message: String
    let severity: Severity
}
```
- Represents a single lint issue
- Parsed from Ruff JSON output
- Severity enum (error/warning)

### 3. Services (Business Logic Layer)

#### RuffService.swift
- Executes Ruff linter process
- Writes content to temporary file
- Parses JSON output
- Returns array of diagnostics
- Handles errors and cleanup

```swift
class RuffService {
    func lint(content: String, filePath: String) async throws -> [RuffDiagnostic]
}
```

## Data Flow

### Opening a File

```
User Action (Tap Open)
    ↓
EditorView presents UIDocumentPickerViewController
    ↓
User selects file
    ↓
EditorView reads file content
    ↓
EditorView creates PythonDocument
    ↓
EditorView updates AppState.openedDocument
    ↓
SwiftUI re-renders CodeEditorView
    ↓
EditorView triggers lint operation
    ↓
RuffService.lint() called
    ↓
Results stored in document.lintResults
    ↓
AppState.openedDocument updated
    ↓
SwiftUI re-renders with diagnostics
```

### Linting Process

```
1. RuffService receives content and file path
2. Create temporary file with UUID name
3. Write content to temp file
4. Build command: ruff check --output-format=json [args] [file]
5. Create Process with executable and arguments
6. Set up pipes for stdout and stderr
7. Execute process asynchronously
8. Wait for completion
9. Read stdout data
10. Parse JSON (one object per line)
11. Extract location, code, message from each object
12. Create RuffDiagnostic for each issue
13. Clean up temporary file
14. Return diagnostics array
```

### Configuration Changes

```
User changes setting (e.g., line length)
    ↓
Settings view updates AppState.ruffConfiguration
    ↓
@Published property triggers update
    ↓
User returns to Editor tab
    ↓
User taps Play button to re-lint
    ↓
EditorView calls lint with new configuration
    ↓
RuffService uses updated configuration
    ↓
New results displayed
```

## Thread Safety

### Main Thread
- All UI updates
- SwiftUI view body execution
- @Published property changes

### Background Threads
- Ruff process execution (via async/await)
- File I/O operations
- JSON parsing

### Synchronization
```swift
await MainActor.run {
    // Update @Published properties
    document.lintResults = diagnostics
    appState.openedDocument = document
}
```

## Memory Management

### Automatic Reference Counting (ARC)
- Swift handles memory automatically
- Views are value types (structs)
- AppState is reference type (class)

### Weak References
- Not needed in current implementation
- Environment objects managed by SwiftUI

### Resource Cleanup
```swift
defer {
    try? FileManager.default.removeItem(at: tempFile)
}
```

## Error Handling

### Strategies

1. **Try/Catch**
```swift
do {
    let content = try String(contentsOf: url)
} catch {
    print("Error reading file: \(error)")
}
```

2. **Optional Chaining**
```swift
guard let document = appState.openedDocument else { return }
```

3. **Result Type**
```swift
func handleFileSelection(_ result: Result<[URL], Error>)
```

4. **Async/Throws**
```swift
func lint(content: String) async throws -> [RuffDiagnostic]
```

## Performance Considerations

### Optimizations

1. **Lazy Loading**
   - Views only render visible content
   - ScrollView virtualizes off-screen content

2. **Efficient State Updates**
   - @Published only triggers when value changes
   - SwiftUI diffs views and updates only what changed

3. **Async Operations**
   - Linting doesn't block UI
   - File I/O is asynchronous

4. **Temporary Files**
   - Small memory footprint
   - Cleaned up immediately after use

### Potential Bottlenecks

1. **Large Files**
   - Current implementation loads entire file into memory
   - Future: Stream large files or chunk processing

2. **Many Diagnostics**
   - ScrollView handles efficiently
   - Consider pagination for 1000+ issues

3. **Frequent Re-linting**
   - Debounce could be added
   - Current: Manual trigger via button

## Security

### Sandboxing
- App runs in iOS sandbox
- Limited file system access
- Security-scoped URLs for file access

### File Access
```swift
guard url.startAccessingSecurityScopedResource() else { return }
defer { url.stopAccessingSecurityScopedResource() }
```

### Code Execution
- Ruff runs as subprocess
- Limited to temporary directory
- No arbitrary code execution

### Data Privacy
- No data sent to external servers
- All processing local
- No analytics or tracking

## Testing Strategy

### Unit Tests
- Test model transformations
- Test configuration building
- Test parsing logic
- Mock external dependencies

### Integration Tests
- Test RuffService with actual Ruff
- Test file I/O operations
- Test JSON parsing with real data

### UI Tests
- Test navigation flows
- Test file picker integration
- Test settings persistence
- Test diagnostic display

### Manual Testing
- Different device sizes
- Different iOS versions
- Various Python file types
- Edge cases (empty, large files)

## Build Process

### Debug Build
1. Xcode preprocesses source files
2. Swift compiler builds modules
3. Linker creates executable
4. Code signing with development certificate
5. Deploy to simulator/device

### Release Build
1. Same as debug but with optimizations
2. Dead code elimination
3. Whole-module optimization
4. App Store code signing
5. Archive for distribution

## Dependencies

### System Frameworks
- **SwiftUI**: UI framework
- **Foundation**: Core utilities
- **UniformTypeIdentifiers**: File type handling
- **Combine**: Reactive programming

### External Dependencies
- **Ruff**: Python linter (runtime dependency)

### No Third-Party Libraries
- Pure Swift/SwiftUI implementation
- No package manager dependencies
- Easier maintenance and security

## Scalability

### Current Limitations
- Single file at a time
- In-memory file content
- Synchronous file reading

### Future Enhancements
1. **Multiple Files**
   - Document-based app architecture
   - Multiple windows on iPad

2. **Streaming**
   - Large file support via streaming
   - Incremental parsing

3. **Background Processing**
   - Lint while user browses settings
   - Queue multiple lint operations

4. **Caching**
   - Cache lint results
   - Invalidate on content change

## Platform Differences

### iPhone vs iPad
- Same codebase
- SwiftUI adapts layouts
- iPad: Larger margins, split view support
- iPhone: Compact navigation

### iOS Versions
- Minimum: iOS 16.0
- Features used:
  - SwiftUI 4.0
  - async/await
  - Modern file picker

## Deployment

### TestFlight
- Archive → Upload → TestFlight
- Beta testing with up to 10,000 users
- Feedback collection

### App Store
- App Store Connect submission
- Review process (1-3 days typically)
- Phased release option
- Update via Over-The-Air (OTA)

## Monitoring

### Crash Reporting
- Xcode Organizer shows crash logs
- Can integrate Crashlytics if needed

### Performance Monitoring
- Xcode Instruments for profiling
- Memory leaks detection
- CPU usage analysis

### User Feedback
- App Store reviews
- GitHub issues
- In-app feedback (future)

## Accessibility

### VoiceOver
- All interactive elements labeled
- Semantic roles assigned
- Navigation hierarchies clear

### Dynamic Type
- Text scales with system settings
- Layout adapts to larger text
- Minimum legible sizes maintained

### Color Contrast
- WCAG 2.1 AA compliance
- High contrast mode support
- Not color-only indicators (icons too)

## Internationalization

### Current State
- English only
- No hardcoded strings (mostly)
- SF Symbols for icons (universal)

### Future i18n
```swift
Text("Open File").localized
```
- Localization via .strings files
- Support for RTL languages
- Locale-aware formatting

## Maintenance

### Code Organization
- Clear separation of concerns
- Single responsibility per file
- Consistent naming conventions

### Documentation
- Header comments for complex logic
- README for project overview
- Architecture diagram (this file)

### Version Control
- Git for source control
- Semantic versioning
- Changelog for releases

## Summary

The RuffRuff architecture is:
- ✅ **Modular**: Clear separation between views, models, and services
- ✅ **Testable**: Isolated components, mockable dependencies
- ✅ **Maintainable**: SwiftUI declarative code, clear structure
- ✅ **Scalable**: Easy to add features and enhancements
- ✅ **Performant**: Async operations, efficient rendering
- ✅ **Secure**: Sandboxed, local processing, minimal privileges

The app follows iOS best practices and leverages modern Swift features for a robust, user-friendly Python linting experience on iOS devices.
