import Foundation

/// Represents a diagnostic message from Ruff
struct RuffDiagnostic: Identifiable, Codable {
    let id = UUID()
    let line: Int
    let column: Int
    let endLine: Int?
    let endColumn: Int?
    let code: String
    let message: String
    let severity: Severity
    
    enum Severity: String, Codable {
        case error = "Error"
        case warning = "Warning"
        
        var color: String {
            switch self {
            case .error: return "red"
            case .warning: return "orange"
            }
        }
    }
    
    enum CodingKeys: String, CodingKey {
        case line, column, endLine = "end_line", endColumn = "end_column"
        case code, message, severity
    }
}
