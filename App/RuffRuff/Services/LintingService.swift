import Foundation

/// Abstraction for linting source content and returning diagnostics
protocol LintingService {
    /// Lint a source file's content and return diagnostics for that content.
    /// - Parameters:
    ///   - content: The in-memory source content to lint.
    ///   - filePath: The logical path of the file (used for display/context).
    func lint(content: String, filePath: String) async throws -> [RuffDiagnostic]
}

