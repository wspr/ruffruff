import Foundation

/// A placeholder network-backed linting service.
/// Replace the implementation of `lint` to call your backend that runs Ruff
/// and returns diagnostics for the provided content.
class NetworkLintService: LintingService {
    struct Configuration {
        /// Base URL of your linting backend
        var baseURL: URL
        /// Optional API key or token
        var apiKey: String?
    }
    
    private let configuration: Configuration
    private let urlSession: URLSession
    
    init(configuration: Configuration, urlSession: URLSession = .shared) {
        self.configuration = configuration
        self.urlSession = urlSession
    }
    
    func lint(content: String, filePath: String) async throws -> [RuffDiagnostic] {
        // TODO: Implement an actual network call to your backend.
        // For now, return an empty list to compile and run.
        // Suggested request shape:
        // POST {baseURL}/lint with JSON body {"path": filePath, "content": content}
        // Response: array of RuffDiagnostic-like JSON objects
        return []
    }
}
