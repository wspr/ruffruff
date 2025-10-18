import Foundation

#if os(macOS)
/// Codable models for decoding Ruff JSONL output safely
private struct RuffJSONLine: Decodable {
    struct Position: Decodable {
        let row: Int
        let column: Int
    }
    let location: Position
    let end_location: Position
    let code: String
    let message: String
}
/// Service for interacting with Ruff linter
class RuffService: LintingService {
    private let configuration: RuffConfiguration
    
    init(configuration: RuffConfiguration) {
        self.configuration = configuration
    }
    
    /// Lint a Python file and return diagnostics
    func lint(content: String, filePath: String) async throws -> [LintDiagnostic] {
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
    
    private func executeRuff(on filePath: String) async throws -> [LintDiagnostic] {
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

                // If ruff failed, surface the error
                if process.terminationStatus != 0 {
                    let errData = errorPipe.fileHandleForReading.readDataToEndOfFile()
                    let errMsg = String(data: errData, encoding: .utf8) ?? "Unknown error"
                    let error = NSError(domain: "RuffService", code: Int(process.terminationStatus), userInfo: [NSLocalizedDescriptionKey: errMsg])
                    continuation.resume(throwing: error)
                    return
                }

                let outputData = outputPipe.fileHandleForReading.readDataToEndOfFile()

                // Parse JSON output from ruff using safe decoding
                do {
                    let diagnostics = try self.parseRuffOutput(outputData)
                    continuation.resume(returning: diagnostics)
                } catch {
                    // If parsing fails, return empty diagnostics rather than failing the whole lint
                    continuation.resume(returning: [])
                }
            } catch {
                continuation.resume(throwing: error)
            }
        }
    }
    
    private func parseRuffOutput(_ data: Data) throws -> [LintDiagnostic] {
        guard !data.isEmpty else { return [] }

        guard let jsonString = String(data: data, encoding: .utf8) else { return [] }
        let lines = jsonString.components(separatedBy: .newlines).filter { !$0.isEmpty }

        var diagnostics: [LintDiagnostic] = []
        let decoder = JSONDecoder()

        for line in lines {
            guard let lineData = line.data(using: .utf8) else { continue }
            do {
                let item = try decoder.decode(RuffJSONLine.self, from: lineData)
                let severity: LintDiagnostic.Severity = item.code.hasPrefix("E") ? .error : .warning
                let diagnostic = LintDiagnostic(
                    line: item.location.row,
                    column: item.location.column,
                    endLine: item.end_location.row,
                    endColumn: item.end_location.column,
                    code: item.code,
                    message: item.message,
                    severity: severity
                )
                diagnostics.append(diagnostic)
            } catch {
                // Skip malformed lines rather than failing the entire parse
                continue
            }
        }

        return diagnostics
    }
}
#else
/// Service for interacting with Ruff linter (unavailable on iOS — subprocesses not supported)
class RuffService: LintingService {
    private let configuration: RuffConfiguration
    
    init(configuration: RuffConfiguration) {
        self.configuration = configuration
    }
    
    /// Lint a Python file and return diagnostics
    /// Note: Running external tools like Ruff is not supported on iOS. This stub returns no diagnostics.
    func lint(content: String, filePath: String) async throws -> [LintDiagnostic] {
        // On iOS, spawning external processes is not supported. Consider server-side linting
        // or integrating a Swift-native linter if available.
        return []
    }
}
#endif

