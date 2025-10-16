import Foundation

/// Configuration for Ruff linter
struct RuffConfiguration: Codable {
    var lineLength: Int = 88
    var selectRules: [String] = ["E", "F", "W"]
    var ignoreRules: [String] = []
    var excludePatterns: [String] = []
    
    /// Convert configuration to ruff command-line arguments
    func toCommandLineArgs() -> [String] {
        var args: [String] = []
        
        args.append("--line-length")
        args.append("\(lineLength)")
        
        if !selectRules.isEmpty {
            args.append("--select")
            args.append(selectRules.joined(separator: ","))
        }
        
        if !ignoreRules.isEmpty {
            args.append("--ignore")
            args.append(ignoreRules.joined(separator: ","))
        }
        
        return args
    }
}
