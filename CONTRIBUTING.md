# Contributing to RuffRuff

Thank you for your interest in contributing to RuffRuff! This document provides guidelines and instructions for contributing.

## Code of Conduct

- Be respectful and inclusive
- Welcome newcomers and help them learn
- Focus on constructive feedback
- Assume good intentions

## How to Contribute

### Reporting Bugs

Before creating a bug report:
1. Check existing issues to avoid duplicates
2. Verify the bug exists in the latest version
3. Collect information about your environment

When reporting a bug, include:
- iOS version
- Device type (iPhone/iPad model or simulator)
- Xcode version
- Ruff version
- Steps to reproduce
- Expected vs actual behavior
- Screenshots if applicable
- Console logs from Xcode

### Suggesting Features

Feature requests are welcome! Please:
1. Check if the feature already exists
2. Explain the use case and benefits
3. Describe the expected behavior
4. Consider implementation complexity
5. Be open to discussion and feedback

### Pull Requests

1. **Fork the repository**
   ```bash
   # Fork on GitHub, then clone your fork
   git clone https://github.com/YOUR-USERNAME/ruffruff.git
   cd ruffruff
   ```

2. **Create a branch**
   ```bash
   git checkout -b feature/your-feature-name
   # or
   git checkout -b fix/your-bug-fix
   ```

3. **Make your changes**
   - Follow the coding style (see below)
   - Add tests if applicable
   - Update documentation as needed

4. **Test your changes**
   - Build and run on iOS simulator
   - Test on different device sizes
   - Verify no new warnings or errors

5. **Commit your changes**
   ```bash
   git add .
   git commit -m "Add feature: description"
   ```

6. **Push and create PR**
   ```bash
   git push origin feature/your-feature-name
   ```
   Then create a Pull Request on GitHub

## Development Setup

### Prerequisites

- macOS with Xcode 15.0+
- Git
- Ruff installed (for testing)

### Initial Setup

```bash
# Clone the repository
git clone https://github.com/wspr/ruffruff.git
cd ruffruff

# Open in Xcode
open App/RuffRuff.xcodeproj
```

### Project Structure

```
RuffRuff/
├── App/
│   └── RuffRuff.xcodeproj/     # Xcode project
│       └── RuffRuff/            # Main app code
│           ├── RuffRuffApp.swift      # App entry point
│           ├── Views/                  # SwiftUI views
│           ├── Models/                 # Data models
│           ├── Services/               # Business logic
│           ├── Assets.xcassets/       # Images and assets
│           └── Info.plist             # App configuration
├── Sources/
│   └── RuffRuff/               # Shared source (mirrors App)
├── Tests/
│   └── RuffRuffTests/          # Unit tests
├── Package.swift               # Swift Package Manager config
└── Documentation files
```

## Coding Style

### Swift Style Guide

We follow Apple's Swift API Design Guidelines:

1. **Naming**
   - Use clear, descriptive names
   - CamelCase for types and protocols
   - lowerCamelCase for variables and functions
   - UPPER_CASE for constants

2. **Indentation**
   - 4 spaces (no tabs)
   - Xcode handles this automatically

3. **Line Length**
   - Aim for 100 characters maximum
   - Break long lines at logical points

4. **Whitespace**
   - One blank line between functions
   - Two blank lines between types
   - No trailing whitespace

5. **Comments**
   - Use `///` for documentation comments
   - Use `//` for inline comments
   - Explain "why" not "what"

### Example

```swift
/// Represents a Python document with lint results
struct PythonDocument: Identifiable {
    let id = UUID()
    let url: URL
    var content: String
    var lintResults: [RuffDiagnostic] = []
    
    /// Creates a new document from a file URL
    init(url: URL, content: String) {
        self.url = url
        self.content = content
    }
}
```

### SwiftUI Best Practices

1. **Extract Views**
   - Keep views small and focused
   - Extract complex views into separate files
   - Use view builders for reusable components

2. **State Management**
   - Use `@State` for local state
   - Use `@StateObject` for owned objects
   - Use `@EnvironmentObject` for shared state
   - Use `@Binding` for two-way data flow

3. **Preview Providers**
   - Include preview providers for views
   - Show different states (empty, populated, error)

## Testing Guidelines

### Unit Tests

Located in `Tests/RuffRuffTests/`

- Test model logic
- Test configuration transformations
- Test parsing functions
- Mock external dependencies

Example:
```swift
func testRuffConfiguration() {
    var config = RuffConfiguration()
    config.lineLength = 100
    
    let args = config.toCommandLineArgs()
    
    XCTAssertTrue(args.contains("--line-length"))
    XCTAssertTrue(args.contains("100"))
}
```

### UI Testing

- Test user workflows
- Verify navigation works
- Test file picker integration
- Validate settings persistence

### Manual Testing

Before submitting a PR, test:
1. Opening various Python files
2. Linting with different configurations
3. Settings changes persist correctly
4. UI works on different device sizes
5. No crashes or hangs
6. No memory leaks (use Xcode Instruments)

## Areas for Contribution

### High Priority

- [ ] Code editing capabilities
- [ ] Quick-fix suggestions from Ruff
- [ ] Dark mode improvements
- [ ] iPad optimization
- [ ] Performance improvements for large files

### Medium Priority

- [ ] Multiple file tabs
- [ ] Export lint reports
- [ ] Custom syntax themes
- [ ] Line wrapping options
- [ ] Search within file

### Low Priority

- [ ] Git integration
- [ ] Cloud sync settings
- [ ] Multiple configuration profiles
- [ ] Plugin system
- [ ] Alternative linters support

### Documentation

- Improve README with screenshots
- Add video tutorials
- Expand troubleshooting guide
- Translate to other languages
- API documentation

## Review Process

1. **Automated Checks**
   - Code compiles without errors
   - No new warnings introduced
   - Tests pass (if CI is set up)

2. **Manual Review**
   - Code quality and style
   - Architecture consistency
   - Performance implications
   - UI/UX considerations

3. **Feedback**
   - Reviewers may suggest changes
   - Discussion is encouraged
   - Be responsive to feedback
   - Iterate based on suggestions

4. **Merge**
   - Once approved, maintainer will merge
   - Your contribution will be credited
   - Thank you! 🎉

## Git Workflow

### Commit Messages

Follow conventional commits format:

```
type(scope): description

[optional body]

[optional footer]
```

Types:
- `feat`: New feature
- `fix`: Bug fix
- `docs`: Documentation only
- `style`: Code style changes (formatting)
- `refactor`: Code refactoring
- `test`: Adding or updating tests
- `chore`: Maintenance tasks

Examples:
```
feat(editor): add line wrapping toggle

fix(settings): persist rule selections correctly

docs(readme): add installation instructions

refactor(views): extract diagnostic panel component
```

### Branch Naming

- `feature/description` - New features
- `fix/description` - Bug fixes
- `docs/description` - Documentation
- `refactor/description` - Code refactoring

## Security

If you discover a security vulnerability:
1. **Do NOT** open a public issue
2. Email the maintainers directly
3. Provide details about the vulnerability
4. Allow time for a fix before disclosure

## License

By contributing, you agree that your contributions will be licensed under the MIT License.

## Questions?

- Open a GitHub Discussion for questions
- Check existing issues and PRs
- Reach out to maintainers

## Recognition

Contributors will be:
- Listed in release notes
- Credited in the repository
- Appreciated by the community ❤️

Thank you for making RuffRuff better!
