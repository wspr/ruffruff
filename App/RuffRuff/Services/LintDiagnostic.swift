import Foundation

public struct LintDiagnostic: Sendable, Equatable {
    public enum Severity: String, Sendable {
        case error
        case warning
        case info
    }
    
    public let line: Int
    public let column: Int
    public let endLine: Int
    public let endColumn: Int
    public let code: String
    public let message: String
    public let severity: Severity
}
