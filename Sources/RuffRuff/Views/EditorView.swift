import SwiftUI
import UniformTypeIdentifiers

struct EditorView: View {
    @EnvironmentObject var appState: AppState
    @State private var isShowingFilePicker = false
    @State private var isLinting = false
    
    var body: some View {
        NavigationView {
            Group {
                if let document = appState.openedDocument {
                    CodeEditorView(document: binding(for: document))
                } else {
                    EmptyStateView(onOpenFile: {
                        isShowingFilePicker = true
                    })
                }
            }
            .navigationTitle("Ruff Linter")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    if appState.openedDocument != nil {
                        Button(action: {
                            appState.closeDocument()
                        }) {
                            Image(systemName: "xmark.circle")
                        }
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        isShowingFilePicker = true
                    }) {
                        Image(systemName: "folder")
                    }
                }
                
                if appState.openedDocument != nil {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button(action: {
                            Task {
                                await lintCurrentDocument()
                            }
                        }) {
                            if isLinting {
                                ProgressView()
                            } else {
                                Image(systemName: "play.circle")
                            }
                        }
                        .disabled(isLinting)
                    }
                }
            }
            .fileImporter(
                isPresented: $isShowingFilePicker,
                allowedContentTypes: [.pythonScript, .text],
                allowsMultipleSelection: false
            ) { result in
                handleFileSelection(result)
            }
        }
    }
    
    private func binding(for document: PythonDocument) -> Binding<PythonDocument> {
        Binding(
            get: { appState.openedDocument ?? document },
            set: { appState.openedDocument = $0 }
        )
    }
    
    private func handleFileSelection(_ result: Result<[URL], Error>) {
        switch result {
        case .success(let urls):
            guard let url = urls.first else { return }
            
            // Start accessing the security-scoped resource
            guard url.startAccessingSecurityScopedResource() else {
                print("Failed to access file")
                return
            }
            
            defer {
                url.stopAccessingSecurityScopedResource()
            }
            
            do {
                let content = try String(contentsOf: url, encoding: .utf8)
                let document = PythonDocument(url: url, content: content)
                appState.openDocument(document)
                
                // Automatically lint on open
                Task {
                    await lintCurrentDocument()
                }
            } catch {
                print("Error reading file: \(error)")
            }
            
        case .failure(let error):
            print("Error selecting file: \(error)")
        }
    }
    
    private func lintCurrentDocument() async {
        guard var document = appState.openedDocument else { return }
        
        isLinting = true
        defer { isLinting = false }
        
        let service = RuffService(configuration: appState.ruffConfiguration)
        
        do {
            let diagnostics = try await service.lint(
                content: document.content,
                filePath: document.url.path
            )
            
            await MainActor.run {
                document.lintResults = diagnostics
                appState.openedDocument = document
            }
        } catch {
            print("Error linting: \(error)")
        }
    }
}

// Empty state view when no file is open
struct EmptyStateView: View {
    let onOpenFile: () -> Void
    
    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: "doc.text.magnifyingglass")
                .font(.system(size: 60))
                .foregroundColor(.secondary)
            
            Text("No File Open")
                .font(.title2)
                .fontWeight(.semibold)
            
            Text("Open a Python file to start linting")
                .font(.subheadline)
                .foregroundColor(.secondary)
            
            Button(action: onOpenFile) {
                Label("Open File", systemImage: "folder")
                    .font(.headline)
                    .padding()
                    .background(Color.accentColor)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding(.top)
        }
    }
}

extension UTType {
    static var pythonScript: UTType {
        UTType(filenameExtension: "py") ?? .text
    }
}
