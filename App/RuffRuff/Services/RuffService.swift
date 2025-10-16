import Foundation

/// Service for interacting with Ruff linter
class RuffService {
    private let configuration: RuffConfiguration
    
    init(configuration: RuffConfiguration) {
        self.configuration = configuration
    }
    
    /// Lint a Python file and return diagnostics
    func lint(content: String, filePath: String) async throws -> [RuffDiagnostic] {
        // Create a temporary file for the Python content
        let tempDir = FileManager.default.temporaryDirectory
        let tempFile = tempDir.appendingPathComponent(UUID().uuidString + ".py")
        
        try content.write(to: tempFile, atomically: true, encoding: .utf8)
        
        defer {
            try? FileManager.default.removeItem(at: tempFile)
        }
        
        // Execute ruff
        let result = try await executeRuff(on: tempFile.path)
        
        return result
    }
    
    private func executeRuff(on filePath: String) async throws -> [RuffDiagnostic] {
        // Build the command
        var args = ["check", "--output-format=json"]
        args.append(contentsOf: configuration.toCommandLineArgs())
        args.append(filePath)
        
        let process = Process()
        process.executableURL = URL(fileURLWithPath: "/usr/bin/env")
        process.arguments = ["ruff"] + args
        
        let outputPipe = Pipe()
        let errorPipe = Pipe()
        process.standardOutput = outputPipe
        process.standardError = errorPipe
        
        return try await withCheckedThrowingContinuation { continuation in
            do {
                try process.run()
                process.waitUntilExit()
                
                let outputData = outputPipe.fileHandleForReading.readDataToEndOfFile()
                
                // Parse JSON output from ruff
                if let diagnostics = try? self.parseRuffOutput(outputData) {
                    continuation.resume(returning: diagnostics)
                } else {
                    continuation.resume(returning: [])
                }
            } catch {
                continuation.resume(throwing: error)
            }
        }
    }
    
    private func parseRuffOutput(_ data: Data) throws -> [RuffDiagnostic] {
        guard !data.isEmpty else { return [] }
        
        // Ruff outputs JSONL format (one JSON object per line)
        let jsonString = String(data: data, encoding: .utf8) ?? ""
        let lines = jsonString.components(separatedBy: .newlines).filter { !$0.isEmpty }
        
        var diagnostics: [RuffDiagnostic] = []
        
        for line in lines {
            if let lineData = line.data(using: .utf8),
               let json = try? JSONSerialization.jsonObject(with: lineData) as? [String: Any] {
                
                if let location = json["location"] as? [String: Any],
                   let row = location["row"] as? Int,
                   let column = location["column"] as? Int,
                   let endLocation = json["end_location"] as? [String: Any],
                   let endRow = endLocation["row"] as? Int,
                   let endColumn = endLocation["column"] as? Int,
                   let code = json["code"] as? String,
                   let message = json["message"] as? String {
                    
                    let severity: RuffDiagnostic.Severity = code.hasPrefix("E") ? .error : .warning
                    
                    let diagnostic = RuffDiagnostic(
                        line: row,
                        column: column,
                        endLine: endRow,
                        endColumn: endColumn,
                        code: code,
                        message: message,
                        severity: severity
                    )
                    
                    diagnostics.append(diagnostic)
                }
            }
        }
        
        return diagnostics
    }
}
