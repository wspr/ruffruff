import SwiftUI

struct CodeEditorView: View {
    @Binding var document: PythonDocument
    @State private var selectedDiagnostic: RuffDiagnostic?
    
    var body: some View {
        VStack(spacing: 0) {
            // Header showing file name and diagnostic count
            HStack {
                Text(document.url.lastPathComponent)
                    .font(.headline)
                
                Spacer()
                
                if !document.lintResults.isEmpty {
                    HStack(spacing: 12) {
                        HStack(spacing: 4) {
                            Image(systemName: "exclamationmark.triangle.fill")
                                .foregroundColor(.orange)
                            Text("\(document.lintResults.filter { $0.severity == .warning }.count)")
                                .font(.caption)
                        }
                        
                        HStack(spacing: 4) {
                            Image(systemName: "xmark.circle.fill")
                                .foregroundColor(.red)
                            Text("\(document.lintResults.filter { $0.severity == .error }.count)")
                                .font(.caption)
                        }
                    }
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .background(Color(.systemGray6))
                    .cornerRadius(8)
                }
            }
            .padding()
            .background(Color(.systemGray6))
            
            // Main editor area
            GeometryReader { geometry in
                HStack(spacing: 0) {
                    // Line numbers and diagnostics gutter
                    DiagnosticGutterView(
                        content: document.content,
                        diagnostics: document.lintResults,
                        selectedDiagnostic: $selectedDiagnostic
                    )
                    .frame(width: 60)
                    .background(Color(.systemGray6))
                    
                    Divider()
                    
                    // Code content area
                    ScrollView([.horizontal, .vertical]) {
                        SyntaxHighlightedTextView(
                            content: document.content,
                            diagnostics: document.lintResults
                        )
                        .padding(8)
                    }
                }
            }
            
            // Diagnostic detail at bottom
            if let diagnostic = selectedDiagnostic {
                DiagnosticDetailView(diagnostic: diagnostic)
            } else if !document.lintResults.isEmpty {
                DiagnosticSummaryView(diagnostics: document.lintResults)
            }
        }
    }
}

// Gutter showing line numbers and diagnostic indicators
struct DiagnosticGutterView: View {
    let content: String
    let diagnostics: [RuffDiagnostic]
    @Binding var selectedDiagnostic: RuffDiagnostic?
    
    var body: some View {
        ScrollView {
            VStack(alignment: .trailing, spacing: 0) {
                let lines = content.components(separatedBy: .newlines)
                ForEach(Array(lines.enumerated()), id: \.offset) { index, _ in
                    let lineNumber = index + 1
                    let diagnostic = diagnostics.first { $0.line == lineNumber }
                    
                    HStack(spacing: 4) {
                        if let diagnostic = diagnostic {
                            Button(action: {
                                selectedDiagnostic = diagnostic
                            }) {
                                Image(systemName: diagnostic.severity == .error ? 
                                      "xmark.circle.fill" : "exclamationmark.triangle.fill")
                                    .font(.system(size: 10))
                                    .foregroundColor(diagnostic.severity == .error ? .red : .orange)
                            }
                            .buttonStyle(.plain)
                        } else {
                            Color.clear
                                .frame(width: 10, height: 10)
                        }
                        
                        Text("\(lineNumber)")
                            .font(.system(.caption, design: .monospaced))
                            .foregroundColor(.secondary)
                            .frame(minWidth: 30, alignment: .trailing)
                    }
                    .frame(height: 20)
                    .padding(.horizontal, 4)
                }
            }
            .padding(.vertical, 8)
        }
    }
}

// Syntax-highlighted text view
struct SyntaxHighlightedTextView: View {
    let content: String
    let diagnostics: [RuffDiagnostic]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            let lines = content.components(separatedBy: .newlines)
            ForEach(Array(lines.enumerated()), id: \.offset) { index, line in
                let lineNumber = index + 1
                let hasDiagnostic = diagnostics.contains { $0.line == lineNumber }
                
                Text(highlightedLine(line))
                    .font(.system(.body, design: .monospaced))
                    .frame(height: 20, alignment: .leading)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(hasDiagnostic ? Color.red.opacity(0.1) : Color.clear)
            }
        }
    }
    
    private func highlightedLine(_ line: String) -> AttributedString {
        var attributed = AttributedString(line.isEmpty ? " " : line)
        
        // Basic Python syntax highlighting
        let keywords = ["def", "class", "import", "from", "return", "if", "else", "elif", 
                       "for", "while", "in", "try", "except", "finally", "with", "as",
                       "pass", "break", "continue", "True", "False", "None", "and", "or", "not"]
        
        for keyword in keywords {
            if let range = attributed.range(of: "\\b\(keyword)\\b", options: .regularExpression) {
                attributed[range].foregroundColor = .purple
            }
        }
        
        // Highlight strings
        if let range = attributed.range(of: "\"[^\"]*\"|'[^']*'", options: .regularExpression) {
            attributed[range].foregroundColor = .green
        }
        
        // Highlight comments
        if let range = attributed.range(of: "#.*$", options: .regularExpression) {
            attributed[range].foregroundColor = .gray
        }
        
        return attributed
    }
}

// Diagnostic detail view
struct DiagnosticDetailView: View {
    let diagnostic: RuffDiagnostic
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Image(systemName: diagnostic.severity == .error ? 
                      "xmark.circle.fill" : "exclamationmark.triangle.fill")
                    .foregroundColor(diagnostic.severity == .error ? .red : .orange)
                
                Text(diagnostic.code)
                    .font(.headline)
                    .foregroundColor(diagnostic.severity == .error ? .red : .orange)
                
                Spacer()
                
                Text("Line \(diagnostic.line), Column \(diagnostic.column)")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            
            Text(diagnostic.message)
                .font(.subheadline)
        }
        .padding()
        .background(Color(.systemGray6))
    }
}

// Summary view of all diagnostics
struct DiagnosticSummaryView: View {
    let diagnostics: [RuffDiagnostic]
    
    var body: some View {
        HStack {
            Text("Found \(diagnostics.count) issue(s)")
                .font(.subheadline)
                .foregroundColor(.secondary)
            
            Spacer()
        }
        .padding()
        .background(Color(.systemGray6))
    }
}
