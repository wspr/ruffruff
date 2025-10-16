import SwiftUI
import UniformTypeIdentifiers

/// Main application state
class AppState: ObservableObject {
    @Published var openedDocument: PythonDocument?
    @Published var ruffConfiguration = RuffConfiguration()
    
    func openDocument(_ document: PythonDocument) {
        self.openedDocument = document
    }
    
    func closeDocument() {
        self.openedDocument = nil
    }
}

/// Represents a Python document
struct PythonDocument: Identifiable {
    let id = UUID()
    let url: URL
    var content: String
    var lintResults: [RuffDiagnostic] = []
    
    init(url: URL, content: String) {
        self.url = url
        self.content = content
    }
}
